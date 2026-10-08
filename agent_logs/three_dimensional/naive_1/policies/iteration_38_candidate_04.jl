# Full-angle carrier with proximity-previewed through-water course feedback,
# anterior recovery, fixed-lead posterior recovery allocation, kinematic
# posterior half-cycle steering, a separately proximity-led reactive rudder,
# and response-plus-stroke terminal relief.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        propulsion_recovery_gain=1.50,
        posterior_recovery_gain=0.12,
        propulsion_recovery_speed_start_U=0.45,
        propulsion_recovery_speed_full_U=0.20,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.25,
        course_angle_feedback=0.65,
        course_speed_floor_U=0.45,
        course_proximity_lead_cycles=0.50,
        curvature_bias_limit=8.0 * pi / 180,
        redirect_error_start=0.45,
        redirect_error_full=0.90,
        redirect_acceleration_limit=16.0,
        phase_velocity_limit=1.0,
        tail_carrier_relief=0.65,
        tail_stroke_asymmetry=0.30,
        stroke_transition_scale=0.20,
        rudder_distance_start_L=8.0,
        rudder_distance_full_L=5.5,
        rudder_error_start=0.35,
        rudder_error_full=0.90,
        rudder_lateral_scale_L=0.25,
        rudder_line_of_sight_rate_limit=0.50,
        rudder_line_of_sight_lead_cycles=1.0,
        rudder_proximity_lead_cycles=0.50,
        posterior_rudder_limit=16.0 * pi / 180,
        stall_closing_speed_start_L=0.35,
        stall_closing_speed_full_L=0.10,
        rudder_stall_relief=0.20,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Combine the evidenced axial and lateral body-water observations into a
    # bounded course angle. The positive axial floor prevents startup or
    # reversal from turning lateral beat motion into a singular route command.
    # Folded bearing remains the slow reflection-equivariant target signal.
    bearing = Float64(state.bearing)
    forward_speed = Float64(state.relative_flow_velocity_body_U[1])
    lateral_sideslip =
        -Float64(state.relative_flow_velocity_body_U[2])
    course_forward_speed = max(
        forward_speed,
        params.course_speed_floor_U,
    )
    course_sideslip_angle = atan(
        lateral_sideslip,
        course_forward_speed,
    )
    route_error = bearing -
        params.course_angle_feedback * course_sideslip_angle

    # The head points along negative body x. Full angle prevents a target
    # passed abeam or behind from looking aligned, while the lateral component
    # supplies a continuous turn sign across the rear-axis branch.
    target_forward = -Float64(state.target_body_L[1])
    target_lateral = Float64(state.target_body_L[2])
    target_error = atan(target_lateral, target_forward)
    geometric_turn = tanh(
        target_lateral / params.rudder_lateral_scale_L,
    )

    # Reuse the same normalized approach envelope that recruits the reactive
    # rudder. It is zero at the outer boundary and smoothly reaches one before
    # the terminal approach, so it can allocate pursuit prediction without
    # changing the carrier or the rudder-angle ceiling.
    distance_progress = clamp(
        (params.rudder_distance_start_L - Float64(state.distance_L)) /
            max(
                params.rudder_distance_start_L -
                    params.rudder_distance_full_L,
                eps(params.rudder_distance_start_L),
            ),
        0.0,
        1.0,
    )
    distance_gate = distance_progress^2 * (3 - 2 * distance_progress)

    # The short-window bearing rate contains the same rhythmic body yaw as the
    # target error. Under this policy's negative-body-x head convention,
    # subtracting recent body turn isolates target-line translation. Keep a
    # fixed one-cycle prediction for the posterior recovery allocator. A
    # separate proximity-adaptive prediction below changes only the reactive
    # rudder gate, leaving carrier phase, sign, and peak authority intact.
    line_of_sight_rate = clamp(
        Float64(state.bearing_window_rate) -
            Float64(state.turn_rate_recent),
        -params.rudder_line_of_sight_rate_limit,
        params.rudder_line_of_sight_rate_limit,
    )

    # The posterior half-cycle envelope benefits from target-line preview, but
    # the short folded-bearing window lags during the sharp terminal curl. Form
    # the translation-only rate directly from the full normalized target
    # vector and inertial body-frame velocity. This is the angular rate of the
    # world target line expressed in the policy's forward/lateral convention;
    # body yaw is absent analytically rather than removed by differencing.
    inertial_forward_speed = -Float64(state.velocity_body_U[1])
    inertial_lateral_speed = Float64(state.velocity_body_U[2])
    target_radius_squared = max(
        target_forward^2 + target_lateral^2,
        eps(Float64),
    )
    phase_line_of_sight_rate = clamp(
        (
            target_lateral * inertial_forward_speed -
                target_forward * inertial_lateral_speed
        ) / target_radius_squared,
        -params.rudder_line_of_sight_rate_limit,
        params.rudder_line_of_sight_rate_limit,
    )
    led_target_error = target_error +
        params.rudder_line_of_sight_lead_cycles *
        params.control_period * line_of_sight_rate
    rudder_line_of_sight_lead_cycles =
        params.rudder_line_of_sight_lead_cycles +
        params.rudder_proximity_lead_cycles * distance_gate
    rudder_led_target_error = target_error +
        rudder_line_of_sight_lead_cycles *
        params.control_period * line_of_sight_rate

    # Apply a proximity-grown target-line preview to the separate slow
    # anterior mean-turn path. This changes when the bounded curvature center
    # responds, not its authority, and is inactive before proximity opens.
    course_led_route_error = route_error +
        params.course_proximity_lead_cycles * params.control_period *
        distance_gate * line_of_sight_rate
    turn_request = tanh(
        course_led_route_error / params.steering_bearing_scale,
    )

    # Use full-vector kinematic preview only on the already successful
    # posterior half-cycle envelope, not on its stroke sign or ceiling. This
    # preserves instantaneous target-side selection, removes short-window lag,
    # and is exactly inactive during the evidenced launch outside the distance
    # gate. Other predictive actuator paths retain their sampled signal.
    phase_led_target_error = target_error +
        params.course_proximity_lead_cycles * params.control_period *
        distance_gate * phase_line_of_sight_rate
    phase_redirect_progress = clamp(
        (abs(phase_led_target_error) - params.redirect_error_start) /
            max(
                params.redirect_error_full -
                    params.redirect_error_start,
                eps(params.redirect_error_full),
            ),
        0.0,
        1.0,
    )
    phase_redirect_gate = phase_redirect_progress^2 *
        (3 - 2 * phase_redirect_progress)

    redirect_progress = clamp(
        (abs(target_error) - params.redirect_error_start) /
            max(
                params.redirect_error_full -
                    params.redirect_error_start,
                eps(params.redirect_error_full),
            ),
        0.0,
        1.0,
    )
    redirect_gate = redirect_progress^2 * (3 - 2 * redirect_progress)

    # Use predicted slow route demand only to select between the two completed
    # posterior recovery targets. The one fixed recovery budget moves toward
    # velocity-quadrature phase allocation before instantaneous error grows;
    # anterior redirect and carrier-stroke shaping retain current geometry.
    recovery_allocation_progress = clamp(
        (abs(led_target_error) - params.redirect_error_start) /
            max(
                params.redirect_error_full -
                    params.redirect_error_start,
                eps(params.redirect_error_full),
            ),
        0.0,
        1.0,
    )
    recovery_allocation_gate = recovery_allocation_progress^2 *
        (3 - 2 * recovery_allocation_progress)

    # Retain the sampled anterior-only curvature center and large-error
    # half-cycle residual. Oscillator phase comes only from joint state. The
    # direct-uniform rollout has a long low-speed startup before settling near
    # 0.625 U, while less than two percent of established cruise is below
    # 0.45 U. Recruit bounded oscillator energy only below that measured lower
    # envelope, then return continuously to the inherited carrier. This is a
    # through-water speed-feedback recovery mechanism, not a clocked startup
    # stage. Relative axial flow keeps passive advection distinct from the
    # locomotor slowdown that should recruit carrier energy.
    curvature_center = params.curvature_bias_limit * turn_request
    carrier_q1 = q1 - curvature_center
    propulsion_recovery_progress = clamp(
        (
            params.propulsion_recovery_speed_start_U - forward_speed
        ) /
            max(
                params.propulsion_recovery_speed_start_U -
                    params.propulsion_recovery_speed_full_U,
                eps(params.propulsion_recovery_speed_start_U),
            ),
        0.0,
        1.0,
    )
    propulsion_recovery_gate = propulsion_recovery_progress^2 *
        (3 - 2 * propulsion_recovery_progress)
    oscillator_energy_gain = params.oscillator_mu +
        params.propulsion_recovery_gain * propulsion_recovery_gate
    vdp_drive = oscillator_energy_gain *
        (1 - (carrier_q1 / amp)^2) * qd1
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    anterior_redirect = params.redirect_acceleration_limit *
        redirect_gate * geometric_turn * phase_speed
    a1 = vdp_drive - omega^2 * carrier_q1 + anterior_redirect

    # Preserve the inherited phase-selective posterior carrier: more of the
    # target-side stroke and less of its cancelling return at large error.
    normalized_stroke_rate = geometric_turn * qd1 /
        max(omega * amp, eps(omega * amp))
    useful_stroke_gate = 0.5 * (
        1 + tanh(
            normalized_stroke_rate / params.stroke_transition_scale,
        )
    )
    symmetric_tail_scale = 1 -
        params.tail_carrier_relief * redirect_gate
    tail_carrier_scale = clamp(
        symmetric_tail_scale +
            params.tail_stroke_asymmetry * phase_redirect_gate *
            (2 * useful_stroke_gate - 1),
        0.0,
        1.0,
    )

    # The completed same-sign C-bend produced the wrong mean yaw. Use its
    # measured response to select the opposite posterior load sign. Distance
    # and error gates recruit the rudder before abeam, then remove it smoothly
    # on alignment without suppressing the traveling carrier. Proximity adds
    # look-ahead only on this path; it does not alter recovery allocation.
    rudder_error_progress = clamp(
        (abs(rudder_led_target_error) - params.rudder_error_start) /
            max(
                params.rudder_error_full - params.rudder_error_start,
                eps(params.rudder_error_full),
            ),
        0.0,
        1.0,
    )
    rudder_error_gate =
        rudder_error_progress^2 * (3 - 2 * rudder_error_progress)

    # A sampled +20% rudder boost during deficient terminal closure delayed
    # capture while raising command effort. The successful opposite response
    # was concentrated on the target-side anterior stroke near capture. Keep
    # the measured response gate, but release at most 20% only on that smooth
    # joint-observed half-cycle so the return stroke retains rudder authority.
    stall_progress = clamp(
        (
            params.stall_closing_speed_start_L -
                Float64(state.closing_speed_L)
        ) /
            max(
                params.stall_closing_speed_start_L -
                    params.stall_closing_speed_full_L,
                eps(params.stall_closing_speed_start_L),
            ),
        0.0,
        1.0,
    )
    stall_gate = stall_progress^2 * (3 - 2 * stall_progress)
    rudder_authority = 1 - params.rudder_stall_relief *
        stall_gate * useful_stroke_gate
    posterior_rudder = -params.posterior_rudder_limit *
        rudder_authority * distance_gate * rudder_error_gate *
        geometric_turn

    # Completed rollouts isolate a bounded trade: whole-carrier recovery is
    # ahead early while the target is aligned, but velocity-quadrature recovery
    # produces the better later route. Allocate one fixed recovery budget
    # between those completed targets with fixed-lead predicted route demand.
    # This convex blend never stacks posterior angle amplitude on top of the
    # phase increment and leaves the separately proximity-led rudder unchanged.
    base_lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    posterior_recovery_share = params.posterior_recovery_gain *
        propulsion_recovery_gate
    whole_carrier_recovery_target =
        (1 + posterior_recovery_share) * base_lagged_carrier
    phase_recovery_target = -carrier_q1 -
        (params.tail_lag_gain + posterior_recovery_share) *
        qd1 / max(omega, eps(omega))
    allocated_recovery_target =
        (1 - recovery_allocation_gate) * whole_carrier_recovery_target +
        recovery_allocation_gate * phase_recovery_target
    phase_lag_target = tail_carrier_scale *
        allocated_recovery_target +
        posterior_rudder
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
