# Step 38 wake-policy diagnosis

## Evidence read before the edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. They capture at
  `0.74923--0.74986L` after `18.4525--18.7495T`; the best sampled score is
  `-0.14991`. The two sampled exact-byte speed-reserve rollouts capture at
  `18.4525T` and `18.6010T`.
- The combined top-down and oblique sheets for the best sampled capture, the
  assigned parent's latest `1.6783L` failure, and the exact-byte speed-reserve
  rollback failure all show self-propulsion. Each retains an alternating
  top-down vorticity street and bilateral oblique Lambda2 structures through
  its closest pass. The failures then continue below the target to a stable
  lower-domain exit; there is no collision, numerical instability, passive
  advection, or carrier collapse to repair.
- The assigned parent's capture-corridor-certified release is a concrete
  negative result. It missed at `1.6783L`, versus `1.1608--1.1846L` for the two
  preceding inherited failures, while head/tail action clipping remained high
  at `70.12%/71.85%`. Peak body-force/moment coefficients
  (`0.01462/0.02857/0.01569`) stayed inside the sampled envelope, so retaining
  more ordinary course steering outside a hard projected corridor changed the
  path adversely without revealing a propulsion or load repair.
- A sampled-guidance sibling supplies the decisive reliability check: the exact
  speed-reserve policy bytes that produced the two current sampled captures
  also missed at `1.0260L` and exited below with the same organized two-view
  wake. Thus neither unchanged rollback nor another capture-corridor threshold
  is an evidenced improvement.
- At the first `2.75L` crossing, the rollback failure has instantaneous
  normalized inertial LOS rate about `-0.138/T` and signed projected miss about
  `+1.196L`, versus `-0.092--0.103/T` and `+0.783--0.875L` in the two exact
  captures. Over the preceding carrier period, its mean LOS rate is about
  `-0.043/T`, compared with `-0.004--0.011/T`. The separation already exists
  before the inner intercept guard and has the correct sign for an interception
  response; force, moment, and local-flow averages do not show a comparably
  distinct repair signal.

## Candidate hypothesis

Preserve the exact speed-reserve carrier, raw achieved-course servo, response
release, steering shares, and outward-only actuator reserve. Add one small,
bounded LOS-rate interception residual through the same two-joint steering
shares only on an approaching outer-terminal annulus. Inertial target/velocity
cross product supplies the normalized LOS rate; the residual opposes LOS
rotation, grows smoothly from `4L`, and fades to exactly zero by `1.5L` so it
does not replace inner capture geometry or create a post-pass recovery state.

Counterfactual evaluation on the recorded states gives a mean requested
residual of about `+0.63 rad/T^2` on the exact-policy failure and
`+0.31--0.35 rad/T^2` on the two captures when scaled to the candidate's
`2 rad/T^2` bound. This establishes that the new cue is material and more
selective on the failure, not that the unevaluated closed-loop trajectory will
capture. Falsify it if exact repeats lose capture, the projected miss does not
contract before `2L`, the lower-exit branch remains, action/speed residence or
loads leave the repeat-backed envelope, or either organized wake weakens.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over a rhythmic CPG
source_mechanism: bounded line-of-sight-rate interception feedback superposed on an independently sustained propulsive rhythm
transferable_invariant: an approaching interceptor should oppose inertial line-of-sight rotation while leaving the locomotor carrier active
nontransferable_details: published gains, clocked CPG phase, robot morphology, dimensional timing, species kinematics, exact vortex phase, and task-specific routes
policy_translation: derive normalized LOS rate from body-frame target and velocity cross product; add a bounded outer-terminal two-joint steering residual through the existing shares and release it before the inner capture regime
falsification: reject if repeat capture is lost, the pre-pass miss does not contract, the coherent lower exit remains, either wake degrades, or actuator and load metrics leave the established envelope

## Non-CFD checks

- The required guidance checker passes after removing one duplicated copied-
  parent entry from the rendered workspace `README.md`.
- The Julia contract check returns a finite two-joint action. Direct static
  comparison finds all 48 `params.FIELD` references among the 50 fields
  returned by `target_policy_params()`.
- Julia probes confirm that the new residual is exactly zero outside `4L`,
  below `1.5L`, and for a non-approaching alignment; an approaching `3L`,
  `-0.2/T` LOS-rate probe requests `1.862 rad/T^2`, below its `2 rad/T^2`
  bound.
- The solver editable-boundary check passes. No CFD was run.
