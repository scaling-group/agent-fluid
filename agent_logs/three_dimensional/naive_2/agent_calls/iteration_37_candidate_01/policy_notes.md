# Wake-policy candidate notes

## Evidence diagnosis

The four sampled solvers contain the same policy, trajectory, and combined
keyframe sheet byte-for-byte. They are four deterministic reproductions of one
direct-uniform still-water experiment, not a strong/failure comparison. Each
starts with `U_infinity=(0,0,0)`, advances from `12.327720L`, and captures at
`0.743958L` after `16.604496T` with distance integral `1.998146L` and score
`-0.113729`.

The top-down row shows the fish translating toward the target while building a
coherent alternating wake; because the ambient flow is zero and the inertial
trajectory advances, this is self-propulsion rather than advection. The oblique
row shows finite, tail-connected three-dimensional Lambda2 structures through
the approach, without visible wake breakup or a boundary/collision precursor.
The final frames show a curved target-directed crossing rather than a terminal
hold. The trace supports that reading: only 56 of 3018 increments briefly
increase distance, peak planar force components are `0.023226/0.029013`, peak
moment is `0.018356`, and the episode remains finite despite both joint speeds
touching the released `4.537856 rad/T` boundary. The sampled set supplies no
visual failure sheet; the informative contrast is therefore the inherited
completed evidence, where terminal yaw release, posterior relief, target-rate,
moment, and local-flow residuals preserved a connected wake but worsened route
cost or closest approach.

## Policy hypothesis and candidate decision

No observed nominal deficit survives the evidence. The current controller
already combines a traveling-wave carrier, body-frame target geometry,
phase-demodulated yaw and lateral response, phase-selective posterior steering,
and a one-sided final-band speed guard. Adding another nominal correction would
confound a reproducible capture with a mechanism for which the sampled trace
has no trigger. The single candidate is therefore the exact prefilled policy,
preserved without scalar tuning or a new feedback channel. Its executable file
hash before validation is
`452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`.

Expected result: under the same direct-still-water episode, the candidate
should reproduce the evidenced capture arc, connected wake, feasibility, and
load envelope. Reject this preservation decision if the formal repeat loses
capture or departs materially from the deterministic trajectory. Reopen the
architecture only when a nonduplicate pose, target, or flow rollout exposes a
repeatable body-frame response deficit; compare any one new primitive against
capture, route cost, crossing depth, wake connectivity, joint feasibility, and
loads.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and adaptive wake interaction
source_mechanism: sensor-modulated rhythmic steering with slow route requests separated from fast disturbance residuals
transferable_invariant: preserve a productive traveling rhythm and add a bounded state-feedback residual only when observations identify a distinct directional or disturbance-response error
nontransferable_details: published gains, clock phase, species kinematics, exact vortex timing, full-body waves, and source-task routes
policy_translation: null translation for this candidate; the existing normalized body-frame controller already implements the supported invariant, while the exact repeats expose no new residual to control
falsification: adopt and test one bounded residual only after a nonduplicate rollout shows a repeatable response error; reject it if nominal capture, route cost, crossing depth, wake connectivity, feasibility, force, or moment worsens
