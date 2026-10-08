# Slip-synchronous posterior half-cycle feathering

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the four sampled scores,
  observations, metrics, diagnostics, trajectories, and policies, and the
  inherited optimizer notes. Every sample is a finite capture from direct
  uniform still water with `U_infinity=(0,0,0)`, no prewarm, no cylinders, and
  no boundary interaction.
- I inspected the combined and view-specific keyframe sheets for the sampled
  v20 parent and the informative v24 target-normal-power regression, including
  the top-down mid-plane vorticity and oblique Lambda2 views from release to
  capture. Both visibly self-propel from rest, maintain a coherent alternating
  wake and compact three-dimensional posterior structures, and show no passive
  advection, wake breakup, or out-of-plane instability. Their nearly identical
  wake topology makes terminal transverse allocation, rather than propulsion
  creation, the useful control distinction.
- The assigned v20 parent is the scalar leader of the four samples at
  `18.0070T`, mean distance `1.950358L`, and score `-0.064028`, but reaches the
  capture boundary with only `0.1092` course alignment, `0.9840 rad/T` absolute
  yaw, and `0.8767U` target-normal speed. The v24 whole-wave force-power
  selector arrives slightly earlier and shortens the route, but regresses mean
  distance/score and final alignment/yaw to
  `1.950652L/-0.064407/0.0975/1.2697 rad/T`. Moving the same signal to
  positive posterior work reduces near posterior acceleration-ceiling
  residence to `62.28%`, but delays capture, widens path/cross-track, and lowers
  final alignment to `0.0855`. Selecting conserved mean-bend allocation by the
  signal tightens path/cross-track, yet retains the parent's arrival class and
  worsens final alignment/yaw. Thus another target-normal force-power
  placement is not supported.
- The parent trace exposes a more specific phase signal. Inside `2.10L`, the
  summed joint rate `phi_dot1 + phi_dot2` correlates `0.415` with
  target-normal hydrodynamic force and `0.301` with the change in target-normal
  speed four samples (`0.022T`) later. Tail motion has the same sign as
  cross-course speed in `55.2%` of near samples; over the following `0.022T`,
  target-normal speed rises by `0.01348U` on average in that subset and falls
  by `0.01204U` in the opposite subset. This supports distinguishing stroke
  half-cycles instead of treating measured power as a phase-free scalar.

## Single policy hypothesis

Preserve the evaluated v20 odd body-frame route controller, state-feedback
anterior oscillator, posterior lag and emphasis, conserved forward mean-bend
allocation, phase-consistent reserve, half-cycle steering, and
reversal-preserving rate governor. Replace only its raw yaw-times-moment
posterior-wave selector with slip-synchronous feathering. Resolve velocity
normal to the instantaneous head-to-target line, normalize the observed summed
joint rate by the nominal carrier phase rate, and reduce posterior oscillatory
excursion only while those signed signals agree during a moving, misaligned
approach. The opposite half-cycle retains full wave amplitude, as do all
far/middle actions.

The selector is continuous and reflection invariant because both
target-normal speed and summed joint rate change sign under lateral reflection.
Offline replay of the selector on the parent trace is exactly zero outside
`2.10L`; within approach it is positive on `50.6%` of samples, gives
mean/maximum relief `0.1095/0.4737`, and keeps mean/minimum posterior-wave
authority at `0.9562/0.8105`. Expected evidence is parent-class transit and
coherent wake with retained capture, but lower terminal target-normal speed,
yaw, cross-track, and posterior limit residence without the closure loss of a
phase-free load gate. Falsify the mechanism if transit actions change, capture
or distance integral regresses materially, target-normal speed is not reduced,
alignment/yaw/path do not improve together, limit residence migrates forward,
the reflected response is not reflected, or either wake view deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and half-cycle amplitude asymmetry
source_mechanism: retain the propulsive traveling rhythm while weakening only the stroke half-cycle whose lateral motion reinforces an observed lateral error
transferable_invariant: separate slow target geometry from bounded joint-state phase and apply sensory modulation to one counterproductive half-cycle without changing cadence, mean bend, or posterior lag
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: multiply normalized target-normal body speed by normalized summed joint rate, smooth-gate only their positive product inside the established approach, and use it solely to feather posterior wave excursion while preserving the opposite half-cycle and conserved mean bend
falsification: reject if pre-approach action changes, capture or distance integral worsens materially, terminal slip/alignment/yaw/path do not improve together, saturation migrates without benefit, reflection fails, or either coherent wake row deteriorates
