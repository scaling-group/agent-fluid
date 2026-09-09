# Wake Policy Candidate Notes

## Evidence diagnosis

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. All sampled candidates inherit
  this same initial flow, so it is not controller-specific evidence.
- All four sampled released sheets reproduce the same useful topology and
  metrics: an immediate down-left targetward redirect, a coherent posterior
  wave during a long self-propelled upstream traverse, and direct first entry
  into the `0.75L` capture circle at `34.7105`. Mean distance is `1.62283L`,
  total/mean command energy is `46985.9/1353.65`, and relative-crossflow,
  force, and moment RMS are `0.24023`, `68.96`, and `1036.40`. Head displacement
  `(-10.923,-4.166)L` despite mean local flow `(-0.2018,-0.1721)` corroborates
  active propulsion rather than passive wake advection.
- Both sampled joint speeds reach the configured `260 deg/time` limit and both
  accelerations reach the `30.0` envelope. The existing joint-speed reflex
  therefore improves but does not eliminate actuator-limit overlap during the
  conspicuous initial redirect and sustained high-amplitude wave.
- The inherited direct-heading-response child preserves capture and the same
  visible route, arriving only `0.0385` earlier and lowering total/mean effort
  to `46711.7/1347.25`, but mean distance worsens to `1.62669L` and force/moment
  RMS jump to `91.30/1389.74` while both limits remain touched. Direct heading
  rate is therefore not an evidenced replacement for bearing-window response
  when the purpose is unloading the optional burst.
- No sampled failure keyframe exists in this workspace. The available failure
  boundary is inherited textual evidence: putting bearing trend into persistent
  mean steering exited after `18.304` with negative progress, and replacing the
  established carrier with a slower/smaller curvature carrier became unstable
  with force/moment RMS `16749.8/290421`. Persistent raw-bearing route control,
  the traveling-bend carrier, base asymmetry, and the acceleration-residual
  interface should remain intact.

## Policy hypothesis

Add one coherent previous-command headroom reflex to the optional redirect
burst. Normalize the largest absolute previous joint-acceleration command by
the policy-owned acceleration envelope; above a soft near-envelope onset,
smoothly release only the extra response-gated half-cycle asymmetry on both
joints. Combine this with the existing joint-speed release as bounded evidence
that the coupled carrier is approaching its actuation envelope. Do not change
the carrier, bearing-window response, signed assisting-moment response, mean
steering, reserve, course-slip correction, or base half-cycle asymmetry.

Expected result: preserve target capture and the redirect/upstream topology
while reducing overlap between optional burst authority and saturated commands,
thereby lowering force/moment or limit contact without the load penalty of the
direct-heading-response child. Falsify the mechanism if capture is lost, route
or mean distance materially regresses, or later diagnostics show no meaningful
load/limit benefit relative to the sampled `34.7105` baseline.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: strong bounded redirect modulation is released by observed maneuver or actuator response while the rhythmic propulsive carrier remains intact
transferable_invariant: preserve propulsion and persistent route ownership, and use bounded observed-state feedback to withdraw only surplus transient turning authority as the coupled actuator response approaches its envelope
nontransferable_details: published gains, species-specific C-start kinematics, robot morphology, clocked CPG phase, dimensional frequencies, exact vortex phase, and task-specific routes
policy_translation: use the maximum normalized previous two-joint acceleration command as one coherent headroom signal that releases only the extra bearing-response burst; retain normalized body-frame bearing, joint-state phase, signed moment response, base asymmetry, and the two-acceleration contract
falsification: reject if target reach or coherent upstream propulsion is lost, or if arrival/mean distance regresses without a meaningful reduction in force, moment, or actuator-limit contact
