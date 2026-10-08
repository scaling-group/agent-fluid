# Candidate wake-policy notes

## Evidence diagnosis

- All four sampled episodes satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
- In both rows of the combined sheets, the fish translates under its own
  actuation and retains an alternating top-down street plus compact oblique
  Lambda2 structures through capture. The best finite sample
  (`solver_db2418f56ce7`) and the less effective phase-proxy sample
  (`solver_493935b907b9`) have the same visible wake topology; neither shows
  advection, wake collapse, collision, or instability before termination.
- The measured target-signed adverse-moment residual is the informative
  semantic improvement. Relative to two byte-identical bidirectional-allocation
  samples, it changes capture from `16.988T` to `16.932T`, mean distance from
  `2.08931L` to `2.08513L`, and score from `-0.204764` to `-0.200045`. The
  joint-angle phase proxy captures at `16.965T` with `2.08904L` mean distance
  and score `-0.204466`, so continued oscillation alone does not explain the
  stronger result.
- The gain is not free: the best signed-load sample raises peak force/yaw
  moment from `0.03634/0.01804` to `0.03693/0.01835`, and expands posterior
  angle use from `[-0.5362,0.5700]` to `[-0.5329,0.5992] rad`. Both speed
  peaks remain sublimit (`4.5192/4.5239 rad/T` versus `4.5379 rad/T`) and the
  acceleration outputs remain inside the physical envelope. Local flow peaks
  at only `0.03270U` while fish speed reaches `1.391U`, corroborating
  self-propulsion rather than passive drift.
- A replay of the sampled parent state shows that every posterior-to-anterior
  transfer event occurs while target-signed heading rate is adverse. This
  supplies an observed response cue that is distinct from instantaneous yaw
  load. The current residual does not use it, so it cannot release or add
  authority according to whether the body has actually begun the requested
  turn.

## Policy hypothesis

Preserve the captured target-course controller and all demonstrated envelope
mechanisms. Add one bounded response residual to posterior-to-anterior work
allocation: when posterior positive work is already removed by the narrow
speed guard, the anterior receiver is doing positive target-aligned work, and
measured heading rate still opposes the body-frame turn request, offer a small
additional fraction of that unavailable work. Smoothly release this addition
as wrong-way yaw vanishes. This changes neither nominal curvature nor carrier
gain and cannot create work without a phase-separated donor and receiver.

Expected result: retain capture, alternating shedding, and zero speed-limit
occupancy while improving arrival or mean distance beyond the signed-moment
parent. Reject the mechanism if it loses capture, fails to produce a distinct
trajectory, restores a speed/angle stop, exceeds the parent's
`0.03693/0.01835` force/moment envelope, expands posterior angle beyond
`0.5992 rad`, or cannot improve the `16.932T`, `2.08513L` route.

bookshelf_consulted: true
source_domain: biological C-start release and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: bounded asymmetric corrective work is sustained only while observed direction error and turn response remain adverse, then released into the rhythmic gait
transferable_invariant: corrective authority should depend on both target-relative error and measured response, with continuous release on alignment
nontransferable_details: species maneuvers, published CPG gains, dimensional yaw rates, full-body kinematics, exact beat phase, and task routes
policy_translation: normalize heading rate by a parameter-owned per-T scale and add a smooth wrong-way-response fraction only to speed-blocked posterior work already eligible for the target-aligned anterior receiver
falsification: reject if capture or coherent shedding is lost, the rollout is unchanged, any hard-stop occupancy returns, or route, load, and posterior-angle bounds worsen relative to the signed-moment parent
