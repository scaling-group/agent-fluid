# Wake-policy candidate diagnosis

## Evidence scope

The assigned parent is the response-demodulated, speed-guarded capture policy
copied into `solver/`. All four sampled solvers contain that same policy byte
for byte and report the same direct-uniform still-water capture: score
`-0.11372863446239556`, arrival at `16.604496T`, distance integral
`1.9981459676L`, and head crossing at `0.7439582944L`. Their wall times differ
from about 429 to 709 seconds, but each has 3019 steps and 237 moving-window
shifts. Five distinct inherited solver records sampled across the three
guidance branches also report the exact score and crossing distance. Thus the
available population contains deterministic replication, not a controller
contrast or a held-out pose/flow test.

All four combined keyframe sheets are byte-identical, so this workspace does
not contain an informative failure image. Failure comparisons below therefore
use only completed inherited metrics and prose; no unseen failure wake is
inferred.

## Visual diagnosis

The shared top-down row shows release from rest followed by a target-directed
curved transit under self-propulsion. Alternating signed vorticity grows behind
the tail and remains connected through the final target-crossing frame; there
is no visible advection without a wake and no break associated with storage
recentring. The oblique row likewise shows alternating three-dimensional
tail-connected Lambda2 structures through approach and capture, rather than a
detached or collapsed carrier.

Trajectory data agree with the images. Final planar speed is `1.132762U`, but
the task is first crossing rather than hold. Peak planar force and yaw moment
are about `0.037165` and `0.018356`, joint angles remain below the `45 deg`
hard limit, and the final-band one-sided speed guard keeps the requested
accelerations finite while preserving beat reversal. The inherited failed
controls are more informative than the endpoint motion: target-rate,
terminal-relief, moment, and local-fluid residual additions all retained a
finite wake but worsened route cost or crossing depth. No sampled signal shows
a remaining nominal response deficit.

## Candidate hypothesis and decision

The candidate is an intentional null architecture proposal: preserve the
assigned parent's policy exactly. If the nominal evaluator is deterministic,
it should retain capture, route topology, crossing depth, wake connectivity,
joint feasibility, and load bounds. A changed controller mechanism is not
justified by runtime variation or by another identical nominal capture. This
decision is falsified by a completed held-out pose, target, or flow rollout
that exposes a repeated directional-response deficit, or by a nominal repeat
that diverges after policy and configuration hashes are controlled. Such
evidence would justify one bounded body-frame residual targeted at that
specific deficit.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and adaptive wake interaction
source_mechanism: preserve a low-dimensional propulsive carrier and add bounded sensor feedback only for an observed directional disturbance
transferable_invariant: rhythmic propulsion should remain intact while any residual channel is tied to a measured body-frame response deficit
nontransferable_details: published gains, species-specific kinematics, prescribed vortex phase, dimensional frequency, and task-specific routes
policy_translation: retain the existing joint-state carrier, target geometry, demodulated yaw/slip response, and one-sided speed guard; add no unevidenced nominal residual
falsification: reject preservation only when a controlled held-out rollout shows a repeatable response deficit that one bounded residual improves without losing capture, route cost, crossing depth, wake connection, feasibility, or load bounds
