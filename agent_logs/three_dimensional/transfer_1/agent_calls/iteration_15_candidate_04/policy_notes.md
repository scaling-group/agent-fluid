# Wake-policy candidate diagnosis

## Evidence read before editing

- Every sampled rollout reports direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. The translation visible
  in both keyframe rows is therefore self-propulsion rather than advection or
  a reused-flow artifact.
- The combined sheets for the highest-score capture
  (`solver_6b0e320e2f55`) and the projected-miss capture
  (`solver_5c1f6245a363`) were inspected from release to termination. Both lay
  down a long, coherent alternating top-down vortex street from about `4T`
  onward, while the oblique row retains compact alternating Lambda2 structures
  through capture. Neither shows wake collapse, collision, domain exit, or
  numerical instability immediately before termination.
- Three sampled rollouts are byte-identical to the prefilled
  `dogfish3d_intercept_guarded_speed_reserve_v1` (`567de354...`). All three
  capture at `18.2050--18.6010T`, with mean distance
  `2.0387--2.0456L`, crossing speed `0.8268--0.9083L/T`, and similar coherent
  wakes. This satisfies the inherited exact-repeat boundary and establishes
  the carrier, achieved-course route, projected-intercept release guard, and
  selective outward-carrier reserve as the repeat-supported baseline.
- `dogfish3d_speed_reserve_projected_miss_turn_v1` changes only terminal
  steering geometry inside `2L`: it blends the route request toward normalized
  signed target/velocity projected miss. Its first evaluation also captures,
  at `0.7477L` and `18.5405T`, while preserving `0.8592L/T` crossing speed and
  load peaks within the three-repeat baseline range (`0.03058` force and
  `0.01611` yaw moment). This is a semantic success for the mechanism, but its
  score `-0.16291` and mean distance `2.05046L` are slightly worse than all
  three parent repeats, so it is not yet evidence of a scalar improvement.
- The projected-miss run still touches the `260 deg/T` speed limit and clamps
  returned acceleration on about `68.6%/71.0%` of head/tail rows, essentially
  the same as the repeat-supported parent. The inherited total-command speed
  governor reduced speed-limit residence but missed at `1.3877L`; therefore
  neither lower clamp fraction nor another actuator projection should be
  layered onto this one-run terminal-geometry result.

## Candidate mechanism and falsification

Submit the sampled projected-miss policy byte-for-byte as a reproducibility
candidate. It preserves the repeat-supported traveling bend, far/middle
achieved-course feedback, intercept-compatible response release, and sparse
outward-carrier reserve. Only inside the last `2L` does a continuous gate
replace range-sensitive course error with normalized signed projected miss.
This is a direct robustness test of one observation/mechanism, not scalar gain
tuning or a second unevaluated terminal primitive.

Expected test: reproduce capture while retaining the coherent alternating 3D
wake, crossing speed, and load envelope. A repeat would support signed
projected miss as a terminal steering observation across the sampled
trajectory variability even if it does not improve raw score.

Falsification: reject robustness if the exact replay misses the `0.75L` disk,
returns a lower-domain exit, weakens or collapses the terminal traveling wake,
raises force/moment peaks beyond the repeat-supported range, or grows the
signed projected miss after the terminal blend activates. If it fails, later
workers should revert to the three-repeat speed-reserve baseline and avoid
tuning the projected-miss scale or blend distances until an observation that
separates the divergent terminal approaches is evidenced.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and adaptive capture control
source_mechanism: preserve a rhythmic propulsive carrier while sensed interception geometry continuously shapes a bounded steering residual
transferable_invariant: after broad route acquisition, a normalized signed predicted miss can replace range-sensitive bearing or course error near interception without prescribing a route or suppressing propulsion
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact gait and vortex phases, duty ratios, and task-specific routes
policy_translation: retain the two-joint speed-reserve carrier and replay the body-frame target/velocity projected-miss blend only inside the terminal two body lengths
falsification: reject if exact replay loses capture, changes far-field closure, weakens wake coherence, increases loads, or lets projected miss grow after activation

## Non-CFD verification

- The candidate is byte-identical to the sampled evaluated projected-miss
  policy (`cd57377d579c511a8ec3ed1240e804f421d2994c5b6fc7f2796bbae664849173`).
  That prior evaluation supplies a finite two-joint contract execution without
  substituting for the new replay CFD result.
- Static inventory finds all 45 direct `params.FIELD` references in the
  47-field object returned by `target_policy_params`; only metadata fields
  `version` and `control_period` are intentionally unused by arithmetic. The
  solver editable-boundary check passes.
- The rendered `README.md` initially contained the identical copied-parent
  marker twice, causing the required guidance checker to reject the workspace
  before comparing content. The redundant adjacent marker was removed without
  changing the assigned parent; the formal semantic guidance check then passes.
- Julia is not installed or available on `PATH`, so the local lightweight
  Julia invocation could not be rerun. No CFD was run, as required.
