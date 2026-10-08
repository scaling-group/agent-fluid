# Wake Policy Candidate Notes

## Evidence diagnosis

- All four sampled solver examples are exact behavioral replications of the
  prefilled successful controller: target capture at `34.7105`, mean distance
  `1.62283L`, total/mean command energy `46985.9/1353.65`, relative-crossflow
  RMS `0.24023`, and force/moment RMS `68.96/1036.40`. Both joint speeds reach
  `4.53786` (`260 deg/time`) and both commands reach the `30.0` policy
  envelope, so replication does not resolve the remaining load and limit
  contact.
- The common prewarm sheet shows developed, interacting wakes from all four
  cylinders before release. The successful released sheet shows an immediate
  down-left redirect followed by a coherent, self-propelled upstream traverse
  through the merged wakes and direct first-crossing capture. Displacement
  `(-10.923,-4.166)L`, progress `0.93991`, mean relative flow
  `(0.1114,-0.0444)`, and monotone final/minimum distance `0.74651L` agree with
  the visible target-directed propulsion rather than passive advection.
- No sampled failure keyframe exists. The inherited failures therefore remain
  textual safety boundaries: putting bearing trend into persistent mean
  steering exited after `18.304` with negative progress, while replacing the
  carrier with a slower/smaller curvature equilibrium became unstable with
  force/moment RMS `16749.8/290421`. Preserve the carrier, raw-bearing mean
  route, base half-cycle asymmetry, and acceleration-residual interface.
- The assigned parent's direct-yaw response child preserves the same visible
  redirect-and-traverse topology and reaches slightly sooner (`34.6720`), but
  worsens mean distance to `1.62669L` and raises force/moment RMS to
  `91.30/1389.74` despite lower total energy `46711.7`. The sampled inherited
  lateral-force response child also preserves capture but regresses arrival,
  mean distance, crossflow, and force/moment RMS to
  `35.0845/1.63577L/0.24277/75.85/1146.58`. Fast heading or force response is
  therefore not interchangeable with the validated bearing-window release.
- The prefilled signed moment term withdraws optional burst only when yaw
  moment assists the requested turn. Large opposing wake moment instead leaves
  full surplus burst active, which can make the joints fight a high-load wake
  event even though persistent mean steering and base asymmetry already retain
  target authority. Its normalized evidence scale is already owned by
  `redirect_moment_scale`: `1036.40 / 64^2 = 0.253`, close to the existing
  `0.25` soft-saturation scale.

## Policy hypothesis

Replace signed assisting-moment credit with an unsigned, normalized yaw-load
release for only the optional response burst. Large `abs(moment_z_L2)` should
temporarily withdraw surplus half-cycle asymmetry whether the wake moment helps
or opposes the requested turn, while raw bearing still owns persistent mean
steering and reserve, bearing-window closure still owns maneuver response, and
joint-speed pressure still releases the coupled two-joint burst. This is one
feedback-semantic change using the existing evidence-scaled parameter, not a
carrier or gain sweep.

Expected result: retain target capture and the sharp redirect-to-upstream route
while reducing force/moment RMS or joint-limit contact. Accept a modest arrival
tradeoff only if the load reduction is meaningful; falsify if capture or route
topology is lost, arrival/mean distance materially regresses, or load and limit
evidence fails to improve.

bookshelf_consulted: true
source_domain: organized-wake adaptive swimming and sensor-modulated robotic-fish control
source_mechanism: separate persistent target steering from bounded fast hydrodynamic-load response so the swimmer does not add surplus maneuver effort while a strong wake event already dominates yaw
transferable_invariant: target geometry owns route authority, while a normalized fast body-load signal may release only optional asymmetric burst without changing the traveling-wave carrier or base steering
nontransferable_details: published gains, species-specific body waves and C-start kinematics, prescribed CPG clocks, exact vortex phase, cylinder geometry, and task-specific routes
policy_translation: preserve the two-joint carrier, raw-bearing steering, bearing-window response, and coherent speed release; replace signed assisting `moment_z_L2` credit with soft unsigned moment-pressure release of only the extra half-cycle burst
falsification: reject if target capture or route topology is lost, arrival or mean distance materially regresses, or force/moment load and limit contact do not improve enough to justify unsigned load release
