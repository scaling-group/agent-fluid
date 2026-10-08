# Carrier-residual hydrodynamic-moment anticipation

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled solver examples satisfy the required direct, uniform
  still-water contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm,
  finite dynamics, and capture after `2,919` steps. Their policy sources,
  trajectories, and combined keyframe sheets are byte-identical. I inspected
  both the top-down mid-plane-vorticity and oblique body/Lambda2 rows of the
  prefilled example. The fish is self-propelled, establishes a coherent
  alternating red/blue wake by about `4T`, retains compact three-dimensional
  shed structures behind the posterior body, and follows a smooth target-
  directed path through capture. There is no passive advection, wake collapse,
  boundary interaction, collision, or numerical instability.
- Because the current sample contains no distinct failure rollout, the most
  informative available negative visual control is the inherited step-16
  signed terminal-centering regression. Its two-view wake is qualitatively
  indistinguishable from the current carrier and it also captures, but its
  `-0.056917` score is worse. The inherited optimizer notes further reject
  terminal posterior-wave release, pointwise speed relief, short-window
  bearing lead, and safe-corridor mean-steering release. This rules out
  claiming improvement from another terminal gate or clamp-equivalent wrapper.
- The current yaw-opposition carrier is a genuine useful trajectory change
  over the replicated intercept-release parent. It advances the `8/6/4/2L`
  crossings from `9.202/11.154/13.013/14.905T` to
  `9.075/11.044/12.920/14.801T`, lowers observed distance integral from
  `1.314014L` to `1.303739L`, and improves score from `-0.055617` to
  `-0.048654` while preserving `16.0545T` capture and the coherent two-view
  wake. Mean posterior command and exact posterior acceleration-limit
  residence also fall from `24.888 rad/T^2` and `22.47%` to `24.616 rad/T^2`
  and `21.86%`. The cost boundary is a larger posterior excursion
  (`36.4 deg` versus `31.7 deg`), slightly higher peak lateral force, and a
  shallower final crossing (`0.747530L` versus `0.744345L`). The next mechanism
  should therefore improve response timing without raising the existing
  `4 deg` yaw-redirect curvature cap.
- The current trace provides a leading hydrodynamic signal not yet used by the
  policy. A two-term fit of normalized yaw moment to normalized anterior joint
  position and velocity explains `94.5%` of total moment variance; fitting the
  first `70%` of the rollout still explains `94.8%` on the held final `30%`.
  With conservative rounded coefficients `0.015` and `0.0045`, the remaining
  moment has standard deviation `0.00216` and 95th-percentile magnitude
  `0.00401`. Its sign agrees with the change in carrier-residual yaw over the
  next 16 samples (`0.088T`) on `69.5%` of states, with correlation `0.394`.
  Under a `0.004` residual scale, moment-opposition states inside a reliable
  redirect predict future target-opposing yaw on `73.4%` of inherited states,
  versus `58.2%` elsewhere. This supports a leading response gate; raw moment,
  which is dominated by the locomotor carrier, does not.

## Policy hypothesis

Retain the evaluated state-feedback oscillator, carrier-phase-residual
redirect selector, raw body-frame target/course turn direction, one-sided
opposing-wave relief, mean-first posterior allocation, intercept-conditioned
anterior damping release, yaw-residual opposition feedback, bounds, and exact
speed-limit projection. Add one new mechanism: predict the beat-synchronous
hydrodynamic yaw moment from normalized anterior joint position and velocity,
subtract it from the measured normalized body-frame moment, and use only a
target-opposing residual to open the existing bounded yaw-redirect curvature
slightly before opposed yaw develops. Combine moment and yaw opposition with a
maximum, so total yaw-response curvature never exceeds the inherited `4 deg`
cap. Attenuate the predictive moment branch continuously as measured residual
yaw aids the requested redirect, closing it fully at the inherited yaw-
residual scale.

On fixed inherited states this proposed gate changes only target-aligned
posterior mean curvature after forward-speed and raw-redirect reliability are
present; it is effectively zero during release and changes no anterior role.
Expected result: retain the coherent carrier and capture while advancing
far/middle response enough to reduce distance integral or arrival time without
further increasing posterior excursion or loads. Falsify it if capture or an
`8/6/4/2L` milestone regresses, the wake loses coherence, the moment residual
acts during aiding yaw, posterior angle approaches its target clamp, or
limiting/force/moment costs outweigh route progress.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and adaptive hydrodynamic-response control
source_mechanism: preserve a rhythmic locomotor carrier while a carrier-residual force or moment signal supplies bounded anticipatory steering feedback
transferable_invariant: subtract beat-predictable hydrodynamic moment and use only target-opposing residual moment as a leading cue for an already requested redirect, while yielding continuously to clearly aiding motion and preserving the existing authority cap
nontransferable_details: published gains, dimensional moment thresholds, species or robot kinematics, full-body waves, exact vortex or beat phase, source-task routes, and source-task arrival timing
policy_translation: predict normalized body-frame yaw moment from `q1/amp` and `qd1/(omega*amp)`, subtract it from `moment_z_L2`, gate its target-opposing part by raw body-frame redirect and forward-speed reliability, attenuate it continuously to zero across the inherited aiding-yaw scale, and take the maximum with the inherited yaw-opposition gate under the same bounded posterior mean-curvature limit
falsification: reject if the residual is not phase-separable on a new carrier, fires without reliable target demand, breaks lateral reflection equivariance, overrides clearly aiding yaw, loses capture or wake coherence, delays milestones, or increases posterior excursion, limiting, and loads without a route benefit

The shelf informed only the carrier/residual feedback invariant. All numerical
coefficients and scales above come from the sampled L64 trace, not from a
published gain, kinematic envelope, vortex phase, or prescribed route. The new
candidate receives CFD evidence only after this worker exits.

## Non-CFD verification after the policy edit

- Fixed-state replay against all `2,919` inherited states confirms that the
  final source changes `148` posterior commands only, between `2.739T` and
  `15.642T` (`12.064L` to `1.151L`). Every anterior command is exact, every
  changed posterior action is aligned with the raw target redirect, maximum
  action delta is `4.171 rad/T^2`, and mean changed-command magnitude is
  `0.455 rad/T^2`. These are counterfactual action semantics on inherited
  states, not a closed-loop trajectory claim.
- A deterministic `69,984`-state sweep over lateral reflection, joint state,
  exact joint-speed boundaries, target geometry, body velocity, yaw response,
  and hydrodynamic moment returns finite bounded actions, machine-exact zero
  reflection error, and no outward acceleration at either exact speed limit.
  Static schema inspection finds all `44` direct `params.FIELD` references
  among the `44` fields returned by `target_policy_params()`.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed commands were then run directly and separately. The first
  guidance run exposed two identical assigned-parent markers in the rendered
  workspace `README.md`; removing only the duplicate repaired provenance.
  The material guidance check, lightweight Julia policy contract, and solver
  editable-boundary check all pass. The final candidate SHA-256 is
  `b1cfe0085206c84911ac689cd462c0c2dfd699046c493e6cbea74dd4ff937719`.
  No formal CFD was run.
