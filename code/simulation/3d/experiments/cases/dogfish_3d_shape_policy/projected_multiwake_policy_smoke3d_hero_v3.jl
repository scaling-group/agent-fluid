# Configuration-specific 3D projected-multiwake rollout engine.  It loads a
# fingerprint-matched prewarm snapshot, inserts the modeler-default body with
# the caudal fin only, and keeps only x/y/yaw rigid DOFs.  The historical file
# name is retained so old evidence jobs remain reproducible; the production
# entry point is free_swim_multiwake_target_episode3d.jl.

ENV["GKSwstype"] = get(ENV, "GKSwstype", "100")

case_dir = @__DIR__
include(joinpath(case_dir, "src", "Dogfish3DShapePolicyTestbed.jl"))
using .Dogfish3DShapePolicyTestbed
const T3D = Dogfish3DShapePolicyTestbed
const Base2D = Dogfish3DShapePolicyTestbed.Base2D

using Dates
using JLD2
using JSON
using LinearAlgebra: dot
using SHA
using StaticArrays
using Statistics
using TOML
using WaterLily

include(joinpath(case_dir, "src", "integrated_body_caudal3d.jl"))
include(joinpath(case_dir, "src", "integrated_body_caudal3d_thin_web.jl"))
include(joinpath(case_dir, "src", "integrated_body_caudal3d_embedded_plate.jl"))
include(joinpath(case_dir, "src", "integrated_body_caudal3d_profiled_fin_v7.jl"))

const REFLECTION_EQUIVARIANT_IBM_PATH = joinpath(
    case_dir, "src", "reflection_equivariant_ibm3d.jl",
)
const REFLECTION_EQUIVARIANT_IBM_ENABLED = let value = lowercase(strip(get(
    ENV, "DOGFISH3D_REFLECTION_EQUIVARIANT_IBM", "false",
)))
    if value in ("1", "true", "yes", "on")
        true
    elseif value in ("0", "false", "no", "off")
        false
    else
        error("DOGFISH3D_REFLECTION_EQUIVARIANT_IBM must be a boolean")
    end
end
REFLECTION_EQUIVARIANT_IBM_ENABLED && include(REFLECTION_EQUIVARIANT_IBM_PATH)
const REFLECTION_EQUIVARIANT_IBM_CONTRACT = REFLECTION_EQUIVARIANT_IBM_ENABLED ?
    DOGFISH_REFLECTION_EQUIVARIANT_IBM_CONTRACT : nothing

const DEG = pi / 180
const MATERIAL_REFERENCE_STATION = let raw = strip(get(ENV, "DOGFISH3D_MATERIAL_REFERENCE_STATION", ""))
    isempty(raw) ? 1f0 / 3f0 : parse(Float32, raw)
end

env_string(name, default) = (value = strip(get(ENV, name, "")); isempty(value) ? default : value)
env_int(name, default) = (value = strip(get(ENV, name, "")); isempty(value) ? default : parse(Int, value))
env_float(name, default) = (value = strip(get(ENV, name, "")); isempty(value) ? default : parse(Float64, value))
function env_bool(name, default)
    value = lowercase(strip(get(ENV, name, "")))
    isempty(value) && return default
    value in ("1", "true", "yes", "on") && return true
    value in ("0", "false", "no", "off") && return false
    error("$name must be a boolean")
end
sha256_file(path) = bytes2hex(sha256(read(path)))

function profiled_caudal_v7_from_env(Lf::T, body_height_scale) where {T}
    return integrated_profiled_caudal_sdf(
        T3D.dogfish_body_sdf(Lf; height_scale=T(body_height_scale));
        transition_start=env_float("DOGFISH3D_PROFILED_CAUDAL_TRANSITION_START", 0.68),
        peduncle_station=env_float("DOGFISH3D_PROFILED_CAUDAL_PEDUNCLE_STATION", 0.76),
        peduncle_half_width=env_float("DOGFISH3D_PROFILED_CAUDAL_PEDUNCLE_HALF_WIDTH", 0.018),
        trailing_half_width=env_float("DOGFISH3D_PROFILED_CAUDAL_TRAILING_HALF_WIDTH", 0.012),
        peduncle_ztop=env_float("DOGFISH3D_PROFILED_CAUDAL_PEDUNCLE_ZTOP", 0.018),
        peduncle_zbot=env_float("DOGFISH3D_PROFILED_CAUDAL_PEDUNCLE_ZBOT", 0.013),
        trailing_ztop=env_float("DOGFISH3D_PROFILED_CAUDAL_TRAILING_ZTOP", 0.13),
        trailing_zbot=env_float("DOGFISH3D_PROFILED_CAUDAL_TRAILING_ZBOT", 0.09),
        tail_etop=env_float("DOGFISH3D_PROFILED_CAUDAL_TAIL_ETOP", 2.2),
        tail_ebot=env_float("DOGFISH3D_PROFILED_CAUDAL_TAIL_EBOT", 2.0),
        minimum_posterior_half_width_cells=env_float(
            "DOGFISH3D_PROFILED_CAUDAL_MINIMUM_POSTERIOR_HALF_WIDTH_CELLS", 1.0,
        ),
    )
end

struct LoggedJointHistory{T}
    time_T::Vector{T}
    phi1::Vector{T}
    phi2::Vector{T}
    phi_dot1::Vector{T}
    phi_dot2::Vector{T}
    phi_ddot1::Vector{T}
    phi_ddot2::Vector{T}
end

function load_logged_joint_history(path)
    lines = readlines(path)
    length(lines) >= 3 || error("logged trajectory must contain a header and at least two rows")
    header = split(strip(lines[1]), ',')
    required = (
        "time", "phi1", "phi2", "phi_dot1", "phi_dot2", "phi_ddot1", "phi_ddot2",
    )
    indices = Dict(name => findfirst(==(name), header) for name in required)
    any(value === nothing for value in values(indices)) &&
        error("logged trajectory is missing one or more q/qdot/qddot columns")
    columns = Dict(name => Float64[] for name in required)
    for (offset, line) in enumerate(lines[2:end])
        line_number = offset + 1
        isempty(strip(line)) && continue
        fields = split(strip(line), ',')
        for name in required
            index = indices[name]::Int
            index <= length(fields) || error("short row at line $line_number")
            value = parse(Float64, fields[index])
            isfinite(value) || error("non-finite $name at line $line_number")
            push!(columns[name], value)
        end
    end
    count = length(columns["time"])
    count >= 2 || error("logged trajectory has fewer than two numeric rows")
    all(columns["time"][index + 1] > columns["time"][index] for index in 1:count-1) ||
        error("logged trajectory time must be strictly increasing")
    history = LoggedJointHistory(
        columns["time"], columns["phi1"], columns["phi2"],
        columns["phi_dot1"], columns["phi_dot2"],
        columns["phi_ddot1"], columns["phi_ddot2"],
    )
    return (
        history=history,
        metadata=(
            path=abspath(path),
            sha256=sha256_file(path),
            row_count=count,
            start_time_T=history.time_T[1],
            end_time_T=history.time_T[end],
        ),
    )
end

function quintic_hermite_coefficients(q0, qdot0, qddot0, q1, qdot1, qddot1, h)
    c0 = q0
    c1 = h * qdot0
    c2 = 0.5 * h^2 * qddot0
    r0 = q1 - (c0 + c1 + c2)
    r1 = h * qdot1 - (c1 + 2 * c2)
    r2 = h^2 * qddot1 - 2 * c2
    c3 = 10 * r0 - 4 * r1 + 0.5 * r2
    c4 = -15 * r0 + 7 * r1 - r2
    c5 = 6 * r0 - 3 * r1 + 0.5 * r2
    return (c0, c1, c2, c3, c4, c5)
end

@inline function evaluate_quintic(coefficients, u, h)
    c0, c1, c2, c3, c4, c5 = coefficients
    value = c0 + u * (c1 + u * (c2 + u * (c3 + u * (c4 + u * c5))))
    first_u = c1 + u * (2c2 + u * (3c3 + u * (4c4 + u * 5c5)))
    second_u = 2c2 + u * (6c3 + u * (12c4 + u * 20c5))
    return value, first_u / h, second_u / h^2
end

function logged_joint_state(history::LoggedJointHistory, time_T)
    t = clamp(Float64(time_T), history.time_T[1], history.time_T[end])
    index = clamp(searchsortedlast(history.time_T, t), 1, length(history.time_T) - 1)
    h = history.time_T[index + 1] - history.time_T[index]
    u = (t - history.time_T[index]) / h
    coefficients(field, first, second) = quintic_hermite_coefficients(
        getfield(history, field)[index],
        getfield(history, first)[index],
        getfield(history, second)[index],
        getfield(history, field)[index + 1],
        getfield(history, first)[index + 1],
        getfield(history, second)[index + 1],
        h,
    )
    q1, qd1, qdd1 = evaluate_quintic(coefficients(:phi1, :phi_dot1, :phi_ddot1), u, h)
    q2, qd2, qdd2 = evaluate_quintic(coefficients(:phi2, :phi_dot2, :phi_ddot2), u, h)
    return (
        phi1=q1,
        phi2=q2,
        phi_dot1=qd1,
        phi_dot2=qd2,
        phi_ddot1=qdd1,
        phi_ddot2=qdd2,
    )
end

const TWO_D_FOURIER_PERIOD_T = 0.5146064417862406
const TWO_D_FOURIER_TEMPLATE_SHA256 = "7e8ac79c4a2f927e5cbd04eba932f4255eb6e33d420cc8d07a4ef5cd579eb81c"
const TWO_D_FOURIER_ODD_TEMPLATE_SHA256 = "16f56f40d6f41343d1c5cdd7cb20fa0d6adda21b52e28adc356e24623a553082"
const TWO_D_FOURIER_SOURCE_POLICY_SHA256 = "c11d5621099e7cd46145247a8dcd6c4e3c7d6e2cf42f5bd25cf21415c4503d7b"
const TWO_D_FOURIER_Q1_COS = (-0.016657873214341767, -6.521204198007462e-6, -0.00043487802596786185, -0.00010535787705993413, -7.756949933688449e-5)
const TWO_D_FOURIER_Q1_SIN = (0.1940364173998846, -0.0005606323941933923, 0.00022164302735483969, -8.124212242789208e-5, -4.113808818739145e-5)
const TWO_D_FOURIER_Q2_COS = (0.2091074757895261, 8.796048704341622e-5, -0.0012793001765180933, 3.906449816630736e-5, 5.217349426594933e-6)
const TWO_D_FOURIER_Q2_SIN = (-0.07217014313866918, 0.0012294130284521178, 0.0028866527714422026, 0.0007986385130422412, 0.0007353725196083642)
const TWO_D_FOURIER_ODD_Q1_COS = (TWO_D_FOURIER_Q1_COS[1], 0.0, TWO_D_FOURIER_Q1_COS[3], 0.0, TWO_D_FOURIER_Q1_COS[5])
const TWO_D_FOURIER_ODD_Q1_SIN = (TWO_D_FOURIER_Q1_SIN[1], 0.0, TWO_D_FOURIER_Q1_SIN[3], 0.0, TWO_D_FOURIER_Q1_SIN[5])
const TWO_D_FOURIER_ODD_Q2_COS = (TWO_D_FOURIER_Q2_COS[1], 0.0, TWO_D_FOURIER_Q2_COS[3], 0.0, TWO_D_FOURIER_Q2_COS[5])
const TWO_D_FOURIER_ODD_Q2_SIN = (TWO_D_FOURIER_Q2_SIN[1], 0.0, TWO_D_FOURIER_Q2_SIN[3], 0.0, TWO_D_FOURIER_Q2_SIN[5])

policy_path = abspath(env_string(
    "DOGFISH3D_POLICY_FILE",
    joinpath(case_dir, "candidate_target_policy.jl"),
))
isfile(policy_path) || error("3D target policy file not found: $policy_path")
expected_policy_sha256 = lowercase(env_string("DOGFISH3D_POLICY_EXPECTED_SHA256", ""))
if !isempty(expected_policy_sha256)
    lowercase(sha256_file(policy_path)) == expected_policy_sha256 ||
        error("3D target policy SHA-256 mismatch")
end
include(policy_path)

function target_motion_derived_params(params; L::Int, T::Type=Float32)
    typed = Base2D.cast_named_tuple(params, T)
    return (params=typed, period=Float64(typed.control_period))
end

function target_control_design(; control_period=0.78f0)
    base_params = Base2D.two_joint_bend_params(
        T=Float32,
        phi1=0f0,
        phi2=0f0,
        center1=1f0 / 3f0,
        center2=2f0 / 3f0,
        half_width1=1f0 / 8f0,
        half_width2=1f0 / 8f0,
    )
    params = merge(base_params, (control_period=Float32(control_period),))
    return (
        version="dogfish.projected_multiwake_policy_smoke3d.v1",
        morphology=(schema=NamedTuple(), params=NamedTuple(), generator=(s, p) -> 0f0),
        motion=(
            schema=NamedTuple(),
            params=params,
            generator=Base2D.two_joint_bend_angle_with_rates,
            derive=target_motion_derived_params,
        ),
        experiments=[(id="projected_multiwake_policy_smoke3d", morphology=NamedTuple(), motion=NamedTuple())],
    )
end

clamp_value(value, limit) = clamp(value, -limit, limit)

function integrate_joint_state(joint, phi_ddot, dt; phi_limit, phi_dot_limit, phi_ddot_limit)
    a1 = clamp_value(phi_ddot[1], phi_ddot_limit)
    a2 = clamp_value(phi_ddot[2], phi_ddot_limit)
    qd1 = clamp_value(joint.phi_dot1 + a1 * dt, phi_dot_limit)
    qd2 = clamp_value(joint.phi_dot2 + a2 * dt, phi_dot_limit)
    q1 = clamp_value(joint.phi1 + qd1 * dt, phi_limit)
    q2 = clamp_value(joint.phi2 + qd2 * dt, phi_limit)
    abs(q1) == phi_limit && (qd1 = 0.0)
    abs(q2) == phi_limit && (qd2 = 0.0)
    return (
        phi1=q1,
        phi2=q2,
        phi_dot1=qd1,
        phi_dot2=qd2,
        phi_ddot1=a1,
        phi_ddot2=a2,
    )
end

@inline function zero_mean_half_cycle_sine(phase, asymmetry)
    carrier = sin(phase)
    return carrier + asymmetry * (abs(carrier) - 2 / pi)
end

function prescribed_straight_joint_state(
    joint,
    initial_joint,
    elapsed_next,
    dt;
    period,
    amp1,
    amp2,
    asymmetry1,
    asymmetry2,
    bias1,
    bias2,
    phase_lag,
    carrier_global_phase_offset=0.0,
    ramp_periods,
    phi_limit,
    phi_dot_limit,
    phi_ddot_limit,
)
    ramp = Base2D.smootherstep01(elapsed_next / max(ramp_periods * period, eps(Float64)))
    phase = 2pi * elapsed_next / period + carrier_global_phase_offset
    wave1 = zero_mean_half_cycle_sine(phase, asymmetry1)
    wave2 = zero_mean_half_cycle_sine(phase - phase_lag, asymmetry2)
    q1 = (1 - ramp) * initial_joint.phi1 + ramp * (bias1 + amp1 * wave1)
    q2 = (1 - ramp) * initial_joint.phi2 + ramp * (bias2 + amp2 * wave2)
    q1 = clamp_value(q1, phi_limit)
    q2 = clamp_value(q2, phi_limit)
    qd1 = clamp_value((q1 - joint.phi1) / dt, phi_dot_limit)
    qd2 = clamp_value((q2 - joint.phi2) / dt, phi_dot_limit)
    qdd1 = clamp_value((qd1 - joint.phi_dot1) / dt, phi_ddot_limit)
    qdd2 = clamp_value((qd2 - joint.phi_dot2) / dt, phi_ddot_limit)
    return (
        phi1=q1,
        phi2=q2,
        phi_dot1=qd1,
        phi_dot2=qd2,
        phi_ddot1=qdd1,
        phi_ddot2=qdd2,
    )
end

function prescribed_analytic_harmonic_joint_state(
    joint,
    initial_joint,
    elapsed_next,
    dt;
    period,
    carrier_amp1,
    carrier_amp2,
    steering_amp1,
    steering_amp2,
    command1,
    command2,
    phase_lag,
    carrier_global_phase_offset=0.0,
    steering_harmonic=2,
    steering_phase_offset=0.0,
    ramp_periods,
    phi_limit,
    phi_dot_limit,
    phi_ddot_limit,
)
    ramp = Base2D.smootherstep01(
        elapsed_next / max(ramp_periods * period, eps(Float64)),
    )
    phase = 2pi * elapsed_next / period + carrier_global_phase_offset
    carrier1 = carrier_amp1 * sin(phase)
    carrier2 = carrier_amp2 * sin(phase - phase_lag)
    steering1 = steering_amp1 * command1 *
        cos(steering_harmonic * phase + steering_phase_offset)
    steering2 = steering_amp2 * command2 *
        cos(
            steering_harmonic * (phase - phase_lag) +
            steering_phase_offset,
        )
    q1 = clamp_value(
        (1 - ramp) * initial_joint.phi1 +
        ramp * (carrier1 + steering1),
        phi_limit,
    )
    q2 = clamp_value(
        (1 - ramp) * initial_joint.phi2 +
        ramp * (carrier2 + steering2),
        phi_limit,
    )
    qd1 = clamp_value((q1 - joint.phi1) / dt, phi_dot_limit)
    qd2 = clamp_value((q2 - joint.phi2) / dt, phi_dot_limit)
    qdd1 = clamp_value((qd1 - joint.phi_dot1) / dt, phi_ddot_limit)
    qdd2 = clamp_value((qd2 - joint.phi_dot2) / dt, phi_ddot_limit)
    return (
        phi1=q1,
        phi2=q2,
        phi_dot1=qd1,
        phi_dot2=qd2,
        phi_ddot1=qdd1,
        phi_ddot2=qdd2,
    )
end

@inline function zero_mean_fourier_value(phase, cosine_coefficients, sine_coefficients)
    value = 0.0
    @inbounds for harmonic in eachindex(cosine_coefficients)
        value += cosine_coefficients[harmonic] * cos(harmonic * phase) +
            sine_coefficients[harmonic] * sin(harmonic * phase)
    end
    return value
end

function prescribed_fourier_joint_state(
    joint,
    initial_joint,
    elapsed_next,
    dt;
    period,
    steering_amp1,
    steering_amp2,
    asymmetry1,
    asymmetry2,
    phase_lag,
    carrier_global_phase_offset=0.0,
    steering_harmonic=2,
    steering_phase_offset=0.0,
    carrier_scale=1.0,
    carrier_scale1=carrier_scale,
    carrier_scale2=carrier_scale,
    carrier_mode="successful_2d_fourier_zero_mean",
    carrier_phase_shift2=0.0,
    ramp_periods,
    phi_limit,
    phi_dot_limit,
    phi_ddot_limit,
)
    ramp = Base2D.smootherstep01(elapsed_next / max(ramp_periods * period, eps(Float64)))
    phase = 2pi * elapsed_next / period + carrier_global_phase_offset
    coefficients = carrier_mode == "successful_2d_fourier_odd_harmonics" ? (
        q1_cos=TWO_D_FOURIER_ODD_Q1_COS,
        q1_sin=TWO_D_FOURIER_ODD_Q1_SIN,
        q2_cos=TWO_D_FOURIER_ODD_Q2_COS,
        q2_sin=TWO_D_FOURIER_ODD_Q2_SIN,
    ) : carrier_mode == "successful_2d_fourier_zero_mean" ? (
        q1_cos=TWO_D_FOURIER_Q1_COS,
        q1_sin=TWO_D_FOURIER_Q1_SIN,
        q2_cos=TWO_D_FOURIER_Q2_COS,
        q2_sin=TWO_D_FOURIER_Q2_SIN,
    ) : error("unsupported Fourier carrier mode: $carrier_mode")
    carrier1 = carrier_scale1 * zero_mean_fourier_value(
        phase, coefficients.q1_cos, coefficients.q1_sin,
    )
    # Match the tethered template loader: a positive shift evaluates the
    # original q2 waveform at (phase - shift).
    carrier2 = carrier_scale2 * zero_mean_fourier_value(
        phase - carrier_phase_shift2, coefficients.q2_cos, coefficients.q2_sin,
    )
    # The steering harmonic is explicit: harmonic 2 reproduces the previous
    # half-cycle asymmetry, while harmonic 1 tests a same-frequency dynamic
    # body-tail coordination mode. Both are exactly zero-mean and add no DC bend.
    steering1 = steering_amp1 * asymmetry1 * cos(steering_harmonic * phase + steering_phase_offset)
    steering2 = steering_amp2 * asymmetry2 * cos(steering_harmonic * (phase - phase_lag) + steering_phase_offset)
    q1 = clamp_value((1 - ramp) * initial_joint.phi1 + ramp * (carrier1 + steering1), phi_limit)
    q2 = clamp_value((1 - ramp) * initial_joint.phi2 + ramp * (carrier2 + steering2), phi_limit)
    qd1 = clamp_value((q1 - joint.phi1) / dt, phi_dot_limit)
    qd2 = clamp_value((q2 - joint.phi2) / dt, phi_dot_limit)
    qdd1 = clamp_value((qd1 - joint.phi_dot1) / dt, phi_ddot_limit)
    qdd2 = clamp_value((qd2 - joint.phi_dot2) / dt, phi_ddot_limit)
    return (
        phi1=q1,
        phi2=q2,
        phi_dot1=qd1,
        phi_dot2=qd2,
        phi_ddot1=qdd1,
        phi_ddot2=qdd2,
    )
end

function current_joint_params(base_params, joint, reference_time, L)
    return Base2D.merge_two_joint_state(base_params, joint; reference_time, L)
end

@inline wrap_angle(value) = atan(sin(value), cos(value))

@inline function heading_actuator_commands(command, basis::AbstractString)
    basis == "common" && return (command, command)
    basis == "differential" && return (command, -command)
    error("heading actuator basis must be common or differential")
end

@inline function unilateral_heading_command(value, limit, allowed_sign)
    allowed_sign > 0 && return clamp(value, 0.0, limit)
    allowed_sign < 0 && return clamp(value, -limit, 0.0)
    return clamp(value, -limit, limit)
end

@inline function cycle_synchronized_heading_hold(
    raw_command,
    held_command,
    last_update_index::Int,
    effective_time_T,
    feedback_start_T,
    carrier_period_T,
    update_periods::Int,
)
    if update_periods == 0
        return (
            command=raw_command,
            update_index=last_update_index,
            updated=true,
        )
    end
    if effective_time_T < feedback_start_T
        return (
            command=held_command,
            update_index=last_update_index,
            updated=false,
        )
    end
    update_span_T = update_periods * carrier_period_T
    candidate_update_index = floor(
        Int,
        (effective_time_T - feedback_start_T) / update_span_T + 1e-9,
    )
    if candidate_update_index > last_update_index
        return (
            command=raw_command,
            update_index=candidate_update_index,
            updated=true,
        )
    end
    return (
        command=held_command,
        update_index=last_update_index,
        updated=false,
    )
end

struct HeadingPhaseAuthorityTable{T}
    phase::Vector{T}
    weight::Vector{T}
    path::String
    sha256::String
    schema::String
    source_positive_report_sha256::String
    source_negative_report_sha256::String
    fourier_lowpass_harmonics::Int
end

function load_heading_phase_authority(path::AbstractString, expected_sha256::AbstractString="")
    resolved = abspath(path)
    isfile(resolved) || error("heading phase-authority JSON not found: $resolved")
    actual_sha256 = sha256_file(resolved)
    isempty(expected_sha256) || lowercase(actual_sha256) == lowercase(expected_sha256) ||
        error("heading phase-authority SHA256 mismatch")
    data = JSON.parsefile(resolved)
    schema = String(data["schema"])
    schema in (
        "dogfish3d.v7_heading_phase_authority.v1",
        "dogfish3d.quiescent_q2_heading_phase_authority.v1",
    ) || error("unsupported heading phase-authority schema $schema")
    samples = data["samples"]
    length(samples) >= 8 || error("heading phase-authority table needs at least eight samples")
    phase = Float64[Float64(sample["phase_rad"]) for sample in samples]
    weight = Float64[Float64(sample["authority_weight"]) for sample in samples]
    issorted(phase) || error("heading phase-authority phases must be sorted")
    all(isfinite, phase) && all(isfinite, weight) ||
        error("heading phase-authority table contains nonfinite values")
    0.0 <= first(phase) < 2pi && last(phase) < 2pi ||
        error("heading phase-authority phases must span [0,2pi)")
    maximum(abs, weight) <= 1.000001 ||
        error("heading phase-authority weights must be normalized to [-1,1]")
    return HeadingPhaseAuthorityTable(
        phase,
        weight,
        resolved,
        actual_sha256,
        schema,
        String(data["source_positive_report_sha256"]),
        String(data["source_negative_report_sha256"]),
        Int(data["fourier_lowpass_harmonics"]),
    )
end

@inline function heading_phase_authority_weight(table::HeadingPhaseAuthorityTable, phase)
    wrapped = mod(Float64(phase), 2pi)
    index = searchsortedlast(table.phase, wrapped)
    if index == 0
        left_phase = table.phase[end] - 2pi
        right_phase = table.phase[1]
        fraction = (wrapped - left_phase) / (right_phase - left_phase)
        return (1 - fraction) * table.weight[end] + fraction * table.weight[1]
    elseif index == length(table.phase)
        left_phase = table.phase[end]
        right_phase = table.phase[1] + 2pi
        fraction = (wrapped - left_phase) / (right_phase - left_phase)
        return (1 - fraction) * table.weight[end] + fraction * table.weight[1]
    end
    left_phase = table.phase[index]
    right_phase = table.phase[index + 1]
    fraction = (wrapped - left_phase) / (right_phase - left_phase)
    return (1 - fraction) * table.weight[index] + fraction * table.weight[index + 1]
end

function material_head_position(
    state, params, Lf, raw_time, body_sdf, mass_profile_2d, reference_model,
    ;
    centroid_caudal_fin=nothing,
    centroid_fin_material_density=one(Lf),
)
    spine = Base2D.SpineMotionMap(Base2D.two_joint_bend_angle_with_rates, params, Lf)
    reference = reference_model == "actual_superellipse_centroid" ?
        (
            centroid_caudal_fin === nothing ?
                T3D.deformed_body_centroid_superellipse(
                    Base2D.two_joint_bend_angle_with_rates,
                    params,
                    body_sdf,
                    Lf,
                    raw_time,
                ) :
                T3D.deformed_combined_centroid_superellipse(
                    Base2D.two_joint_bend_angle_with_rates,
                    params,
                    body_sdf,
                    centroid_caudal_fin,
                    Lf,
                    raw_time;
                    body_density=one(Lf),
                    fin_material_density=centroid_fin_material_density,
                )
        ) : reference_model == "two_d_matched_mass_centroid" ?
        Base2D.deformed_body_centroid(
            Base2D.two_joint_bend_angle_with_rates,
            params,
            mass_profile_2d,
            Lf,
            raw_time,
        ) : Base2D.spine_centerline(spine, MATERIAL_REFERENCE_STATION, raw_time)
    head = Base2D.spine_centerline(spine, zero(Lf), raw_time)
    return state.center + Base2D.rotate_to_world_frame(head - reference, state.theta)
end

function array_scalar(a, index::CartesianIndex, component::Int)
    if Base2D.is_cuda_storage(a)
        cuda = Base2D.CUDA_MODULE[]
        cuda === nothing && return Float64(a[index, component])
        return cuda.allowscalar() do
            Float64(a[index, component])
        end
    end
    return Float64(a[index, component])
end

function centered_flow_velocity_xy(sim, point)
    nx, ny, nz = size(sim.flow.p)
    ix = clamp(round(Int, Float64(point[1])), 2, nx - 1)
    iy = clamp(round(Int, Float64(point[2])), 2, ny - 1)
    iz = clamp(round(Int, Float64(point[3])), 2, nz - 1)
    I = CartesianIndex(ix, iy, iz)
    ux = 0.5 * (
        array_scalar(sim.flow.u, I, 1) +
        array_scalar(sim.flow.u, I + WaterLily.δ(1, I), 1)
    )
    uy = 0.5 * (
        array_scalar(sim.flow.u, I, 2) +
        array_scalar(sim.flow.u, I + WaterLily.δ(2, I), 2)
    )
    return SVector(ux, uy)
end

function fish_surface_moment(sim, fish_body, center, z_plane, axis::Int)
    raw_time = WaterLily.time(sim.flow)
    Tp = eltype(sim.flow.p)
    To = promote_type(Float64, Tp)
    center3 = SVector(Tp(center[1]), Tp(center[2]), Tp(z_plane))
    sim.flow.σ .= zero(Tp)
    if axis == 3
        WaterLily.@loop sim.flow.σ[I] = T3D.free_swim_moment_density_3d(
            I, sim.flow.p, sim.flow.u, sim.flow.ν, fish_body, raw_time, center3, Val(3),
        ) over I in WaterLily.inside(sim.flow.p)
    elseif axis == 1
        WaterLily.@loop sim.flow.σ[I] = T3D.free_swim_moment_density_3d(
            I, sim.flow.p, sim.flow.u, sim.flow.ν, fish_body, raw_time, center3, Val(1),
        ) over I in WaterLily.inside(sim.flow.p)
    else
        WaterLily.@loop sim.flow.σ[I] = T3D.free_swim_moment_density_3d(
            I, sim.flow.p, sim.flow.u, sim.flow.ν, fish_body, raw_time, center3, Val(2),
        ) over I in WaterLily.inside(sim.flow.p)
    end
    moment = sum(To, sim.flow.σ, dims=ntuple(identity, ndims(sim.flow.σ)))[:] |> Array
    return Float64(moment[1])
end

function fish_force_moment(sim, fish_body, center, z_plane; locked_diagnostics=false)
    raw_force = WaterLily.pressure_force(sim.flow, fish_body) .+
        WaterLily.viscous_force(sim.flow, fish_body)
    moment_z = fish_surface_moment(sim, fish_body, center, z_plane, 3)
    locked = locked_diagnostics ? (
        -fish_surface_moment(sim, fish_body, center, z_plane, 1),
        -fish_surface_moment(sim, fish_body, center, z_plane, 2),
    ) : (0.0, 0.0)
    return (
        force=SVector(-Float64(raw_force[1]), -Float64(raw_force[2])),
        force_z=-Float64(raw_force[3]),
        moment_z=-moment_z,
        locked_moments=locked,
    )
end

function policy_observation(
    state,
    joint,
    target,
    force,
    moment_z,
    local_flow_world,
    head,
    Lf,
    elapsed,
    history,
)
    target_delta = target - head
    target_body = Base2D.rotate_to_body_frame(target_delta, state.theta)
    target_body_L = target_body / Lf
    velocity_body = Base2D.rotate_to_body_frame(state.velocity, state.theta)
    local_flow_body = Base2D.rotate_to_body_frame(local_flow_world, state.theta)
    relative_flow_body = local_flow_body - velocity_body
    force_body = Base2D.rotate_to_body_frame(force, state.theta) / Lf^2
    distance_L = hypot(target_delta...) / Float64(Lf)
    bearing = atan(target_body[2], max(abs(target_body[1]), 0.25 * Float64(Lf)))
    previous = isempty(history) ? nothing : history[end]
    oldest = isempty(history) ? nothing : history[1]
    dt = previous === nothing ? 0.0 : elapsed - previous.time
    window_dt = oldest === nothing ? 0.0 : elapsed - oldest.time
    bearing_rate = dt > 0 ? wrap_angle(bearing - previous.bearing) / dt : 0.0
    bearing_window_rate = window_dt > 0 ? wrap_angle(bearing - oldest.bearing) / window_dt : 0.0
    closing_speed_L = dt > 0 ? (previous.distance_L - distance_L) / dt : 0.0
    heading_rate = Float64(state.omega) * Float64(Lf)
    turn_rate_recent = window_dt > 0 ? wrap_angle(Float64(state.theta) - oldest.heading) / window_dt : heading_rate
    return (
        distance_L,
        target_body_L,
        velocity_body_U=velocity_body,
        local_flow_velocity_body_U=local_flow_body,
        relative_flow_velocity_body_U=relative_flow_body,
        force_body_L=force_body,
        moment_z_L2=Float64(moment_z) / Float64(Lf)^3,
        bearing,
        bearing_rate,
        bearing_window_rate,
        heading_rate,
        turn_rate_recent,
        closing_speed_L,
        wake_crossflow_velocity_U=Float64(local_flow_body[2]),
        phi=(joint.phi1, joint.phi2),
        phi_dot=(joint.phi_dot1, joint.phi_dot2),
        previous_action=(joint.phi_ddot1, joint.phi_ddot2),
    )
end

function write_json(path, value)
    open(path, "w") do io
        JSON.print(io, Base2D.jsonable(value), 2)
        println(io)
    end
    return path
end

function write_midplane_frame!(path, sim, z_plane, elapsed)
    WaterLily.@loop sim.flow.σ[I] = WaterLily.curl(3, I, sim.flow.u) over I in WaterLily.inside(sim.flow.p)
    iz = clamp(round(Int, Float64(z_plane)), 2, size(sim.flow.p, 3) - 1)
    vorticity = Float32.(Array(@view sim.flow.σ[:, :, iz]))
    occupancy = Float32.(Array(@view sim.flow.μ₀[:, :, iz, 1]))
    size(vorticity) == size(occupancy) || error("mid-plane diagnostic arrays have inconsistent shapes")
    open(path, "w") do io
        write(io, Int32(size(vorticity, 1)))
        write(io, Int32(size(vorticity, 2)))
        write(io, Float64(elapsed))
        write(io, vorticity)
        write(io, occupancy)
    end
    return path
end

function fixed_follow_crop(center_index, width, axis_length)
    crop_width = min(max(4, width), axis_length)
    lower = clamp(round(Int, center_index) - fld(crop_width, 2), 1, axis_length - crop_width + 1)
    return lower:(lower + crop_width - 1)
end

function write_cropped_volume_frame!(path, sim, state, Lf, elapsed, follow_window_L)
    width = round(Int, follow_window_L * Float64(Lf))
    x_range = fixed_follow_crop(Float64(state.center[1]), width, size(sim.flow.p, 1))
    y_range = fixed_follow_crop(Float64(state.center[2]), width, size(sim.flow.p, 2))
    z_range = axes(sim.flow.p, 3)

    lambda2_scale = (sim.L / sim.U)^2
    WaterLily.@inside sim.flow.σ[I] = WaterLily.λ₂(I, sim.flow.u) * lambda2_scale
    lambda2 = Float32.(Array(@view sim.flow.σ[x_range, y_range, z_range]))

    vorticity_scale = sim.L / sim.U
    WaterLily.@inside sim.flow.σ[I] = WaterLily.curl(3, I, sim.flow.u) * vorticity_scale
    vorticity_z = Float32.(Array(@view sim.flow.σ[x_range, y_range, z_range]))

    WaterLily.measure_sdf!(sim.flow.σ, sim.body, WaterLily.time(sim.flow); fastd²=0f0)
    body_sdf = Float32.(Array(@view sim.flow.σ[x_range, y_range, z_range]))
    size(lambda2) == size(vorticity_z) == size(body_sdf) ||
        error("cropped-volume diagnostic arrays have inconsistent shapes")

    open(path, "w") do io
        write(io, codeunits("D3CVOL1\n"))
        write(io, Int32(size(lambda2, 1)))
        write(io, Int32(size(lambda2, 2)))
        write(io, Int32(size(lambda2, 3)))
        write(io, Int32(first(x_range)))
        write(io, Int32(first(y_range)))
        write(io, Int32(first(z_range)))
        write(io, Int32(round(Int, Float64(Lf))))
        write(io, Float64(elapsed))
        write(io, Float64(state.center[1] / Lf))
        write(io, Float64(state.center[2] / Lf))
        write(io, Float64(state.theta))
        write(io, Float64(follow_window_L))
        write(io, lambda2)
        write(io, vorticity_z)
        write(io, body_sdf)
    end
    return (
        path=abspath(path),
        dims=size(lambda2),
        crop_first=(first(x_range), first(y_range), first(z_range)),
        crop_last=(last(x_range), last(y_range), last(z_range)),
    )
end

function write_hero_volume_frame!(
    path, sim, state, Lf, elapsed, sample_stride, diagnostic_scratch,
)
    stride_x, stride_y, stride_z = sample_stride
    # WaterLily allocates one ghost layer on each face.  D3CVOL2 stores only
    # the physical 512x256x96 domain advertised by runtime_spec/domain_dims.
    x_range = 2:stride_x:(size(sim.flow.p, 1) - 1)
    y_range = 2:stride_y:(size(sim.flow.p, 2) - 1)
    z_range = 2:stride_z:(size(sim.flow.p, 3) - 1)

    size(diagnostic_scratch) == size(sim.flow.σ) ||
        error("hero diagnostic scratch has the wrong dimensions")
    lambda2_scale = (sim.L / sim.U)^2
    WaterLily.@inside diagnostic_scratch[I] =
        WaterLily.λ₂(I, sim.flow.u) * lambda2_scale
    lambda2 = Float32.(Array(@view diagnostic_scratch[x_range, y_range, z_range]))

    vorticity_scale = sim.L / sim.U
    WaterLily.@inside diagnostic_scratch[I] =
        WaterLily.curl(3, I, sim.flow.u) * vorticity_scale
    vorticity_z = Float32.(Array(@view diagnostic_scratch[x_range, y_range, z_range]))

    WaterLily.measure_sdf!(
        diagnostic_scratch, sim.body, WaterLily.time(sim.flow); fastd²=0f0,
    )
    body_sdf = Float32.(Array(@view diagnostic_scratch[x_range, y_range, z_range]))
    size(lambda2) == size(vorticity_z) == size(body_sdf) ||
        error("hero-volume diagnostic arrays have inconsistent shapes")

    full_dims = ntuple(index -> size(sim.flow.p, index) - 2, 3)
    domain_scale_L = ntuple(index -> Float64(full_dims[index]) / Float64(Lf), 3)
    open(path, "w") do io
        write(io, codeunits("D3CVOL2\n"))
        for value in (
            size(lambda2, 1), size(lambda2, 2), size(lambda2, 3),
            first(x_range), first(y_range), first(z_range),
            round(Int, Float64(Lf)),
            stride_x, stride_y, stride_z,
            full_dims[1], full_dims[2], full_dims[3],
        )
            write(io, Int32(value))
        end
        for value in (
            Float64(elapsed),
            Float64(state.center[1] / Lf),
            Float64(state.center[2] / Lf),
            Float64(state.theta),
            domain_scale_L[1],
            domain_scale_L[2],
            domain_scale_L[3],
        )
            write(io, value)
        end
        write(io, lambda2)
        write(io, vorticity_z)
        write(io, body_sdf)
    end
    return (
        path=abspath(path),
        dims=size(lambda2),
        crop_first=(first(x_range), first(y_range), first(z_range)),
        crop_last=(last(x_range), last(y_range), last(z_range)),
        sample_stride,
        full_dims,
        domain_scale_L,
    )
end

function rollout_score_metrics(traces, initial_distance_L, horizon, termination)
    times = [0.0; [Float64(row.elapsed) for row in traces]]
    distances = [Float64(initial_distance_L); [Float64(row.distance_L) for row in traces]]
    horizon_safe = max(Float64(horizon), eps(Float64))
    observed_distance_integral_L = 0.0
    for index in 2:length(times)
        dt_fraction = max(0.0, times[index] - times[index - 1]) / horizon_safe
        observed_distance_integral_L += 0.5 * (distances[index - 1] + distances[index]) * dt_fraction
    end
    elapsed_fraction = clamp(last(times) / horizon_safe, 0.0, 1.0)
    terminal_hold_integral_L = last(distances) * max(0.0, 1.0 - elapsed_fraction)
    distance_integral_L = observed_distance_integral_L + terminal_hold_integral_L
    captured = termination == "capture"
    unstable = termination in ("nonfinite_state", "solver_error", "max_steps")
    weighted_distance_integral_score = -distance_integral_L
    final_distance_score = -0.2 * last(distances)
    survival_score = 0.2 * elapsed_fraction
    success_score = captured ? 2.0 : 0.0
    unstable_penalty = unstable ? 2.0 : 0.0
    score = weighted_distance_integral_score + final_distance_score + survival_score +
        success_score - unstable_penalty
    return (
        score,
        score_semantics="dogfish.projected_multiwake_target3d.v1",
        distance_integral_weight=1.0,
        final_distance_weight=0.2,
        survival_bonus_weight=0.2,
        capture_bonus=2.0,
        unstable_dynamics_penalty=2.0,
        observed_distance_integral_L,
        terminal_hold_integral_L,
        distance_integral_L,
        mean_distance_L=distance_integral_L,
        elapsed_fraction,
        initial_distance_L=first(distances),
        final_distance_L=last(distances),
        minimum_distance_L=minimum(distances),
        progress=(first(distances) - last(distances)) / max(first(distances), eps(Float64)),
        minimum_progress=(first(distances) - minimum(distances)) / max(first(distances), eps(Float64)),
        captured,
        unstable,
    )
end

function main()
    config_path = abspath(env_string(
        "DOGFISH3D_ROLLOUT_CONFIG",
        joinpath(case_dir, "configs", "free_swim_multiwake_target_secondrow_capture0p5_scaled16x16_l32_3d.toml"),
    ))
    geometry_path = abspath(env_string(
        "DOGFISH3D_GEOMETRY_CONFIG",
        joinpath(case_dir, "configs", "dogfish_nurbs_modeler_default_body_caudal_v1.json"),
    ))
    source_spec = load_projected_multiwake_spec_3d(config_path)
    config = TOML.parsefile(config_path)
    initialization_mode = env_string("DOGFISH3D_INITIALIZATION_MODE", "snapshot")
    initialization_mode in ("snapshot", "uniform_direct") || error(
        "DOGFISH3D_INITIALIZATION_MODE must be snapshot or uniform_direct",
    )
    snapshot_path = ""
    prewarm_report = if initialization_mode == "snapshot"
        snapshot_path = abspath(env_string("DOGFISH3D_PREWARM_SNAPSHOT", ""))
        isempty(snapshot_path) && error("DOGFISH3D_PREWARM_SNAPSHOT is required")
        isfile(snapshot_path) || error("prewarm snapshot not found: $snapshot_path")
        prewarm_report_path = joinpath(dirname(snapshot_path), "prewarm_report.json")
        isfile(prewarm_report_path) || error("prewarm report not found beside snapshot")
        report = JSON.parsefile(prewarm_report_path)
        report["status"] == "ok" || error("prewarm report is not successful")
        report
    else
        projected = config["projected_multiwake_3d"]
        Dict{String,Any}(
            "runtime_resolution" => source_spec.L,
            "config_sha256" => sha256_file(config_path),
            "requested_max_dimensionless_dt" => Float64(
                config["free_swim"]["max_dimensionless_dt"],
            ),
            "runtime_fin_x_start" => Float64(get(projected, "fin_x_start", 0.80)),
            "fin_min_root_half_cells" => env_float(
                "DOGFISH3D_DIRECT_FIN_MIN_ROOT_HALF_CELLS", 1.0,
            ),
            "fin_min_midplane_half_cells" => env_float(
                "DOGFISH3D_DIRECT_FIN_MIN_MIDPLANE_HALF_CELLS", 0.0,
            ),
        )
    end
    runtime_L = env_int("DOGFISH3D_ROLLOUT_L", Int(prewarm_report["runtime_resolution"]))
    runtime_spec = merge(source_spec, (L=runtime_L, backend=env_string("DOGFISH_MEMORY_BACKEND", source_spec.backend)))
    validate_projected_multiwake_spec_3d(runtime_spec)
    if initialization_mode == "snapshot"
        Int(prewarm_report["runtime_resolution"]) == runtime_L || error("snapshot resolution mismatch")
        String(prewarm_report["config_sha256"]) == sha256_file(config_path) || error("snapshot config hash mismatch")
    end

    max_dimensionless_dt = env_float("DOGFISH3D_ROLLOUT_DT", Float64(prewarm_report["requested_max_dimensionless_dt"]))
    horizon = env_float("DOGFISH3D_ROLLOUT_HORIZON", source_spec.rollout_horizon)
    horizon > 0 || error("rollout horizon must be positive")
    max_steps = env_int("DOGFISH3D_ROLLOUT_MAX_STEPS", 100_000)
    output_root = abspath(env_string(
        "DOGFISH3D_ROLLOUT_OUTPUT",
        joinpath(case_dir, "logs", "projected_multiwake_policy_smoke3d"),
    ))
    flow_filter_alpha = clamp(env_float("DOGFISH3D_FLOW_FILTER_ALPHA", 0.25), 0.0, 1.0)
    control_mode = env_string("DOGFISH3D_CONTROL_MODE", "candidate_policy")
    control_mode in ("candidate_policy", "iter11_policy", "prescribed_straight_gait", "prescribed_heading_control", "prescribed_dynamic_heading_control", "prescribed_logged_trajectory") ||
        error("DOGFISH3D_CONTROL_MODE must be candidate_policy, iter11_policy, prescribed_straight_gait, prescribed_heading_control, prescribed_dynamic_heading_control, or prescribed_logged_trajectory")
    logged_trajectory_raw_path = env_string("DOGFISH3D_LOGGED_TRAJECTORY_FILE", "")
    logged_trajectory_path = isempty(logged_trajectory_raw_path) ?
        "" : abspath(logged_trajectory_raw_path)
    logged_trajectory_expected_sha256 = lowercase(
        env_string("DOGFISH3D_LOGGED_TRAJECTORY_EXPECTED_SHA256", ""),
    )
    logged_trajectory_bundle = if control_mode == "prescribed_logged_trajectory"
        isempty(logged_trajectory_path) && error(
            "DOGFISH3D_LOGGED_TRAJECTORY_FILE is required for prescribed_logged_trajectory",
        )
        isfile(logged_trajectory_path) || error(
            "logged trajectory not found: $logged_trajectory_path",
        )
        bundle = load_logged_joint_history(logged_trajectory_path)
        !isempty(logged_trajectory_expected_sha256) &&
            lowercase(bundle.metadata.sha256) != logged_trajectory_expected_sha256 &&
            error("logged trajectory SHA-256 mismatch")
        bundle.metadata.start_time_T <= 0.0 || error(
            "logged trajectory must start at or before 0T",
        )
        bundle.metadata.end_time_T + 1e-9 >= horizon || error(
            "logged trajectory ends before rollout horizon",
        )
        bundle
    else
        nothing
    end
    prescribed_carrier = lowercase(env_string("DOGFISH3D_PRESCRIBED_CARRIER", "analytic_sine"))
    prescribed_carrier in (
        "analytic_sine", "successful_2d_fourier_zero_mean",
        "successful_2d_fourier_odd_harmonics",
    ) || error(
        "DOGFISH3D_PRESCRIBED_CARRIER must be analytic_sine, " *
        "successful_2d_fourier_zero_mean, or successful_2d_fourier_odd_harmonics",
    )
    straight_period = env_float(
        "DOGFISH3D_STRAIGHT_PERIOD",
        prescribed_carrier == "analytic_sine" ? 1.1 : TWO_D_FOURIER_PERIOD_T,
    )
    straight_amp1 = env_float("DOGFISH3D_STRAIGHT_AMP1_DEG", 7.5) * DEG
    straight_amp2 = env_float("DOGFISH3D_STRAIGHT_AMP2_DEG", 9.75) * DEG
    straight_bias1 = env_float("DOGFISH3D_STRAIGHT_BIAS1_DEG", 0.0) * DEG
    straight_bias2 = env_float("DOGFISH3D_STRAIGHT_BIAS2_DEG", 0.0) * DEG
    straight_asymmetry1 = env_float("DOGFISH3D_STRAIGHT_HALF_CYCLE_ASYMMETRY1", 0.0)
    straight_asymmetry2 = env_float("DOGFISH3D_STRAIGHT_HALF_CYCLE_ASYMMETRY2", 0.0)
    straight_asymmetry1_late = env_float("DOGFISH3D_STRAIGHT_HALF_CYCLE_ASYMMETRY1_LATE", straight_asymmetry1)
    straight_asymmetry2_late = env_float("DOGFISH3D_STRAIGHT_HALF_CYCLE_ASYMMETRY2_LATE", straight_asymmetry2)
    all(abs(value) <= 0.95 for value in (
        straight_asymmetry1, straight_asymmetry2,
        straight_asymmetry1_late, straight_asymmetry2_late,
    )) || error("straight half-cycle asymmetries must have magnitude at most 0.95")
    straight_bias1_late = env_float("DOGFISH3D_STRAIGHT_BIAS1_LATE_DEG", straight_bias1 / DEG) * DEG
    straight_bias2_late = env_float("DOGFISH3D_STRAIGHT_BIAS2_LATE_DEG", straight_bias2 / DEG) * DEG
    straight_bias_transition_start = env_float("DOGFISH3D_STRAIGHT_BIAS_TRANSITION_START_T", Inf)
    straight_bias_transition_end = env_float("DOGFISH3D_STRAIGHT_BIAS_TRANSITION_END_T", Inf)
    straight_bias_transition_end >= straight_bias_transition_start ||
        error("straight bias transition end must be no earlier than start")
    straight_phase_lag = env_float("DOGFISH3D_STRAIGHT_PHASE_LAG_DEG", 85.0) * DEG
    carrier_global_phase_offset = env_float(
        "DOGFISH3D_CARRIER_GLOBAL_PHASE_DEG", 0.0,
    ) * DEG
    abs(carrier_global_phase_offset) <= pi ||
        error("DOGFISH3D_CARRIER_GLOBAL_PHASE_DEG magnitude must be at most 180")
    steering_harmonic = env_int("DOGFISH3D_STEERING_HARMONIC", 2)
    steering_harmonic in (1, 2) || error("DOGFISH3D_STEERING_HARMONIC must be 1 or 2")
    steering_phase_offset = env_float("DOGFISH3D_STEERING_PHASE_OFFSET_DEG", 0.0) * DEG
    analytic_steering_mode = lowercase(env_string(
        "DOGFISH3D_ANALYTIC_STEERING_MODE", "legacy_halfcycle",
    ))
    analytic_steering_mode in ("legacy_halfcycle", "smooth_harmonic") || error(
        "DOGFISH3D_ANALYTIC_STEERING_MODE must be legacy_halfcycle or smooth_harmonic",
    )
    analytic_steering_amp1 = env_float(
        "DOGFISH3D_ANALYTIC_STEERING_AMP1_DEG", 10.5,
    ) * DEG
    analytic_steering_amp2 = env_float(
        "DOGFISH3D_ANALYTIC_STEERING_AMP2_DEG", -3.0,
    ) * DEG
    carrier_scale = env_float("DOGFISH3D_CARRIER_SCALE", 1.0)
    carrier_scale1 = env_float("DOGFISH3D_CARRIER_SCALE1", carrier_scale)
    carrier_scale2 = env_float("DOGFISH3D_CARRIER_SCALE2", carrier_scale)
    carrier_phase_shift2 = env_float("DOGFISH3D_CARRIER_PHASE_SHIFT2_DEG", 0.0) * DEG
    all(0.0 <= value <= 3.0 for value in (carrier_scale, carrier_scale1, carrier_scale2)) ||
        error("DOGFISH3D carrier scales must be in [0,3]")
    abs(carrier_phase_shift2) <= pi ||
        error("DOGFISH3D_CARRIER_PHASE_SHIFT2_DEG magnitude must be at most 180")
    initial_heading_override = strip(get(ENV, "DOGFISH3D_INITIAL_HEADING_OVERRIDE_DEG", ""))
    initial_heading_deg = isempty(initial_heading_override) ?
        Float64(runtime_spec.initial_heading_deg) : parse(Float64, initial_heading_override)
    initial_phi1_deg = env_float(
        "DOGFISH3D_INITIAL_PHI1_OVERRIDE_DEG",
        Float64(config["projected_multiwake_3d"]["initial_phi1_deg"]),
    )
    initial_phi2_deg = env_float(
        "DOGFISH3D_INITIAL_PHI2_OVERRIDE_DEG",
        Float64(config["projected_multiwake_3d"]["initial_phi2_deg"]),
    )
    abs(initial_phi1_deg) <= runtime_spec.phi_limit_deg ||
        error("DOGFISH3D_INITIAL_PHI1_OVERRIDE_DEG exceeds the joint-angle limit")
    abs(initial_phi2_deg) <= runtime_spec.phi_limit_deg ||
        error("DOGFISH3D_INITIAL_PHI2_OVERRIDE_DEG exceeds the joint-angle limit")
    initial_yaw_rate_T = env_float("DOGFISH3D_INITIAL_YAW_RATE_RAD_PER_T", 0.0)
    abs(initial_yaw_rate_T) <= 2.0 || error("DOGFISH3D_INITIAL_YAW_RATE_RAD_PER_T magnitude must be at most 2")
    straight_ramp_periods = env_float("DOGFISH3D_STRAIGHT_RAMP_PERIODS", 0.6)
    prescribed_carrier != "analytic_sine" &&
        control_mode == "prescribed_heading_control" &&
        error("Fourier carrier heading control must use dynamic asymmetry, not the retired static-bias controller")
    control_mode == "prescribed_dynamic_heading_control" &&
        prescribed_carrier == "analytic_sine" &&
        analytic_steering_mode != "smooth_harmonic" &&
        error("Analytic-sine dynamic heading control requires DOGFISH3D_ANALYTIC_STEERING_MODE=smooth_harmonic")
    prescribed_carrier == "analytic_sine" &&
        analytic_steering_mode == "smooth_harmonic" &&
        any(abs(value) > 1e-12 for value in (
            straight_bias1, straight_bias2, straight_bias1_late, straight_bias2_late,
        )) &&
        error("smooth analytic harmonic steering forbids static joint bias")
    propulsion_only_surge = env_bool("DOGFISH3D_PROPULSION_ONLY_SURGE", false)
    heading_trim_bias = env_float("DOGFISH3D_HEADING_TRIM_BIAS_DEG", 0.0) * DEG
    heading_use_scheduled_feedforward = env_bool("DOGFISH3D_HEADING_USE_SCHEDULED_FEEDFORWARD", false)
    heading_kp = env_float("DOGFISH3D_HEADING_KP", 0.0)
    heading_kd_T = env_float("DOGFISH3D_HEADING_KD_T", 0.0)
    heading_bias_limit = env_float("DOGFISH3D_HEADING_BIAS_LIMIT_DEG", 32.0) * DEG
    heading_trim_asymmetry = env_float("DOGFISH3D_HEADING_TRIM_ASYMMETRY", 0.0)
    heading_asymmetry_limit = env_float("DOGFISH3D_HEADING_ASYMMETRY_LIMIT", 0.14)
    heading_unilateral_command_sign = env_float(
        "DOGFISH3D_HEADING_UNILATERAL_COMMAND_SIGN", 0.0,
    )
    heading_unilateral_command_sign in (-1.0, 0.0, 1.0) || error(
        "DOGFISH3D_HEADING_UNILATERAL_COMMAND_SIGN must be -1, 0, or +1",
    )
    heading_command_filter_tau_T = env_float(
        "DOGFISH3D_HEADING_COMMAND_FILTER_TAU_T", 0.0,
    )
    heading_command_filter_tau_T >= 0 ||
        error("DOGFISH3D_HEADING_COMMAND_FILTER_TAU_T must be nonnegative")
    turn_brake_schedule_enabled = env_bool(
        "DOGFISH3D_TURN_BRAKE_SCHEDULE_ENABLED", false,
    )
    turn_brake_turn_command = env_float(
        "DOGFISH3D_TURN_BRAKE_TURN_COMMAND", 0.0,
    )
    turn_brake_brake_command = env_float(
        "DOGFISH3D_TURN_BRAKE_BRAKE_COMMAND", 0.0,
    )
    turn_brake_post_neutral_command = env_float(
        "DOGFISH3D_TURN_BRAKE_POST_NEUTRAL_COMMAND", 0.0,
    )
    turn_brake_turn_start_T = env_float(
        "DOGFISH3D_TURN_BRAKE_TURN_START_T", 1.1,
    )
    turn_brake_brake_start_T = env_float(
        "DOGFISH3D_TURN_BRAKE_BRAKE_START_T", 3.3,
    )
    turn_brake_neutral_start_T = env_float(
        "DOGFISH3D_TURN_BRAKE_NEUTRAL_START_T", 4.4,
    )
    if turn_brake_schedule_enabled
        control_mode == "prescribed_dynamic_heading_control" || error(
            "turn-brake schedule requires prescribed_dynamic_heading_control",
        )
        heading_unilateral_command_sign == 0 || error(
            "turn-brake schedule requires bilateral command interval",
        )
        0 <= turn_brake_turn_start_T < turn_brake_brake_start_T <
            turn_brake_neutral_start_T || error(
            "turn-brake schedule times must satisfy 0 <= turn < brake < neutral",
        )
        max(
            abs(turn_brake_turn_command),
            abs(turn_brake_brake_command),
            abs(turn_brake_post_neutral_command),
        ) <=
            heading_asymmetry_limit || error(
            "turn-brake schedule command exceeds the heading asymmetry limit",
        )
        turn_brake_turn_command * turn_brake_brake_command < 0 || error(
            "turn-brake turn and brake commands must have opposite signs",
        )
    end
    heading_actuator_basis = lowercase(env_string("DOGFISH3D_HEADING_ACTUATOR_BASIS", "common"))
    heading_actuator_basis in ("common", "differential") ||
        error("DOGFISH3D_HEADING_ACTUATOR_BASIS must be common or differential")
    heading_actuator_yaw_gain_sign = env_float(
        "DOGFISH3D_HEADING_ACTUATOR_YAW_GAIN_SIGN", -1.0,
    )
    heading_actuator_yaw_gain_sign in (-1.0, 1.0) ||
        error("DOGFISH3D_HEADING_ACTUATOR_YAW_GAIN_SIGN must be -1 or +1")
    heading_phase_authority_path = env_string("DOGFISH3D_HEADING_PHASE_AUTHORITY_JSON", "")
    heading_phase_authority_expected_sha256 = lowercase(env_string(
        "DOGFISH3D_HEADING_PHASE_AUTHORITY_EXPECTED_SHA256", "",
    ))
    heading_phase_authority = isempty(heading_phase_authority_path) ? nothing :
        load_heading_phase_authority(
            heading_phase_authority_path,
            heading_phase_authority_expected_sha256,
        )
    june13_smooth_h2_contract = (
        prescribed_carrier == "analytic_sine" &&
        analytic_steering_mode == "smooth_harmonic" &&
        steering_harmonic == 2 &&
        isapprox(straight_period, 1.1; atol=1e-12) &&
        isapprox(straight_amp1 / DEG, 20.0; atol=1e-12) &&
        isapprox(straight_amp2 / DEG, 26.0; atol=1e-12) &&
        isapprox(analytic_steering_amp1 / DEG, 10.5; atol=1e-12) &&
        isapprox(analytic_steering_amp2 / DEG, -3.0; atol=1e-12)
    )
    heading_asymmetry_limit_cap = june13_smooth_h2_contract ? 0.8 : 0.14
    0.0 <= heading_asymmetry_limit <= heading_asymmetry_limit_cap || error(
        "DOGFISH3D_HEADING_ASYMMETRY_LIMIT exceeds the validated action-contract cap " *
        string(heading_asymmetry_limit_cap),
    )
    heading_feedback_start_T = env_float("DOGFISH3D_HEADING_FEEDBACK_START_T", 0.0)
    heading_feedback_ramp_end_T = env_float("DOGFISH3D_HEADING_FEEDBACK_RAMP_END_T", heading_feedback_start_T)
    heading_filter_tau_T = env_float("DOGFISH3D_HEADING_FILTER_TAU_T", 0.0)
    heading_update_periods = env_int("DOGFISH3D_HEADING_UPDATE_PERIODS", 0)
    heading_update_periods >= 0 || error("DOGFISH3D_HEADING_UPDATE_PERIODS must be nonnegative")
    turn_brake_schedule_enabled && heading_update_periods != 0 &&
        error("turn-brake schedule requires continuous command updates")
    heading_phase_authority !== nothing && heading_update_periods != 0 &&
        error("phase-authority control requires continuous heading updates")
    heading_feedback_ramp_end_T >= heading_feedback_start_T ||
        error("heading feedback ramp end must be no earlier than start")
    heading_filter_tau_T >= 0 || error("heading filter time constant must be nonnegative")
    heading_initial_offset = env_float("DOGFISH3D_HEADING_INITIAL_OFFSET_DEG", 0.0) * DEG
    heading_step_offset = env_float("DOGFISH3D_HEADING_STEP_OFFSET_DEG", 0.0) * DEG
    heading_step_time = env_float("DOGFISH3D_HEADING_STEP_TIME_T", Inf)
    vtk_enabled = env_bool("DOGFISH3D_ROLLOUT_VTK", false)
    vtk_frame_count = env_int("DOGFISH3D_ROLLOUT_VTK_FRAMES", 41)
    vtk_frame_count >= 2 || error("DOGFISH3D_ROLLOUT_VTK_FRAMES must be at least 2")
    midplane_enabled = env_bool("DOGFISH3D_ROLLOUT_MIDPLANE", false)
    midplane_frame_count = env_int("DOGFISH3D_ROLLOUT_MIDPLANE_FRAMES", 21)
    midplane_frame_count >= 2 || error("DOGFISH3D_ROLLOUT_MIDPLANE_FRAMES must be at least 2")
    cropped_volume_enabled = env_bool("DOGFISH3D_ROLLOUT_CROPPED_VOLUME", false)
    cropped_volume_frame_count = env_int("DOGFISH3D_ROLLOUT_CROPPED_VOLUME_FRAMES", 9)
    cropped_volume_frame_count >= 2 ||
        error("DOGFISH3D_ROLLOUT_CROPPED_VOLUME_FRAMES must be at least 2")
    cropped_volume_follow_window_L = env_float("DOGFISH3D_ROLLOUT_CROPPED_VOLUME_WINDOW_L", 4.0)
    2.0 <= cropped_volume_follow_window_L <= min(runtime_spec.domain_scale_L[1:2]...) ||
        error("DOGFISH3D_ROLLOUT_CROPPED_VOLUME_WINDOW_L must be within [2, min(domain_x,domain_y)]")
    hero_volume_enabled = env_bool("DOGFISH3D_ROLLOUT_HERO_VOLUME", false)
    hero_volume_frame_count = env_int("DOGFISH3D_ROLLOUT_HERO_VOLUME_FRAMES", 91)
    hero_volume_frame_count >= 2 ||
        error("DOGFISH3D_ROLLOUT_HERO_VOLUME_FRAMES must be at least 2")
    hero_volume_sample_stride = (
        env_int("DOGFISH3D_ROLLOUT_HERO_VOLUME_STRIDE_X", 2),
        env_int("DOGFISH3D_ROLLOUT_HERO_VOLUME_STRIDE_Y", 2),
        env_int("DOGFISH3D_ROLLOUT_HERO_VOLUME_STRIDE_Z", 1),
    )
    all(value -> 1 <= value <= 8, hero_volume_sample_stride) ||
        error("DOGFISH3D_ROLLOUT_HERO_VOLUME_STRIDE_{X,Y,Z} must be within [1,8]")
    allow_scientific_failure = env_bool("DOGFISH3D_ALLOW_SCIENTIFIC_FAILURE", false)
    reference_model = lowercase(env_string("DOGFISH3D_REFERENCE_MODEL", "material_station"))
    reference_model in (
        "material_station", "actual_superellipse_centroid", "two_d_matched_mass_centroid",
    ) || error(
        "DOGFISH3D_REFERENCE_MODEL must be material_station, actual_superellipse_centroid, " *
        "or two_d_matched_mass_centroid",
    )
    mkpath(output_root)

    T = Float32
    L = runtime_L
    Lf = T(L)
    backend = Base2D.resolve_memory_backend(backend=runtime_spec.backend)
    dims = Tuple(max(4, Int(round(scale * L))) for scale in runtime_spec.domain_scale_L)
    raw_dt_cap = T(max_dimensionless_dt) * Lf
    inflow = Tuple(T(value) for value in runtime_spec.flow_velocity_L)
    z_plane = T(runtime_spec.z_plane_fraction * runtime_spec.domain_scale_L[3] * L)
    runtime_target_L = (
        env_float("DOGFISH3D_TARGET_X_L", runtime_spec.target_L[1]),
        env_float("DOGFISH3D_TARGET_Y_L", runtime_spec.target_L[2]),
    )
    target = SVector(T(runtime_target_L[1]) * Lf, T(runtime_target_L[2]) * Lf)
    success_radius = T(runtime_spec.success_radius_L) * Lf
    0.0 <= Float64(MATERIAL_REFERENCE_STATION) <= 1.0 ||
        error("DOGFISH3D_MATERIAL_REFERENCE_STATION must be in [0,1]")

    policy_params = target_policy_params()
    design = target_control_design(control_period=Float32(policy_params.control_period))
    experiment = first(Base2D.design_experiments(design))
    _, base_params, period = Base2D.assemble_experiment_for_length(design, experiment; L, T)
    profile = T3D.dogfish3d_thickness_profile(T)
    mass_profile_2d = Base2D.baseline_thickness_profile(T)
    body_height_scale = env_float("DOGFISH3D_BODY_HEIGHT_SCALE", 1.0)
    0.5 <= body_height_scale <= 2.0 ||
        error("DOGFISH3D_BODY_HEIGHT_SCALE must be in [0.5, 2.0]")
    body_geometry = lowercase(env_string("DOGFISH3D_BODY_GEOMETRY", "modeler_default"))
    body_geometry in (
        "modeler_default", "integrated_caudal", "integrated_thin_web",
        "integrated_embedded_plate", "integrated_profiled_caudal_v7",
        "june13_superellipse_fan",
    ) ||
        error(
            "DOGFISH3D_BODY_GEOMETRY must be modeler_default, integrated_caudal, " *
            "integrated_thin_web, integrated_embedded_plate, integrated_profiled_caudal_v7 " *
            "or june13_superellipse_fan",
        )
    june13_reference_body = body_geometry == "june13_superellipse_fan"
    june13_reference_body && body_height_scale != 1.0 &&
        error("june13_superellipse_fan requires DOGFISH3D_BODY_HEIGHT_SCALE=1")
    june13_reference_body && reference_model != "actual_superellipse_centroid" &&
        error("june13_superellipse_fan requires DOGFISH3D_REFERENCE_MODEL=actual_superellipse_centroid")
    integrated_body = body_geometry in (
        "integrated_caudal", "integrated_thin_web", "integrated_embedded_plate",
        "integrated_profiled_caudal_v7",
    )
    profiled_caudal_v7 = body_geometry == "integrated_profiled_caudal_v7"
    integrated_caudal_variant = Symbol(lowercase(env_string(
        "DOGFISH3D_INTEGRATED_CAUDAL_VARIANT", "balanced",
    )))
    integrated_caudal_variant in (:compact, :balanced, :strong) ||
        error("DOGFISH3D_INTEGRATED_CAUDAL_VARIANT must be compact, balanced or strong")
    thin_web_variant = Symbol(lowercase(env_string(
        "DOGFISH3D_THIN_WEB_VARIANT", "thin_boxy",
    )))
    thin_web_variant in (:thin_elliptic, :thin_boxy, :thin_tuna_boxy) ||
        error(
            "DOGFISH3D_THIN_WEB_VARIANT must be thin_elliptic, thin_boxy or thin_tuna_boxy",
        )
    integrated_caudal_span_scale = env_float("DOGFISH3D_INTEGRATED_CAUDAL_SPAN_SCALE", 1.0)
    integrated_caudal_span_scale > 0 ||
        error("DOGFISH3D_INTEGRATED_CAUDAL_SPAN_SCALE must be positive")
    integrated_peduncle_half_width = env_float(
        "DOGFISH3D_INTEGRATED_PEDUNCLE_HALF_WIDTH", 0.025,
    )
    integrated_tail_half_width = env_float(
        "DOGFISH3D_INTEGRATED_TAIL_HALF_WIDTH", 0.016,
    )
    integrated_caudal_mass_model = lowercase(env_string(
        "DOGFISH3D_INTEGRATED_CAUDAL_MASS_MODEL", "two_d_matched",
    ))
    integrated_caudal_mass_model in ("two_d_matched", "hydrodynamic_body") ||
        error(
            "DOGFISH3D_INTEGRATED_CAUDAL_MASS_MODEL must be two_d_matched or hydrodynamic_body",
        )
    embedded_plate_added_mass_scale = env_float(
        "DOGFISH3D_EMBEDDED_PLATE_ADDED_MASS_SCALE", 0.5,
    )
    embedded_plate_added_mass_scale >= 0.0 ||
        error("embedded plate added mass scale must be nonnegative")
    body_added_inertia_scale = env_float("DOGFISH3D_BODY_ADDED_INERTIA_SCALE", 1.0)
    body_added_inertia_scale >= 0.0 ||
        error("body added inertia scale must be nonnegative")
    body_geometry in ("integrated_embedded_plate", "integrated_profiled_caudal_v7") &&
        integrated_caudal_mass_model != "two_d_matched" &&
        error("$body_geometry requires DOGFISH3D_INTEGRATED_CAUDAL_MASS_MODEL=two_d_matched")
    0 < integrated_tail_half_width <= integrated_peduncle_half_width < 0.0471 ||
        error("integrated tail/peduncle widths must satisfy 0 < tail <= peduncle < posterior body")
    body_sdf = if body_geometry == "integrated_caudal"
        integrated_body_caudal_sdf(
            T3D,
            Lf;
            variant=integrated_caudal_variant,
            body_height_scale=T(body_height_scale),
            caudal_span_scale=T(integrated_caudal_span_scale),
            peduncle_half_width=T(integrated_peduncle_half_width),
            tail_half_width=T(integrated_tail_half_width),
        )
    elseif body_geometry == "integrated_thin_web"
        body_height_scale == 1.0 ||
            error("integrated_thin_web uses an explicit 13-station height profile; BODY_HEIGHT_SCALE must be 1")
        integrated_body_caudal_thin_web_sdf(T3D, Lf; variant=thin_web_variant)
    elseif body_geometry == "integrated_embedded_plate"
        integrated_body_caudal_embedded_plate_sdf(
            T3D, Lf; body_height_scale=T(body_height_scale),
        )
    elseif profiled_caudal_v7
        profiled_caudal_v7_from_env(Lf, body_height_scale)
    else
        T3D.dogfish_body_sdf(Lf; height_scale=T(body_height_scale))
    end
    body_geometry_source_path = body_geometry == "integrated_caudal" ?
        joinpath(case_dir, "src", "integrated_body_caudal3d.jl") :
        body_geometry == "integrated_thin_web" ?
            joinpath(case_dir, "src", "integrated_body_caudal3d_thin_web.jl") :
        body_geometry == "integrated_embedded_plate" ?
            joinpath(case_dir, "src", "integrated_body_caudal3d_embedded_plate.jl") :
        body_geometry == "integrated_profiled_caudal_v7" ?
            joinpath(case_dir, "src", "integrated_body_caudal3d_profiled_fin_v7.jl") :
            joinpath(case_dir, "src", "body_superellipse3d.jl")
    fin_x_start = env_float("DOGFISH3D_FIN_X_START", Float64(prewarm_report["runtime_fin_x_start"]))
    fin_x_end = env_float("DOGFISH3D_FIN_X_END", 1.07)
    fin_upper_height = env_float(
        "DOGFISH3D_FIN_UPPER_HEIGHT", june13_reference_body ? 0.11 : 0.13,
    )
    fin_lower_height = env_float(
        "DOGFISH3D_FIN_LOWER_HEIGHT", june13_reference_body ? 0.11 : 0.09,
    )
    fin_half_thickness = env_float("DOGFISH3D_FIN_HALF_THICKNESS", 0.012)
    fin_material_density = env_float(
        "DOGFISH3D_FIN_MATERIAL_DENSITY", june13_reference_body ? 1.0 : 0.0,
    )
    fin_added_mass_scale = env_float("DOGFISH3D_FIN_ADDED_MASS_SCALE", 1.0)
    caudal_fin_enabled = env_bool("DOGFISH3D_CAUDAL_FIN_ENABLED", true)
    integrated_body && caudal_fin_enabled &&
        error("an integrated caudal body must not be combined with a separate caudal fin")
    integrated_body && integrated_caudal_mass_model == "two_d_matched" &&
        reference_model != "two_d_matched_mass_centroid" &&
        error("two_d_matched caudal mass requires DOGFISH3D_REFERENCE_MODEL=two_d_matched_mass_centroid")
    reference_model == "two_d_matched_mass_centroid" &&
        !(integrated_body && integrated_caudal_mass_model == "two_d_matched") &&
        error("two_d_matched_mass_centroid is only valid for an integrated caudal with two_d_matched mass")
    0.0 <= fin_x_start < fin_x_end || error("fin x stations must satisfy 0 <= start < end")
    fin_upper_height > 0.0 || error("fin upper height must be positive")
    fin_lower_height > 0.0 || error("fin lower height must be positive")
    fin_half_thickness > 0.0 || error("fin half thickness must be positive")
    fin_material_density >= 0.0 || error("fin material density must be nonnegative")
    fin_added_mass_scale >= 0.0 || error("fin added mass scale must be nonnegative")
    if june13_reference_body
        abs(fin_x_start - 0.80) <= 1.0e-12 ||
            error("june13_superellipse_fan requires DOGFISH3D_FIN_X_START=0.80")
        abs(fin_x_end - 1.07) <= 1.0e-12 ||
            error("june13_superellipse_fan requires DOGFISH3D_FIN_X_END=1.07")
        abs(fin_upper_height - 0.11) <= 1.0e-12 &&
            abs(fin_lower_height - 0.11) <= 1.0e-12 ||
            error("june13_superellipse_fan requires symmetric DOGFISH3D_FIN_*_HEIGHT=0.11")
        abs(fin_half_thickness - 0.012) <= 1.0e-12 ||
            error("june13_superellipse_fan requires DOGFISH3D_FIN_HALF_THICKNESS=0.012")
        caudal_fin_enabled ||
            error("june13_superellipse_fan requires DOGFISH3D_CAUDAL_FIN_ENABLED=true")
    end
    fin = if !caudal_fin_enabled
        nothing
    elseif june13_reference_body
        # Exact wet-geometry contract used by the preserved June-13 L32/L64/L128
        # WaterLily runs.  `min_cells=1` affects only grid-resolved SDF thickness;
        # dry mass must remain an analytical, resolution-independent reference.
        T3D.caudal_fin(
            Lf;
            x_start=0.80,
            x_end=1.07,
            height=0.11,
            half_thickness=0.012,
            min_cells=1.0,
        )
    else
        T3D.modeler_caudal_fin(
            body_sdf;
            x_start=fin_x_start,
            x_end=fin_x_end,
            upper_height=fin_upper_height,
            lower_height=fin_lower_height,
            half_thickness=fin_half_thickness,
            min_root_half_cells=Float64(prewarm_report["fin_min_root_half_cells"]),
            min_midplane_half_cells=Float64(prewarm_report["fin_min_midplane_half_cells"]),
        )
    end
    mass_property_fin = if june13_reference_body
        # The old runtime widened the *wet* fan to one cell at coarse L.  Its
        # material properties must instead be evaluated on the limiting
        # continuous geometry (the requested 0.012L half-thickness), otherwise
        # L32 and L64 would describe different fish masses.
        T3D.caudal_fin(
            Lf;
            x_start=0.80,
            x_end=1.07,
            height=0.11,
            half_thickness=0.012,
            min_cells=0.0,
        )
    else
        fin
    end
    centroid_caudal_fin = june13_reference_body ? mass_property_fin : nothing
    centroid_fin_material_density = T(fin_material_density)
    cylinders = T3D.projected_cylinder_union_3d(runtime_spec; T)
    state = Base2D.FreeSwimState(
        SVector(T(runtime_spec.initial_center_L[1]) * Lf, T(runtime_spec.initial_center_L[2]) * Lf),
        T(initial_heading_deg * DEG),
        SVector(zero(T), zero(T)),
        T(initial_yaw_rate_T / Float64(Lf)),
    )
    initial_heading = Float64(state.theta)
    initial_forward_axis = SVector(-cos(state.theta), -sin(state.theta))
    joint = control_mode == "prescribed_logged_trajectory" ?
        logged_joint_state(logged_trajectory_bundle.history, 0.0) :
        (
            phi1=initial_phi1_deg * DEG,
            phi2=initial_phi2_deg * DEG,
            phi_dot1=0.0,
            phi_dot2=0.0,
            phi_ddot1=0.0,
            phi_ddot2=0.0,
        )
    initial_joint = joint
    phi_limit = runtime_spec.phi_limit_deg * DEG
    phi_dot_limit = runtime_spec.phi_dot_limit_deg * DEG
    phi_ddot_limit = runtime_spec.phi_ddot_limit_deg * DEG
    if control_mode == "prescribed_logged_trajectory"
        history = logged_trajectory_bundle.history
        maximum(abs, vcat(history.phi1, history.phi2)) <= phi_limit + 1e-8 ||
            error("logged trajectory exceeds configured joint-angle limit")
        maximum(abs, vcat(history.phi_dot1, history.phi_dot2)) <= phi_dot_limit + 1e-8 ||
            error("logged trajectory exceeds configured joint-rate limit")
        maximum(abs, vcat(history.phi_ddot1, history.phi_ddot2)) <= phi_ddot_limit + 1e-8 ||
            error("logged trajectory exceeds configured joint-acceleration limit")
    end

    initial_map = T3D.free_swim_map_3d(
        design,
        base_params,
        profile,
        Lf,
        state,
        zero(T),
        raw_dt_cap,
        z_plane;
        reference_station=reference_model == "material_station" ? MATERIAL_REFERENCE_STATION : nothing,
        centroid_body_sdf=reference_model == "actual_superellipse_centroid" ? body_sdf : nothing,
        centroid_profile_2d=reference_model == "two_d_matched_mass_centroid" ?
            mass_profile_2d : nothing,
        centroid_caudal_fin=reference_model == "actual_superellipse_centroid" ?
            centroid_caudal_fin : nothing,
        centroid_fin_material_density,
    )
    fish_body = T3D.compose_body_3d(body_sdf, initial_map, fin)
    simulation_builder = () -> Simulation(
        dims,
        inflow,
        L;
        U=one(T),
        Δt=raw_dt_cap,
        ν=Lf / T(runtime_spec.Re),
        body=fish_body ∪ cylinders,
        T,
        mem=backend.mem,
        exitBC=Bool(config["projected_multiwake_3d"]["exit_bc"]),
    )
    sim = backend.name == "cuda" ? Base.invokelatest(simulation_builder) : simulation_builder()
    if initialization_mode == "snapshot"
        WaterLily.load!(sim, Val(:jld2); fname=basename(snapshot_path), dir=dirname(snapshot_path))
    end
    sim.flow.Δt[end] = min(T(sim.flow.Δt[end]), raw_dt_cap)
    raw_start = T(WaterLily.time(sim.flow))
    start_time = Float64(sim_time(sim))
    target_time = start_time + horizon
    assembled_params = current_joint_params(base_params, joint, raw_start, L)
    fish_body = T3D.compose_body_3d(
        body_sdf,
        T3D.free_swim_map_3d(
            design,
            assembled_params,
            profile,
            Lf,
            state,
            raw_start,
            raw_dt_cap,
            z_plane;
            reference_station=reference_model == "material_station" ? MATERIAL_REFERENCE_STATION : nothing,
            centroid_body_sdf=reference_model == "actual_superellipse_centroid" ? body_sdf : nothing,
            centroid_profile_2d=reference_model == "two_d_matched_mass_centroid" ?
                mass_profile_2d : nothing,
            centroid_caudal_fin=reference_model == "actual_superellipse_centroid" ?
                centroid_caudal_fin : nothing,
            centroid_fin_material_density,
        ),
        fin,
    )
    sim.body = fish_body ∪ cylinders

    vtk_stream = vtk_enabled ? T3D.start_free_swim_vtk_stream_3d(
        output_root;
        collection_name=control_mode == "prescribed_straight_gait" ?
            "projected_multiwake_straight_swim3d" : "projected_multiwake_target_episode3d",
        fields=("velocity", "lambda2", "body"),
        flush_collection=true,
        compress=true,
    ) : nothing
    vtk_times = collect(range(0.0, horizon; length=vtk_frame_count))
    vtk_index = 1
    function write_due_vtk_frames!()
        vtk_stream === nothing && return nothing
        elapsed_now = Float64(sim_time(sim)) - start_time
        while vtk_index <= length(vtk_times) && elapsed_now + 1.0e-8 >= vtk_times[vtk_index]
            T3D.write_free_swim_vtk_frame_3d!(
                vtk_stream,
                sim,
                state,
                z_plane;
                period=max(horizon, eps(Float64)),
            )
            vtk_index += 1
        end
        return nothing
    end
    write_due_vtk_frames!()

    midplane_root = joinpath(output_root, "midplane")
    midplane_csv = nothing
    midplane_times = collect(range(0.0, horizon; length=midplane_frame_count))
    midplane_index = 1
    midplane_written = 0
    if midplane_enabled
        mkpath(midplane_root)
        midplane_csv = open(joinpath(midplane_root, "frames.csv"), "w")
        println(midplane_csv, "frame,elapsed,file,center_x_L,center_y_L,heading_rad,phi1_rad,phi2_rad")
    end
    function write_due_midplane_frames!()
        midplane_csv === nothing && return nothing
        elapsed_now = Float64(sim_time(sim)) - start_time
        while midplane_index <= length(midplane_times) && elapsed_now + 1.0e-8 >= midplane_times[midplane_index]
            name = "frame_" * lpad(string(midplane_written), 4, '0') * ".bin"
            write_midplane_frame!(joinpath(midplane_root, name), sim, z_plane, elapsed_now)
            println(
                midplane_csv,
                join((
                    midplane_written,
                    elapsed_now,
                    name,
                    Float64(state.center[1] / Lf),
                    Float64(state.center[2] / Lf),
                    Float64(state.theta),
                    joint.phi1,
                    joint.phi2,
                ), ","),
            )
            flush(midplane_csv)
            midplane_written += 1
            midplane_index += 1
        end
        return nothing
    end
    write_due_midplane_frames!()

    cropped_volume_root = joinpath(output_root, "cropped_volume3d")
    cropped_volume_csv = nothing
    cropped_volume_times = collect(range(0.0, horizon; length=cropped_volume_frame_count))
    cropped_volume_index = 1
    cropped_volume_written = 0
    if cropped_volume_enabled
        mkpath(cropped_volume_root)
        cropped_volume_csv = open(joinpath(cropped_volume_root, "frames.csv"), "w")
        println(
            cropped_volume_csv,
            "frame,elapsed,file,center_x_L,center_y_L,heading_rad,phi1_rad,phi2_rad,x_first,x_last,y_first,y_last,z_first,z_last,nx,ny,nz",
        )
    end
    function write_due_cropped_volume_frames!()
        cropped_volume_csv === nothing && return nothing
        elapsed_now = Float64(sim_time(sim)) - start_time
        while cropped_volume_index <= length(cropped_volume_times) &&
                elapsed_now + 1.0e-8 >= cropped_volume_times[cropped_volume_index]
            name = "frame_" * lpad(string(cropped_volume_written), 4, '0') * ".d3cvol"
            result = write_cropped_volume_frame!(
                joinpath(cropped_volume_root, name),
                sim,
                state,
                Lf,
                elapsed_now,
                cropped_volume_follow_window_L,
            )
            println(
                cropped_volume_csv,
                join((
                    cropped_volume_written,
                    elapsed_now,
                    name,
                    Float64(state.center[1] / Lf),
                    Float64(state.center[2] / Lf),
                    Float64(state.theta),
                    joint.phi1,
                    joint.phi2,
                    result.crop_first[1],
                    result.crop_last[1],
                    result.crop_first[2],
                    result.crop_last[2],
                    result.crop_first[3],
                    result.crop_last[3],
                    result.dims[1],
                    result.dims[2],
                    result.dims[3],
                ), ","),
            )
            flush(cropped_volume_csv)
            cropped_volume_written += 1
            cropped_volume_index += 1
        end
        return nothing
    end
    write_due_cropped_volume_frames!()

    hero_volume_root = joinpath(output_root, "hero_volume3d")
    hero_volume_csv = nothing
    hero_volume_times = collect(range(0.0, horizon; length=hero_volume_frame_count))
    hero_volume_index = 1
    hero_volume_written = 0
    hero_volume_last_elapsed = NaN
    hero_volume_scratch = hero_volume_enabled ? similar(sim.flow.σ) : nothing
    if hero_volume_enabled
        mkpath(hero_volume_root)
        hero_volume_csv = open(joinpath(hero_volume_root, "frames.csv"), "w")
        println(
            hero_volume_csv,
            "frame,elapsed,file,center_x_L,center_y_L,heading_rad,phi1_rad,phi2_rad,x_first,x_last,y_first,y_last,z_first,z_last,nx,ny,nz,stride_x,stride_y,stride_z,full_nx,full_ny,full_nz",
        )
    end
    function write_hero_volume_frame_at_current_state!()
        name = "frame_" * lpad(string(hero_volume_written), 4, '0') * ".d3cvol"
        elapsed_now = Float64(sim_time(sim)) - start_time
        result = write_hero_volume_frame!(
            joinpath(hero_volume_root, name),
            sim,
            state,
            Lf,
            elapsed_now,
            hero_volume_sample_stride,
            hero_volume_scratch,
        )
        println(
            hero_volume_csv,
            join((
                hero_volume_written,
                elapsed_now,
                name,
                Float64(state.center[1] / Lf),
                Float64(state.center[2] / Lf),
                Float64(state.theta),
                joint.phi1,
                joint.phi2,
                result.crop_first[1],
                result.crop_last[1],
                result.crop_first[2],
                result.crop_last[2],
                result.crop_first[3],
                result.crop_last[3],
                result.dims[1],
                result.dims[2],
                result.dims[3],
                result.sample_stride[1],
                result.sample_stride[2],
                result.sample_stride[3],
                result.full_dims[1],
                result.full_dims[2],
                result.full_dims[3],
            ), ","),
        )
        flush(hero_volume_csv)
        hero_volume_last_elapsed = elapsed_now
        hero_volume_written += 1
        return nothing
    end
    function write_due_hero_volume_frames!()
        hero_volume_csv === nothing && return nothing
        elapsed_now = Float64(sim_time(sim)) - start_time
        while hero_volume_index <= length(hero_volume_times) &&
                elapsed_now + 1.0e-8 >= hero_volume_times[hero_volume_index]
            write_hero_volume_frame_at_current_state!()
            hero_volume_index += 1
        end
        return nothing
    end
    function write_final_hero_volume_frame!()
        hero_volume_csv === nothing && return nothing
        elapsed_now = Float64(sim_time(sim)) - start_time
        if hero_volume_written == 0 || !isfinite(hero_volume_last_elapsed) ||
                abs(elapsed_now - hero_volume_last_elapsed) > 1.0e-8
            write_hero_volume_frame_at_current_state!()
        end
        return nothing
    end
    write_due_hero_volume_frames!()

    embedded_components = body_geometry == "integrated_embedded_plate" ?
        integrated_embedded_plate_components(body_sdf) : nothing
    property_body_sdf = embedded_components === nothing ? body_sdf : embedded_components.body
    embedded_plate = embedded_components === nothing ? nothing : embedded_components.plate
    use_two_d_matched_mass = integrated_body &&
        integrated_caudal_mass_model == "two_d_matched"
    props = if use_two_d_matched_mass
        # Rigid-body inertia belongs to the continuous reference body.  The
        # grid-resolved lateral-width floor is only a wet-SDF discretization
        # device and must not change dry mass, COM, or yaw inertia with L.
        body_hydrodynamic_volume = profiled_caudal_v7 ?
            profiled_caudal_volume_superellipse(body_sdf; resolved=false) :
            T3D.body_volume_superellipse(property_body_sdf)
        body_hydrodynamic_centroid_x = profiled_caudal_v7 ?
            profiled_caudal_centroid_x_superellipse(body_sdf; resolved=false) :
            T3D.body_centroid_x_superellipse(property_body_sdf)
        embedded_plate_volume = embedded_plate === nothing ?
            zero(T) : T3D.caudal_fin_volume(embedded_plate)
        embedded_plate_centroid_x = embedded_plate === nothing ?
            zero(T) : T3D.caudal_fin_centroid_x(embedded_plate)
        hydrodynamic_volume = body_hydrodynamic_volume + embedded_plate_volume
        hydrodynamic_centroid_x = hydrodynamic_volume > zero(T) ?
            (
                body_hydrodynamic_volume * body_hydrodynamic_centroid_x +
                embedded_plate_volume * embedded_plate_centroid_x
            ) / hydrodynamic_volume : body_hydrodynamic_centroid_x
        area_2d = Base2D.body_area_from_profile(mass_profile_2d, Lf)
        axial_density_scale = hydrodynamic_volume / area_2d
        mass_centroid_x = Base2D.body_centroid_x_from_profile(mass_profile_2d, Lf)
        inertia_z = Base2D.body_inertia_from_profile(
            mass_profile_2d, Lf; density=axial_density_scale,
        )
        (
            volume=hydrodynamic_volume,
            mass=hydrodynamic_volume,
            centroid_x=mass_centroid_x,
            physical_mass_centroid_x=mass_centroid_x,
            uniform_density_mass_centroid_x=mass_centroid_x,
            body_volume_centroid_x=hydrodynamic_centroid_x,
            inertia_z,
            fin_volume=embedded_plate_volume,
            fin_mass=zero(T),
            axial_density_scale,
            hydrodynamic_volume_model=profiled_caudal_v7 ?
                "continuous profiled-caudal superellipse; grid width floor excluded from rigid-body mass" :
                embedded_plate === nothing ?
                    "body superellipse" :
                    "conservative component sum; embedded root overlap counted twice",
        )
    else
        hydro_props = T3D.combined_body_properties_superellipse(
            body_sdf;
            density=one(T),
            fin=mass_property_fin,
            fin_material_density=T(fin_material_density),
            reference_x=reference_model == "actual_superellipse_centroid" ?
                nothing : MATERIAL_REFERENCE_STATION * Lf,
        )
        merge(hydro_props, (
            axial_density_scale=one(T),
            hydrodynamic_volume_model=june13_reference_body ?
                "continuous June-13 superellipse plus physical 0.012L fan; wet one-cell thickness floor excluded from dry mass" :
                "union components",
        ))
    end
    unscaled_body_added_mass = profiled_caudal_v7 ?
        profiled_caudal_added_mass(
            body_sdf;
            density=one(T),
            reference_x=props.centroid_x,
            resolved_volume=false,
        ) :
        T3D.superellipse_added_mass(
            property_body_sdf;
            density=one(T),
            reference_x=props.centroid_x,
        )
    body_added_mass = merge(unscaled_body_added_mass, (
        inertia=T(body_added_inertia_scale) * unscaled_body_added_mass.inertia,
    ))
    fin_added = fin === nothing ?
        (lateral=zero(T), inertia=zero(T)) :
        T3D.caudal_fin_added_mass(
            fin;
            density=T(fin_added_mass_scale),
            centroid_x=props.centroid_x,
        )
    embedded_plate_added = embedded_plate === nothing ?
        (lateral=zero(T), inertia=zero(T)) :
        T3D.caudal_fin_added_mass(
            embedded_plate;
            density=T(embedded_plate_added_mass_scale),
            centroid_x=props.centroid_x,
        )
    added_mass = merge(body_added_mass, (
        lateral=body_added_mass.lateral + fin_added.lateral + embedded_plate_added.lateral,
        inertia=body_added_mass.inertia + fin_added.inertia + embedded_plate_added.inertia,
    ))

    traces = NamedTuple[]
    solver_control_step_wall_seconds = Float64[]
    history = NamedTuple[]
    filtered_flow = nothing
    filtered_heading_error = 0.0
    filtered_heading_rate_T = 0.0
    held_commanded_asymmetry = unilateral_heading_command(
        heading_trim_asymmetry,
        heading_asymmetry_limit,
        heading_unilateral_command_sign,
    )
    filtered_commanded_asymmetry = held_commanded_asymmetry
    filtered_commanded_asymmetry_rate_T = 0.0
    last_heading_update_index = -1
    steps = 0
    status = "ok"
    termination = "horizon"
    failure_message = nothing
    wall_start = time_ns()
    initial_head = material_head_position(
        state, assembled_params, Lf, raw_start, body_sdf, mass_profile_2d, reference_model,
        ; centroid_caudal_fin, centroid_fin_material_density,
    )
    initial_distance_L = hypot((target - initial_head)...) / Float64(Lf)

    # The flow clock is Float32 in production. Comparing its Float64 rendering
    # against an unrounded decimal horizon (for example 3.3) can leave a
    # sub-ULP remainder after the final capped step. The timestep cap then sees
    # zero Float32 remainder and restores a full step, overshooting the horizon
    # and corrupting the last force/state sample. Compare in the runtime clock
    # precision so a reached Float32 target terminates immediately.
    runtime_target_time = T(target_time)
    while T(sim_time(sim)) + eps(T) < runtime_target_time && steps < max_steps
        solver_control_step_start = time_ns()
        Base2D.cap_free_swim_timestep!(sim, raw_dt_cap, target_time)
        raw_t0 = T(WaterLily.time(sim.flow))
        raw_dt = T(sim.flow.Δt[end])
        raw_t1 = raw_t0 + raw_dt
        elapsed = Float64(sim_time(sim)) - start_time
        sim_dt = Float64(raw_dt / Lf)

        loads = fish_force_moment(sim, fish_body, state.center, z_plane; locked_diagnostics=steps % 50 == 0)
        head = material_head_position(
            state, assembled_params, Lf, raw_t0, body_sdf, mass_profile_2d, reference_model,
            ; centroid_caudal_fin, centroid_fin_material_density,
        )
        raw_flow = centered_flow_velocity_xy(sim, SVector(head[1], head[2], z_plane))
        filtered_flow = filtered_flow === nothing ? raw_flow :
            (1.0 - flow_filter_alpha) * filtered_flow + flow_filter_alpha * raw_flow
        obs = policy_observation(
            state,
            joint,
            target,
            loads.force,
            loads.moment_z,
            filtered_flow,
            head,
            Lf,
            elapsed,
            history,
        )
        history_heading = Float64(state.theta)
        transition_fraction = if elapsed + sim_dt <= straight_bias_transition_start
            0.0
        elseif elapsed + sim_dt >= straight_bias_transition_end
            1.0
        else
            (elapsed + sim_dt - straight_bias_transition_start) /
                (straight_bias_transition_end - straight_bias_transition_start)
        end
        smooth_transition = transition_fraction^2 * (3 - 2 * transition_fraction)
        scheduled_bias1 = (1 - smooth_transition) * straight_bias1 +
            smooth_transition * straight_bias1_late
        scheduled_bias2 = (1 - smooth_transition) * straight_bias2 +
            smooth_transition * straight_bias2_late
        scheduled_asymmetry1 = (1 - smooth_transition) * straight_asymmetry1 +
            smooth_transition * straight_asymmetry1_late
        scheduled_asymmetry2 = (1 - smooth_transition) * straight_asymmetry2 +
            smooth_transition * straight_asymmetry2_late
        heading_reference = initial_heading +
            (elapsed + sim_dt < heading_step_time ? heading_initial_offset : heading_step_offset)
        heading_error = wrap_angle(heading_reference - Float64(state.theta))
        heading_rate_T = Float64(state.omega) * Float64(Lf)
        heading_filter_alpha = heading_filter_tau_T > 0 ?
            1.0 - exp(-sim_dt / heading_filter_tau_T) : 1.0
        filtered_heading_error += heading_filter_alpha *
            wrap_angle(heading_error - filtered_heading_error)
        filtered_heading_rate_T += heading_filter_alpha *
            (heading_rate_T - filtered_heading_rate_T)
        feedback_fraction = if elapsed + sim_dt <= heading_feedback_start_T
            0.0
        elseif elapsed + sim_dt >= heading_feedback_ramp_end_T
            1.0
        elseif heading_feedback_ramp_end_T > heading_feedback_start_T
            (elapsed + sim_dt - heading_feedback_start_T) /
                (heading_feedback_ramp_end_T - heading_feedback_start_T)
        else
            1.0
        end
        feedback_scale = feedback_fraction^2 * (3 - 2 * feedback_fraction)
        commanded_bias = scheduled_bias1
        commanded_asymmetry = 0.5 * (scheduled_asymmetry1 + scheduled_asymmetry2)
        raw_commanded_asymmetry = commanded_asymmetry
        heading_update_index = last_heading_update_index
        phase_authority_weight = heading_actuator_yaw_gain_sign
        applied_asymmetry1 = scheduled_asymmetry1
        applied_asymmetry2 = scheduled_asymmetry2
        heading_feedforward_bias = heading_use_scheduled_feedforward ?
            0.5 * (scheduled_bias1 + scheduled_bias2) : heading_trim_bias
        if control_mode == "prescribed_heading_control"
            feedback_bias = -heading_kp * filtered_heading_error +
                heading_kd_T * filtered_heading_rate_T
            commanded_bias = clamp_value(heading_feedforward_bias +
                feedback_scale * feedback_bias, heading_bias_limit)
        end
        if control_mode == "prescribed_dynamic_heading_control"
            # desired yaw acceleration is kp*error-kd*yaw_rate.  The command
            # sign must come from a matched-kinematics load audit; it is not a
            # geometry-invariant convention. V7 differential steering has the
            # opposite sign from the retired standalone-fin calibration.
            phase_authority_weight = heading_phase_authority === nothing ?
                heading_actuator_yaw_gain_sign :
                heading_phase_authority_weight(
                    heading_phase_authority,
                    2pi * (elapsed + sim_dt) / straight_period,
                )
            feedback_asymmetry = phase_authority_weight * (
                heading_kp * filtered_heading_error -
                heading_kd_T * filtered_heading_rate_T
            )
            schedule_time_T = elapsed + sim_dt
            schedule_target_asymmetry = if schedule_time_T <
                turn_brake_turn_start_T
                0.0
            elseif schedule_time_T < turn_brake_brake_start_T
                turn_brake_turn_command
            elseif schedule_time_T < turn_brake_neutral_start_T
                turn_brake_brake_command
            else
                turn_brake_post_neutral_command
            end
            raw_commanded_asymmetry = if turn_brake_schedule_enabled
                clamp_value(schedule_target_asymmetry, heading_asymmetry_limit)
            else
                unilateral_heading_command(
                    heading_trim_asymmetry + feedback_scale * feedback_asymmetry,
                    heading_asymmetry_limit,
                    heading_unilateral_command_sign,
                )
            end
            if heading_update_periods == 0
                if heading_command_filter_tau_T > 0
                    filter_frequency_T = 1.0 / heading_command_filter_tau_T
                    displacement = filtered_commanded_asymmetry -
                        raw_commanded_asymmetry
                    exponential = exp(-filter_frequency_T * sim_dt)
                    linear_coefficient = filtered_commanded_asymmetry_rate_T +
                        filter_frequency_T * displacement
                    next_displacement = (
                        displacement + linear_coefficient * sim_dt
                    ) * exponential
                    next_rate_T = (
                        linear_coefficient -
                        filter_frequency_T * (
                            displacement + linear_coefficient * sim_dt
                        )
                    ) * exponential
                    filtered_commanded_asymmetry =
                        raw_commanded_asymmetry + next_displacement
                    filtered_commanded_asymmetry_rate_T = next_rate_T
                else
                    filtered_commanded_asymmetry = raw_commanded_asymmetry
                    filtered_commanded_asymmetry_rate_T = 0.0
                end
                commanded_asymmetry = unilateral_heading_command(
                    filtered_commanded_asymmetry,
                    heading_asymmetry_limit,
                    heading_unilateral_command_sign,
                )
                if commanded_asymmetry != filtered_commanded_asymmetry
                    filtered_commanded_asymmetry = commanded_asymmetry
                    filtered_commanded_asymmetry_rate_T = 0.0
                end
                held_commanded_asymmetry = commanded_asymmetry
            else
                hold = cycle_synchronized_heading_hold(
                    raw_commanded_asymmetry,
                    held_commanded_asymmetry,
                    last_heading_update_index,
                    elapsed + sim_dt,
                    heading_feedback_start_T,
                    straight_period,
                    heading_update_periods,
                )
                held_commanded_asymmetry = hold.command
                last_heading_update_index = hold.update_index
                commanded_asymmetry = held_commanded_asymmetry
                heading_update_index = last_heading_update_index
            end
            applied_asymmetry1, applied_asymmetry2 =
                heading_actuator_commands(commanded_asymmetry, heading_actuator_basis)
        end
        # Candidate policies may opt into the same explicit physical heading
        # reference. Existing target policies ignore these added fields.
        obs = merge(obs, (; heading_reference, heading_error))
        if !(control_mode in ("prescribed_straight_gait", "prescribed_heading_control", "prescribed_dynamic_heading_control", "prescribed_logged_trajectory"))
            action = target_policy(obs, policy_params)
            joint = integrate_joint_state(
                joint,
                action.phi_ddot,
                sim_dt;
                phi_limit,
                phi_dot_limit,
                phi_ddot_limit,
            )
        else
            joint = if control_mode == "prescribed_logged_trajectory"
                logged_joint_state(
                    logged_trajectory_bundle.history,
                    elapsed + sim_dt,
                )
            elseif prescribed_carrier != "analytic_sine"
                prescribed_fourier_joint_state(
                    joint,
                    initial_joint,
                    elapsed + sim_dt,
                    sim_dt;
                    period=straight_period,
                    steering_amp1=straight_amp1,
                    steering_amp2=straight_amp2,
                    asymmetry1=applied_asymmetry1,
                    asymmetry2=applied_asymmetry2,
                    phase_lag=straight_phase_lag,
                    carrier_global_phase_offset,
                    steering_harmonic,
                    steering_phase_offset,
                    carrier_scale,
                    carrier_scale1,
                    carrier_scale2,
                    carrier_mode=prescribed_carrier,
                    carrier_phase_shift2,
                    ramp_periods=straight_ramp_periods,
                    phi_limit,
                    phi_dot_limit,
                    phi_ddot_limit,
                )
            elseif analytic_steering_mode == "smooth_harmonic"
                prescribed_analytic_harmonic_joint_state(
                    joint,
                    initial_joint,
                    elapsed + sim_dt,
                    sim_dt;
                    period=straight_period,
                    carrier_amp1=straight_amp1,
                    carrier_amp2=straight_amp2,
                    steering_amp1=analytic_steering_amp1,
                    steering_amp2=analytic_steering_amp2,
                    command1=applied_asymmetry1,
                    command2=applied_asymmetry2,
                    phase_lag=straight_phase_lag,
                    carrier_global_phase_offset,
                    steering_harmonic,
                    steering_phase_offset,
                    ramp_periods=straight_ramp_periods,
                    phi_limit,
                    phi_dot_limit,
                    phi_ddot_limit,
                )
            else
                prescribed_straight_joint_state(
                    joint,
                    initial_joint,
                    elapsed + sim_dt,
                    sim_dt;
                    period=straight_period,
                    amp1=straight_amp1,
                    amp2=straight_amp2,
                    asymmetry1=scheduled_asymmetry1,
                    asymmetry2=scheduled_asymmetry2,
                    bias1=control_mode == "prescribed_heading_control" ? commanded_bias : scheduled_bias1,
                    bias2=control_mode == "prescribed_heading_control" ? commanded_bias : scheduled_bias2,
                    phase_lag=straight_phase_lag,
                    carrier_global_phase_offset,
                    ramp_periods=straight_ramp_periods,
                    phi_limit,
                    phi_dot_limit,
                    phi_ddot_limit,
                )
            end
            action = (phi_ddot=(joint.phi_ddot1, joint.phi_ddot2),)
        end
        assembled_params = current_joint_params(base_params, joint, raw_t1, L)
        unconstrained_next_state = Base2D.update_free_swim_state(
            state,
            loads.force,
            loads.moment_z,
            raw_dt,
            props.mass,
            props.inertia_z;
            added_mass,
        )
        next_state = if propulsion_only_surge
            displacement = unconstrained_next_state.center - state.center
            surge_displacement = dot(displacement, initial_forward_axis)
            surge_velocity = dot(unconstrained_next_state.velocity, initial_forward_axis)
            Base2D.FreeSwimState(
                state.center + surge_displacement * initial_forward_axis,
                state.theta,
                surge_velocity * initial_forward_axis,
                zero(T),
            )
        else
            unconstrained_next_state
        end
        finite_state = all(isfinite, next_state.center) && all(isfinite, next_state.velocity) &&
            isfinite(next_state.theta) && isfinite(next_state.omega) && all(isfinite, action.phi_ddot)
        if !finite_state
            status = "failed"
            termination = "nonfinite_state"
            failure_message = "policy action or free-swim state became nonfinite"
            break
        end

        body_state = Base2D.free_swim_step_body_state(state, next_state, raw_dt)
        fish_body = T3D.compose_body_3d(
            body_sdf,
            T3D.free_swim_map_3d(
                design,
                assembled_params,
                profile,
                Lf,
                body_state,
                raw_t1,
                raw_dt,
                z_plane;
                reference_station=reference_model == "material_station" ? MATERIAL_REFERENCE_STATION : nothing,
                centroid_body_sdf=reference_model == "actual_superellipse_centroid" ? body_sdf : nothing,
                centroid_profile_2d=reference_model == "two_d_matched_mass_centroid" ?
                    mass_profile_2d : nothing,
                centroid_caudal_fin=reference_model == "actual_superellipse_centroid" ?
                    centroid_caudal_fin : nothing,
                centroid_fin_material_density,
            ),
            fin,
        )
        sim.body = fish_body ∪ cylinders
        try
            sim_step!(sim; remeasure=true)
        catch error
            status = "failed"
            termination = "solver_error"
            failure_message = sprint(showerror, error)
            break
        end
        sim.flow.Δt[end] = min(T(sim.flow.Δt[end]), raw_dt_cap)
        state = next_state
        steps += 1
        push!(solver_control_step_wall_seconds, (time_ns() - solver_control_step_start) / 1.0e9)
        write_due_vtk_frames!()
        write_due_midplane_frames!()
        write_due_cropped_volume_frames!()
        write_due_hero_volume_frames!()

        new_elapsed = Float64(sim_time(sim)) - start_time
        new_head = material_head_position(
            state, assembled_params, Lf, raw_t1, body_sdf, mass_profile_2d, reference_model,
            ; centroid_caudal_fin, centroid_fin_material_density,
        )
        distance_L = hypot((target - new_head)...) / Float64(Lf)
        push!(history, (time=elapsed, distance_L=obs.distance_L, bearing=obs.bearing, heading=history_heading))
        while length(history) > 7
            popfirst!(history)
        end
        push!(traces, (
            step=steps,
            elapsed=new_elapsed,
            center=Tuple(Float64.(state.center ./ Lf)),
            head=Tuple(Float64.(new_head ./ Lf)),
            heading=Float64(state.theta),
            velocity=Tuple(Float64.(state.velocity)),
            distance_L,
            force_body_coefficient=Tuple(Float64.(obs.force_body_L)),
            moment_coefficient=Float64(obs.moment_z_L2),
            local_flow_body=Tuple(Float64.(obs.local_flow_velocity_body_U)),
            joint=(joint.phi1, joint.phi2, joint.phi_dot1, joint.phi_dot2),
            action=Tuple(Float64.(action.phi_ddot)),
            heading_reference,
            heading_error,
            heading_rate_T,
            filtered_heading_error,
            filtered_heading_rate_T,
            feedback_scale,
            scheduled_asymmetry1,
            scheduled_asymmetry2,
            applied_asymmetry1,
            applied_asymmetry2,
            commanded_bias,
            commanded_asymmetry,
            raw_commanded_asymmetry,
            phase_authority_weight,
            heading_update_index,
            force_z=loads.force_z,
            locked_moments=loads.locked_moments,
        ))
        domain_x_L, domain_y_L = runtime_spec.domain_scale_L[1:2]
        head_outside = !(0.0 <= Float64(new_head[1] / Lf) <= domain_x_L) ||
            !(0.0 <= Float64(new_head[2] / Lf) <= domain_y_L)
        center_outside = !(0.0 <= Float64(state.center[1] / Lf) <= domain_x_L) ||
            !(0.0 <= Float64(state.center[2] / Lf) <= domain_y_L)
        if head_outside || center_outside
            status = "failed"
            termination = "out_of_domain"
            failure_message = "fish head or material reference left the x-y domain"
            break
        end
        if distance_L <= runtime_spec.success_radius_L
            termination = "capture"
            break
        end
    end
    steps >= max_steps && termination == "horizon" && begin
        status = "failed"
        termination = "max_steps"
        failure_message = "maximum step count reached"
    end
    write_final_hero_volume_frame!()
    vtk_collection = vtk_stream === nothing ? nothing : T3D.close_free_swim_vtk_stream_3d!(vtk_stream)
    midplane_csv !== nothing && close(midplane_csv)
    cropped_volume_csv !== nothing && close(cropped_volume_csv)
    hero_volume_csv !== nothing && close(hero_volume_csv)
    wall_seconds = (time_ns() - wall_start) / 1.0e9
    timing_warmup_steps = min(50, length(solver_control_step_wall_seconds) ÷ 10)
    steady_step_wall_seconds = solver_control_step_wall_seconds[(timing_warmup_steps + 1):end]
    final_distance_L = isempty(traces) ? initial_distance_L : traces[end].distance_L
    score_metrics = rollout_score_metrics(traces, initial_distance_L, horizon, termination)
    report = (
        schema="dogfish.projected_multiwake_policy_smoke3d.v1",
        status,
        termination,
        failure_message,
        generated_at=Dates.format(now(), dateformat"yyyy-mm-ddTHH:MM:SS"),
        runtime_resolution=L,
        domain_dims=dims,
        Re=runtime_spec.Re,
        max_dimensionless_dt,
        horizon,
        achieved_horizon=Float64(sim_time(sim)) - start_time,
        steps,
        wall_seconds,
        ms_per_step=steps > 0 ? 1000 * wall_seconds / steps : nothing,
        solver_control_wall_seconds=sum(solver_control_step_wall_seconds),
        solver_control_timing_excludes_vtk=true,
        solver_control_timing_warmup_steps=timing_warmup_steps,
        solver_control_mean_ms_per_step_after_warmup=isempty(steady_step_wall_seconds) ? nothing :
            1000 * mean(steady_step_wall_seconds),
        solver_control_median_ms_per_step_after_warmup=isempty(steady_step_wall_seconds) ? nothing :
            1000 * median(steady_step_wall_seconds),
        config_path,
        config_sha256=sha256_file(config_path),
        geometry_path,
        geometry_sha256=sha256_file(geometry_path),
        reflection_equivariant_ibm_enabled=REFLECTION_EQUIVARIANT_IBM_ENABLED,
        reflection_equivariant_ibm_path=REFLECTION_EQUIVARIANT_IBM_ENABLED ?
            REFLECTION_EQUIVARIANT_IBM_PATH : nothing,
        reflection_equivariant_ibm_sha256=REFLECTION_EQUIVARIANT_IBM_ENABLED ?
            sha256_file(REFLECTION_EQUIVARIANT_IBM_PATH) : nothing,
        reflection_equivariant_ibm_contract=REFLECTION_EQUIVARIANT_IBM_CONTRACT,
        initialization_mode,
        prewarm_snapshot=initialization_mode == "snapshot" ? snapshot_path : nothing,
        prewarm_snapshot_sha256=initialization_mode == "snapshot" ?
            sha256_file(snapshot_path) : nothing,
        direct_uniform_initial_condition=initialization_mode == "uniform_direct",
        start_dimensionless_time=start_time,
        policy_path,
        policy_sha256=sha256_file(policy_path),
        policy_params_source=control_mode == "candidate_policy" ? "candidate_target_policy" : control_mode,
        policy_params=control_mode in ("prescribed_straight_gait", "prescribed_heading_control", "prescribed_dynamic_heading_control", "prescribed_logged_trajectory") ? nothing : policy_params,
        policy_adapter_gain_changes=control_mode in ("prescribed_straight_gait", "prescribed_heading_control", "prescribed_dynamic_heading_control", "prescribed_logged_trajectory") ? nothing : false,
        control_mode,
        propulsion_only_surge,
        initial_forward_axis=Tuple(Float64.(initial_forward_axis)),
        straight_gait=control_mode in ("prescribed_straight_gait", "prescribed_heading_control", "prescribed_dynamic_heading_control") ? (
            carrier_mode=prescribed_carrier,
            period=straight_period,
            amplitudes_deg=(straight_amp1 / DEG, straight_amp2 / DEG),
            phase_lag_deg=straight_phase_lag / DEG,
            carrier_global_phase_offset_deg=carrier_global_phase_offset / DEG,
            steering_harmonic,
            steering_phase_offset_deg=steering_phase_offset / DEG,
            analytic_steering_mode,
            analytic_steering_amplitudes_deg=(
                analytic_steering_amp1 / DEG,
                analytic_steering_amp2 / DEG,
            ),
            carrier_scale,
            carrier_scales=(carrier_scale1, carrier_scale2),
            carrier_phase_shift2_deg=carrier_phase_shift2 / DEG,
            biases_deg=(straight_bias1 / DEG, straight_bias2 / DEG),
            late_biases_deg=(straight_bias1_late / DEG, straight_bias2_late / DEG),
            half_cycle_asymmetries=(straight_asymmetry1, straight_asymmetry2),
            late_half_cycle_asymmetries=(straight_asymmetry1_late, straight_asymmetry2_late),
            half_cycle_waveform=prescribed_carrier == "successful_2d_fourier_odd_harmonics" ?
                "zero-mean odd-only (1/3/5) successful-2D carrier plus smooth zero-mean dynamic steering" :
                prescribed_carrier == "successful_2d_fourier_zero_mean" ?
                    "zero-mean five-harmonic successful-2D carrier plus smooth zero-mean dynamic steering" :
                    analytic_steering_mode == "smooth_harmonic" ?
                        "analytic sine carrier plus smooth zero-mean harmonic steering; dynamic half-cycle asymmetry without static bend" :
                        "sin(phase)+asymmetry*(abs(sin(phase))-2/pi); zero carrier-cycle mean",
            source_template_sha256=prescribed_carrier == "successful_2d_fourier_odd_harmonics" ?
                TWO_D_FOURIER_ODD_TEMPLATE_SHA256 :
                prescribed_carrier == "successful_2d_fourier_zero_mean" ?
                    TWO_D_FOURIER_TEMPLATE_SHA256 : nothing,
            source_policy_sha256=prescribed_carrier == "analytic_sine" ?
                nothing : TWO_D_FOURIER_SOURCE_POLICY_SHA256,
            carrier_has_zero_joint_means=
                prescribed_carrier != "analytic_sine" ||
                analytic_steering_mode == "smooth_harmonic",
            static_bias_applied=any(abs(value) > 1e-12 for value in (
                straight_bias1, straight_bias2, straight_bias1_late, straight_bias2_late,
            )),
            bias_transition_start_T=straight_bias_transition_start,
            bias_transition_end_T=straight_bias_transition_end,
            bias_schedule="smoothstep(start, late)",
            ramp_periods=straight_ramp_periods,
        ) : nothing,
        logged_trajectory=control_mode == "prescribed_logged_trajectory" ? (
            logged_trajectory_bundle.metadata...,
            interpolation="piecewise quintic Hermite matching q/qdot/qddot at every logged knot",
            body_control="dynamic two-joint distributed bend; no persistent static-bias controller",
            initial_joint=(
                phi1=initial_joint.phi1,
                phi2=initial_joint.phi2,
                phi_dot1=initial_joint.phi_dot1,
                phi_dot2=initial_joint.phi_dot2,
                phi_ddot1=initial_joint.phi_ddot1,
                phi_ddot2=initial_joint.phi_ddot2,
            ),
        ) : nothing,
        heading_controller=control_mode == "prescribed_heading_control" ? (
            law="bias=clamp(feedforward+feedback_scale*(-kp*filtered_error+kd_T*filtered_yaw_rate_T),+/-limit)",
            sign_convention="positive common bias produces negative yaw",
            initial_heading_rad=initial_heading,
            feedforward_source=heading_use_scheduled_feedforward ? "smoothstep straight-gait bias schedule" : "constant heading trim",
            use_scheduled_feedforward=heading_use_scheduled_feedforward,
            feedback_start_T=heading_feedback_start_T,
            feedback_ramp_end_T=heading_feedback_ramp_end_T,
            heading_filter_tau_T,
            trim_bias_deg=heading_trim_bias / DEG,
            kp_rad_bias_per_rad_error=heading_kp,
            kd_rad_bias_per_rad_per_T=heading_kd_T,
            bias_limit_deg=heading_bias_limit / DEG,
            initial_reference_offset_deg=heading_initial_offset / DEG,
            step_reference_offset_deg=heading_step_offset / DEG,
            step_time_T=heading_step_time,
        ) : control_mode == "prescribed_dynamic_heading_control" ? (
            law="target=unilateral_clamp(trim+feedback_scale*authority_weight(phase)*(kp*filtered_error-kd_T*filtered_yaw_rate_T)); command=critical_damped_second_order_filter_or_cycle_hold(target)",
            actuator_basis=heading_actuator_basis,
            actuator=heading_actuator_basis == "differential" ?
                "opposite smooth zero-mean second-harmonic modulation (+c,-c) on the distributed joints" :
                "equal smooth zero-mean second-harmonic modulation (+c,+c) on both distributed joints",
            measured_positive_command_yaw_moment_sign=heading_actuator_yaw_gain_sign,
            sign_convention=heading_actuator_yaw_gain_sign > 0 ?
                "positive asymmetry produces positive yaw moment" :
                "positive asymmetry produces negative yaw moment",
            initial_heading_rad=initial_heading,
            feedback_start_T=heading_feedback_start_T,
            feedback_ramp_end_T=heading_feedback_ramp_end_T,
            heading_filter_tau_T,
            trim_asymmetry=heading_trim_asymmetry,
            kp_asymmetry_per_rad_error=heading_kp,
            kd_asymmetry_per_rad_per_T=heading_kd_T,
            asymmetry_limit=heading_asymmetry_limit,
            action_contract_limit_cap=heading_asymmetry_limit_cap,
            june13_smooth_h2_action_contract=june13_smooth_h2_contract,
            unilateral_command_sign=heading_unilateral_command_sign,
            unilateral_command_interval=heading_unilateral_command_sign > 0 ?
                (0.0, heading_asymmetry_limit) :
                heading_unilateral_command_sign < 0 ?
                    (-heading_asymmetry_limit, 0.0) :
                    (-heading_asymmetry_limit, heading_asymmetry_limit),
            command_filter_tau_T=heading_command_filter_tau_T,
            command_filter_model=heading_update_periods == 0 &&
                heading_command_filter_tau_T > 0 ?
                "exact-step critically damped second-order filter; natural frequency=1/tau" :
                nothing,
            turn_brake_schedule=turn_brake_schedule_enabled ? (
                turn_command=turn_brake_turn_command,
                brake_command=turn_brake_brake_command,
                post_neutral_command=turn_brake_post_neutral_command,
                turn_start_T=turn_brake_turn_start_T,
                brake_start_T=turn_brake_brake_start_T,
                neutral_start_T=turn_brake_neutral_start_T,
                semantics="piecewise target command passed through the same exact-step critically damped command filter",
            ) : nothing,
            phase_authority=heading_phase_authority === nothing ? nothing : (
                schema=heading_phase_authority.schema,
                path=heading_phase_authority.path,
                sha256=heading_phase_authority.sha256,
                source_positive_report_sha256=
                    heading_phase_authority.source_positive_report_sha256,
                source_negative_report_sha256=
                    heading_phase_authority.source_negative_report_sha256,
                fourier_lowpass_harmonics=
                    heading_phase_authority.fourier_lowpass_harmonics,
                semantics="phase weight multiplies kp*error-kd*yaw_rate before command limiting",
            ),
            update_periods=heading_update_periods,
            update_mode=heading_update_periods == 0 ?
                "continuous low-pass command" :
                "carrier-cycle sample-and-hold",
            initial_reference_offset_deg=heading_initial_offset / DEG,
            step_reference_offset_deg=heading_step_offset / DEG,
            step_time_T=heading_step_time,
        ) : nothing,
        observation_adapter=(
            force_normalization="F/(rho*U^2*L^2)",
            moment_normalization="Mz/(rho*U^2*L^3)",
            local_flow_sampling="head_centered_face_average_plus_temporal_ema",
            local_flow_filter_alpha=flow_filter_alpha,
        ),
        free_dofs=propulsion_only_surge ? ("surge_along_initial_heading",) :
            ("surge_x", "sway_y", "yaw_z"),
        locked_dofs=propulsion_only_surge ?
            (runtime_spec.locked_dofs..., "diagnostic_sway", "diagnostic_yaw") :
            runtime_spec.locked_dofs,
        fish_present=true,
        fish_motion="free_xy_yaw",
        fish_initial_center_L=runtime_spec.initial_center_L,
        fish_initial_heading_deg=initial_heading_deg,
        source_config_initial_heading_deg=runtime_spec.initial_heading_deg,
        fish_initial_joint_angles_deg=(initial_phi1_deg, initial_phi2_deg),
        source_config_initial_joint_angles_deg=(
            Float64(config["projected_multiwake_3d"]["initial_phi1_deg"]),
            Float64(config["projected_multiwake_3d"]["initial_phi2_deg"]),
        ),
        fish_initial_yaw_rate_rad_per_T=initial_yaw_rate_T,
        target_L=runtime_target_L,
        source_config_target_L=runtime_spec.target_L,
        success_radius_L=runtime_spec.success_radius_L,
        domain_scale_L=runtime_spec.domain_scale_L,
        cylinder_count=length(runtime_spec.cylinder_centers_L),
        cylinder_centers_L=runtime_spec.cylinder_centers_L,
        cylinder_diameters_L=runtime_spec.cylinder_diameters_L,
        body_height_scale,
        body_geometry,
        body_geometry_source_path,
        june13_reference_simulation_commit=june13_reference_body ?
            "a380cef8d0bc1a4413f4911472416ecd67cd2a2d" : nothing,
        june13_reference_render_commit=june13_reference_body ?
            "f1684460008766c4f61386955ddfd7a7cfc4c479" : nothing,
        june13_reference_body_sha256=june13_reference_body ?
            "d6f7571f5b84e292c52b6a3982f220a0f8004e2c83890ba89a3329ea6230c479" : nothing,
        june13_reference_caudal_sha256=june13_reference_body ?
            "4a40a619439335ca717c63f69255467d0ddd9f7d8a0e27343c0cd2ac2b018a20" : nothing,
        june13_wet_fin_half_thickness_L=june13_reference_body && fin !== nothing ?
            Float64(fin.half_thickness) : nothing,
        june13_physical_fin_half_thickness_L=june13_reference_body ?
            Float64(mass_property_fin.half_thickness) : nothing,
        body_geometry_source_sha256=sha256_file(body_geometry_source_path),
        integrated_caudal_variant=body_geometry == "integrated_caudal" ?
            String(integrated_caudal_variant) : nothing,
        thin_web_variant=body_geometry == "integrated_thin_web" ?
            String(thin_web_variant) : nothing,
        embedded_plate_geometry=embedded_plate === nothing ? nothing : (
            x_start_L=Float64(embedded_plate.x_start),
            x_upper_tip_L=Float64(embedded_plate.x_upper_tip),
            x_lower_tip_L=Float64(embedded_plate.x_lower_tip),
            upper_height_L=Float64(embedded_plate.upper_height),
            lower_height_L=Float64(embedded_plate.lower_height),
            root_half_thickness_L=Float64(embedded_plate.root_half_thickness),
            creates_material_beyond_s1=false,
        ),
        profiled_caudal_geometry=profiled_caudal_v7 ?
            profiled_caudal_parameters(body_sdf) : nothing,
        profiled_caudal_hydrodynamic_properties=profiled_caudal_v7 ? (
            physical_volume=Float64(profiled_caudal_volume_superellipse(
                body_sdf; resolved=false,
            )),
            resolved_volume=Float64(profiled_caudal_volume_superellipse(
                body_sdf; resolved=true,
            )),
            physical_centroid_x_L=Float64(profiled_caudal_centroid_x_superellipse(
                body_sdf; resolved=false,
            ) / Lf),
            resolved_centroid_x_L=Float64(profiled_caudal_centroid_x_superellipse(
                body_sdf; resolved=true,
            ) / Lf),
        ) : nothing,
        integrated_caudal_span_scale=body_geometry == "integrated_caudal" ?
            integrated_caudal_span_scale : nothing,
        integrated_peduncle_half_width_L=body_geometry == "integrated_caudal" ?
            integrated_peduncle_half_width : nothing,
        integrated_tail_half_width_L=body_geometry == "integrated_caudal" ?
            integrated_tail_half_width : nothing,
        integrated_caudal_mass_model=integrated_body ?
            integrated_caudal_mass_model : "hydrodynamic_body",
        dry_mass_reference=profiled_caudal_v7 ?
            "continuous analytical profiled-caudal body; resolution-independent normalized mass" :
            june13_reference_body ?
                "continuous June-13 superellipse plus physical 0.012L fan; wet one-cell floor excluded" :
                nothing,
        resolved_wet_sdf_volume_affects_dry_mass=
            profiled_caudal_v7 || june13_reference_body ? false : nothing,
        resolved_wet_sdf_volume_affects_analytical_added_mass=
            profiled_caudal_v7 || june13_reference_body ? false : nothing,
        mass_axial_density_scale=Float64(props.axial_density_scale),
        hydrodynamic_volume_model=props.hydrodynamic_volume_model,
        conservative_hydrodynamic_volume=Float64(props.volume),
        mass_reference_centroid_x_L=Float64(props.physical_mass_centroid_x / Lf),
        hydrodynamic_volume_centroid_x_L=Float64(props.body_volume_centroid_x / Lf),
        caudal_fin_enabled,
        fin_x_start,
        fin_x_end,
        fin_upper_height,
        fin_lower_height,
        fin_half_thickness,
        fin_min_root_half_cells=Float64(prewarm_report["fin_min_root_half_cells"]),
        fin_min_midplane_half_cells=Float64(prewarm_report["fin_min_midplane_half_cells"]),
        fin_material_density,
        fin_added_mass_scale,
        body_added_inertia_scale,
        unscaled_body_added_yaw_inertia=Float64(unscaled_body_added_mass.inertia),
        scaled_body_added_yaw_inertia=Float64(body_added_mass.inertia),
        embedded_plate_added_mass_scale=embedded_plate === nothing ?
            nothing : embedded_plate_added_mass_scale,
        embedded_plate_added_mass=embedded_plate === nothing ?
            nothing : embedded_plate_added,
        reference_model,
        effective_reference_model=june13_reference_body &&
            reference_model == "actual_superellipse_centroid" ?
                "continuous_superellipse_plus_physical_fan_mass_centroid" :
                reference_model,
        material_reference_station=reference_model == "material_station" ? Float64(MATERIAL_REFERENCE_STATION) : nothing,
        material_reference_x=Float64(props.centroid_x),
        uniform_density_mass_centroid_x=Float64(props.uniform_density_mass_centroid_x),
        body_volume_centroid_x=Float64(props.body_volume_centroid_x),
        fin_material_mass=Float64(props.fin_mass),
        dry_mass=Float64(props.mass),
        dry_yaw_inertia=Float64(props.inertia_z),
        added_mass,
        initial_distance_L,
        final_distance_L,
        minimum_distance_L=isempty(traces) ? initial_distance_L : minimum(row.distance_L for row in traces),
        captured=termination == "capture",
        score=score_metrics.score,
        score_metrics,
        vtk_enabled,
        vtk_frame_count=vtk_stream === nothing ? 0 : vtk_stream.count,
        vtk_collection,
        midplane_enabled,
        midplane_frame_count=midplane_written,
        midplane_frames_csv=midplane_enabled ? joinpath(midplane_root, "frames.csv") : nothing,
        cropped_volume_enabled,
        cropped_volume_frame_count=cropped_volume_written,
        cropped_volume_follow_window_L,
        cropped_volume_frames_csv=cropped_volume_enabled ?
            joinpath(cropped_volume_root, "frames.csv") : nothing,
        hero_volume_enabled,
        hero_volume_frame_count=hero_volume_written,
        hero_volume_sample_stride,
        hero_volume_frames_csv=hero_volume_enabled ?
            joinpath(hero_volume_root, "frames.csv") : nothing,
        trace=traces,
        simulation_created=true,
    )
    write_json(joinpath(output_root, "policy_smoke_report.json"), report)
    write_json(joinpath(output_root, "summary.json"), report)
    open(joinpath(output_root, "trajectory.csv"), "w") do io
        println(io, "elapsed,center_x_L,center_y_L,head_x_L,head_y_L,distance_L,heading_rad,velocity_x_U,velocity_y_U,force_x_L2,force_y_L2,moment_z_L3,local_flow_x_U,local_flow_y_U,phi1_rad,phi2_rad,phi_dot1,phi_dot2,phi_ddot1,phi_ddot2,heading_reference_rad,heading_error_rad,heading_rate_rad_per_T,filtered_heading_error_rad,filtered_heading_rate_rad_per_T,feedback_scale,scheduled_asymmetry1,scheduled_asymmetry2,applied_asymmetry1,applied_asymmetry2,commanded_bias_rad,commanded_asymmetry,raw_commanded_asymmetry,phase_authority_weight,heading_update_index")
        for row in traces
            println(io, join((
                row.elapsed,
                row.center[1], row.center[2],
                row.head[1], row.head[2],
                row.distance_L,
                row.heading,
                row.velocity[1], row.velocity[2],
                row.force_body_coefficient[1], row.force_body_coefficient[2],
                row.moment_coefficient,
                row.local_flow_body[1], row.local_flow_body[2],
                row.joint...,
                row.action...,
                row.heading_reference,
                row.heading_error,
                row.heading_rate_T,
                row.filtered_heading_error,
                row.filtered_heading_rate_T,
                row.feedback_scale,
                row.scheduled_asymmetry1,
                row.scheduled_asymmetry2,
                row.applied_asymmetry1,
                row.applied_asymmetry2,
                row.commanded_bias,
                row.commanded_asymmetry,
                row.raw_commanded_asymmetry,
                row.phase_authority_weight,
                row.heading_update_index,
            ), ","))
        end
    end
    println(JSON.json(Base2D.jsonable((
        schema=report.schema,
        status,
        termination,
        failure_message,
        achieved_horizon=report.achieved_horizon,
        steps,
        wall_seconds,
        initial_distance_L,
        final_distance_L,
        minimum_distance_L=report.minimum_distance_L,
        score=report.score,
        policy_sha256=report.policy_sha256,
        prewarm_snapshot_sha256=report.prewarm_snapshot_sha256,
    ))))
    fatal_failure = termination in ("nonfinite_state", "solver_error", "max_steps")
    if fatal_failure || (status != "ok" && !allow_scientific_failure)
        error("3D projected-multiwake rollout failed: $termination: $failure_message")
    end
    return report
end

env_bool("DOGFISH3D_ENGINE_AUTORUN", true) && main()
