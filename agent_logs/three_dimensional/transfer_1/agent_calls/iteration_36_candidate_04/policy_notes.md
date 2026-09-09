# Wake-policy candidate diagnosis

## Evidence diagnosis

- All four sampled solver evaluations use direct uniform still-water
  initialization at `U_infinity=(0,0,0)` and capture at
  `0.7485--0.7499L`. Three are exact-byte evaluations of the prefilled
  intercept-guarded speed-reserve controller; the fourth is the
  outer-terminal unsupported-bearing qualifier.
- The best sampled capture (`solver_ac993a461b7c`, score `-0.14991`) and
  the assigned-parent repeat failure (`solver_7bb8108ca3e3`, score
  `-11.61504`, `left_domain`) both show self-propulsion in the combined
  sheets. Each keeps a persistent alternating top-down vortex street and
  bilateral oblique Lambda2 structures through its closest pass. The failure
  has no visible carrier collapse, collision, or numerical instability, so
  propulsion and wake organization are not the repair target.
- The qualifier has now captured once at `0.74986L` and failed its exact
  repeat at `1.18462L`; it is therefore `1/2`, not a reliable semantic
  improvement over the exact speed-reserve baseline. Its repeat failure also
  stays within the prior force/moment envelope (peak coefficients
  `0.01462/0.02753/0.01535`) and continues actuating after the pass.
- Recomputing the evaluator's eight-row distance-window signal from the
  sampled trajectories gives strictly positive closing speed below `4L` for
  every capture (minimum `0.138--0.641L/T`). The parent failure first crosses
  negative near `1.23L`, reaches its `1.18462L` closest pass, then falls as
  low as `-0.859L/T` while exiting below. This separates successful
  first-pass acquisition from the evidenced failure without changing any
  sampled capture approach.

## Candidate hypothesis

Restore the three-repeat intercept-guarded speed-reserve baseline and add one
response-gated burst-redirect residual. Inside the acquired terminal region,
negative eight-row closing speed smoothly activates a bounded,
target-signed mean-curvature target over the two joints. The residual is
additive, so the posterior-lagged traveling bend remains active, and it
vanishes continuously as positive closure returns. The new mechanism should
be exactly inactive on all four sampled capture approaches and intervene only
after the inherited lower-pass topology becomes observable.

Falsify the mechanism if it loses first-pass capture, remains inactive after
progress loss, retains the lower-boundary exit, creates persistent static
curvature or coasting, weakens either wake view, or pushes clipping, joint
speed, force, or moment outside the repeat-backed envelope.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-feedback robotic-fish direction control
source_mechanism: response-gated C-start redirect superposed on a rhythmic propulsive carrier
transferable_invariant: observed failure of target progress can gate a strong bounded curvature response that releases when useful response returns while preserving the locomotor rhythm outside the event
nontransferable_details: species-specific bend angles, published gains, clocked CPG phase, dimensional timing, robot morphology, and task-specific routes
policy_translation: use normalized distance, eight-row closing speed, body-frame target/course error, and two-joint state to add a bounded mean-curvature residual only after terminal progress loss; retain the evaluated posterior-lagged carrier
falsification: reject if sampled capture approaches are perturbed, recovery does not occur, the carrier wake collapses, static curvature persists, or actuator/load metrics leave the repeat-backed envelope

## Non-CFD checks

- Counterfactual replay of the new distance/progress gate over the recorded
  trajectories activates it on zero rows in all four captures. It activates on
  613 rows of the assigned-parent failure, beginning at `18.865T`, `1.186L`,
  and windowed closing speed `-0.045L/T`; the computed residual remains within
  its configured `10 rad/T^2` bound. This checks selectivity and boundedness,
  not whether the unevaluated candidate recovers in CFD.
- The required guidance-difference check and editable-boundary check pass, and
  every direct `params.FIELD` reference has a returned parameter field. The
  lightweight Julia execution check could not run because this worker image
  and its available modules contain no `julia` executable.
