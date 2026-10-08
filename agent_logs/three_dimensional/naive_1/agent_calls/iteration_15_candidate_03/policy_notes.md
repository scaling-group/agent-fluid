# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts are valid direct-uniform still-water evaluations
  and reproduce the same trajectory byte for byte: capture at `24.326511T`,
  crossing distance `0.749329L`, mean distance `2.224097L`, and score
  `-0.325310`. Their policies are behaviorally identical; three policy files
  are byte-identical and the fourth differs only in a comment. This is
  replicated fixed-pose evidence for one mechanism, not four parameter tests.
- In the inspected complete combined sheet (`solver_392ed1eddf30`), the
  top-down row shows a broad, smooth target-directed route rather than a
  boundary hook, and the oblique row shows discrete alternating Lambda2
  structures from the self-propelled traveling carrier through capture. The
  `solver_d802465f301b` top-down row and numerical trace replicate that route,
  but its oblique panels are blank; that rendering failure is not independent
  3D-wake evidence and does not contradict the complete sheet.
- The assigned parent records the informative controller failure: preserving
  full target angle without a distinct yaw-load path left an S-shaped carrier,
  `3.691L` closest approach, and low-domain exit. Sampled inherited guidance
  then calibrates posterior-load sign: a same-sign C-bend moved the posterior
  mean as intended but reversed mean yaw and still exited low, whereas the
  opposite-sign target-gated posterior rudder produced the lineage's first
  capture without destroying the wake or load envelope.
- The current 20% closing-deficit rudder relief is a narrow positive allocation
  result relative to the unrelieved capture: it advances capture from
  `24.337509T` to `24.326511T`, lowers mean distance from `2.224316L` to
  `2.224097L`, and lowers near-target mean action norm from `42.948` to
  `42.934`, with unchanged peak normalized force/moment near
  `0.031649/0.016385` and rate-cap occupancy near `14.04/6.92%`. The matched
  +20% boost instead delayed capture. The relief direction is supported, but
  its one-step articulated-head distance derivative is beat-scale and is not
  a durable approach-state observation.
- Trace cross-check: from `22--23T`, distance falls from about `1.63L` to
  `1.18L`, mean head closing speed is `0.453L/T`, and mean center translation
  projected toward the target is `0.374U`. Over `24.0T` to capture, those means
  separate to about `0.148L/T` and `-0.008U`; at capture the center projection
  is about `-0.067U` while the articulated head still crosses the sphere.
  Thus projected center translation identifies the tangential/receding
  terminal regime without treating the head sweep itself as forward progress.

## Policy hypothesis

Keep the replicated oscillator, anterior steering, half-cycle carrier shaping,
full-angle/error gates, opposite-sign posterior rudder, and tested 20% relief
bound unchanged. Replace only the relief sensor: project normalized body-frame
center velocity onto the unit body-frame target vector, then apply the existing
smooth deficit gate to that translational closing response. The distance and
error gates still prevent this residual from becoming a global route or a
drive change. The expected useful effect is a smoother terminal allocation:
retain the propulsive carrier, but release excess posterior steering while
center motion is tangential or receding instead of switching on articulated
head-distance motion.

Falsification: reject the translation-projected relief if capture is later
than `24.326511T`, mean distance exceeds `2.224097L`, the rollout returns to a
near miss or domain exit, or the coherent wake, near-target effort, roughly
`14.04/6.92%` rate-cap occupancy, `0.031649` peak force, or `0.016385` peak
moment worsens materially. A fixed-pose capture would validate this sensor
replacement only in the released configuration; it would not establish
held-out robustness.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: preserve a rhythmic carrier while sensor feedback continuously schedules a bounded residual command during approach
transferable_invariant: near the target, allocate less steering load when normalized target-relative translation is deficient without extinguishing the traveling carrier
nontransferable_details: published gains, species-specific kinematics, clock-driven phases, exact vortex timing, and task-specific routes
policy_translation: replace one-step head-distance closing speed with body-frame center velocity projected onto the unit target vector; retain the proven posterior-rudder sign, carrier, gates, and 20% relief bound
falsification: reject if capture is later than 24.326511T, mean distance exceeds 2.224097L, capture is lost, or wake, saturation, effort, force, or moment exceed the sampled envelope
```
