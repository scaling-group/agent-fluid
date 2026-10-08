# Closing-gated terminal-hold candidate

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and finite dynamics.
  Their motion and wakes are therefore self-generated rather than imposed
  advection.
- The captured prefill, `solver_e44c6b14905f`, is the strong finite example.
  Its top-down row grows a coherent alternating red/blue caudal street and
  shows sustained target-directed translation; the oblique row confirms
  discrete three-dimensional Lambda2 structures through the approach. It
  captures at `16.291T` and `0.746L`, improving the termination class over the
  one-sided-relief and bearing-gated failures, which leave the upper boundary
  after reaching only `5.144L` and `5.086L`, respectively. Thus the inherited
  response-gated exact target-versus-course redirect is the mechanism to
  preserve, not replace.
- The informative `solver_c0ba6ee601b1` failure has a similarly coherent wake
  in both visual rows, but its path curls toward positive world y after closest
  approach and exits at center y=`15.201L`. Its `5.086L` minimum followed by a
  `6.292L` final distance agrees with the visible loss of target approach. The
  success is therefore a steering-response change, not merely more visible
  vortex production.
- The capture exposes a narrower terminal defect. Over the rollout, joint-1
  and joint-2 acceleration occupy the hard limit in about `49.4%` and `60.4%`
  of samples; their rate-limit residence is about `4.0%` and `6.7%`. The fish
  reaches `1.279L` at `15.752T` and crosses the target boundary only `0.539T`
  later with speed about `1.11U`; during the final `0.29T`, heading rate swings
  above `3 rad/T` and both joint commands repeatedly clip. The maximum planar
  force and yaw-moment coefficients (`0.0372` and `0.0189`) also exceed those
  of the two `left_domain` comparators. Capture is real, but the first-crossing
  success currently arrives with avoidable terminal actuation and beat-scale
  yaw.
- Inherited optimizer logs rule out extending continuous curvature, amplifying
  both half-cycles, or treating the roughly `0.033T` bearing history as a slow
  response estimate. Those mechanisms either retained the upper-exit topology
  or worsened distance and saturation. The new mechanism therefore leaves the
  carrier, redirect, and course observations exactly intact outside a tight
  approach neighborhood.

## Policy hypothesis

Preserve the captured controller's joint-state oscillator, posterior lag,
course-aware cruise law, and response-gated redirect. Add one continuous
terminal-hold mechanism: only when normalized head distance is near the
capture radius and measured normalized closing speed is positive, blend both
joint commands toward a slower critically damped zero-bend hold. Distance and
closing speed are invariant under reflection, and the hold is odd in joint
state, so the two-joint feedback remains reflection equivariant. If approach
progress reverses, the closing gate releases the proven propulsive controller
without a timer or hidden stage.

The downstream rollout should preserve the prefill's wake and trajectory until
roughly the last `1.25L`, retain capture with no material arrival delay, and
reduce terminal acceleration/rate-limit residence and yaw/load peaks. Reject
the mechanism if capture is lost, arrival is materially delayed, the gate
coasts before enough inward momentum exists, distance begins increasing while
the hold remains active, or any early wake or course behavior changes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and terminal target capture
source_mechanism: retain the propulsive rhythm during transit, then use observed approach state to release excess drive into a bounded hold
transferable_invariant: separate target-directed transit from terminal regulation with a continuous state gate, and restore propulsion automatically when measured approach progress is lost
nontransferable_details: published CPG gains, dimensional approach radii, species-specific braking kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: form a gate from normalized body-independent distance and closing speed; near the target blend the two-joint carrier and redirect into a damped zero-bend state-feedback hold inside the existing action envelope
falsification: reject if the `0.746L` capture and coherent transit wake are not retained, arrival is materially slower than `16.291T`, or terminal joint saturation, yaw, and loads do not fall

The candidate has no same-worker CFD result; these criteria are for the
downstream evaluator.

## Non-CFD verification

- The guidance-parent comparison, lightweight Julia contract, and solver
  boundary checks pass. A `6,561`-pair state sweep also verifies bounded finite
  actions and exact sign reversal when bearing, lateral velocity, joint angles,
  and joint rates reflect together; nonfinite optional observations fall back
  to the captured transit law.
- As a counterfactual command audit only, replay on the captured trajectory's
  recorded states leaves mean gate activation above `1.5L` below `0.0001`.
  Inside `1.25L`, it lowers anterior/posterior action-limit residence from
  about `66.7/84.9%` to `0.0/2.2%`, and terminal command RMS from about
  `27.8/29.9` to `17.0/17.5 rad/T^2`. This verifies localization and braking
  authority, not closed-loop capture; the downstream CFD may generate a
  different path.
