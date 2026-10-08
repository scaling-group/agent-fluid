# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts are valid direct-uniform still-water evaluations:
  `U_infinity=0`, no prewarm, no cylinders, and capture termination. The
  combined sheets show self-propelled motion rather than advection. In both the
  top-down vorticity row and oblique Lambda2 row, the v24 baseline and the three
  posterior/yaw variants retain the same coherent alternating three-dimensional
  wake and late target-directed arc. Visual differences are too small to rank;
  the trajectory and load histories must decide among them.
- The prefilled v24 course-residual brake (`solver_8ce1bc88a53c`) captures at
  `23.8315T` with mean distance `2.434073L`. Inside `3L`, it carries mean/peak
  absolute yaw `1.684/3.208 rad/T`, mean absolute target-transverse speed
  `0.2393U`, mean absolute lateral force `0.011795`, and mean absolute yaw moment
  `0.006402`.
- Selecting dissipative curvature direction from carrier-rejected yaw
  (`solver_ceb6585a8076`) still captures but arrives at `23.8535T` and leaves
  the same terminal topology and nearly the same mean yaw/load. The assigned
  parent's inherited hard course/yaw consensus result likewise captures later
  at about `23.859T` with no material terminal cleanup. Another cue sign gate is
  therefore not the missing actuator mechanism.
- Relieving only the yaw-supporting posterior half-cycle
  (`solver_3b8f345c391b`) preserves capture and wake coherence and improves all
  four terminal means: yaw `1.606 rad/T`, target-transverse speed `0.2335U`,
  lateral force `0.011351`, and yaw moment `0.006137`; peak yaw falls to
  `3.063 rad/T`. Its capture is later at `23.8755T`, so the relief acts in the
  desired direction but removes useful posterior drive too often.
- Adding a posterior counter-tangent only when yaw moment reinforces excess yaw
  (`solver_28bce98206ce`) retains the v24 arrival and gives the best sampled
  score/mean distance (`-0.535298`, `2.433642L`), establishing normalized moment
  as a useful admission signal. It does not clean the turn: target-transverse
  speed rises to `0.2449U`, peak yaw to `3.264 rad/T`, and peak moment to
  `0.014385`. Moment selection cannot make the extra tangent a load remedy.

## Policy hypothesis

Preserve v24's state-feedback oscillator, C-bend redirect/release, continuous
target-course terminal bend, and smooth component-wise command projection.
Use the successful amplitude coordinate from `solver_3b8f345c391b`, but admit
posterior half-cycle relief only when (1) carrier-rejected yaw is excessive,
(2) the observed tail side supports that yaw, and (3) normalized yaw moment
reinforces it. Naturally braking moment phases and the opposite posterior stroke
remain untouched. This is a new load-selective stroke-asymmetry mechanism, not
a scalar-only gain change.

The candidate is falsified if it loses capture or coherent wake structure, if
arrival/mean distance regress beyond the always-relieved variant, or if terminal
yaw, transverse speed, lateral force, yaw moment, joint-speed exposure, and
command exposure do not improve jointly relative to v24-scale progress. The
post-worker CFD evaluation is not yet evidence and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish asymmetric flapping and wake-load rejection
source_mechanism: sensor-conditioned half-cycle amplitude asymmetry separates a bounded steering or damping action from the propulsive carrier
transferable_invariant: change only the stroke that reinforces undesired turning, and use fast load feedback for admission rather than for target-route direction
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, exact vortex phase, and source-task trajectories
policy_translation: retain body-frame target-course curvature; infer excess-yaw direction from carrier-rejected heading rate, infer stroke side from the two observed joint states, and attenuate only the posterior oscillatory target when normalized yaw moment reinforces that yaw
falsification: reject if capture or wake coherence regresses, useful arrival is not retained, or terminal yaw, transverse motion, loads, and actuator exposure fail to improve together
