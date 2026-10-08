# Multi-wake target-policy candidate notes

## Visual and quantitative diagnosis before the edit

- All four sampled rollouts use the required direct-uniform still-water
  initialization (`U_infinity=[0,0,0]`), without cylinders or prewarm.  Both
  rows of every combined keyframe sheet were inspected.  The top-down views
  show self-propelled motion and alternating vortex shedding, while the
  oblique Lambda2 views show compact three-dimensional wake structures; none
  supports an advection or missing-thrust diagnosis.
- The transferred seed `solver_e1a03f18d808` has the strongest reusable
  segment: distance falls from `12.328L` to `4.780L` at `17.853T`.  It then
  curls below the target and exits the lower boundary at `27.495T` with
  distance `9.709L`.  Its raw action exceeds at least one `1800 deg/T^2`
  acceleration limit on `97.9%` of samples, peak yaw rate is `3.140 rad/T`,
  and the coherent wake persists through the route failure.
- The response-release child `solver_dc5e319e8345` is the best finite sampled
  approach (`4.660L`), but it retains the same visual lower-exit topology,
  `98.0%` raw acceleration over-limit exposure, and essentially unchanged
  thresholded yaw reversals (84 versus the seed's 82).  The improvement is
  only `0.120L`, with no new termination class, so the inherited suggestion to
  tune this subcycle yaw-release gate does not survive its completed result.
- The inherited maneuver-cadence child `solver_914f6830b5c6` preserves the
  wake and lower-exit topology but worsens closest approach to `5.347L`; its
  late course is visibly more oscillatory and at least one raw acceleration
  remains over the envelope on about `90%` of samples.  The globally slower,
  soft-limited sibling `solver_a1d9e06dfe8a` removes raw acceleration
  exceedance, but follows the distinct wrong-side trajectory to an upper exit
  at `14.911T` and never gets closer than `8.752L`.  Together these outcomes
  reject another cadence-allocation edit as the next test.
- Inherited optimizer logs add two useful negative controls.  A continuously
  applied `12 deg` tail mean-curvature map exits above at `7.887T` with only
  `12.206L` closest approach, and even a course-released `2 deg` tail-curvature
  map exits above with `12.083L` closest approach.  Static posterior curvature
  therefore has much more route authority than offline correlation suggested.
  It should not be repeated at another scalar magnitude before testing a
  steering primitive that preserves zero-crossing propulsion.
- On the productive seed trace, the signed angle from measured swimming
  velocity to the target is about `-0.50 rad` at `8T`, `-0.40 rad` at `12T`,
  then grows to `-0.68 rad` at `16T` and `-1.23 rad` near closest approach.
  Thus actual translation becomes materially misaligned before distance
  reverses.  A speed-qualified course signal can activate earlier than the
  failed progress-loss cadence gate; unlike the seven-sample (`~0.0385T`) yaw
  proxy, its two-T means acquire one coherent corrective sign before the
  closest-approach epoch.

## Candidate hypothesis

Preserve the seed's demonstrated anterior oscillator, posterior lag, cadence,
target steering, and approach scheduling.  Add one bounded actuator-level
mechanism: when normalized body-frame velocity is fast enough to define a
course and that course is materially misaligned with the body-frame target
vector, bias the positive and negative acceleration half-cycles in the signed
corrective direction.  The residual is proportional to the magnitude of the
existing state-generated carrier, so it changes half-cycle authority without
adding a static bend, clock, route, or independent high-frequency oscillator.
Internally clamp the final action at the known actuator envelope; when the
course gate is zero, the applied action is exactly what the evaluator would
have obtained by clipping the seed.

The expected result is to retain the seed's early wake and deep approach while
reducing the late downward course error before closest approach.  Falsify the
hypothesis if the coherent alternating wake or early distance reduction is
lost, if either the sampled upper- or lower-boundary topology remains without
a meaningfully better approach, if the course residual increases yaw
reversals or load peaks, or if internal envelope handling merely hides a
persistently bang-bang gait without improving the route.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning layered on classical posterior-lagged swimming
source_mechanism: steer by making the corrective carrier half-cycle modestly stronger instead of imposing a persistent mean body curvature
transferable_invariant: preserve a propulsive traveling bend while a bounded, response-dependent half-cycle asymmetry converts persistent course error into signed turning authority
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, clock-driven CPG phase, exact vortex phase, motor dynamics, and task-specific routes
policy_translation: form a signed course error only from L-normalized body-frame target geometry and body-frame velocity; qualify it by observed speed and misalignment, then bias the magnitude of the two state-feedback joint accelerations within the fixed envelope with posterior emphasis
falsification: reject the transfer if early propulsion or wake coherence degrades, either inherited boundary-exit topology persists without useful approach improvement, or the asymmetric carrier raises reversal or load severity

## Candidate scope

This is one mechanism-level candidate rather than a gain sweep.  The new
parameters own only course qualification, half-cycle asymmetry, posterior
emphasis, and the fixed action-envelope adapter.  Formal CFD remains deferred
to EvE after this worker exits.

## Pre-evaluation checks

- Offline replay on the seed trace gives two-T mean course commands of about
  `-0.001` at `0--2T`, `-0.031` at `8--10T`, `-0.221` at `12--14T`, `-0.522`
  at `14--16T`, and `-0.792` at `16--18T`.  The mechanism is therefore nearly
  dormant at release and during the first demonstrated approach, then becomes
  directional before the `17.853T` minimum-distance sample.  This replay is a
  signal/branch check, not new CFD evidence.
- Applying the candidate algebraically to recorded seed states changes the
  evaluator-clipped action on about `30.2%` of samples, with mean two-joint L1
  change `0.403 rad/T^2`; all outputs stay within `1800 deg/T^2`.  An aligned
  moving observation gives exactly the evaluator-clipped seed action, while a
  misaligned moving observation activates the course branch and changes the
  action finitely.
- The lightweight Julia contract passes.  Formal CFD remains deferred to the
  evaluator, so no success or improved physical behavior is claimed here.
