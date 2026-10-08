# Candidate diagnosis and hypothesis

## Inherited evidence

- Both top-down mid-plane and oblique Lambda2 rows were inspected for the
  strongest finite sample `solver_477c7f626e4f` and the informative weaker
  full-reserve sample `solver_e7cd0978d380`. Both report direct uniform
  initialization at `U_infinity=(0,0,0)`, form a coherent alternating wake,
  self-propel along the same broad clockwise capture arc, and capture at the
  same `23.3750T`/4,250-step boundary. Neither sheet shows advection, prewarm,
  wake collapse, or a meaningfully different trajectory class.
- The assigned parent `solver_04760fa01847` captures at `23.3750T` with score
  `-0.503415`, scoring mean/final distance `2.400748/0.747085L`, and the same
  pre-`3L` crossing (`20.1300T`) as all four samples. The independent
  `solver_e584ff748453` rollout is numerically identical despite a comment-only
  policy difference, confirming deterministic repetition.
- Extending the parent's cadence-reserve handoff from continuous course-brake
  demand to the bounded union of continuous and phase-selected stabilization
  demand (`solver_477c7f626e4f`) keeps the same capture step but improves score
  and scoring mean/final distance to `-0.502603` and
  `2.400102/0.746257L`. Inside `3L`, recomputed mean absolute yaw,
  target-line cross-track speed, radial closing speed, and mean absolute moment
  improve from `1.71472 rad/T`, `0.23486U`, `0.69701U`, and `0.006597` to
  `1.70656 rad/T`, `0.23432U`, `0.69819U`, and `0.006564`; peak yaw,
  cross-track speed, and moment worsen to `3.28817 rad/T`, `0.62616U`, and
  `0.015118`. Thus the sampled handoff is a narrow progress/mean-load
  improvement, not a terminal-peak remedy.
- Across the best rollout, normalized inertial target-line cross-track motion
  has nonzero signed means of `-0.153`, `-0.161`, `-0.033`, `+0.158`, and
  `+0.350` in the `12--6`, `6--3`, `3--2`, `2--1`, and `<1L` bands. The sign
  reversal is a route-level overshoot signature that raw body-frame lateral
  velocity cannot isolate from tailbeat sway. The existing target lateral term
  also divides that velocity by `L`, making it negligible, while the terminal
  controller already demonstrates a bounded carrier-rejected target-line
  cross-track coordinate.

## Policy hypothesis

Adopt the evidence-backed stabilization-envelope handoff, preserve the
successful C-bend, posterior traveling wave, split terminal observer, and
smooth command projection, and make one semantic observer change: use the
normalized target-line cross-track residual after subtracting the observed
anterior carrier component as the slow course term in the main geometric
request. This is rotation invariant, speed gated at release, bounded, and uses
only current body-frame target, velocity, and joint state. It should correct
the sampled far/middle drift and late sign reversal without adding steering
actuator range or another terminal schedule.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking
source_mechanism: sensor feedback modulates a slow directional command while the coupled oscillator preserves rhythmic propulsion
transferable_invariant: separate the fast propulsive carrier from a bounded target-course error before changing the oscillator mean
nontransferable_details: published CPG gains, oscillator timing, robot morphology, duty ratios, species kinematics, and prescribed routes
policy_translation: replace raw body-lateral slip in route steering with speed-gated normalized target-line cross-track motion after anterior beat rejection; retain the two-joint state-feedback carrier and sampled stabilization-envelope handoff
falsification: reject if CFD loses capture or coherent alternating wake, gives back the 23.3750T and 2.400102L best-sample progress, worsens target-line cross-track motion and yaw/load together, or increases joint/command-limit exposure
