# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent guidance is `optimizer_ac762b97e357`. Its inherited
  result and all four sampled solver examples terminate in nominal capture at
  `0.745621L` and `16.610T`, with score `-0.115560`. The four candidate files,
  combined keyframe sheets, and detailed traces are byte-identical. This is
  useful repeatability evidence for the nominal direct-uniform still-water
  case, but it is not independent pose/flow robustness evidence. No sampled
  failure keyframe exists in this workspace; the strongest available failure
  comparison is therefore the inherited `2.169L` phase-selective upper-exit
  miss summarized in `guidance/control_experience.md`.
- `wake_observation.md` and `wake_diagnostics.json` confirm direct uniform
  initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, 236
  moving-window shifts, and a finite capture. The score diagnostics give a
  `1.999656L` scored distance integral and `0.16610` elapsed fraction.
- In the top-down sheet, the fish is self-propelled rather than advected: a
  coherent alternating street grows behind the tail from release through
  capture, while the head advances toward the target. The body and near wake
  remain strongly laterally oscillatory at the final crossing. The oblique
  sheet shows connected tail-shed Lambda2 structures and a visibly wavy path,
  without wake breakup or instability immediately before capture.
- The trace agrees with the images: peak planar force/moment are bounded at
  about `0.03583/0.01776`, but at least one acceleration is within 5% of its
  limit for `73.91%` of samples and at least one joint speed is within 1% of
  its limit for `27.42%`. At capture the speed magnitude is about `1.13U`, the
  posterior speed is still near its clamp, and the fish has substantial beat-
  synchronous yaw. This argues against adding carrier amplitude, curvature,
  or a terminal drive-relief mode.
- A zero-intercept regression on the completed trace inside `6L` gives
  `velocity_body_y = -0.7153*q1 - 0.1314*q1_dot + residual`, explaining
  `99.80%` of body-lateral velocity variance with residual RMS `0.0222U`.
  Inside `3L`, the coefficients remain `-0.7264/-0.1325` with `99.71%`
  explained variance. Thus the current instantaneous velocity-course and
  relative-crossflow channels are dominated near the target by the carrier's
  own phase, just as raw short-window yaw was before the successful yaw
  demodulator.

## Policy hypothesis

Keep the full traveling-wave carrier, raw-course anterior center, centered-
coordinate yaw demodulator, posterior half-cycle steering, and completed
speed-boundary projection unchanged. Add one approach-gated lateral-phase
observer after the raw anterior center is known: reconstruct carrier sway from
`q1_carrier` and `q1_dot`, subtract it from body-lateral velocity, and add it
to relative crossflow. Use those two residual lateral signals only in the
posterior course, slip, and half-cycle-response calculations. The gate begins
at the already owned `6.5L` approach boundary and becomes full at `3L`, where
the regression is stable; far-route behavior and the anterior carrier remain
the parent's behavior.

Expected result: the posterior controller should stop interpreting rhythmic
self-sway as alternating route error, retain the connected wake and nominal
capture, and reduce path waviness or arrival/distance integral without raising
joint contact or loads. Falsify the mechanism if capture is lost or delayed,
the target arc or wake disconnects, the residual still correlates strongly
with carrier phase, or saturation, force, or moment worsens.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and wake-disturbance residual control
source_mechanism: separate slow target-direction feedback from fast rhythmic locomotor response before applying a bounded residual correction
transferable_invariant: internally generated beat motion should not be treated as persistent body-frame route or disturbance error
nontransferable_details: published CPG gains, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: on approach, estimate body-lateral carrier sway from centered anterior joint angle and velocity; use phase-demodulated body velocity and relative crossflow in posterior course and flow feedback while preserving the full carrier and raw anterior course center
falsification: reject if nominal capture, arrival, distance integral, connected wake, joint history, saturation, force, or moment worsens, or if the residual remains carrier-correlated
