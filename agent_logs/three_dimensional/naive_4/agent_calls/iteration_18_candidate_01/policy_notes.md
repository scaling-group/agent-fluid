# Approach-only target support for residual-yaw steering

## Pre-edit visual and quantitative diagnosis

- All four sampled solvers are exact deterministic repetitions of the same
  policy and finite trajectory: their policy SHA-256 is `ec7aaed...0920e`,
  their combined sheets are byte-identical, and each captures at `16.0545T`,
  final distance `0.747530L`, distance integral `1.931257L`, score
  `-0.048654`, and `239` moving-window shifts. Their diagnostics confirm the
  required direct uniform still-water initialization, `U_infinity=(0,0,0)`,
  no cylinders, no prewarm, and no instability.
- I inspected the combined top-down mid-plane vorticity and oblique body/
  Lambda2 rows for the sampled candidate and the inherited replicated
  anterior-only parent. Both are self-propelled: a traveling posterior bend
  establishes a strong alternating red/blue wake by about `4T`, the oblique
  row retains compact three-dimensional posterior structures, and neither
  rollout shows passive advection, wake collapse, boundary interaction, or
  instability. The current sample has no failure-class image; the informative
  contrast is the inherited parent's less useful route, not a visibly
  different wake topology.
- Relative to that parent (`16.0545T`, `0.744345L`, distance integral
  `1.938857L`, score `-0.055617`), carrier-residual yaw-opposition feedback
  advances all `8/6/4/2/1.25L` milestones to
  `9.075/11.044/12.920/14.801/15.532T` from
  `9.202/11.154/13.013/14.905/15.604T` and improves the distance integral,
  while leaving arrival time effectively unchanged and worsening the crossing
  distance slightly. The sampled edit is therefore a replicated positive
  cruise-route mechanism with an unresolved terminal boundary, not merely a
  noisy scalar win.
- The current trace localizes that boundary. Below `1.0L`, the extra
  yaw-opposition gate is active on `48` samples above `0.05` and averages
  `0.86`, while the ratio `abs(bearing)/abs(raw_response_error)` averages only
  `0.11` on active samples. At `15.91T`, `0.897L`, target bearing is only
  `0.014 rad`, yet beat-scale course error makes raw response error
  `0.741 rad` and keeps the extra yaw gate at `0.895`. This branch can continue
  adding mean curvature when the body nearly points at the target, even though
  the original target/course steering remains available. The trajectory then
  crosses below the target (`head_y=9.345L`) rather than above it as the parent
  does (`10.032L`).

## Policy hypothesis recorded before editing

Preserve the sampled oscillator, raw and carrier-residual redirect paths,
mean-first posterior allocation, one-sided opposing-wave relief, closing
approach settling, anterior-only intercept release, and exact speed-boundary
projection. Change only the added carrier-yaw-residual mean-curvature branch:
in cruise it retains full authority, but as the already-evidenced closing
approach gate rises, continuously cap that extra branch by the fraction of raw
redirect magnitude directly supported by body-frame target bearing. Thus a
large persistent bearing can still request the full response correction,
while a raw redirect dominated by beat-scale course slip cannot sustain extra
mean bend near an aligned target. The base target/course curvature is not
released or attenuated.

This is a control-role allocation test rather than a scalar gain edit. The
expected useful trajectory preserves the current policy through approach
entry, including its earlier cruise milestones and coherent wake, then avoids
carrying the supplemental yaw correction through the near-zero-bearing part of
the intercept. Falsify it if a pre-approach milestone changes, capture is lost
or delayed, the distance integral returns toward the parent, posterior demand
or loads rise materially, or the two-view wake loses coherence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG residual control and terminal fish capture
source_mechanism: preserve rhythmic propulsion while sensory geometry bounds a residual steering action during terminal approach
transferable_invariant: separate persistent target geometry from fast carrier-scale course motion, and remove supplemental steering authority before the proven base steering when target alignment is already supported
nontransferable_details: published gains, dimensional turn rates, species-specific approach kinematics, prescribed oscillator or vortex phase, exact capture radius, and task-specific route
policy_translation: blend from the full cruise yaw-residual gate toward a bounded `abs(bearing)/abs(raw_response_error)` support fraction only under normalized body-frame proximity and closing feedback; retain raw target/course direction, base posterior curvature, wave shaping, and anterior carrier semantics
falsification: reject if the blend acts before the closing approach, changes lateral-reflection symmetry, weakens the base steering path, regresses cruise milestones or capture, degrades the alternating wake, or increases limiting and loads enough to offset route benefit

## Non-CFD verification after the edit

- The final candidate SHA-256 is
  `454c8cefeab58c76da3de868d026b556101b02e29729c36f3c999c1eb2423551`.
  Static schema inspection finds all `41` direct `params.FIELD` references
  among the `41` fields returned by `target_policy_params()`.
- A deterministic `6,561`-state sweep spanning joint state, both exact joint-
  speed boundaries, target side, bearing, body-frame course, and yaw response
  returns finite bounded actions, zero outward acceleration at either speed
  boundary, and exactly zero lateral-reflection error.
- Counterfactual evaluation on the inherited sampled trace confirms the edit
  is scoped as proposed: anterior commands are unchanged everywhere, no
  posterior command changes at or beyond `1.75L`, and only `74/2919`
  posterior states change, from `1.675L` through capture. This check proves
  branch ownership, not a new closed-loop outcome.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three commands
  were therefore run directly and separately. The guidance check first found
  the same assigned parent marked twice in the rendered workspace `README.md`;
  removing only that duplicate marker repaired provenance. The rerun, the
  lightweight Julia policy contract, and the solver editable-boundary check
  all pass.

No formal CFD was run in this worker; the candidate's trajectory claims remain
the falsifiable expectations above.
