# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`; none is a prewarm artifact.
- The strongest finite example, `solver_1a1f00e33399`, captures at
  `24.3375T` and `0.749625L` with mean distance `2.224L`. Its top-down row
  shows a self-propelled head trajectory closing continuously on the target,
  while its oblique row retains an alternating three-dimensional Lambda2 wake
  through the terminal turn. Rate-cap occupancy is about `14.0/6.9%`, and
  peak planar force/yaw-moment coefficients remain about `0.03165/0.01638`.
- The informative `solver_94750f47d14e` failure retains a similarly coherent
  alternating wake but passes below the target, reaches only `3.692L`, and
  exits the lower boundary at `32.23T`. Its same-sign posterior C-bend changes
  late yaw but recruits after the miss. The successful policy instead combines
  a continuously signed lateral target signal with an opposite-sign,
  distance-and-full-error-gated posterior rudder. Because those two changes
  were evaluated together, the capture establishes the package, not a clean
  ablation of either component.
- In the capture trace, distance falls steadily after `5L`; one-step closing
  speed has a median near `0.468L/T` and stays above `0.277L/T` for about 95%
  of those samples. It falls toward `0.11--0.13L/T` only at the final crossing,
  while full target error and the rudder request remain large. That isolates a
  narrow terminal slowdown without evidence that propulsion or the wake has
  collapsed.

## Candidate hypothesis

Preserve the captured trajectory's oscillator, slip-aware anterior center,
full-angle half-cycle redistribution, and posterior reactive rudder. Add one
smooth stall-recovery multiplier to the rudder, driven by normalized observed
`closing_speed_L`. It is exactly one outside the near-target rudder regime and
while closure exceeds `0.35L/T`; it can rise by at most 20% as closure falls
toward `0.10L/T`. This is response scheduling, not a global rudder-gain retune:
the far and middle controller are unchanged, and added authority is available
only where proximity, full target error, and deficient closure agree.

Expected result: retain the evidenced capture and wake, then shorten the last
fraction of a body length. Falsify the mechanism if capture is lost or delayed,
if the early trajectory differs before the existing rudder is recruited, if
closure oscillations cause chatter, or if joint-rate occupancy and planar
force/yaw-moment peaks materially exceed the sampled `14.0/6.9%` and
`0.03165/0.01638` envelope.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and biological burst redirect
source_mechanism: preserve the propulsive rhythm while bounded steering authority is recruited or released by observed task response
transferable_invariant: use normalized feedback to change maneuver authority only when geometric error persists and the desired response is deficient
nontransferable_details: published CPG gains, robot geometry, species-specific kinematics, exact beat phase, and prescribed routes
policy_translation: retain the evidenced two-joint carrier and add a bounded closing-deficit multiplier only to the already proximity-and-error-gated posterior rudder
falsification: reject if the capture or coherent wake is lost, the gate changes the far trajectory, terminal closure does not improve, or saturation and load peaks materially exceed the sampled successful envelope
