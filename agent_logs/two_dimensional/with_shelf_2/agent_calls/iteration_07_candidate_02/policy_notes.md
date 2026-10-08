# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while four developed cylinder streets merge across the target
  corridor. It is an initial-condition control, not candidate-specific credit.
- The inherited posterior-curvature failure is actively self-propelled: it
  travels `-10.51L` upstream and has comparatively low force/moment RMS
  (`116/1278`). Its released sheet nevertheless shows a broad pass above the
  target, a hook into a near-vertical posture, and upper-domain exit at
  `84.22`; its `2.43L` minimum and `6.64L` mean distance and `+1.80L` lateral
  displacement confirm that low load alone does not provide route control.
- The four current samples are functionally the same yaw-gated distributed
  half-cycle controller (their Julia differences are comments only). All four
  reproduce the same continuous diagonal wake-entry path and exactly the same
  target capture at `51.47`, final/minimum distance `0.748L`, mean distance
  `1.820L`, and head displacement `-11.28/-4.94L`. This is strong same-seed
  materialization evidence, but not robustness evidence across wake phase,
  inflow, geometry, or target changes.
- The success still reaches both `4.5379 rad/time` joint-speed hard caps;
  maximum accelerations remain close to the candidate soft limit at
  `28.79/28.14 rad/time^2`, with force/moment RMS `426/4084`. The inherited
  ungated heading-response controller had still higher loads (`487/4680`) and
  folded into a lower exit after approaching to `1.65L`, so increasing its
  steering or propulsion gains is not supported.

## Candidate hypothesis

Retain the repeatedly successful normalized body-frame route controller
unchanged: a zero-centered state-feedback traveling bend, heading-response
half-cycle steering distributed over both joints, and an absolute normalized
yaw-moment gate acting only on that steering residual. Add one mechanism after
the smooth acceleration command is formed: a joint-state barrier that smoothly
attenuates only acceleration with the same sign as an already-near-limit joint
velocity. Opposing acceleration, which brakes the joint, and all low-speed
propulsion and steering remain available.

This tests whether avoiding repeated hard speed clipping can reduce load and
cap contact without changing the successful route topology. It is not a scalar
gain sweep: the new response depends on joint state and acceleration direction.
The next CFD rollout falsifies it if `target_reached` is lost, arrival or mean
distance materially regress from `51.47`/`1.820L`, either boundary-exit
topology returns, or cap/load evidence does not improve. Because current
compact evidence has no sign-resolved hydrodynamic events, this candidate does
not add signed moment or crossflow rejection.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and efficient-swimming actuator guardrails
source_mechanism: preserve the rhythmic propulsion command while bounded joint-state feedback reserves deceleration authority near the actuator envelope
transferable_invariant: near a joint-speed boundary, attenuate only acceleration that increases speed while leaving opposite-sign braking and the low-speed traveling wave available
nontransferable_details: published gains, dimensional speed limits, species-specific kinematics, robotic CPG topology, exact vortex phases, and task-specific routes
policy_translation: apply a smooth outward-only speed barrier independently to the two final joint-acceleration commands using observed phi_dot and candidate-owned thresholds
falsification: reject if capture or useful diagonal progress is lost, arrival and mean distance regress, the speed caps remain active, or loads fail to improve
