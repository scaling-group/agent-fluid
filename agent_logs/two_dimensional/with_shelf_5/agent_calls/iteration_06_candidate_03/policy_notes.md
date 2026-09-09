# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish at the upper-right release pose
while four interacting cylinder streets have filled the target corridor. This
is a common initial condition, not candidate-specific evidence. The inherited
`12 deg` mean-curvature failure never establishes a useful route: its three
released frames remain at the upper-right boundary and it exits after `16.791`
with head displacement `(2.175,-0.869)L`, progress `-0.147`, and final target
distance `14.251L`. The assigned-parent seed diagnosis supplies the other
failure boundary: a target-blind curl is carried toward the lower boundary with
only about `0.038U` mean motion relative to local flow. More scalar drive or a
larger always-on mean bend is therefore not supported.

The two byte-identical fast samples (`solver_09b5b834b2ae` and
`solver_a64551a56856`) visibly make an immediate correct-sign redirect and then
swim on a shallow left/down diagonal through the merged wake to the target.
Both cross the `0.75L` boundary after `43.951`, with mean distance `2.139L`.
Their mean velocity `(-0.247,-0.102)` differs materially from mean local flow
`(-0.134,-0.156)`, so the route is controlled swimming rather than passive
advection. The slower bearing-rate-lead sample also succeeds, but its broad
loop takes `93.027`, has mean distance `4.031L`, and roughly doubles RMS
force/moment from `49.4/701` to `95.4/1146`. Its architecture lacks the fast
sample's posterior half-cycle curvature redistribution, so it does not support
replacing that mechanism with another bearing-rate correction.

The sample without terminal amplitude relief reaches in the same `43.951` and
has almost identical effort, force, moment, and joint extrema to the two copies
with relief; its score is only `0.00259` lower. Thus the semantic gain is the
posterior target-favored half-cycle, not another amplitude scalar. The fast
policy still reaches both `260 deg/time` rate caps and `1800 deg/time^2`
acceleration caps. Its shorter episode lowers total command energy from about
`9.05e4` to `5.31e4`, but mean command energy is higher (`1208` versus about
`973`). The remaining opportunity is to establish target-closing motion still
sooner without increasing static curvature or globally changing the carrier.

## Policy hypothesis

Preserve the evaluated `0.55`-period, `28 deg` anterior state oscillator,
bounded `8 deg` bearing bias, posterior lag, target-favored half-cycle
redistribution, and smooth terminal amplitude envelope. Add one compact
response-gated redirect mechanism. When body-frame bearing remains large and
the normalized windowed closing speed is below the evidence-separated slow
route scale, add a bounded posterior curvature burst on the already preferred
joint-state half-cycle. As target distance begins closing quickly, the burst
fades continuously; small bearing also removes it. This changes neither head
mean-curvature authority nor oscillator timing, and it can reactivate after a
wake-induced stall without a clock, fixed coordinate, or vortex phase.

The fast sample averages about `0.267L/time` net range closure, while the slow
sample averages about `0.126L/time`; a `0.12L/time` soft threshold therefore
marks absent or stalled progress rather than prescribing a route. The added
posterior bias is capped at `2.5 deg`, below the existing `4 deg` half-cycle
redistribution and far below the failed increase in always-on anterior bend.
These values are rollout-scaled engineering hypotheses, not imported gains.

Falsify the candidate if it loses the fast target-reaching topology, exits
right, arrives later than `43.951`, collapses the alternating traveling bend,
or raises force/moment and episode effort without a lower distance integral.
The current evaluation has no sign-resolved wake-event histories, so this
candidate deliberately does not add local-flow, force, or moment feedback.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and nonsteady biological redirect modes
source_mechanism: sensor-gated asymmetric tail burst that releases when the commanded redirect produces useful target response
transferable_invariant: preserve the rhythmic carrier while large persistent body-frame error and deficient progress gate a bounded target-favored posterior burst, then remove the burst continuously once closing response appears
nontransferable_details: published gains, dimensional closing speeds, species or robot kinematics, clocked CPG phase, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: keep the sampled two-joint oscillator and bearing curvature; use normalized `window_closing_speed_L`, bounded bearing request, and centered anterior joint state to gate an added posterior preferred-half-cycle target
falsification: reject if the fast diagonal capture is lost or delayed, the early right-exit topology returns, the traveling bend collapses, or load and effort increase without better distance progress

## Pre-evaluation verification

The prescribed semantic-guidance check, Julia policy-contract check, direct
parameter-schema guard, and solver editable-boundary check pass. A no-CFD
sweep over `32,400` combinations of approach range, body-frame bearing,
windowed closing response, joint angle, and capped joint rate produced only
finite actions and preserved left/right reflection symmetry; zero bearing with
zero joint state also returns exactly zero action. CFD behavior remains
intentionally unevaluated until the post-worker rollout.
