# Wake-policy candidate diagnosis

## Evidence read before the edit

- The sole sampled parent is the transferred 2D champion
  `solver_e1a03f18d808`. Its rollout is a valid direct-uniform still-water
  experiment (`U_infinity=(0,0,0)`, no prewarm and no cylinders), so its motion
  is not imposed advection. There are no inherited optimizer notes and no
  second sampled solver; the useful comparison is therefore the parent's
  finite closest-approach phase versus its later failure phase.
- Both rows of `wake_keyframes.jpg` were inspected. The top-down row shows a
  regular alternating vortex train and substantial translation from release
  through `t*=16`, while the target distance falls from `12.328L` to its
  `4.780L` minimum at `t*=17.853`. The oblique Lambda2 row confirms compact
  three-dimensional structures shed behind the moving body rather than a
  quiescent or prewarmed-flow artifact. The carrier is therefore worth
  preserving.
- The failure is trajectory control, not numerical instability: after the
  closest approach the target stays far off the instantaneous body axis, the
  distance rises to `9.709L`, and the fish exits through the lower virtual
  boundary at `t*=27.495` with center `(12.187,0.798)L`. At closest approach
  the head is `(13.359,7.539)L`, already below the target, with velocity
  `(-0.330,-0.735)U`; the subsequent keyframes show continued downward travel
  instead of a route reversal.
- The trajectory also exposes an authority mismatch hidden by the coherent
  wake: 74.0% of raw joint-acceleration components exceed the
  `1800 deg/T^2` envelope, 11.9% of joint-velocity samples are within 1% of
  the `260 deg/T` limit, and neither joint approaches the 45-degree angle
  limit. The copied `0.55T`, 28-degree oscillator is consequently shaped by
  hard acceleration/velocity clipping. Its rapid body-yaw oscillation and
  clipped follower leave little clean cycle-mean authority for correction.
  Local-flow magnitude remains at most `0.0257U` while body speed reaches
  `0.8695U`, supporting the self-propulsion diagnosis.

## Candidate hypothesis

Preserve the state-feedback traveling-bend carrier and posterior lag, but
operate its cruise target below the measured acceleration and velocity
envelopes. Add one state-gated redirect primitive: only when closing progress
is lost while the target is materially off-axis, continuously reduce carrier
cadence and add a symmetric cycle-mean tail-curvature request in the existing
turn direction. Release the redirect as closing progress and alignment
recover. Smoothly bound final acceleration commands below the evaluator's hard
limit so steering is tested through the intended feedback law rather than
through opaque clipping.

Expected evidence is an earlier upward route reversal after the target crosses
off-axis, lower hard-limit exposure, continued coherent posterior wake, and a
better termination class or smaller final distance. Falsify the hypothesis if
the wake loses propulsive coherence, closest approach worsens materially, raw
route topology is unchanged, or the progress-loss gate merely prolongs the
same lower-boundary exit.

bookshelf_consulted: true
source_domain: Closed-loop robotic-fish CPG direction tracking and cycle-averaged turning models.
source_mechanism: Sensor feedback modulates oscillator offset or beat asymmetry so route-scale steering changes cycle-mean curvature without replacing the propulsive rhythm.
transferable_invariant: Persistent target error should receive bounded cycle-mean curvature authority, while the fast joint-state oscillator remains responsible for phase and propulsion.
nontransferable_details: Published robot gains, motor dynamics, species kinematics, dimensional cadence, duty ratios, exact vortex phase, and source-task routes.
policy_translation: Use normalized body-frame target angle plus normalized closing speed to gate drive relief and an equal-sign mean-curvature increment through the existing two-joint state-feedback contract.
falsification: Reject the transfer if it destroys the coherent wake or fails to reverse the receding off-axis trajectory before virtual-domain exit.
