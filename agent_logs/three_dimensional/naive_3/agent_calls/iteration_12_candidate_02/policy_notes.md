# Line-of-sight-rate lead candidate

## Evidence and visual diagnosis

- All four sampled episodes and the assigned-parent rollouts report direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. Their top-down vorticity and oblique Lambda2 rows therefore
  show controller-driven motion: an alternating three-dimensional wake remains
  coherent while the fish translates, rather than ambient advection.
- The sampled policies all repeat a high pass and upper-boundary hook. The
  distance-conditioned hold reaches `3.592L`; full-quadrant held or
  yaw-gated redirects reach `2.999L` and `2.989L`; anterior half-cycle
  stiffness shaping worsens closest approach to `4.859L`. The visual sheets
  show that simply retaining an alternating wake is insufficient when the
  steering primitive either settles toward a held bend or disturbs the
  established approach.
- The inherited velocity-course controller is the useful semantic break. With
  the same zero-centered carrier and posterior mean curvature, it reaches
  `0.903L` while the latest sign-corrected counterstroke variant reaches
  `0.909L`; both retain alternating wakes and then leave the domain. Flipping
  which posterior half-cycle is attenuated changes closest approach by only
  `0.006L`, so posterior counterstroke relief is not the missing terminal
  authority in either sign.
- In the latest inherited trace, distance falls from `2.042L` at `17.0T` to
  the `0.909L` minimum near `18.88T`. Over that interval instantaneous
  velocity-course error changes with the beat, including a wrong-sign sample
  near `2.46L`, while inertial target line-of-sight rate reconstructed as
  recent yaw rate minus windowed body-frame bearing rate remains mostly
  positive and grows from about `0.17` to `0.86 rad/T`. The target is visibly
  still ahead at the start of this growth, so this is an observable terminal
  collision-course error rather than a post-pass route label.

## Policy hypothesis

Restore the inherited speed-gated full-quadrant velocity-course controller and
remove terminal posterior counterstroke attenuation. Add one bounded
proportional-navigation-like residual: inside a normalized near-target gate,
while the target is in the front quadrant and motion is still target-closing,
subtract a saturated estimate of inertial line-of-sight rate from the course
steering signal. Recent yaw minus windowed bearing rate cancels most beat-scale
body rotation and keeps the requested posterior mean curvature signed
consistently when instantaneous velocity course briefly flips. The
zero-centered anterior oscillator, posterior lag, curvature cap, and broad
approach remain unchanged.

The mechanism should leave the trajectory exactly unchanged outside the
near-target gate, retain the alternating wake, and bend the final approach
through the `0.75L` circle without increasing the curvature cap. Falsify it if
it changes the approach above `3.5L`, loses wake coherence, materially raises
limit occupancy, fails to improve on the `0.903--0.909L` inherited near miss,
or responds to the rear-quadrant bearing fold after the pass.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal target capture
source_mechanism: observed line-of-sight-rate feedback layered on a propulsive joint-state oscillator
transferable_invariant: preserve the traveling propulsive rhythm and add bounded corrective work when the target line of sight persistently rotates during a closing approach
nontransferable_details: published navigation gains, robot linkage dynamics, clock phase, species kinematics, dimensional switch distances, exact vortex phases, and task-specific routes
policy_translation: reconstruct inertial line-of-sight rate from reflection-equivariant recent yaw minus windowed body-frame bearing rate, then blend its bounded sign into velocity-course steering only while close, front-quadrant, and target-closing
falsification: reject if broad approach changes, beat-scale cancellation fails, the alternating wake or actuator reserve degrades, or closest distance does not improve below the inherited 0.903L near miss
