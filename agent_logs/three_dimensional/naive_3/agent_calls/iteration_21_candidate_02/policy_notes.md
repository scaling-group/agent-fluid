# Wake policy candidate notes

## Evidence diagnosis

All four sampled rollouts use direct uniform still-water initialization with
`U_infinity=(0,0,0)` and terminate in capture at about `18.27T` and
`0.748--0.749L`. Their top-down rows show a coherent alternating wake from
release through capture, while their oblique rows show compact repeated
three-dimensional Lambda2 structures behind a continuously swimming body.
Mean/peak body speed is about `0.734/1.329U`, versus only
`0.017/0.0315U` local flow, so target approach is self-propelled rather than
moving-window or still-water advection. The sheets are visually nearly
indistinguishable; trajectory and load histories are needed to separate them.

The scalar-best fixed-width brake (`solver_3991cf23285f`, score
`-0.247735`) is the informative mechanical failure despite capture: posterior
angle still reaches exactly `45 deg`, and peak planar force/yaw moment reaches
`0.1718/0.0770`. Both velocity-conditioned stopping-margin variants preserve
the same wake and capture while holding posterior angle near `43 deg` and
reducing those peaks to about `0.0372/0.0191`. The distance-independent
continuous projection (`solver_c9eff9fb23a3`) is also slightly better than the
assigned distance-gated parent (`-0.248133` versus `-0.248270`) and establishes
that target distance need not disable mechanical viability protection. Across
all four samples, however, raw acceleration exceeds the physical envelope in
roughly `51%/46%` of anterior/posterior samples, and velocity limit occupancy
remains about `4.4%/2.6%`.

Inherited score logs add the semantic transition: four earlier course-aware
policies missed at `0.838--0.867L` and exited left, whereas posterior
acceleration reservation first captured at `0.749826L`. Thus the steering
allocation is the terminal-authority mechanism to preserve; neither more mean
curvature nor another scalar barrier threshold is supported.

## Policy hypothesis

Use the sampled distance-independent, velocity-conditioned posterior viability
projection with its evidenced onset, then project both final acceleration
commands into the declared physical envelope inside the policy. The first part
keeps protection tied to normalized joint stopping distance rather than target
route; the second makes the public action feasible by construction. Because
the episode already applies the same hard acceleration envelope, the final
projection should leave the applied trajectory, coherent wake, capture, angle
margin, and force/moment history unchanged while eliminating raw acceleration
exceedance. It is an interface and actuator-feasibility improvement, not a
claim that applied limit occupancy or energetic effort has fallen.

Falsify this candidate if it loses capture, changes the broad route or
alternating wake, touches either angle boundary, exceeds the sampled
`0.0372/0.0191` force/moment peaks, or produces any material trajectory change
that would contradict the assumed equivalence between policy-side projection
and the downstream actuator clamp. A later worker should not interpret zero
raw exceedance as lower physical effort unless applied limit occupancy also
falls in a separately evaluated mechanism.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG and residual control
source_mechanism: preserve the rhythmic carrier while bounded state feedback keeps commanded actuation inside physical authority
transferable_invariant: actuator feasibility should be enforced without replacing the state-feedback traveling wave or target-course mechanism
nontransferable_details: published CPG gains, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: retain the joint-state carrier and body-frame course steering, use normalized joint stopping margin for posterior viability, and project both returned accelerations into the declared envelope
falsification: reject the transfer if capture or wake coherence changes, angle viability regresses, loads rise, or raw-envelope compliance does not become exact
