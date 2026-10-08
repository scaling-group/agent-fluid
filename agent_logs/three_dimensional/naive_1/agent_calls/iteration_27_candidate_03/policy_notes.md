# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization, with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. Two executable-equivalent
  assigned-parent policies allocate the bounded speed-deficit recovery share
  to posterior velocity-quadrature lag and reproduce `23.122009T` capture,
  `0.749507L` crossing distance, `2.133413L` scored mean distance, and score
  `-0.237071`. Two executable-equivalent controls instead scale the whole
  posterior carrier and reproduce `23.331013T`, `0.749672L`, `2.135772L`, and
  `-0.239045`. These repeats establish deterministic fixed-pose behavior, not
  pose, inflow, or hydrodynamic robustness.
- Both full top-down sheets and videos show self-propulsion along the same
  useful S-shaped approach. An alternating red/blue caudal street develops by
  about `4T`, remains attached during the turn, and reaches the target without
  wake collapse, coasting, domain exit, or instability. The phase-lag parent
  is farther from the target through `8T`, becomes closer between `9T` and
  `12T`, and stays ahead through capture; the improvement is a traveling-bend
  phase/route allocation result rather than stronger startup translation.
  The parent's oblique sheet and video are blank render artifacts. A matched
  whole-carrier control has a complete oblique sequence with discrete
  three-dimensional Lambda2 structures through capture, so it is the current
  complete 3D-wake bound rather than independent visual proof for the parent.
- The phase-lag allocation improves arrival and route while lowering peak
  normalized force/moment from `0.030861/0.016213` to
  `0.030360/0.015861`, but its total mean action rises from `59.044` to
  `60.062` and exact anterior/posterior rate-cap occupancy rises from about
  `11.34/6.27%` to `11.92/7.06%`. The sampled trace places the largest
  posterior near-cap occupancy in the same `2--6T` interval in which the
  through-water recovery gate is active. An inherited instantaneous
  `lagged_carrier * qd2` work-sign qualification already regressed to score
  `-0.247507`; it must not be reused as an energy or power proxy.

## One candidate hypothesis

Preserve the assigned parent's through-water course observation, anterior
oscillator recovery, full target geometry, anterior redirect,
phase-selective carrier, reactive rudder, terminal relief, and the completed
`0.12` posterior phase-lag allocation. Add one actuator-feasibility
qualification only to that incremental phase-lag share. Normalize measured
posterior joint speed by the policy-owned `260 deg/T` rate envelope and
smoothly taper the increment between `85%` and `100%` of the envelope. The
baseline posterior lag, angle component, rudder, and every route signal remain
active, so approaching the rate cap removes only phase authority that the
posterior actuator cannot immediately realize.

This is a bounded, reflection-invariant joint-state feedback mechanism rather
than scalar gain tuning. It introduces no time, step count, coordinate, route
memory, load residual, case identity, or exact vortex phase. Falsify it if
capture is lost or later than `23.122009T`, scored mean distance exceeds
`2.133413L`, or posterior saturation and action do not improve without
surrendering the parent's later route lead. Also reject it if a complete
evaluation degrades the S-route, alternating two-view wake, or the established
`0.030360/0.015861` peak normalized force/moment envelope. Any fixed-pose
still-water improvement would establish only actuator-allocation compatibility,
not held-out multi-wake, pose, or hydrodynamic robustness.

An offline activation audit on the completed parent trajectory reconstructs
the existing through-water recovery gate from the logged inertial velocity,
heading, and local body-frame flow. The recovery is nonzero for `668` logged
samples; the new posterior-rate qualification would modify `163` of them, and
its mean headroom over the active recovery samples is about `0.797`. This is
only evidence that the mechanism is live on the inherited trace. It does not
predict the closed-loop candidate trajectory or replace CFD evaluation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded rhythmic locomotion
source_mechanism: preserve a coupled traveling carrier while feedback modulates a small posterior phase allocation within the actuator envelope
transferable_invariant: feedback-recruited posterior phase authority should remain bounded and be released smoothly when measured joint state shows that the actuator cannot realize more rate, without suppressing the underlying carrier
nontransferable_details: published gains, dimensional frequencies, robot actuator calibrations, species-specific kinematics, distributed-body envelopes, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain the sampled body-frame speed-deficit phase-lag recovery, but multiply only its incremental lag share by a smooth headroom gate derived from posterior joint-rate magnitude normalized by a policy-owned rate envelope
falsification: reject if capture is later than 23.122009T or lost, mean distance exceeds 2.133413L, rate-cap occupancy or action fails to improve, or route, complete two-view wake, force, or moment exceeds the sampled bounds
