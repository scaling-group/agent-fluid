# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled rollouts are valid direct-uniform still-water evaluations with
`U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, finite dynamics, and
capture termination. They contain only two physical trajectories: the duplicated
v33 anterior-half-cycle controller captures at `23.84252T`, score `-0.53509095`,
and scoring mean/final distance `2.433543/0.746165L`; the differently named but
bit-identical split-observer implementations capture at `23.83702T`, score
`-0.53501328`, and `2.433468/0.746096L`.

I inspected both rows of the combined sheets for the strongest split observer,
the v33 comparator, the inherited local-crossflow gate, and the inherited
half-cycle energy-transfer regression. From the initially empty still-water
field, each fish self-propels along the same smooth target-directed arc. The
top-down row develops a spatially ordered alternating lateral wake, and the
oblique row retains compact three-dimensional Lambda2 structures through the
terminal bend. There is no passive advection, wake collapse, collision,
boundary exit, or instability. The mechanism differences are below keyframe
resolution, so the histories and scoring metrics decide the comparison.

The sampled split observer improves v33's arrival, mean/final distance,
inside-`3L` mean absolute yaw (`1.67999` to `1.67938 rad/T`), target-cross-track
speed (`0.23924` to `0.23868U`), and peak moment (`0.013730` to `0.013581`),
while peak yaw rises slightly from `3.18484` to `3.19386 rad/T`. Its peak joint
rate and smoothly projected action remain feasible at `4.53786 rad/T` and
`31.3853 rad/T^2`. This replicated narrow improvement supports preserving the
split observer and the coherent carrier.

The inherited completed variants close three nearby branches. Displacement-rate
phase leads regress score to `-0.535363` or `-0.535561` and raise peak moment;
half-cycle envelope redistribution regresses to `-0.536347` or `-0.538062`;
and attenuating the anterior residual from body-frame local crossflow regresses
to `-0.536241`, mean/final distance `2.434443/0.747358L`. The last variant trims
peak yaw only from `3.19386` to `3.19158 rad/T` while worsening mean yaw
(`1.67938` to `1.67952 rad/T`) and mean/peak moment
(`0.0063875/0.013581` to `0.0063883/0.013650`). Correlation therefore did not
make local crossflow a useful causal gate. All retain a visually coherent wake
and the same capture step, so those facts do not rescue their progress/load
regressions.

## Single candidate hypothesis

Retain the split course/phase observers, v24 continuous course brake,
response-released C-bend, carrier cadence and amplitude, posterior lag, and
component-wise smooth command projection. Change only how the existing
phase-selected anterior excess-yaw correction enters the two-joint plant.
Instead of moving the anterior oscillator center and waiting for the posterior
follower to restore the tail tangent, express the same curvature-scale request
as simultaneous equal-and-opposite raw joint accelerations. The residual then
changes the internal bending coordinate while its direct contribution to
`phi_ddot[1] + phi_ddot[2]`, the distal tangent acceleration, is exactly zero
before the established component-wise projection.

This tests whether preserving instantaneous tail-end wave kinematics avoids the
progress/load trade seen when timing, envelope, and flow gates perturb the
carrier. It introduces no clock, route state, world coordinate, or inferred
vortex phase; proximity, route demand, excess yaw, and beat side remain bounded
functions of normalized body-frame observations and joint state. Reject the
mechanism if CFD loses or delays capture, worsens split-baseline mean/final
distance, changes the alternating wake, fails to improve the mixed yaw/moment
boundary, or increases joint/command-limit exposure. The zero-sum statement is
an algebraic raw-command invariant, not a claim that projected commands or
hydrodynamic loads will cancel.

bookshelf_consulted: true
source_domain: Lighthill-style reactive swimming and robotic-fish turning with separated anterior steering and posterior propulsion roles
source_mechanism: preserve consequential tail-end traveling-wave kinematics while applying a bounded steering deformation upstream
transferable_invariant: steering should alter the smallest internal shape coordinate that can create a turn while avoiding a direct perturbation of the tail-end wave responsible for thrust
nontransferable_details: elongated-body force coefficients, published gains, species-specific kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: convert the existing body-frame and joint-state-gated anterior terminal curvature request into equal-and-opposite two-joint accelerations so its raw summed distal-tangent acceleration is zero while all route feedback and carrier terms remain unchanged
falsification: reject if split-baseline capture, progress, coherent wake, mixed yaw/moment performance, or actuator feasibility regresses; also reject the presumed role separation if tail-tangent preservation does not improve the prior progress/load trade

## Non-CFD validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unsupported by this account and failed before inspecting the workspace.
- Its prescribed guidance-materiality and solver-boundary checks pass when run
  directly. Exactly one nonempty `candidate_target_policy.jl` exists in
  `solver/`.
- The prescribed Julia smoke test cannot start because no Julia executable is
  installed. A deterministic static audit finds `69` unique direct
  `params.FIELD` references among `71` returned fields, with no undeclared
  reference; only `version` and `control_period` are metadata. No prohibited
  time, step, case, cylinder, random, file-I/O, or mutable-global dependency is
  present.
- The raw internal-bend contribution is visibly paired as
  `+internal_bend_accel` and `-internal_bend_accel`, so its algebraic summed
  acceleration is zero before component-wise projection. The candidate SHA-256
  is `53a98642ba0b32b702159ffa5321e972a92d9e402caf6b30a98afdaf69eee54e`.
  No formal CFD was run; EvE should compare the later result against the
  repeated split baseline, not against the weaker inherited regressions.
