# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets, with the target inside the
  merged second-row wake. This is the common release condition and not a
  candidate-specific advantage.
- Every sampled released sheet is a finite target reach; no sampled semantic
  failure sheet is available. The sheets show a sharp targetward redirect,
  then a coherent posterior trail and sustained leftward swimming through the
  interacting wakes into the `0.75L` capture circle. Head displacement near
  `-10.92L` in x and mean fish velocity near `-0.31U`, compared with mean local
  x flow near `-0.20U`, show active propulsion rather than passive advection.
  The inherited bearing-trend residual that exited right after `18.304` with
  negative progress remains the relevant failure boundary: fast wake or
  response signals must not own persistent route steering.
- Three sampled copies of the coherent whole-carrier speed release reproduce
  exactly `34.7105` arrival, `1.62283L` mean distance, `46985.9/1353.65`
  total/mean command energy, `0.24023` RMS relative crossflow, and
  `68.96/1036.40` RMS force/moment. The actuator-local sibling retains the same
  visible route but regresses all of those comparisons except mean effort:
  `34.8590`, `1.62681L`, `47176.8/1353.36`, `0.24086`, and
  `74.24/1105.81`. This supports one shared release for the coupled traveling
  bend, not independent per-joint burst withdrawal.
- Inherited logs provide a second negative boundary. Adding previous-command
  envelope pressure to the coherent speed release still captures, but regresses
  arrival/mean distance to `35.1285/1.64127L`, total energy to `47457.0`,
  crossflow to `0.24265`, and force/moment to `71.47/1078.27`. Acceleration
  occupancy is therefore not an earned second release signal. The best parent
  already reaches both the `30.0` command envelope and the joint-speed limit,
  while its maximum joint angles remain below the hard angle limit; another
  magnitude-only saturation gate is not justified.

## Candidate policy hypothesis

Preserve the reproduced carrier, posterior lag, raw-bearing mean steering and
reserve, course-slip correction, assisting-sign yaw credit, base half-cycle
asymmetry, and coherent max-speed burst release. Add one wake-assistance credit:
normalized body-frame lateral force may partially relieve only the optional
response burst when its sign agrees with the persistent raw-bearing turn. The
force credit is capped, composed only into response credit not route authority,
and cannot remove the carrier, mean steering, reserve, or base asymmetry.

The observed force scale is about `68.96 / 64 = 1.08` after the contract's body
length normalization, so the new soft scale is order one and its maximum
additional credit is deliberately partial. The mechanism tests whether useful
wake-induced lateral impulse can replace a small amount of surplus active turn
without treating all crossflow as a disturbance. Expected later evidence is
target capture with the same redirect/upstream topology and lower effort or
force/moment without a material arrival or mean-distance regression. Reject it
if capture or coherent leftward propulsion is lost, if arrival/route regress
without a load or effort benefit, or if assisting lateral force proves to have
the wrong sign/lag in a changed wake phase. No same-worker CFD improvement is
claimed.

bookshelf_consulted: true
source_domain: Karman-wake fish interaction and sensor-modulated robotic-fish adaptive control
source_mechanism: preserve rhythmic self-propulsion and route control while useful wake-induced lateral response can replace only surplus maneuver effort
transferable_invariant: an environmental response earns bounded control credit only when its body-frame sign assists persistent target error; it must never replace the propulsive carrier or slow route authority
nontransferable_details: trout muscle timing, robot morphology, published gains, dimensional force scales, exact vortex phases, single-cylinder synchronization, species kinematics, and source-task routes
policy_translation: qualify normalized `force_body_L[2]` by smooth raw-bearing sign and add a capped force-assistance credit only to the existing optional response-burst release; retain coordinated two-joint speed pressure, signed yaw credit, mean steering, reserve, base asymmetry, and both joint-state carriers
falsification: reject if capture or coherent upstream propulsion is lost, or if route and arrival regress without lower effort or force/moment; a changed wake phase must preserve the assistance sign before any robustness claim
