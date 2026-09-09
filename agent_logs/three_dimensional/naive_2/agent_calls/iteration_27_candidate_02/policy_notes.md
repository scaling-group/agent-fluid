# Evidence-selected unified terminal handoff

## Visual and metric diagnosis before candidate selection

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
no prewarm, finite dynamics, and `capture` termination. I inspected every
combined `wake_keyframes.jpg`, including both its top-down mid-plane vorticity
row and oblique body/Lambda2 row. Each fish self-propels along the same direct
down-left route; by `4T` it has formed a compact, body-connected alternating
wake whose localized three-dimensional posterior structures persist through
capture. No sample shows passive advection, wake breakup, collision, domain
exit, or visible instability. The current sample contains no failed
termination sheet; the inherited written `left_domain` near misses therefore
remain the failure boundary rather than a visual comparison invented from four
captures.

The useful distinction is terminal course quality, not the carrier. The
prefilled unified response-and-predicted-miss controller is the strongest
sample: it captures at `15.50081T`, scores `-0.02108896`, and has a
`1.90236L` distance integral. From the terminal trajectory its raw
constant-course miss is `0.179L`; it has zero dwell beyond `40 deg`,
`17.84/17.03%` near-rate-limit occupancy, and peak normalized planar
force/moment `0.03653/0.01801`.

Two later feedback mechanisms preserve the compact wake and capture but fail
their stated margin objective. Transferring released half-cycle authority to
active yaw arrest captures at `15.80614T`, but its terminal course miss widens
to `0.751L`, above the inherited `0.590L` replicate boundary; score and
distance integral worsen to `-0.02174694` and `1.90392L`. Replacing terminal
pursuit direction with the instantaneous rotation-invariant predicted miss
captures at `15.77355T`, but still widens terminal course miss to `0.678L`,
worsens score/integral to `-0.02195351/1.90414L`, and introduces `0.42%`
posterior dwell beyond `40 deg`. The response-qualified posterior sibling is
slower again at `16.02701T`. All remain in the same roughly
`0.0348--0.0365/0.0174--0.0180` load class and roughly `17--18%` near-rate
class, so neither new mechanism earns acceptance through reserve or load
improvement.

## Exactly one candidate

Retain the prefilled unified response-and-predicted-miss policy exactly. It
preserves the established joint-state traveling-bend carrier, raw normalized
body-frame pursuit/course blend, constant-course predictor, terminal mean
bend, posterior mid-stroke pulse, and the single response-plus-geometric-miss
release gate. This is a deliberate semantic selection against the assigned
parent's later interception-direction mechanism and the sampled yaw-arrest
alternative, not a scalar tune or a claim that a new unevaluated mechanism has
already improved CFD.

The candidate is supported if a later evaluation repeats capture with the
direct compact-wake route, negligible `>40 deg` dwell, terminal course miss no
worse than the evidenced `0.590L` replicate boundary, and force/moment and
near-rate occupancy in the sampled class. Falsify selection on a miss or left
exit, course miss above `0.590L`, material route/wake degradation, persistent
joint pinning, or larger normalized loads. A further threshold capture alone
does not prove enlarged capture margin.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions, terminal approach control, and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve the autonomous propulsive rhythm while normalized target-relative geometry and measured response govern the bounded redirect-to-cruise handoff
transferable_invariant: retain a productive traveling carrier and accept a terminal feedback addition only when capture margin or termination improves together with route, joint, and load quality
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional frequency, exact vortex phase, capture pose, target coordinates, and task-specific routes
policy_translation: adopt no new shelf primitive in this candidate; retain the unified body-frame response-plus-predicted-miss handoff because sampled yaw-arrest and predicted-direction translations preserved capture but contradicted their margin objective
falsification: reject the retained handoff if repeat evidence loses capture, exceeds the 0.590L terminal-course boundary, or degrades the direct wake, joint reserve, normalized loads, boundedness, or reflection symmetry

## Validation boundary

The candidate file is intentionally unchanged from the prefilled sampled
controller. No formal CFD was run; the current candidate's next CFD result is
future evidence, not evidence claimed here.
