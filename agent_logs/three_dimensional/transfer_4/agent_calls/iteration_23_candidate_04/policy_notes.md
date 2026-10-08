# Hydrodynamic-moment preview for the terminal posterior envelope

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, sampled policies, scores, observations,
  metrics, diagnostics, and trajectories, plus the inherited optimizer notes
  and completed evaluations. I inspected the combined sheets for the sampled-
  best posterior envelope, the signed-course regression, and the assigned
  parent's course-persistent hold, including both their top-down vorticity and
  oblique Lambda2 rows. All inspected episodes are contract-valid direct
  uniform still-water releases with `U_infinity=(0,0,0)`, no prewarm, and no
  cylinders.
- In both views the fish self-propel from rest and retain an alternating,
  advecting mid-plane street with compact three-dimensional posterior
  structures through capture. No sheet shows passive advection, wake breakup,
  collision, boundary exit, or out-of-plane instability. The visible
  discriminator is the final laterally bent approach, not gross wake presence.
- The sampled-best alignment-qualified posterior envelope captures at
  `18.0235T` with score/mean distance `-0.064545/1.950801L`, center path
  `13.2111L`, near/final alignment `0.6722/0.1818`, and near/final absolute
  yaw `1.8883/0.4200 rad/T`. It keeps the full far/middle trajectory and
  improves on the episode-equivalent parent's path, yaw, and posterior
  acceleration-ceiling residence while retaining the coherent wake.
- Three completed course-slip extensions fail to improve that controller. A
  signed course-to-curvature residual regresses score/mean distance to
  `-0.064645/1.950875L` and final yaw to `0.5884 rad/T`; blending course slip
  into desired yaw rate regresses to `-0.064995/1.951153L`; and the assigned
  parent's unsigned course-persistent posterior hold regresses to
  `-0.065308/1.951589L`, delays capture to `18.1335T`, lengthens path to
  `13.2762L`, and moves near acceleration-ceiling residence from
  `70.20/72.47%` to `71.63/67.07%`. The hold lowers mean near yaw but finishes
  after a sign reversal at `+1.2838 rad/T`, so its extra damping delays and
  redistributes work rather than settling the crossing.
- The sampled-best trace exposes a different feedback signal. In approach the
  normalized yaw moment has RMS `0.00840`, 90th-percentile magnitude
  `0.01278`, and predicts the change in measured yaw over the next `0.0275T`
  with correlation `0.9843`. Its instantaneous sign agrees with yaw only about
  half the time. Thus indiscriminate moment cancellation would also erase the
  half-cycles already braking yaw, but same-sign moment is a measured early
  signature of a yaw-amplifying hydrodynamic load.

## Single policy hypothesis

Start from the evaluated-best alignment-qualified terminal posterior envelope,
preserving its odd target-to-curvature map, anterior state-feedback carrier,
posterior lag/emphasis, phase-consistent reserve, far/middle route observer,
mean and half-cycle steering, and reversal-preserving rate governor. Add one
hydrodynamic-moment preview to the existing terminal posterior envelope.
Normalize the already body-scaled yaw moment by its observed approach scale,
form a reflection-invariant agreement gate from signed moment and normalized
turn rate, and union that gate with the existing yaw-magnitude gate. The result
holds back only posterior oscillatory excursion when the fluid moment is
currently reinforcing yaw; it does not change mean steering or the anterior
carrier, is exactly inactive outside `2.10L`, and leaves an opposing/braking
moment untouched.

Replaying the gate on the sampled-best trajectory changes posterior-wave
authority in `149/396` approach samples, from mean `0.90243` to `0.90085`,
with maximum additional withdrawal `0.03169`; authority is identical outside
approach and at the recorded final braking-moment state. The expected signature
is preservation of far/middle closure and both coherent wake views, with fewer
yaw-amplifying posterior half-cycles, no course-slip-induced capture delay,
and score/mean distance, path, and terminal yaw no worse than the sampled
leader. Falsify if capture or the sampled-best distance integral is lost,
arrival/path regresses materially, acceleration residence merely migrates to
the anterior joint, yaw is not reduced, reflection fails, or either wake view
deteriorates.

bookshelf_consulted: true
source_domain: wake-interaction disturbance rejection, sensor-modulated robotic-fish control, and Lighthill-style posterior reactive propulsion
source_mechanism: separate the slow target-directed turn request from fast hydrodynamic yaw-moment feedback while preserving the posterior traveling wave and useful braking half-cycles
transferable_invariant: reject only observed fluid moment that reinforces current yaw; do not cancel all lateral motion or replace target steering, and keep the correction bounded and state-driven
nontransferable_details: published gains, species-specific amplitude envelopes, dimensional frequencies, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: normalize `moment_z_L2` by its measured approach distribution, combine its signed agreement with normalized body turn rate into a reflection-invariant terminal gate, and apply that gate only to the posterior oscillatory envelope under the existing normalized approach and alignment authorities
falsification: reject if behavior changes outside approach, capture or sampled-best mean distance is lost, path/yaw/load do not improve, useful braking moments are suppressed, saturation migrates without benefit, reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The required dedicated checker was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable to this account. Running its immutable checks directly
  gives PASS for the material guidance update and repository boundary; the
  boundary reports `candidate_target_policy.jl` as the only solver change.
- Julia is not installed, so the exact include/action probe cannot run in this
  shell. The deterministic schema guard passes: all `63` direct
  `params.FIELD` references resolve among `65` unique returned fields, both
  public functions occur once, the candidate is nonempty, delimiters balance,
  and no time, step, random, file-I/O, cylinder-coordinate, or world-route
  source appears.
- Focused algebraic probes make posterior-wave authority exactly one outside
  approach, make the added reinforcement gate exactly zero for opposing yaw
  moment, and preserve gate and authority magnitudes when yaw and moment are
  reflected together. These are contract and activation checks, not CFD
  evidence; EvE must evaluate the capture and trajectory prediction after this
  worker exits.
