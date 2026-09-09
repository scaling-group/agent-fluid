# Step 39 wake-policy diagnosis

## Evidence read before the edit

- All four sampled solver examples satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The three
  exact-byte speed-reserve rollouts capture at `0.74846--0.74953L` after
  `18.2875--18.6010T`; the outer unsupported-bearing qualifier captures at
  `0.74986L` after `18.6560T` and has the best sampled score, `-0.14991`.
- The combined top-down and oblique sheets for that best sampled capture, the
  inherited step-38 LOS-rate capture, and the informative step-37 lower exit
  all show self-propulsion with an organized alternating mid-plane street and
  bilateral oblique Lambda2 structures. The step-37 policy passes below the
  target at `1.6783L` and continues to a stable lower-domain exit; there is no
  wake collapse, passive advection, collision, or instability to repair.
- The assigned parent is the speed-reserve controller and captured at
  `0.74846L` after `18.2875T`. Its three current sampled runs clip head/tail
  action on `68.45--68.48%/70.62--71.00%` of rows, reside at the joint-speed
  limit on `10.41--10.49%/11.30--11.49%`, and retain peak body-force/moment
  coefficients within `0.01466--0.01472/0.02843--0.02922/0.01616--0.01627`.
- The inherited step-38 controller made one architectural change: a bounded
  approaching-only outer-terminal LOS-rate residual, leaving the carrier,
  route servo, response release, steering shares, and reserve logic intact.
  Its completed CFD rollout captured at `0.74605L` after `18.2985T`. Head/tail
  clipping was `68.50%/70.51%`, speed-limit residence was
  `10.58%/11.66%`, and peak force/moment coefficients were
  `0.01475/0.02916/0.01593`; these are effectively inside the sampled parent
  envelope, and both wake views remain organized through capture.

## Candidate hypothesis

Repeat the inherited `dogfish3d_outer_los_rate_intercept_v1` policy exactly.
The prior rollout makes bounded LOS-rate interception a physically compatible
candidate, but one threshold capture cannot distinguish a reliable mechanism
from the terminal variability already demonstrated by exact-policy repeats.
Do not tune its scale, annulus, carrier, or steering allocation before that
semantic test. The repeat should preserve far-field closure and the traveling
bend while applying the same small body-frame interception correction between
`4L` and `1.5L`.

Falsify the mechanism if this exact repeat misses or exits, weakens either wake,
changes far-field closure, or materially exceeds the repeat-backed actuator or
load envelope. A second capture would justify continued exact-repeat evidence,
not scalar gain optimization, until reliability exceeds the baseline's known
`4/6` record.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over a rhythmic CPG
source_mechanism: bounded line-of-sight-rate interception feedback superposed on an independently sustained propulsive rhythm
transferable_invariant: oppose observed inertial line-of-sight rotation during an approaching intercept while leaving the locomotor carrier active
nontransferable_details: published gains, clocked CPG phase, robot morphology, dimensional timing, species kinematics, exact vortex phase, and task-specific routes
policy_translation: repeat the normalized body-frame target/velocity cross-product residual through the existing two-joint steering shares, gated to the outer-terminal approaching annulus and released before the inner capture regime
falsification: reject if the exact repeat loses capture, preserves the coherent lower-exit topology, degrades either wake, or leaves the established actuator and load envelope

## Non-CFD checks

- The semantic guidance checker passes after removing the duplicated copied-
  parent marker from the rendered workspace `README.md`.
- The candidate is byte-identical to the evaluated inherited step-38 policy,
  with SHA-256 `fa1e73606ad3cccf13d12579377fd177abd8f6fa5b6fc00b42c1d1b501503db6`.
- All 48 direct `params.FIELD` references are present in the object returned by
  `target_policy_params()`. The prescribed Julia assertion returns the finite
  action `(-15.078363043496848, -1.6932057383289447)` through the project's
  documented launcher.
- The solver editable-boundary check passes. No CFD was run.
