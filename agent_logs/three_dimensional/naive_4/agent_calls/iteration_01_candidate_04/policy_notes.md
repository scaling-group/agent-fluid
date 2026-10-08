# Candidate wake-policy diagnosis

## Evidence scope

- The assigned parent and sampled guidance contain no completed optimizer
  descendants or inherited candidate notes. The sole sampled rollout,
  `solver_064577d12113`, is therefore both the strongest finite example and the
  informative failure available for this first architecture proposal.
- Its diagnostics confirm the required `uniform_direct` initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and no numerical instability.
  The current candidate will be evaluated only after this worker exits, so no
  outcome is claimed for it here.

## Visual diagnosis

- The top-down sheet shows a coherent alternating posterior wake growing from
  release through 8T, and the oblique Lambda2 sheet confirms a genuinely 3D
  self-generated wake. The motion is not background advection: local flow is
  initially zero and remains small (about 0.02U in either component at exit)
  compared with the fish's roughly 0.57U upward velocity.
- The carrier first makes useful leftward progress. It is visually aligned
  with the target near 4T and reaches its best distance, 12.078L, near 6.36T.
  It then yaws across the target line, develops a large upward component, and
  exits the upper virtual boundary at 8.547T. Final distance is 12.380L versus
  12.328L initially.
- The trajectory corroborates the overshoot: reconstructed body-frame bearing
  changes from about +0.12 rad at 2T to approximately zero at 4T and -0.62 rad
  by 8T, while dimensionless heading rate oscillates to roughly +/-1.7. Joint
  angles remain below about 26.6 degrees, but raw accelerations reach about
  60/75 rad/T^2, above the 31.4 rad/T^2 actuator envelope. The useful mechanism
  is thus the lagged traveling bend; the missing mechanism is bounded target
  steering with explicit overshoot suppression and protected authority.

## Policy hypothesis

Retain the seed's state-feedback oscillator and posterior lag, but center both
joint rhythms on a small bounded curvature bias driven by body-frame bearing.
Project bearing over a short horizon using the observed bearing-window rate so
the bias releases and reverses before another centerline overshoot. Clamp the
returned accelerations at the known envelope; because a shifted oscillator is
clipped asymmetrically, the target-dependent mean bend retains authority even
when the propulsive carrier alone would saturate. No time, world coordinate,
target identity, or route is introduced.

The existing matched-kinematics audit states that a positive common joint bias
produces negative yaw. Here a positive body-frame bearing calls for that
negative-yaw response, so the bounded bias uses the same sign as bearing; this
sign choice is still subject to the rollout falsification below.

Expected evidence: the wake should remain alternating and posterior-dominant,
but bearing should remain near zero after the first alignment, upward velocity
should not grow into boundary exit, and distance should continue below the
seed's 12.078L minimum. Falsify the architecture if it repeats the upper exit,
reverses the initial correct steering sign, destroys the coherent wake, or
merely trades yaw for persistent joint/acceleration saturation.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and two-joint mean-curvature turning
source_mechanism: sensor-driven bounded mean bend superposed on a propulsive rhythm
transferable_invariant: persistent body-frame target error should bias curvature while the posterior-lagged traveling bend continues to generate thrust
nontransferable_details: published gains, clocked CPG phases, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: use bounded bearing plus observed bearing-window rate to shift the two joint-state oscillator centers within the existing acceleration contract
falsification: reject if target progress and boundary survival do not improve together, or if steering erases the coherent posterior wake or increases saturation
