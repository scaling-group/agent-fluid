function force_components(force)
    if is_cuda_storage(force)
        cuda = CUDA_MODULE[]
        return cuda.allowscalar() do
            (Float64(force[1]), Float64(force[2]))
        end
    end
    return (Float64(force[1]), Float64(force[2]))
end

function instantaneous_force_power(sim)
    force_norm = 0.5 * sim.L * sim.U^2
    power_norm = force_norm * sim.U
    t = WaterLily.time(sim.flow)
    total_force = WaterLily.total_force(sim)
    input_power = 0.0

    if is_cuda_storage(sim.flow.p)
        cuda = CUDA_MODULE[]
        cuda.allowscalar() do
            for I in CartesianIndices(sim.flow.p)
                if any(axis -> I[axis] == 1 || I[axis] == size(sim.flow.p, axis), 1:ndims(sim.flow.p))
                    continue
                end

                x = WaterLily.loc(0, I, eltype(sim.flow.p))
                d, _, V = WaterLily.measure(sim.body, x, t, fastd²=1)
                abs(d) > 1 && continue

                n = WaterLily.nds(sim.body, x, t)
                traction = sim.flow.p[I] * n - 2 * sim.flow.ν * WaterLily.S(I, sim.flow.u) * n
                input_power -= WaterLily.dot(traction, V)
            end
        end
    else
        for I in CartesianIndices(sim.flow.p)
            if any(axis -> I[axis] == 1 || I[axis] == size(sim.flow.p, axis), 1:ndims(sim.flow.p))
                continue
            end

            x = WaterLily.loc(0, I, eltype(sim.flow.p))
            d, _, V = WaterLily.measure(sim.body, x, t, fastd²=1)
            abs(d) > 1 && continue

            n = WaterLily.nds(sim.body, x, t)
            traction = sim.flow.p[I] * n - 2 * sim.flow.ν * WaterLily.S(I, sim.flow.u) * n
            input_power -= WaterLily.dot(traction, V)
        end
    end

    force_x, force_y = force_components(total_force)
    return (force_x / force_norm, force_y / force_norm), Float64(input_power / power_norm)
end

function collect_force_power_trace!(sim, period; n_cycles::Float32, samples_per_cycle::Int)
    dt = period / samples_per_cycle
    n_samples = max(1, Int(round(Float64(n_cycles * samples_per_cycle))))
    t0 = sim_time(sim)

    fxs = Float64[]
    fys = Float64[]
    cps = Float64[]
    times = Float64[]
    for sample_index in 1:n_samples
        relative_t = sample_index * dt
        sim_step!(sim, t0 + relative_t, remeasure=true)
        force, cp = instantaneous_force_power(sim)
        push!(times, Float64(relative_t))
        push!(fxs, Float64(force[1]))
        push!(fys, Float64(force[2]))
        push!(cps, Float64(cp))
    end

    return (
        times=times,
        fxs=fxs,
        fys=fys,
        cps=cps,
        dt=Float64(dt),
        n_samples=n_samples,
        duration=Float64(n_samples * dt),
    )
end

function input_power_coefficients(cps)
    return [max(-Float64(cp), 0.0) for cp in cps]
end

function integrate_target_reach_1d(trace, assay)
    target_x = Float64(assay.params.target_x)
    success_radius = Float64(assay.params.success_radius)
    mass_coeff = Float64(assay.params.mass_coeff)
    linear_drag = Float64(assay.params.linear_drag)
    x = Float64(assay.params.initial_x)
    u = Float64(assay.params.initial_u)
    dt = Float64(trace.dt)

    xs = Float64[]
    us = Float64[]
    distances = Float64[]
    hit_index = nothing

    for (index, fx) in enumerate(trace.fxs)
        acceleration = (Float64(fx) - linear_drag * u) / mass_coeff
        u += acceleration * dt
        x += u * dt
        distance = abs(target_x - x)
        push!(xs, x)
        push!(us, u)
        push!(distances, distance)
        if hit_index === nothing && distance <= success_radius
            hit_index = index
        end
    end

    closest_index = argmin(distances)
    return (
        time=trace.times,
        x=xs,
        u=us,
        distance_to_target=distances,
        target_x=target_x,
        success_radius=success_radius,
        x_final=xs[end],
        u_final=us[end],
        x_max=maximum(xs),
        d_min=distances[closest_index],
        d_final=distances[end],
        closest_index=closest_index,
        time_to_closest=trace.times[closest_index],
        hit_target=hit_index !== nothing,
        time_to_first_hit=hit_index === nothing ? nothing : trace.times[hit_index],
        termination_reason=hit_index === nothing ? :horizon : :hit_target,
    )
end

function run_steady_cruise_experiment(
    design,
    experiment;
    experiment_index::Int,
    experiment_id::String,
    L::Int,
    Re::Float32,
    n_warmup_cycles::Float32,
    n_eval_cycles::Float32,
    samples_per_cycle::Int,
    T::Type,
    backend,
    mem,
)
    assay = experiment.assay
    sim, period, morphology_params, assembled_params, resolved_backend = build_simulation(
        design,
        experiment;
        L,
        Re,
        T,
        backend,
        mem,
    )

    sim_step!(sim, n_warmup_cycles * period, remeasure=true)
    trace = collect_force_power_trace!(sim, period; n_cycles=n_eval_cycles, samples_per_cycle)

    ct_prop = mean(trace.fxs)
    cx_drag = -ct_prop
    rms_lateral_force = sqrt(mean(abs2, trace.fys))
    mean_lateral_force = mean(trace.fys)
    cp = -mean(trace.cps)
    eta = ct_prop > 0 && cp > eps(cp) ? ct_prop / cp : 0.0
    score = ct_prop
    selection_eligible = assay_is_selection_core(assay)
    raw_metrics = (
        CT_prop=ct_prop,
        Cx_drag=cx_drag,
        rms_lateral_force=rms_lateral_force,
        mean_lateral_force=mean_lateral_force,
        CP=cp,
        eta=eta,
        period=period,
        samples=trace.n_samples,
        grid_L=L,
        Re=Float64(Re),
    )

    return (
        score=score,
        selection_eligible=selection_eligible,
        selection_score=selection_eligible ? score : nothing,
        assay_local_score=score,
        assay_local_score_name=STEADY_CRUISE_ASSAY_LOCAL_SCORE,
        raw_metrics=raw_metrics,
        validity=steady_cruise_validity(),
        CT_prop=ct_prop,
        Cx_drag=cx_drag,
        rms_lateral_force=rms_lateral_force,
        mean_lateral_force=mean_lateral_force,
        CP=cp,
        eta=eta,
        period=period,
        samples=trace.n_samples,
        grid_L=L,
        Re=Float64(Re),
        memory_backend=resolved_backend.name,
        cuda_available=resolved_backend.cuda_available,
        policy_version=String(design.version),
        parameter_index=experiment_index,
        experiment_id=experiment_id,
        assay=assay,
        morphology_parameters=morphology_params,
        parameter_set=experiment.motion,
        assembled_parameters=assembled_params,
    )
end

function run_transient_forward_push_experiment(
    design,
    experiment;
    experiment_index::Int,
    experiment_id::String,
    L::Int,
    Re::Float32,
    n_eval_cycles::Float32,
    samples_per_cycle::Int,
    T::Type,
    backend,
    mem,
)
    assay = experiment.assay
    horizon_cycles = hasproperty(assay.params, :horizon_cycles) ?
        Float32(assay.params.horizon_cycles) : n_eval_cycles
    sim, period, morphology_params, assembled_params, resolved_backend = build_simulation(
        design,
        experiment;
        L,
        Re,
        T,
        backend,
        mem,
    )

    trace = collect_force_power_trace!(sim, period; n_cycles=horizon_cycles, samples_per_cycle)
    power_coeffs = input_power_coefficients(trace.cps)
    impulse_forward = sum(trace.fxs) * trace.dt
    lateral_impulse_abs = sum(abs.(trace.fys)) * trace.dt
    input_energy = sum(power_coeffs) * trace.dt
    peak_index = argmax(trace.fxs)
    peak_forward_force = trace.fxs[peak_index]
    time_to_peak_force = trace.times[peak_index]
    mean_forward_force = mean(trace.fxs)
    rms_lateral_force = sqrt(mean(abs2, trace.fys))
    mean_lateral_force = mean(trace.fys)
    mean_input_power = mean(power_coeffs)
    impulse_per_energy = impulse_forward > 0 && input_energy > eps(input_energy) ?
        impulse_forward / input_energy : 0.0
    stability_flags = (
        finite_trace = all(isfinite, trace.fxs) && all(isfinite, trace.fys) && all(isfinite, trace.cps),
        large_lateral_force = rms_lateral_force > 5.0,
    )
    score = impulse_forward
    selection_eligible = assay_is_selection_core(assay)
    raw_metrics = (
        impulse_forward=impulse_forward,
        peak_forward_force=peak_forward_force,
        time_to_peak_force=time_to_peak_force,
        mean_forward_force=mean_forward_force,
        lateral_impulse_abs=lateral_impulse_abs,
        rms_lateral_force=rms_lateral_force,
        mean_lateral_force=mean_lateral_force,
        input_energy=input_energy,
        mean_input_power=mean_input_power,
        impulse_per_energy=impulse_per_energy,
        horizon_cycles=Float64(horizon_cycles),
        duration=trace.duration,
        period=period,
        samples=trace.n_samples,
        grid_L=L,
        Re=Float64(Re),
        stability_flags=stability_flags,
        time_trace=trace.times,
        force_x_trace=trace.fxs,
        force_y_trace=trace.fys,
        input_power_trace=power_coeffs,
        CT_prop=mean_forward_force,
        Cx_drag=-mean_forward_force,
        CP=mean_input_power,
        eta=impulse_per_energy,
    )

    return (
        score=score,
        selection_eligible=selection_eligible,
        selection_score=selection_eligible ? score : nothing,
        assay_local_score=score,
        assay_local_score_name=TRANSIENT_FORWARD_PUSH_ASSAY_LOCAL_SCORE,
        raw_metrics=raw_metrics,
        validity=transient_forward_push_validity(),
        CT_prop=mean_forward_force,
        Cx_drag=-mean_forward_force,
        rms_lateral_force=rms_lateral_force,
        mean_lateral_force=mean_lateral_force,
        CP=mean_input_power,
        eta=impulse_per_energy,
        period=period,
        samples=trace.n_samples,
        grid_L=L,
        Re=Float64(Re),
        memory_backend=resolved_backend.name,
        cuda_available=resolved_backend.cuda_available,
        policy_version=String(design.version),
        parameter_index=experiment_index,
        experiment_id=experiment_id,
        assay=assay,
        morphology_parameters=morphology_params,
        parameter_set=experiment.motion,
        assembled_parameters=assembled_params,
    )
end

function run_target_reach_1d_experiment(
    design,
    experiment;
    experiment_index::Int,
    experiment_id::String,
    L::Int,
    Re::Float32,
    n_eval_cycles::Float32,
    samples_per_cycle::Int,
    T::Type,
    backend,
    mem,
)
    assay = experiment.assay
    horizon_cycles = hasproperty(assay.params, :horizon_cycles) ?
        Float32(assay.params.horizon_cycles) : n_eval_cycles
    sim, period, morphology_params, assembled_params, resolved_backend = build_simulation(
        design,
        experiment;
        L,
        Re,
        T,
        backend,
        mem,
    )

    trace = collect_force_power_trace!(sim, period; n_cycles=horizon_cycles, samples_per_cycle)
    power_coeffs = input_power_coefficients(trace.cps)
    trajectory = integrate_target_reach_1d(trace, assay)
    input_energy = sum(power_coeffs) * trace.dt
    impulse_forward = sum(trace.fxs) * trace.dt
    lateral_impulse_abs = sum(abs.(trace.fys)) * trace.dt
    mean_forward_force = mean(trace.fxs)
    rms_lateral_force = sqrt(mean(abs2, trace.fys))
    mean_lateral_force = mean(trace.fys)
    mean_input_power = mean(power_coeffs)
    initial_distance = abs(Float64(assay.params.target_x) - Float64(assay.params.initial_x))
    progress_fraction = (initial_distance - trajectory.d_min) / max(initial_distance, eps(initial_distance))
    final_progress_fraction = (initial_distance - trajectory.d_final) / max(initial_distance, eps(initial_distance))
    hit_bonus = trajectory.hit_target ? 1.0 : 0.0
    energy_penalty = 0.05 * input_energy
    lateral_penalty = 0.01 * lateral_impulse_abs
    score = progress_fraction + 0.25 * final_progress_fraction + hit_bonus -
        energy_penalty - lateral_penalty
    stability_flags = (
        finite_trace = all(isfinite, trace.fxs) && all(isfinite, trace.fys) &&
            all(isfinite, trace.cps) && all(isfinite, trajectory.x) && all(isfinite, trajectory.u),
        large_lateral_force = rms_lateral_force > 5.0,
        hit_target = trajectory.hit_target,
    )
    selection_eligible = assay_is_selection_core(assay)
    raw_metrics = (
        target_x=Float64(assay.params.target_x),
        success_radius=Float64(assay.params.success_radius),
        initial_x=Float64(assay.params.initial_x),
        initial_u=Float64(assay.params.initial_u),
        x_final=trajectory.x_final,
        x_max=trajectory.x_max,
        u_final=trajectory.u_final,
        d_min=trajectory.d_min,
        d_final=trajectory.d_final,
        time_to_closest=trajectory.time_to_closest,
        time_to_first_hit=trajectory.time_to_first_hit,
        hit_target=trajectory.hit_target,
        termination_reason=trajectory.termination_reason,
        progress_fraction=progress_fraction,
        final_progress_fraction=final_progress_fraction,
        impulse_forward=impulse_forward,
        input_energy=input_energy,
        lateral_impulse_abs=lateral_impulse_abs,
        mean_forward_force=mean_forward_force,
        rms_lateral_force=rms_lateral_force,
        mean_lateral_force=mean_lateral_force,
        mean_input_power=mean_input_power,
        horizon_cycles=Float64(horizon_cycles),
        duration=trace.duration,
        period=period,
        samples=trace.n_samples,
        grid_L=L,
        Re=Float64(Re),
        stability_flags=stability_flags,
        trajectory=trajectory,
        force_x_trace=trace.fxs,
        force_y_trace=trace.fys,
        input_power_trace=power_coeffs,
        CT_prop=mean_forward_force,
        Cx_drag=-mean_forward_force,
        CP=mean_input_power,
        eta=progress_fraction > 0 && input_energy > eps(input_energy) ?
            progress_fraction / input_energy : 0.0,
    )

    return (
        score=score,
        selection_eligible=selection_eligible,
        selection_score=selection_eligible ? score : nothing,
        assay_local_score=score,
        assay_local_score_name=TARGET_REACH_1D_ASSAY_LOCAL_SCORE,
        raw_metrics=raw_metrics,
        validity=target_reach_1d_validity(),
        CT_prop=mean_forward_force,
        Cx_drag=-mean_forward_force,
        rms_lateral_force=rms_lateral_force,
        mean_lateral_force=mean_lateral_force,
        CP=mean_input_power,
        eta=raw_metrics.eta,
        period=period,
        samples=trace.n_samples,
        grid_L=L,
        Re=Float64(Re),
        memory_backend=resolved_backend.name,
        cuda_available=resolved_backend.cuda_available,
        policy_version=String(design.version),
        parameter_index=experiment_index,
        experiment_id=experiment_id,
        assay=assay,
        morphology_parameters=morphology_params,
        parameter_set=experiment.motion,
        assembled_parameters=assembled_params,
    )
end

function run_policy_experiment(
    design,
    subject::NamedTuple;
    parameter_index::Int=1,
    experiment_index::Int=parameter_index,
    L::Int=64,
    Re::Float32=2000f0,
    n_warmup_cycles::Float32=2.0f0,
    n_eval_cycles::Float32=2.0f0,
    samples_per_cycle::Int=24,
    T::Type=Float32,
    backend="auto",
    mem=nothing,
)
    is_legacy_experiment = hasproperty(subject, :params)
    is_design_experiment = hasproperty(subject, :morphology) && hasproperty(subject, :motion)
    experiment_id = (is_legacy_experiment || is_design_experiment) ? String(subject.id) :
        "parameter_set_$(lpad(string(experiment_index), 3, '0'))"
    experiment = if is_design_experiment
        subject
    elseif is_legacy_experiment
        (
            id=experiment_id,
            morphology=NamedTuple(),
            motion=subject.params,
            assay=hasproperty(subject, :assay) ? normalize_assay(subject.assay) : default_assay(),
        )
    else
        (id=experiment_id, morphology=NamedTuple(), motion=subject)
    end
    assay = experiment_assay(experiment)
    experiment = merge(experiment, (assay=assay,))

    if assay.family == STEADY_CRUISE_ASSAY_FAMILY
        return run_steady_cruise_experiment(
            design,
            experiment;
            experiment_index,
            experiment_id,
            L,
            Re,
            n_warmup_cycles,
            n_eval_cycles,
            samples_per_cycle,
            T,
            backend,
            mem,
        )
    elseif assay.family == TRANSIENT_FORWARD_PUSH_ASSAY_FAMILY
        return run_transient_forward_push_experiment(
            design,
            experiment;
            experiment_index,
            experiment_id,
            L,
            Re,
            n_eval_cycles,
            samples_per_cycle,
            T,
            backend,
            mem,
        )
    elseif assay.family == TARGET_REACH_1D_ASSAY_FAMILY
        return run_target_reach_1d_experiment(
            design,
            experiment;
            experiment_index,
            experiment_id,
            L,
            Re,
            n_eval_cycles,
            samples_per_cycle,
            T,
            backend,
            mem,
        )
    end

    error("Unsupported assay family `$(assay.family)`")
end

function evaluate_design(design; experiment_index::Int=1, kwargs...)
    issues = validate_design_spec(design)
    isempty(issues) || error("Invalid candidate design: " * join(issues, "; "))

    experiments = collect(design_experiments(design))
    1 <= experiment_index <= length(experiments) ||
        error("experiment_index $experiment_index outside 1:$(length(experiments))")
    return run_policy_experiment(design, experiments[experiment_index]; experiment_index, kwargs...)
end

evaluate_policy(policy; parameter_index::Int=1, experiment_index::Int=parameter_index, kwargs...) =
    evaluate_design(policy; experiment_index, kwargs...)
