# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the fish held in the upper-right while the
  four staggered-cylinder wakes develop and merge around the target. This is a
  common release condition, not a transferable vortex phase, cylinder route,
  or candidate-specific advantage.
- The assigned parent is the best sampled finite result. Its released sheet
  shows active upstream swimming, an alternating posterior-lagged bend, an
  early redirect through the interacting wake, and target capture after
  `130.729` released units with `3.75391L` mean distance. Mean body-frame
  streamwise velocity (`-0.08315`) exceeds the magnitude of mean local flow
  (`-0.06591`), so the route is self-propelled rather than passive advection.
- The parent's short first-order filter over both joint commands improved the
  replicated unfiltered scaffold's `137.357` arrival and `4.18356L` mean
  distance, but it did not suppress fast or costly actuation. Total command
  energy rose from `90228` to `115750`; RMS relative crossflow, lateral force,
  and yaw moment rose from `0.12955/14.75/303.02` to
  `0.15435/18.30/359.97`. Joint-1 acceleration now reaches its `31.416`
  hard cap, joint-2 acceleration rises from `25.552` to `30.851`, and maximum
  joint angles rise from `0.402/0.346` to `0.469/0.439` rad. The keyframe
  path reaches the corridor sooner but has sharper lateral folds than the
  lower-load unfiltered path. Thus the full-command delay enlarged the
  oscillator envelope; its speed gain is not evidence of actuator relief.
- The sampled course-alignment sibling is a useful lower-risk contrast: it
  preserves near-baseline loads and energy while slightly improving mean
  distance to `4.07666L`, but does not reproduce the parent's earlier arrival.
  No sampled solver is a semantic failure. The informative inherited
  mechanism failure is the `279.439`-unit same-sign posterior half-cycle
  modulation: its sheet shows repeated large loops above and below the wake
  corridor, with `6.9817L` mean distance and `182836` energy. Other inherited
  posterior target or tail-lag changes also delay capture. A new test therefore
  must not alter the successful tail target or redistribute route authority.

## Policy hypothesis

Make one actuator-coordination change to the assigned parent. Preserve its
instantaneous body-frame bearing route loop, progress-qualified bearing-rate
damping, direct normalized moment residual, state-inferred anterior half-cycle
steering, oscillator parameters, and posterior target exactly. Keep the short
timestep-aware first-order response only on joint 2, while applying the raw
joint-1 acceleration directly. This restores immediate radial regulation and
route authority at the anterior joint, which is where the full filter reached
the hard acceleration cap, while retaining a bounded response phase at the
posterior propulsive interface that may preserve some of the parent's upstream
speed benefit. The mechanism uses only current two-joint state, previous
applied joint-2 action, and normalized observation interval; it adds no clock,
route coordinate, wake phase, or mutable state.

The formal expectation is preserved capture, upstream translation, and the
alternating traveling bend, with joint-1 angle/acceleration and RMS crossflow,
force, moment, and command effort moving toward the unfiltered scaffold while
arrival and mean distance remain better than `137.357` and `4.18356L`.
Falsify the mechanism if capture is lost or materially delayed, the posterior
wave or upstream translation weakens, route folds approach the inherited
posterior-modulation failure, joint-1 still contacts the cap, or the speed and
distance benefit does not coexist with reduced envelope, effort, and loads.
CFD evaluation occurs only after this worker exits, so these are expectations,
not claims about the new candidate.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: separate anterior wave regulation and steering from posterior lagged propulsion, and apply bounded actuator dynamics without replacing the coherent traveling-wave command
transferable_invariant: in a low-dimensional swimmer the anterior joint should retain prompt regulation of the steering oscillator while posterior actuation can carry a lagged propulsive response; response dynamics must be judged by the realized gait envelope rather than nominal command smoothness
nontransferable_details: published gains, servo time constants, dimensional beat settings, species-specific kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: preserve normalized body-frame target and moment feedback plus the existing two-joint state-feedback traveling bend; apply the history-dt-aware previous-action tracker only to the unchanged joint-2 target command and leave raw joint-1 radial and route acceleration direct
falsification: reject if capture, upstream translation, or alternating propulsion is lost or delayed, if the route develops large loops, or if arrival and distance fail to improve over the unfiltered scaffold while joint envelope, cap contact, effort, crossflow, force, and moment fail to improve over the full-filter parent
