# Geometry-driven posterior-lag asymmetry

## Completed evidence and visual diagnosis before editing

- All four sampled solver artifacts are byte-identical v50 controllers and
  trajectories.  Each starts directly from uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm, then captures at
  `17.41299 T`, score `-0.0595203`, final distance `0.745094 L`, and
  total/observed distance integrals `1.945327/1.329976 L`.  The sample therefore
  establishes a four-run reproducibility baseline but supplies no distinct
  failed trajectory.
- I inspected both rows of the representative and visually distinct combined
  sheets from release through capture.  The top-down row shows active
  self-propulsion on a smooth target-signed arc: compact startup vorticity
  develops into a coherent alternating posterior street without collision,
  reversal, domain exit, or lateral runaway.  The readable oblique sample
  shows a coherent body and compact paired caudal Lambda2 structures at
  release, `4 T`, `16 T`, and capture; one intermediate frame is black.  The
  other three oblique sheets are black after release, so they are rendering
  limitations and do not support comparative 3D-wake claims.
- The sampled metrics and trace agree with the images: distance falls from
  `12.3277 L` to capture with only 89 beat-scale increases no larger than
  `0.000138 L`, maximum speed is about `0.9831 L/T`, and peak normalized force/moment is
  `0.032252/0.016092`, and exact acceleration-limit residence is
  `34.97%` anterior, `5.15%` posterior, and `40.11%` for either joint.  The
  useful carrier and wake should therefore be preserved; the remaining
  opportunity is actuator allocation, not missing propulsion or instability.
- Inherited completed logs provide the informative mechanism failures missing
  from the current duplicate sample.  Instantaneous normalized target/velocity
  course slip has now failed as a route correction, a desired-yaw-rate input,
  and a posterior shape residual.  All three retain the v50 capture step but
  fail to improve a meaningful checkpoint or distance integral, and the two
  direct actuator placements increase posterior acceleration-limit residence.
  The cue is `0.94/0.99` correlated with anterior joint rate/posterior joint
  angle during approach, so another placement would mostly feed carrier phase
  back as route error.

## Sole candidate and falsifiable policy hypothesis

Preserve v50's normalized body-frame target sensing, de-gaited pose and rate
feedback, state-feedback traveling-wave carrier, C-start-like redirect,
selective crossflow pose confidence, axis-selective launch response,
carrier-first spillover, geometric posterior-response qualification, approach
priority, and componentwise actuator projection.  Add one structurally distinct
steering primitive inside the posterior traveling wave: multiply the observed
posterior lag by a small reflection-even factor formed from a bounded head-only
de-gaited target-pose signal and the centered anterior joint side.  Increase lag on the
turn-aligned half-cycle and decrease it on the opposing half-cycle, while
releasing the modulation during the large-error redirect.  The anterior
oscillator, mean route curvature, cadence, and all course-velocity feedback
remain unchanged.

This is a joint-state phase-lag allocation test, not a gain retune of the failed
course controller.  It should preserve v50's coherent carrier while converting
some ordinary steering into asymmetric posterior wave timing, where the
completed trace has substantially more acceleration headroom than at the
anterior joint.  The next CFD rollout should retain capture and early closing,
then improve at least one middle/late distance checkpoint or distance integral
without raising posterior saturation, speed, force, or moment materially.
Falsify the mechanism if target-signed curvature weakens or reverses, the
traveling wake decoheres, capture/integral performance regresses, the large
redirect changes, or the established action/load envelope is exceeded.  Formal
CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and phase-lag or wave-shape modulation
source_mechanism: preserve a low-dimensional propulsive oscillator while target geometry changes posterior wave timing across observed half-cycles to generate turning
transferable_invariant: steer a productive traveling wave by a bounded reflection-equivariant posterior phase-lag asymmetry driven by persistent body-frame target geometry, leaving the anterior rhythm and large-error redirect intact
nontransferable_details: published gains, duty ratios, dimensional cadence, robot or species kinematics, full-body oscillator states, exact vortex phases, and task-specific routes
policy_translation: form a bounded turn signal from normalized head-only de-gaited bearing and target-vector angle, multiply posterior lag by its product with centered anterior joint side, and release that factor during the existing redirect before the two-joint carrier-first projection
falsification: reject if the v50 route, capture, or coherent two-view wake regresses, if no checkpoint or integral improves, or if posterior limit residence, speed, normalized force, or moment materially exceeds the completed envelope
```

## Evidence boundary

Every numerical and visual outcome above comes from the assigned-parent
guidance, sampled completed solver evidence, and inherited optimizer logs.  The
posterior-lag asymmetry below is one unevaluated hypothesis; no same-worker CFD
result is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v54_geometry_driven_posterior_lag_asymmetry`, SHA-256
  `01a2d879399c41ecdc063bae4fd0cadd630713596f8f7c2d04b0953d65c01d92`.
  All `69` distinct direct `params.FIELD` references resolve among the `71`
  fields returned by `target_policy_params()`; the two metadata fields not
  directly referenced are `version` and the inherited `control_period`.
- A frozen-state replay across all `3,166` completed v50 trace rows changes
  `895` rows.  The anterior action is exactly unchanged; only the posterior
  action changes, by `0.21686 rad/T^2` on average when active and at most
  `0.94626 rad/T^2`, against the fixed `31.41593 rad/T^2` envelope.  The lag
  factor stays within `0.95430-1.03692` on that trace and yields continuously
  as the inherited redirect request grows.  This establishes localization and
  scale only, not closed-loop benefit.
- A deterministic `87,480`-state mirrored grid gives zero sign error for the
  new de-gaited pose signal, zero reflection error for its lag factor, and less
  than `1.2e-13 rad/T^2` reflection error for the isolated posterior-drive
  delta.  All final policy actions remain finite and within the componentwise
  acceleration bound.  The policy contains no explicit time, step count,
  random number, file I/O, mutable global state, fixed obstacle coordinate, or
  memorized route.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this ChatGPT account.  Its exact three no-CFD checks were
  run locally and separately: material guidance/notes, the full lightweight
  Julia policy contract, and the solver editable-boundary check all pass.  The
  guidance check first found the inherited duplicate assigned-parent marker in
  the rendered workspace `README.md`; removing only that duplicate marker
  repaired provenance, and the rerun passed.  No formal CFD was run.
