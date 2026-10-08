# Candidate diagnosis and hypothesis

## Evidence read before editing

- The four sampled solver examples are byte-identical v41 policies and
  trajectories.  Each is a direct-uniform still-water rollout with
  `U_infinity=(0,0,0)`, captures at `24.640015T` and `0.748356L`, has mean
  distance `2.347937L`, and shows the same `284` moving-window shifts.  The
  inherited assigned-parent logs add seven more identical completed captures,
  so the samples establish determinism but contain no informative failure
  keyframe.
- Both rows of the combined keyframe sheet were inspected from release through
  capture.  In the top-down row the fish self-propels rather than advecting,
  leaves a regular alternating wake on the long approach, then makes a smooth
  terminal hook into the target.  The oblique row shows compact paired
  three-dimensional Lambda2 structures shed behind the tail without visible
  spanwise blow-up.  This agrees with monotone net progress from `12.32772L`
  to capture, the inherited low peak planar load class
  (`0.0254/0.0319/0.0156`), zero sampled posterior hard-stop occupancy, and no
  instability.  The inherited informative failures are controller failures,
  not wake collapse: broad dual-joint rate barriers preserved coherent wakes
  but changed capture into a left-boundary pass, while v42 headroom transfer
  retained capture but reduced its margin and worsened score.
- The sampled trace reveals a terminal observation mismatch not resolved by
  those actuator-allocation tests.  The capture distance is measured from the
  material head, whereas v41's constant-velocity miss uses center velocity.
  At the final sample the center-to-head longitudinal lever is about `0.488L`,
  measured yaw rate is `1.887/T`, and center lateral velocity is about
  `0.655L/T`.  The head's rotational lateral term is therefore about
  `-0.92L/T`, larger than and opposite the center lateral velocity.  The
  center-velocity predictor reports `0.632L` perpendicular miss even as the
  head crosses the `0.75L` circle.  This is a geometric measurement mismatch,
  not evidence for another course gain or miss threshold.

## One policy hypothesis

Preserve v41's state-feedback traveling wave, course preview, predicted-miss
corridor, posterior stroke reserve, rate coast, and phase-selective terminal
allocation.  Change only the input to the *extra terminal residual*: estimate
the velocity of the capture point from body-center velocity plus the observed
yaw-rate contribution over an owned normalized head lever, then form the
terminal course error and miss gate from that velocity.  The existing
center-velocity course preview remains unchanged, so the established far and
middle route do not acquire a new bias.  Under lateral reflection, yaw rate,
capture-point lateral velocity, course error, and residual all reverse sign;
the scalar gates remain unchanged.

The falsifiable expectation is that terminal support releases when head
rotation already carries the capture point through the safe corridor, avoiding
an unnecessary aligned-half-cycle pulse while retaining the v41 route.  Reject
the mechanism if capture is lost, the `0.001644L` nominal crossing margin is
reduced, the pre-`2.10L` trajectory changes, or posterior hard-stop, exact-rate,
raw-command, wake-coherence, or peak-load classes regress.  A nominal gain
would still not establish held-out robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve the propulsive oscillator while a localized sensor-feedback residual corrects the controlled point's approach
transferable_invariant: terminal feedback should use the velocity of the point whose crossing defines success and should leave the established propulsive rhythm intact outside that regime
nontransferable_details: published gains, clock-driven CPG phase, species kinematics, exact vortex phase, and source-task routes
policy_translation: form a mirror-equivariant head-velocity estimate from normalized body-center velocity, observed yaw rate, and an owned normalized lever; use it only for the bounded joint-state-gated terminal residual
falsification: reject on lost capture, smaller crossing margin, any far-route change, or worse hard-stop, rate, raw-command, wake, or load class
