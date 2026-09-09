# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed interacting cylinder wakes. The released sheets all start
  from that common state, so it is an initial condition rather than evidence
  for a particular policy.
- All four sampled policies reach the `0.75L` target circle. Their sheets show
  the same sharp initial redirect, coherent posterior trail, and sustained
  leftward traverse through the interacting streets. Head displacement near
  `(-10.92,-4.2)L` while mean local flow is about `(-0.20,-0.17)U` supports
  active upstream propulsion rather than passive advection. No sampled
  semantic-failure sheet exists; the applicable inherited failure boundary is
  the predictive-bearing controller that put fast response into persistent
  route steering and exited after `18.304` with negative progress.
- The strongest sampled common-release controller is reproduced twice and
  reaches in `34.7105`, with `1.62283L` mean distance, `46986/1353.65`
  total/mean command energy, `0.24023` RMS relative crossflow, and
  `68.96/1036.40` force/moment RMS. It retains the established carrier, mean
  raw-bearing steering, base asymmetry, and a common burst release driven by
  the maximum normalized speed of either joint.
- The assigned parent differs structurally by making that speed release local
  to each joint. It preserves the visible route and capture but regresses
  arrival to `34.8590`, mean distance to `1.62681L`, total effort to `47177`,
  crossflow to `0.24086`, and force/moment RMS to `74.24/1105.81`. Independent
  release therefore does not isolate a useful partner-joint burst in this
  shared wake; the common response is the evidenced coordination boundary.
- Both the common and local versions still touch the joint-speed and `30.0`
  acceleration limits. This leaves a direct, normalized actuation-response
  signal untested: recent command pressure at the owned acceleration envelope.

## Policy hypothesis

Restore the sampled common max-speed release, then add one compatible
limit-aware mechanism. Normalize the maximum absolute previous two-joint
command by the policy-owned acceleration envelope and smoothly release only a
bounded share of the optional response burst as that common pressure approaches
the envelope. Combine command and speed pressure as bounded complementary
release, so neither can remove the base half-cycle asymmetry, persistent mean
steering, reserve, or propulsive carrier. This tests whether high command
occupancy identifies surplus burst/carrier competition earlier than joint
speed alone while preserving the cross-joint coordination favored by the
parent comparison.

The later CFD rollout falsifies the candidate if capture or coherent upstream
propulsion is lost, if arrival/mean distance regress without a meaningful
effort or load reduction, or if command pressure merely suppresses useful
redirect authority while speed and acceleration limits remain touched. A
changed wake phase is still required before any robustness claim.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological burst redirect
source_mechanism: preserve rhythmic propulsion and persistent route control while observed actuator response continuously releases surplus transient turning modulation
transferable_invariant: fast bounded response feedback may unload only optional maneuver authority; it must not erase the propulsive rhythm, coordinated two-joint response, or slow target-directed steering
nontransferable_details: published gains, dimensional actuator thresholds, robot morphology, species-specific burst kinematics, exact vortex phase, single-cylinder synchronization, and task-specific routes
policy_translation: use the maximum absolute previous two-joint acceleration command normalized by the policy-owned envelope, together with common normalized joint-speed pressure, to attenuate only the extra body-frame bearing-response half-cycle burst
falsification: reject if capture or upstream propulsion is lost, or if arrival and route regress without lower effort/load and reduced limit pressure; changed-wake evidence is required for robustness
