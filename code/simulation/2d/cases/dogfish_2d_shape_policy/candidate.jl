function candidate_design()
    return (
        version = "dogfish.codesign.v1",
        lineage = lineage_spec(),
        morphology = morphology_spec(),
        motion = motion_spec(),
        experiments = design_experiments(),
    )
end

function lineage_spec()
    return (
        body_regime = :fixed_baseline_spine_swept_body_plan,
        motion_regime = :spine_angle_wave_release,
        notes = "fixed baseline thickness profile swept along an inextensible spine; policy controls spine tangent angle over time",
    )
end

function morphology_spec()
    return (
        schema = morphology_schema(),
        params = morphology_params(),
        generator = morphology_generator,
    )
end

function morphology_schema()
    return NamedTuple()
end

function morphology_params()
    return NamedTuple()
end

@inline function morphology_generator(s, p)
    return 0f0
end

function motion_spec()
    return (
        schema = motion_schema(),
        params = motion_params(),
        generator = motion_generator,
        derive = motion_derived_params,
    )
end

function motion_schema()
    return (
        A = (lower=0.03f0, upper=0.25f0),
        St = (lower=0.15f0, upper=0.60f0),
        k = (lower=1.0f0, upper=8.0f0),
        amp_head = (lower=0.0f0, upper=0.50f0),
        amp_tail = (lower=0.20f0, upper=1.60f0),
        amp_beta = (lower=0.10f0, upper=6.00f0),
        phase = (lower=-3.14159f0, upper=3.14159f0),
        harmonic2 = (lower=-0.50f0, upper=0.50f0),
    )
end

function motion_params()
    return (
        A = 0.06f0,
        St = 0.40f0,
        k = 5.30f0,
        amp_head = 0.08f0,
        amp_tail = 0.60f0,
        amp_beta = 1.80f0,
        phase = 0.0f0,
        harmonic2 = 0.0f0,
    )
end

function motion_derived_params(params; L::Int, T::Type=Float32)
    typed = DogfishShapePolicyTestbed.cast_named_tuple(params, T)
    U = T(1)
    Lf = T(L)
    A = T(typed.A)
    St = T(typed.St)
    omega = T(2 * pi) * St * U / (T(2) * A * Lf)
    # sim_step! uses tU/L; the body map receives raw solver time internally.
    period = T(2) * A / St
    return (params = merge(typed, (omega=omega,)), period = Float64(period))
end

function design_experiments()
    return [
        (
            id = "starter_codesign",
            assay = steady_cruise_assay(),
            morphology = NamedTuple(),
            motion = (
                A = 0.06f0,
                St = 0.40f0,
                k = 5.30f0,
                amp_head = 0.08f0,
                amp_tail = 0.60f0,
                amp_beta = 1.80f0,
                phase = 0.0f0,
                harmonic2 = 0.0f0,
            ),
        ),
    ]
end

function steady_cruise_assay()
    return (
        family = :steady_cruise,
        version = "v1",
        purpose = :selection,
        capability_axis = :forward_efficiency,
        params = NamedTuple(),
    )
end

@inline function motion_generator(s, t, p)
    envelope = p.amp_head + (p.amp_tail - p.amp_head) * normalized_exp(s, p.amp_beta)
    theta = p.k * s - p.omega * t + p.phase
    return p.A * envelope * (sin(theta) + p.harmonic2 * sin(2f0 * theta))
end

# Backward-compatible wrapper for tooling that still calls candidate_policy().
function candidate_policy()
    design = candidate_design()
    return (
        version = design.version,
        schema = design.motion.schema,
        experiments = [
            (
                id = experiment.id,
                params = merge(design.motion.params, experiment.motion),
            ) for experiment in design.experiments
        ],
        displacement = design.motion.generator,
    )
end
