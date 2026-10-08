# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solver rollouts are finite captures from the required
  direct, uniform still-water initialization: `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and no reported instability. Three are
  executable-identical copies of the assigned-parent raw-sideslip controller
  and reproduce capture at `23.424515T`, crossing at `0.749902L`, scored mean
  distance `2.184349L`, and score `-0.287480`.
- The parent top-down sheets show genuine self-propulsion, not advection: the
  fish translates continuously toward the target in quiescent water while an
  alternating red/blue caudal street remains attached along the established
  S-shaped route. Their oblique rows are black render failures, so they add no
  three-dimensional wake evidence. The distinct course-angle sample has a
  complete two-view sheet: its top-down street stays coherent through capture,
  and the oblique row shows discrete three-dimensional Lambda2 structures from
  startup through the terminal turn without visible wake collapse.
- The course-angle sample changes only the slow route observation. It captures
  at `23.369514T`, lowers scored mean distance to `2.152884L`, and improves the
  score to `-0.255909`. Mean/near-target action fall from
  `58.289/45.013` to `58.179/44.396`, anterior/posterior rate-cap occupancy
  falls from `11.74/6.65%` to `11.16/6.10%`, and peak normalized force remains
  lower (`0.029468` versus `0.029780`) while peak moment stays close
  (`0.015365` versus `0.015287`). This supports dimensionless body-water
  course feedback; it is not evidence for changing steering gain alone.
- The assigned-parent inherited log supplies an orthogonal positive actuator
  allocation test. Sharing the existing through-water low-speed recovery gate
  with the lagged posterior carrier captures at `23.347515T`, lowers scored
  mean distance to `2.161137L`, and scores `-0.263925`. Its top-down wake and
  route remain in the useful class, but its oblique row is blank and its peak
  command rises to about `122.52` from `105.53`; therefore the posterior share
  is bounded evidence for early recovery allocation, not a new load or 3D-wake
  envelope.
- Inherited optimizer evidence also rules out the obvious alternatives.
  Adding the adverse-yaw-moment residual to the water-relative parent
  reproducibly regresses capture and mean distance, and multiple terminal
  relief/gate refinements preserve capture while worsening arrival or distance.
  Do not reintroduce those paths or disguise another scalar gate edit as a new
  mechanism.

## One candidate hypothesis

Use the evaluated course-angle controller as the carrier and route baseline,
then add only the evaluated `0.12` posterior share of its already existing,
smooth through-water propulsion-recovery gate. The route loop compares target
bearing with a bounded body-water course angle formed from both normalized
relative-flow components and a positive axial floor. During measured
low-through-water-speed operation, the same recovery response that recruits
anterior oscillator energy also scales the lagged posterior carrier modestly,
without changing its phase or the independently scheduled rudder. Preserve all
full-angle target geometry, anterior redirect, posterior stroke asymmetry,
reactive-rudder sign, and phase-qualified terminal relief unchanged. This is a
small compatibility test between two independently positive mechanisms, not a
new gain sweep, clocked stage, fixed route, or vortex-phase command.

Falsify the composition if capture is lost or later than `23.369514T`, scored
mean distance exceeds `2.152884L`, the preterminal S-route or alternating wake
degrades, mean or near-target action exceeds the raw-sideslip parent's
`58.289/45.013` envelope, rate-cap occupancy materially exceeds
`11.74/6.65%`, or peak normalized force/moment materially exceeds
`0.029780/0.015365`. A positive fixed-pose still-water result would establish
compatibility only; changed-flow or pose evidence with a complete oblique view
is still required for multi-wake or three-dimensional wake robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and elongated-body reactive swimming theory
source_mechanism: steer a preserved rhythmic carrier from measured body-water course while placing a bounded share of low-speed recovery in the lagged posterior bend
transferable_invariant: compare normalized body-frame target bearing with bounded through-water course and recruit posterior traveling-bend energy only when measured relative advance is deficient
nontransferable_details: published gains, dimensional speeds and frequencies, robot sensors, distributed-body envelopes, species-specific kinematics, exact vortex phases, cylinder geometry, fixed coordinates, prescribed timing, and task-specific routes
policy_translation: retain the evaluated course-angle carrier and all target allocation, then multiply only its lagged posterior carrier by one plus the evaluated bounded share of the existing relative-axial-speed recovery gate
falsification: reject if capture is lost or later than 23.369514T, mean distance exceeds 2.152884L, or route, complete two-view wake, action, saturation, force, or moment envelopes worsen

## Post-edit non-CFD validation

- The guidance checker passes: these notes exist and
  `guidance/control_experience.md` differs materially from the uniquely marked
  assigned parent, with all direct `params.FIELD` references covered by
  `target_policy_params()`.
- The configured Julia contract state returns two finite accelerations,
  `(-6.108046, 10.656363)`, and representative mirrored states return exactly
  sign-mirrored finite accelerations.
- The solver boundary check passes with
  `candidate_target_policy.jl` as the only editable solver file. No CFD rollout
  was run; the proposed composition remains an evaluation hypothesis.
