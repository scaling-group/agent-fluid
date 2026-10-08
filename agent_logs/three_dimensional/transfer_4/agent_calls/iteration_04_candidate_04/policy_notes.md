# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled rollouts satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite `capture`
termination. I inspected the combined top-down mid-plane and oblique Lambda2
sheets for the assigned parent `solver_fb3dd7355a7f`, the strongest sampled
candidate `solver_3e8ee72bb918`, and the least efficient capture
`solver_bfe9ef100c67`. Across them, the fish moves through otherwise still
water while shedding an organized alternating caudal wake. The top-down rows
show the same broad, continuously closing target turn, and the oblique rows do
not show wake breakup or a three-dimensional instability before capture.
Thus the useful inherited result is self-propelled course control; the
remaining failure mode is actuator-envelope residence, not course polarity or
wake production.

The assigned parent captures at `23.3585T`, scores `-0.51527750`, and has mean
distance `2.41260L`. Its requested accelerations reach the episode limit in
`70.03%/52.08%` of anterior/posterior samples. Both joint rates reach exactly
`260 deg/T`, with `9.09%/1.62%` of samples at or above `99.9%` of that limit.
The independently clamped sampled policy `solver_ee4561476853` is trajectory-
and score-identical to the parent, corroborating the inherited log's negative
result that merely duplicating the episode acceleration clamp is a semantic
no-op.

In contrast, the state-feedback governor in `solver_3e8ee72bb918` retains
capture at `23.3640T`, improves score to `-0.51274776` and mean distance to
`2.40949L`, and lowers RMS body-force coefficients from
`0.00426/0.01177` to `0.00411/0.01163`. Its maximum joint rates are
`259.39/259.20 deg/T`; no sample reaches `99.9%` of the rate limit, while the
top-down and oblique wake sheets remain coherent. This is evidence that
direction-selective joint-rate feedback—not a policy-side hard clamp—can
improve feasibility without sacrificing the captured trajectory. A smaller
residual remains: `10.81%/1.37%` of samples are still at or above `99%` of the
rate envelope.

## Candidate hypothesis

Use the evaluated rate-governed candidate as the base, preserving its odd
body-frame target-to-curvature map, target guidance, half-cycle steering,
course-gated terminal cadence, and joint-state traveling-wave carrier. Extend
only its envelope governor with a reflection-equivariant soft rate barrier.
The existing smooth gate continues to withdraw acceleration that would
increase signed joint speed; in the same near-limit window, a small opposing
acceleration is added from normalized `abs(phi_dot)/joint_rate_limit`.
Commands that already reverse the joint retain at least their full reversal
authority. The barrier is inactive below the existing `0.96` onset and does
not alter target geometry, route logic, or elapsed-time behavior.

The next CFD evaluation should retain capture and the alternating wake while
reducing residence above `99%` of the rate limit below the sampled governor's
`10.81%/1.37%`, without materially worsening arrival time, mean distance,
force/moment histories, or joint-angle margin. Falsify this extension if it
loses capture, merely shifts saturation into acceleration/angle limits,
degrades the coherent traveling wake, or produces no useful rate-margin gain.
On a state-only replay of the sampled governor trace, the added barrier is
nonzero in `15.68%/3.58%` of anterior/posterior samples; its mean opposing
contribution is only `22.19/3.79 deg/T^2`, with maxima below `179 deg/T^2`.
This replay bounds the intervention but is not CFD evidence and does not
predict the resulting closed-loop trajectory.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and efficient undulatory-swimming guardrails
source_mechanism: preserve rhythmic inter-joint coordination while observed joint state modulates effort near a physical response boundary
transferable_invariant: a traveling bend should not continue driving into an unavailable joint-speed state, and reversal authority should remain available
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, Strouhal targets, open-loop phase, exact vortex phase, and task routes
policy_translation: retain the evaluated state-feedback carrier and use normalized joint rate to add a bounded reflection-equivariant opposing barrier only near the policy-owned rate envelope
falsification: reject if rate-margin residence does not fall or capture, distance progress, load history, reflected steering, or wake coherence degrades materially
