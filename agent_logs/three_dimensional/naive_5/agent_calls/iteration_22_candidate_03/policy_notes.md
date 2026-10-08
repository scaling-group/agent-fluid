# Coordinated soft-envelope replication candidate

## Evidence diagnosis

All four sampled observations report direct uniform still-water initialization
with `U_infinity=0`. Three sampled policies reproduce the assigned parent
byte-for-byte: capture occurs at `27.577T` and `0.749366L`, with no angle or
speed contact, but `1686/10028` joint-action samples reach the policy's
`30 rad/T^2` clamp. Their identical combined sheets show a self-propelled fish,
a coherent alternating mid-plane wake, and a connected oblique 3D vortex train
through capture; the actuator clipping is therefore a control-envelope defect,
not evidence of lost propulsion.

The informative contrast is the one sampled common-envelope descendant. It
preserves both visual wake signatures and the target-directed route topology,
while reaching `10.462/6.232/1.896L` at `8/16/24T` versus the parent's
`10.712/6.714/2.436L`. It captures at `26.296T` and `0.749242L`, removes all
acceleration-clamp samples, retains zero angle and speed contacts, lowers mean
distance from `2.613L` to `2.520L`, and lowers peak planar force/yaw moment from
`0.02218/0.01034` to `0.01883/0.00979`. No sampled rollout is a non-capture;
the parent is the most informative failure only with respect to coordinated
command viability and excess load/arrival cost.

## Policy hypothesis

Replicate the sampled direction-preserving soft command envelope rather than
altering propulsion or steering gains. When either raw two-joint command rises
above the `27 rad/T^2` soft band, smoothly compress the peak toward the hard
limit and multiply both commands by the same factor. Leave sub-band commands
unchanged and keep the predictive angle guard and selective speed guard
downstream, so safety braking remains authoritative. This should reproduce
capture while preserving the anterior/posterior command ratio, eliminate
independent acceleration clipping, reduce load exposure, and retain the
earlier approach. Reject the mechanism if the new evaluation loses capture or
wake coherence, restores any angle/speed contact or command clipping, arrives
later than the parent, or exceeds the parent's force/moment peaks.

bookshelf_consulted: true
source_domain: classical undulatory swimming and low-dimensional CPG/residual robotic-fish control
source_mechanism: a phase-separated traveling bend with posterior lag, controlled through coordinated gait variables rather than independently clipped joint peaks
transferable_invariant: preserve the anterior/posterior command relationship that carries a directed body wave when projecting actuation into a feasible envelope
nontransferable_details: published gains, clock phases, species-specific amplitudes and envelopes, full-body kinematics, and task-specific routes
policy_translation: apply one smooth common scale to the two-joint state-feedback command only above the soft acceleration band, with observed-state angle and speed safety guards downstream
falsification: reject if replication loses capture or coherent wake structure, changes viable sub-band commands, restores limit contact or clipping, delays arrival, or increases peak load
