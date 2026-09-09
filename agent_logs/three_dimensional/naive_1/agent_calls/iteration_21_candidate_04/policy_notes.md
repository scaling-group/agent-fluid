# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled rollouts satisfy the frozen direct-uniform still-water
contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
dynamics, and `termination=capture`. I inspected both rows of every combined
keyframe sheet and compared them with the assigned parent's newly completed
failure. The sampled top-down rows show genuine self-propulsion and coherent,
target-directed alternating streets; the oblique rows retain compact caudal
Lambda2 structures through capture. The two geometry-scheduled parent
executables capture at `18.6505--18.6835T`, with scored mean distance
`2.09340--2.09405L` and scores `-0.20606-- -0.20578`.

The sampled half-cycle envelope-redistribution executable also retains both
wake views and captures twice, at `18.8265--18.8815T`, with lower mean distance
`2.08855--2.08896L`. Its rate and acceleration contact remains in the parent
band, so those captures do not establish demand relief. More importantly, the
assigned parent's just-completed executable-equivalent replication misses at
`1.23864L`, then exits left at `32.868T` and `9.94898L` final distance. The
inherited logs contain another executable-equivalent miss at `0.81206L` and
left exit at `34.232T`. Thus the apparent mean-distance lead has two captures
and two coherent-wake misses and is not a repeatable improvement.

The failure sheet separates route loss from propulsion loss. Its alternating
top-down street and caudal 3D structures remain energetic while the fish bends
down past the target. Reconstructed body-frame geometry shows lateral target
fraction rising to `0.789` at `18T`; after the pass, the target becomes
rearward and the lateral fraction decays from `0.484` at `24T` to `0.100` at
`28T`. The existing lateral-only route request therefore releases toward zero
even though recovery still requires a sustained turn. Lower rate contact in
the failed rollout is not useful relief because capture is lost. A previously
tested bounded rearward reserve also missed at `0.85155L`, so another reserve
gain is not justified.

## Single-candidate policy hypothesis

Preserve the assigned geometry-scheduled carrier: displacement-only
half-cycle curvature steering, target-owned sign, one-sided correcting-yaw
release, differential mean-curvature shares, anterior amplitude relief,
posterior lag, and exact acceleration projection. Replace only the route
geometry with a signed full body-frame bearing computed from normalized
forward and lateral target components. The route remains bounded by the same
`tanh` and scale. For a target ahead this is the small-angle continuation of
the parent's direction-cosine request; after a miss it retains a large signed
bearing as the target moves rearward, instead of multiplying recovery
authority by a vanishing lateral cosine. A continuous astern regularizer uses
the same bearing scale to make the request exactly zero only at the ambiguous
directly-astern direction, preserving left/right reflection symmetry without
adding a second recovery gain.

This is a feedback-structure test rather than scalar-only tuning. Formal CFD
occurs only after this worker exits. Falsify it if target-ahead capture leaves
the established route/wake band, if a near-astern bearing branch chatters or
reverses unproductively, if a miss still decays into the same left-domain
topology, or if action/rate contact or planar loads enter a worse class.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and classical target-vector-to-mean-curvature steering
source_mechanism: sensed signed target bearing drives bounded mean curvature while a coupled traveling rhythm remains organized
transferable_invariant: preserve the propulsive oscillator and map the full normalized body-frame target direction, rather than only lateral magnitude, to a bounded persistent turn request
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, clock phase, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: compute a reflection-symmetric signed bearing from normalized forward and lateral `target_body_L` components, regularize only the directly-astern ambiguity, pass it through the inherited bounded route map, and leave the two-joint carrier, curvature allocation, response release, and action projection unchanged
falsification: reject if capture or either coherent wake view is lost, target-ahead route metrics regress outside repeat variability, near-astern sign switching chatters, post-miss curvature still decays into left exit, or saturation and planar loads materially worsen
