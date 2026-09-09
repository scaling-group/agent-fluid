# Multi-wake policy diagnosis and hypothesis

## Evidence read before editing

The common prewarm sheet shows the held fish above and downstream of four
interacting, fully developed cylinder streets.  The target lies inside their
merged second-row wake, so released control must first turn down-left and then
retain self-propelled leftward travel through strong alternating crossflow.

All four sampled released sheets show that useful topology: a sharp redirect
from the initial 29-degree pose, followed by a coherent, approximately
horizontal upstream traverse that enters the target disk.  This is propulsion,
not passive advection: the fish moves about `-10.9L` in x against the inflow,
while its own alternating wake remains visible behind it.  The candidate
should therefore preserve the `0.55`-period traveling-bend carrier, raw-bearing
mean steering and reserve, course-slip correction, and base half-cycle
asymmetry.

The repeated response-gated parent reaches in `34.821` with mean distance
`1.6270L`, total/mean command energy `47151/1354.1`, relative crossflow
`0.2414`, and RMS force/moment `77.09/1142.74`.  The inherited assisting-moment
credit retains the route but reaches in `34.941`, with lower force/moment
`71.86/1064.16`.  Restricting that credit to the anterior targetward
half-cycle reaches in `34.854` but increases load to `82.35/1231.74`; this is
the informative negative boundary, so joint phase is not reused as a load
proxy.  The strongest sampled child instead combines full assisting-moment
credit with joint-speed pressure on only the extra burst.  It reaches in
`34.711`, improves mean distance to `1.6228L`, lowers total energy to `46986`,
and lowers force/moment to `68.96/1036.40`, while its keyframes retain the same
redirect-and-traverse topology.  Against the full moment-credit result this is
a simultaneous route, effort, and load improvement, although it is evidence
only for this shared prewarm.

The inherited predictive-bearing failure remains a hard architectural
boundary: putting bearing trend into persistent steering exited right after
`18.304` with negative progress.  No derivative or fast wake signal is added
to mean steering here.

## Candidate hypothesis

Start from the strongest sampled full-moment-plus-speed-release policy.  Add
one compatible proprioceptive headroom observation: normalize the magnitude
of `state.previous_action` by the policy-owned acceleration envelope and use
its smooth near-envelope pressure together with the already validated joint-
speed pressure.  Their maximum can withdraw only the surplus redirect burst;
it cannot reduce the carrier, raw-bearing mean steering, actuator reserve, or
base asymmetry.  This should avoid repeatedly requesting extra curvature when
the preceding step already consumed acceleration headroom, reducing command
limit contact and hydrodynamic load without changing the visible route.

Falsify the candidate if it loses target capture or coherent leftward
propulsion, or if it does not produce a meaningful reduction in limit contact,
mean effort, force/moment load, or route cost relative to the sampled
full-moment-plus-speed-release child.  Also reject it if a changed wake phase
shows that previous-command pressure suppresses needed redirect authority.

bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG control
source_mechanism: a strong transient curvature burst is released when observed response or actuator state shows that the redirect is already being expressed
transferable_invariant: separate persistent target-directed steering from a surplus transient burst and gate only the burst with bounded state feedback
nontransferable_details: species-specific body envelopes, published CPG gains, clock phase, exact vortex phase, dimensional frequencies, and task-specific routes
policy_translation: retain normalized body-frame bearing steering and the two-joint traveling bend; combine normalized joint-speed and previous-command pressure to release only extra half-cycle asymmetry
falsification: reject if capture or leftward propulsion is lost, or if headroom feedback fails to improve load, effort, saturation, or route cost beyond the sampled speed-release policy
