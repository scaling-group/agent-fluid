const ASSAY_CONTRACT_VERSION = "dogfish.assay.v1"
const SCORE_SCHEMA_VERSION = "dogfish.score.v1"
const SELECTION_PROGRAM_VERSION = "dogfish-assay-selection-v0"
const STEADY_CRUISE_ASSAY_FAMILY = :steady_cruise
const TRANSIENT_FORWARD_PUSH_ASSAY_FAMILY = :transient_forward_push
const TARGET_REACH_1D_ASSAY_FAMILY = :target_reach_1d
const STEADY_CRUISE_ASSAY_LOCAL_SCORE = "steady_cruise.CT_prop.v1"
const STEADY_CRUISE_BATCH_SELECTION_SCORE = "steady_cruise.best_CT_plus_eta_tiebreaker.v1"
const TRANSIENT_FORWARD_PUSH_ASSAY_LOCAL_SCORE = "transient_forward_push.impulse_forward.v0"
const TARGET_REACH_1D_ASSAY_LOCAL_SCORE = "target_reach_1d.progress_energy.v0"

function assay_symbol(value)
    value isa Symbol && return value
    return Symbol(String(value))
end

function default_assay()
    return (
        schema_version = ASSAY_CONTRACT_VERSION,
        family = STEADY_CRUISE_ASSAY_FAMILY,
        version = "v1",
        purpose = :selection,
        capability_axis = :forward_efficiency,
        params = NamedTuple(),
    )
end

function default_transient_forward_push_assay()
    return (
        schema_version = ASSAY_CONTRACT_VERSION,
        family = TRANSIENT_FORWARD_PUSH_ASSAY_FAMILY,
        version = "v0",
        purpose = :diagnostic,
        capability_axis = :transient_forward_impulse,
        params = (
            horizon_cycles = 1.0f0,
        ),
    )
end

function default_target_reach_1d_assay()
    return (
        schema_version = ASSAY_CONTRACT_VERSION,
        family = TARGET_REACH_1D_ASSAY_FAMILY,
        version = "v0",
        purpose = :diagnostic,
        capability_axis = :finite_horizon_reachability,
        params = (
            target_x = 0.20f0,
            success_radius = 0.03f0,
            horizon_cycles = 1.0f0,
            mass_coeff = 1.0f0,
            linear_drag = 0.15f0,
            initial_x = 0.0f0,
            initial_u = 0.0f0,
        ),
    )
end

function default_assay_for_family(family::Symbol)
    family == STEADY_CRUISE_ASSAY_FAMILY && return default_assay()
    family == TRANSIENT_FORWARD_PUSH_ASSAY_FAMILY && return default_transient_forward_push_assay()
    family == TARGET_REACH_1D_ASSAY_FAMILY && return default_target_reach_1d_assay()
    error("assay family `$family` is not executable yet")
end

function normalize_assay(assay)
    assay isa NamedTuple || error("assay must be a NamedTuple")
    hasproperty(assay, :family) || error("assay missing family")

    family = assay_symbol(assay.family)
    fallback = default_assay_for_family(family)

    provided_params = hasproperty(assay, :params) ? assay.params : NamedTuple()
    provided_params isa NamedTuple || error("assay params must be a NamedTuple")
    params = merge(fallback.params, provided_params)

    return (
        schema_version = hasproperty(assay, :schema_version) ?
            String(assay.schema_version) : fallback.schema_version,
        family = family,
        version = hasproperty(assay, :version) ? String(assay.version) : fallback.version,
        purpose = hasproperty(assay, :purpose) ? assay_symbol(assay.purpose) : fallback.purpose,
        capability_axis = hasproperty(assay, :capability_axis) ?
            assay_symbol(assay.capability_axis) : fallback.capability_axis,
        params = params,
    )
end

function experiment_assay(experiment)
    return hasproperty(experiment, :assay) ? normalize_assay(experiment.assay) : default_assay()
end

function invalid_assay(error_message)
    return (
        schema_version = ASSAY_CONTRACT_VERSION,
        family = :invalid_assay,
        version = "invalid",
        purpose = :invalid,
        capability_axis = :invalid,
        params = NamedTuple(),
        error = error_message,
    )
end

function validate_assay_definition(index::Int, assay)
    try
        normalized = normalize_assay(assay)
        return validate_assay_params(index, normalized)
    catch error
        return ["experiment $index invalid assay: " * sprint(showerror, error)]
    end
end

function validate_positive_assay_param!(issues, index::Int, assay, name::Symbol)
    value = Float64(getproperty(assay.params, name))
    isfinite(value) || push!(issues, "experiment $index assay param `$name` must be finite")
    value > 0 || push!(issues, "experiment $index assay param `$name` must be positive")
end

function validate_finite_assay_param!(issues, index::Int, assay, name::Symbol)
    value = Float64(getproperty(assay.params, name))
    isfinite(value) || push!(issues, "experiment $index assay param `$name` must be finite")
end

function validate_assay_params(index::Int, assay)
    issues = String[]
    if assay.family == TRANSIENT_FORWARD_PUSH_ASSAY_FAMILY
        validate_positive_assay_param!(issues, index, assay, :horizon_cycles)
    elseif assay.family == TARGET_REACH_1D_ASSAY_FAMILY
        for name in (:target_x, :success_radius, :horizon_cycles, :mass_coeff)
            validate_positive_assay_param!(issues, index, assay, name)
        end
        for name in (:linear_drag, :initial_x, :initial_u)
            validate_finite_assay_param!(issues, index, assay, name)
        end
    end
    return issues
end

function assay_is_selection_core(assay)
    return assay.family == STEADY_CRUISE_ASSAY_FAMILY && assay.purpose == :selection
end

function steady_cruise_validity()
    return (
        assumption_domain = :steady_cruise_body_fixed,
        admissible = true,
        verifier_checks = (
            :steady_cruise_assay,
            :body_fixed_reference_frame,
            :finite_force_samples,
        ),
    )
end

function transient_forward_push_validity()
    return (
        assumption_domain = :body_fixed_transient_forward_probe,
        admissible = true,
        verifier_checks = (
            :transient_forward_push_assay,
            :body_fixed_reference_frame,
            :finite_horizon_force_trace,
            :no_longitudinal_trajectory_state,
        ),
    )
end

function target_reach_1d_validity()
    return (
        assumption_domain = :force_integrated_1d_reachability_surrogate,
        admissible = true,
        verifier_checks = (
            :target_reach_1d_assay,
            :finite_horizon_force_trace,
            :longitudinal_state_integrated_from_force,
            :trajectory_artifact,
            :not_full_free_swimming_fsi,
        ),
    )
end
