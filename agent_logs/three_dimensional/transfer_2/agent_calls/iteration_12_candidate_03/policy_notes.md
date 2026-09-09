# Range-aware intercept redirect candidate

## Evidence diagnosis before the policy edit

- All four sampled solver episodes and the assigned parent's completed episode
  satisfy the direct-uniform still-water contract: `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, finite moving-window shifts, stable dynamics,
  and `capture` termination. The sampled episodes capture in
  `19.706--19.987T`; there is no semantic failure in the current batch, so the
  slowest capture is only an informative mechanism underperformer.
- Both rows of the combined keyframe sheets for the strongest sampled LOS-led
  controller (`solver_1b6df3d71b19`) and the slowest range/coherence-gated
  controller (`solver_c25cd0071858`) were inspected from release through
  termination. Their top-down rows show self-propelled motion with a coherent
  alternating wake and a smooth but sharp terminal arc. Their oblique rows show
  compact three-dimensional Lambda2 structures along the traveled route. The
  nearly identical wake topology provides no evidence that the slower policy's
  extra gate improves propulsion, stability, or path quality.
- Metrics provide the useful separation. The plain LOS-led controller captured
  at `19.706T`, mean distance `2.10594L`, and score `-0.21598`; an executable
  semantic repeat captured at `19.888T`, `2.11324L`, and `-0.22270`. Applying
  response release to the full redirect captured at `19.850T`, `2.11128L`, and
  `-0.22093`, while the range/coherence gate captured at `19.987T`, `2.11652L`,
  and `-0.22648`. None supplies a compensating new trajectory or wake class.
- The assigned parent's inherited log isolated response release to the
  transient anterior bias while keeping posterior redirect curvature
  continuous. Its completed result still captured, but at `19.877T`, mean
  distance `2.11339L`, and score `-0.22325`; this is essentially the semantic
  repeat rather than an improvement. Together with the inherited posterior
  phase-allocation regression, this is concrete negative evidence against
  another response/phase gate around either redirect actuator.
- The reusable opening is geometric rather than scalar. The present course
  term assigns the same steering demand to a given angular error at every
  range, even though its implied cross-track miss grows with distance. That can
  defer useful correction in the middle field and retain excess correction in
  the visible terminal hook. No sampled policy has tested a bounded
  range-aware intercept error while preserving the established LOS lead.

## One-candidate hypothesis

Start from the semantically strongest plain LOS-led controller, removing the
prefilled full-redirect response release. Preserve the state-feedback carrier,
posterior lag, full signed body-frame target vector, distance/closing drive
allocator, half-cycle route steering, LOS-rate lead, posterior redirect, and
soft command limit. Replace only the range-blind geometric part of the course
redirect with a bounded blend of normalized course angle and projected
cross-track miss `distance_L*sin(course_error)`. At middle range the miss term
should request an earlier, gentler intercept; near the target it should decay
with range instead of sustaining the same angular demand.

Expected signature: retain capture and both coherent wake views, reduce the
late hook without weakening the posterior traveling wave, and improve arrival
or mean distance beyond the `19.888T/2.11324L` semantic-repeat result without
raising joint/command-limit residence or the established force/moment class.
Falsify the mechanism if capture is lost; arrival and mean distance remain in
or below the repeat band with no visibly different useful path; the trajectory
develops an earlier outward curl; or wake coherence, loads, joint margin, or
command headroom worsen.

bookshelf_consulted: true
source_domain: terminal capture guidance and sensor-modulated robotic-fish direction tracking
source_mechanism: bounded target-vector-to-curvature feedback that corrects projected miss while retaining a posterior-lagged propulsive rhythm
transferable_invariant: an angular course error should produce stronger early correction when it implies a large cross-track miss and continuously weaker correction as the projected miss shrinks near the target
nontransferable_details: published controller gains, robot or species kinematics, dimensional cadence, clock phase, exact vortex phases, capture routes, and world-frame coordinates
policy_translation: blend normalized body-frame course error with bounded `distance_L*sin(course_error)` inside the existing two-joint LOS-led redirect while leaving carrier, posterior lag, and actuator bounds unchanged
falsification: reject if capture, arrival, distance integral, terminal path shape, coherent wake, loads, joint margin, or command headroom regress against the plain LOS-led semantic repeat
