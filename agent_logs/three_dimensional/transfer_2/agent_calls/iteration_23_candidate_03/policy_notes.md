# Traveling-carrier restoration candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled evaluations satisfy the frozen release contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders,
  stable moving-window transport, and `capture` termination. This iteration
  refines trajectory and actuator allocation inside an already coherent
  self-propelled capture class.
- Both rows of the combined sheets for the strongest finite response-aware
  repeat (`solver_bf9554cfba28`) and the assigned-parent carrier-reserve test
  (`solver_d6f4924b438d`) were inspected from release through capture. Their
  top-down views show a clean start, an organized alternating vorticity street,
  target-directed translation, and a continuous late hook into the capture
  circle. Their oblique views show compact three-dimensional Lambda2
  structures shed behind the caudal region, with no passive advection, wake
  breakup, collision, or instability. The parent preserves the useful wake
  class; its deficiency is a subtly wider route rather than a visible loss of
  propulsion.
- The response-aware policy has two byte-identical evaluations. They capture
  at `19.162/19.338T`, with distance integrals `2.06924/2.07622L`, head paths
  `12.309/12.304L`, mean anterior commands `18.46/18.45 rad/T^2`, anterior
  greater-than-90%-bound residence `36.0/35.7%`, and joint-rate greater-than-
  99%-envelope residence `6.36/6.34%`. Both retain zero 99%-angle-limit
  residence and peak planar force/yaw moment coefficients no greater than
  `0.02537/0.01357`.
- The assigned parent attenuates both traveling-wave carrier components during
  an unresolved redirect to reserve 90%-of-output limiter headroom. It still
  captures at `19.333T` with the same coherent two-view wake and load class,
  but its `2.07854L` distance integral and `12.370L` path are worse than both
  response-aware repeats. The actuator return is small: mean anterior and
  posterior commands fall only about `1.2%/0.9%`, greater-than-90%-bound
  residence changes to `35.5/33.7%`, and rate-limit residence changes from
  `6.34--6.36%` to `6.29%`. This resolves the parent's falsification in the
  negative: instantaneous raw-command carrier reservation trades away the
  repeatable short route without materially recovering actuator headroom.
- Inherited logs bound the rollback. The distance-only handoff captured at
  `19.354T/2.07892L` on a `12.416L` path, while replacing route-request/yaw
  agreement with course-error/yaw agreement regressed to
  `19.398T/2.08187L/12.341L`. The supported response-aware mechanism is the
  route-request/yaw release itself, not another response scalar, terminal bend,
  or middle-field extension.

## One-candidate hypothesis

Restore the exact evaluated response-aware posterior-allocation handoff by
removing only the parent's carrier-budget helper, reserve parameter, and
unresolved-redirect carrier scaling. Preserve all normalized body-frame target,
distance, closing, velocity-course, bearing-rate, joint-phase, and yaw-response
feedback; preserve the far posterior-amplitude and near posterior-lag endpoints,
mean steering, approach relief, and smooth limiter. This returns the anterior
and posterior traveling carrier continuously while retaining the bounded
route-request/yaw release that produced both sampled short-path captures.

Expected signature: reproduce capture, coherent top-down and oblique wakes,
the `12.30--12.31L` head-path class, and distance integral no worse than the
two response-aware repeats' execution envelope, with zero angle-limit residence
and the sampled `~0.0254/~0.0136` force/moment class. Falsify the rollback if a
byte-identical evaluation instead remains in the parent's wider-path/integral
class, loses capture or wake coherence, or materially worsens command/rate
residence, joint margin, or loads. If falsified, do not retune the reserve
fraction; test a genuinely different observation-conditioned gait mechanism.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve the phase-related propulsive carrier while using observed directional response to release a bounded gait modulation back into that carrier
transferable_invariant: keep a coherent two-joint traveling bend intact and continuously remove only the target-conditioned posterior allocation after body-frame route demand produces measured yaw response
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, robot actuator models, full-body waveforms, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: restore the evaluated state-feedback carrier and retain only the normalized-distance posterior amplitude-to-lag handoff advanced by signed route-request/yaw agreement under the two-joint acceleration contract
falsification: reject if exact reevaluation does not recover the supported short-path capture envelope with coherent wakes, stable loads, joint margin, and no material actuator regression
