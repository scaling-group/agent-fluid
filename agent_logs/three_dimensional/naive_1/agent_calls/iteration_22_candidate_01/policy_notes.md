# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture. I
  inspected the top-down vorticity and oblique body/Lambda2 rows for all four
  current samples and contrasted them with the inherited direct-uniform
  `solver_f7fc67cae600` near miss/left exit, then cross-checked the views
  against metrics, diagnostics, trajectories, executable policy diffs, the
  assigned guidance, and inherited optimizer notes.
- The current sheets form one coherent self-propelled wake class: a
  body-attached alternating top-down street follows the target-bending route,
  and compact caudal Lambda2 structures persist to first crossing. The
  inherited failure remains equally energetic in both views but curls down
  and away after reaching `0.85155L`, then exits left at `34.0285T` and
  `10.33926L`. Wake coherence therefore does not establish useful route
  allocation or recovery.
- The two executable-identical common-envelope redistribution samples capture
  at `18.82649--18.88149T`, reproduce mean distance
  `2.088545--2.088964L`, and score from `-0.20106` to `-0.20041`. The sampled
  geometry-scheduled carrier captures at `18.68350T` and `2.094046L`; an
  inherited executable-equivalent carrier capture expands its observed band
  to `18.85399T` and `2.100995L`. Thus redistribution now has repeated
  far/middle distance-integral evidence, but not faster arrival.
- The sampled rearward-route multiplier also captures, at `18.96399T` and
  mean distance `2.090724L`, but reconstructed forward target fraction stays
  positive on every row (`0.35412--1.0`). Its new recovery branch is never
  activated, so this outcome is ordinary-capture safety evidence rather than
  post-miss recovery evidence and does not support carrying the extra branch
  into this candidate.
- Redistribution does not relieve demand: its two exact repeats contact the
  acceleration envelope on `60.85--61.00%` anterior and
  `72.97--73.27%` posterior rows, and the rate limit on `11.04--11.07%` and
  `14.91--14.93%`. The parent guidance rules out pointwise rate tapers,
  distance/alignment release gates, velocity-phase prediction, and posterior
  wave enhancement. The last mechanism is the relevant ablation boundary:
  enhancing the zero-mean posterior displacement-plus-lag wave preserved an
  energetic wake but turned down past the target, reached only `3.1465L`, and
  exited left with `74.69%` posterior acceleration contact.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and robotic-fish mean-curvature turning
source_mechanism: separate a posterior-lagged propulsive wave from bounded target-vector mean curvature
transferable_invariant: preserve target-signed mean curvature while scheduling only zero-mean posterior wave authority from normalized body-frame geometry
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot duty ratios, clock phase, exact vortex phase, world-frame paths, and task-specific routes
policy_translation: retain the captured redistribution carrier and both target-signed bias shares; during large normalized lateral target error, mildly attenuate only the posterior displacement-plus-lag wave before adding the unchanged posterior bias
falsification: reject if capture or either coherent wake row is lost, mean distance leaves the replicated redistribution band without material posterior-demand relief, the route repeats the inherited downward/left exit, or force and moment peaks materially worsen

## Single-candidate policy hypothesis

Add one `posterior_redirect_relief_fraction` state-feedback allocation to the
prefilled redistribution parent. Form the zero-mean posterior traveling-wave
target separately from `tail_bias`, scale that wave continuously by
`1 - posterior_redirect_relief_fraction * abs(lateral_fraction)`, and then add
the unchanged target-signed posterior bias. Keep the oscillator, common
half-cycle relief redistribution, displacement-only curvature phase,
correcting-yaw response release, lag, damping, and final acceleration
projection otherwise identical.

This is the previously requested opposite allocation to the failed posterior
wave enhancement, not a scalar-only propulsion retune. It should preserve the
route owner and mean-curvature shares while testing whether less competing
caudal oscillation during redirect reduces the dominant posterior demand.
Formal CFD runs only after this worker exits. Accept the mechanism only if it
retains capture and both wake views, stays near the reproduced
`2.088545--2.088964L` route band, and lowers posterior acceleration or rate
contact outside rollout variation; otherwise reject posterior-specific wave
allocation around this carrier in either direction.

## Implementation and non-CFD validation

The candidate adds the parameter-owned
`posterior_redirect_relief_fraction=0.15` and decomposes the inherited
posterior target into unchanged target-signed bias plus a bounded
displacement-and-lag wave. Its scale remains in `[0.85,1]`, equals one when
lateral target error is zero, and uses no time, world coordinate, hidden
state, flow phase, or task identity.

The required guidance-provenance and solver-boundary checks pass. The exact
lightweight Julia policy-contract check passes with the evaluator-provided
Julia binary. A representative-state dry ablation also confirms finite
commands inside the owned acceleration envelope, exact parent action at zero
lateral error, a materially different posterior action during redirect, and
left/right reflection symmetry. No CFD was run and no outcome is claimed for
this unevaluated candidate.
