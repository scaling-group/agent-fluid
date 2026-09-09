# Wake-policy candidate diagnosis

## Evidence read before policy edit

- All four sampled solver rollouts and the assigned-parent rollout report
  direct uniform initialization at `U_infinity=[0,0,0]`, no cylinders, and no
  prewarm. The observed translation is therefore self-propulsion rather than
  ambient advection.
- I inspected both rows of the combined keyframe sheets for the highest-scoring
  sampled finite rollout (`solver_6b0e320e2f55`) and the assigned parent's
  informative failure (`solver_8faa36e7a77f`). The repeatable
  `dogfish3d_intercept_guarded_speed_reserve_v1` sheet shows a coherent,
  alternating top-down vorticity street and compact paired oblique Lambda2
  structures from release through its `0.7494L` capture at `18.6010T`. The
  projected-miss repeat also keeps laying down an alternating wake after its
  closest pass; it is still moving at roughly `0.7--0.8L/T` as its path bends
  below the target and continues toward the lower boundary. This is a route
  and terminal-steering failure, not advection, carrier collapse, or numerical
  instability.
- Three exact-byte sampled evaluations of the prefilled speed-reserve policy
  captured at `0.7466--0.7494L` and `18.2050--18.6010T`, with scores
  `-0.15856`, `-0.15828`, and `-0.15140`. In contrast, inherited optimizer
  logs now give the projected-miss replacement one threshold capture followed
  by two exact-policy lower exits at closest approaches `1.7680L` and
  `1.6366L`. The assigned-parent failure reached its closest pass near
  `18.7825T`, then retained the same coherent wake while distance grew to
  `10.1730L`; its run was direct-uniform and stable.
- The inherited baseline diagnostics show action clamping on roughly
  `68.5--68.7%/70.6--71.0%` of rows and exact joint-speed-limit residence near
  `10.4--11.6%`. Earlier total-command governing reduced speed residence but
  lost capture. This rejects another saturation-first governor and supports
  preserving both the carrier and the proven route/intercept error. It also
  suggests that constant additive steering is frequently combined with a
  carrier already pointing at the command clamp, where added same-sign effort
  cannot create proportional steering authority.

## One candidate hypothesis

Retain the prefilled achieved-course geometry, projected-intercept release
guard, sparse outward-carrier reserve, carrier cadence, and steering magnitude.
Change only the terminal steering realization: inside the already-defined
intercept range, use each joint's state-derived carrier acceleration to reduce
the additive steering residual on a carrier-aligned half-cycle and increase it
on the opposing half-cycle. This continuous, sign-symmetric phase allocation leaves
far-field commands byte-equivalent in structure, keeps the traveling bend
active, and does not replace the route error with the falsified projected-miss
error.

Expected test: preserve the three-repeat capture topology and coherent 3D wake,
while making terminal curvature less dependent on same-sign clipped carrier
phases. A useful outcome would capture without increasing action/speed
saturation or peak force/moment beyond the baseline envelope; a faster or less
variable crossing would be secondary evidence.

Falsification: reject the half-cycle allocation if it changes early distance
closure before the `2.75L` intercept region, weakens the alternating wake,
raises saturation or loads, or turns any repeatable baseline capture into the
below-target `left_domain` topology. Because this worker cannot run formal CFD,
the new candidate is a hypothesis, not evidence of improvement.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: use observed oscillator phase to allocate steering asymmetrically across the two half-cycles while retaining a propulsive carrier
transferable_invariant: a persistent turn request can be realized by bounded state-synchronous wave asymmetry instead of increasing a phase-independent mean command
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact beat and vortex phase, prescribed routes, and task-specific paths
policy_translation: retain normalized body-frame achieved-course and intercept feedback; inside the existing intercept gate, continuously shift each joint's additive steering from carrier-aligned acceleration toward the opposing half-cycle using only joint-derived carrier state
falsification: reject if far-field closure changes, the traveling wake weakens, capture is lost, or action/speed saturation and force or yaw-moment loads exceed the repeatable speed-reserve envelope

## Non-CFD verification

- The required guidance-semantic check passes after removing the duplicated
  adjacent assigned-parent marker from the rendered workspace `README.md`.
- The mandated Julia policy-contract check passes with the bundled Julia
  `1.12.6` runtime: `target_policy_params()` has no forbidden `L` field and
  `target_policy` returns two finite accelerations.
- A direct Julia comparison against sampled baseline bytes confirms identical
  output outside the existing `2.75L` intercept gate. A mirrored terminal
  state returns exactly sign-mirrored joint accelerations, confirming that the
  new carrier/turn product preserves reflection equivariance.
- The solver editable-boundary check passes. No CFD rollout was run.
