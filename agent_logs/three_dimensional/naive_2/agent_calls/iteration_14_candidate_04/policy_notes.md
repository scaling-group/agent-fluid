# Course-predictive terminal-curvature candidate

## Evidence and visual diagnosis before editing

- The assigned prefill and all four sampled evaluations report direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  Their
  top-down sheets show body-connected alternating vorticity, while the oblique
  sheets show compact three-dimensional Lambda2 structures.  Motion is
  self-propelled, and the observed failures are control-trajectory failures
  rather than advection, wake absence, or numerical instability.
- The prefilled phase-separated full-circle controller preserves propulsion
  but never enters the capture corridor: it reaches `4.650L`, crosses the
  target x station at `y=14.555L`, and exits the upper virtual boundary.  Its
  broad late arc, `25.4%` posterior dwell beyond `40 deg`, and peak normalized
  planar force/moment of `0.620/0.261` do not support another full-circle
  steering or approach-braking variant.
- The sampled course-predictive controller is the only semantic success.  Its
  top-down row follows a direct targetward trajectory behind a compact
  alternating wake, and its oblique row keeps body-connected 3D structures
  through capture.  Metrics agree: capture occurs at `16.0105T` and `0.7477L`
  with head `(9.656,9.140)L`, zero logged joint-angle dwell beyond `40 deg`,
  and peak normalized planar force/moment `0.0347/0.0172`.  The architecture
  forms steering from the rotation-invariant target/velocity course residual,
  then recruits bounded mean curvature from predicted cross-track miss while
  retaining the traveling-bend carrier.
- The assigned parent's latest inherited experiment isolates what not to add.
  Removing a joint-state estimate of beat-correlated lateral velocity only
  from closest-approach prediction preserved low loads and reduced rate-limit
  occupancy, but changed capture into a `0.9016L` near miss followed by a
  lower-left exit at `28.37T` and `10.604L` final distance.  Its keyframes show
  the same coherent carrier crossing below the capture circle and then making
  a long downward escape.  A cleaner internal signal and closer scalar minimum
  are therefore not improvements when they destroy the capture termination.

## Single candidate hypothesis

Replace the weaker prefill with the sampled successful controller without an
untested cleanup: preserve its state-feedback traveling bend, posterior lag,
rotation-invariant body-frame course steering, constant-course predicted-miss
gate, and bounded terminal mean-curvature handoff as one compatible mechanism.
The current evidence favors reproducibility of semantic success over modifying
the predictor that produced it.  This architecture uses only normalized
`target_body_L`, `distance_L`, `velocity_body_U`, and two-joint state, with no
time, route, cylinder coordinates, or mutable phase.

Support is repeat capture with a coherent alternating wake, zero large-angle
dwell, and low normalized loads.  Falsify transfer beyond this assigned
still-water case if a cylinder-wake evaluation loses capture, if alternating
crossflow makes the instantaneous constant-course miss switch the terminal
curvature to the wrong side, or if joint-rate occupancy and loads rise without
better target progress.  Such evidence would justify a history-based slow
course estimate or bounded wake residual; the failed instantaneous joint-state
subtraction should not be retried as the default remedy.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking with target-directed mean-curvature turning
source_mechanism: preserve a rhythmic propulsive carrier while persistent course error and predicted cross-track miss recruit a bounded terminal bend
transferable_invariant: separate propulsive rhythm from slower target-course correction, using normalized observed geometry to add only enough persistent curvature for interception
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use body-frame target and velocity dot/cross geometry for course steering and predicted miss, then center the two-joint traveling bend on a bounded target-signed terminal curvature
falsification: reject if capture, wake coherence, joint reserve, and low normalized loads do not remain jointly favorable, especially under actual multi-wake crossflow

## Dry validation only

The mandated guidance-materiality check, lightweight Julia policy contract,
deterministic parameter-schema guard, and editable-boundary check pass.  An
`8,748`-state grid spanning joint state, fore/aft and lateral target geometry,
body velocity, and distance produced finite commands strictly inside the
smooth `30 rad/T^2` envelope with exact left/right reflection (maximum error
`0.0`).  These checks establish executable semantics, not physical success.
No CFD is run by this worker; downstream evaluation must decide the capture,
wake, load, and actual multi-wake falsifiers above.
