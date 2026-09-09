# Multi-wake policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=[0,0,0]`, no cylinders
or prewarm, finite dynamics, and valid moving-window transport. I inspected the
combined top-down vorticity and oblique body/Lambda2 sheets for the best scored
capture (`solver_9f4d1c41c5e1`), the prefilled capture
(`solver_610ca5f49cc1`), and the inherited geometry-held near-miss
(`solver_6f7220e1f457`), then cross-checked the visual claims against their
trajectory, score metrics, and wake diagnostics.

The four current samples use the same executable controller equations and
parameters; their file differences are comments only. All four nevertheless
capture, spanning `19.228T` to `19.784T`, mean scored distance `2.119L` to
`2.132L`, and score `-0.243312` to `-0.229933`. Their visual rows consistently
show self-propelled target-directed translation, a coherent alternating
top-down street, and compact finite caudal Lambda2 structures through capture.
This is repeat evidence for the normalized lateral request, one-sided yaw
release, and opposite-sign anterior/posterior curvature package, not evidence
that one of the comment-only variants has better gains.

The informative inherited failure retains a coherent wake and reaches
`1.092679L` at `19.058T`, but its full signed-line-of-sight request fails to
release through the near pass, curls below the target, and exits the lower
boundary at `32.071T` and `9.554851L`. The successful package visibly avoids
that terminal curl and makes broad-scale distance progress nearly monotone.
Route steering should therefore remain unchanged in this candidate.

Actuator demand is the repeatable weakness. Across the four captures, joint
rates contact the `260 deg/T` limit on `10.6--10.8%` / `14.0--14.4%` of rows,
while raw acceleration exceeds `1800 deg/T^2` on `61.7--62.2%` /
`71.7--72.3%`. The demand is not confined to capture: in the best scored run,
far, middle, and near regimes all show roughly `60--75%` acceleration
over-request. An inherited posterior-only/inverse-gate policy bundled with
per-joint `tanh` compression exited early after weak translation, so that
bundle neither disproves command shaping nor licenses copying it. Command
relief now needs an isolated ablation on the repeated capture architecture.

## Policy hypothesis

Preserve the evidenced oscillator, posterior lag, normalized body-frame route
request, differential curvature, and one-sided yaw release exactly. Add one
joint-state rate barrier after those raw accelerations are formed: acceleration
that would increase an already-high absolute joint rate tapers continuously to
zero at the policy-owned rate limit, while oppositely signed braking remains
fully available. Finally bound acceleration at the policy-owned physical
envelope. This is a phase-aware actuator-envelope mechanism, not scalar-only
gain tuning and not a new route channel.

The barrier should reduce rate-limit residence and eliminate raw over-envelope
requests without changing the target-owned steering sign or suppressing the
traveling wake. Falsify it if capture is lost, arrival or mean distance worsens
materially beyond the observed repeat spread, either lower-exit or high-pass
topology returns, wake coherence collapses, or rate contact fails to decrease.

bookshelf_consulted: true
source_domain: robotic-fish joint-state CPG control and moderate-amplitude swimming guardrails
source_mechanism: preserve a low-dimensional propulsive rhythm while actuator-aware state feedback bounds physically excessive commands
transferable_invariant: shape only outward joint acceleration near the normalized rate envelope while retaining target-owned mean curvature, posterior lag, and full braking authority
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, exact vortex phases, full-body kinematics, and task routes
policy_translation: normalize each measured joint rate by policy-owned limits, taper only same-sign outward acceleration near the envelope, and leave the sampled body-frame redirect equations unchanged
falsification: reject if capture or coherent posterior wake is lost, route sign changes, mean distance worsens beyond repeat variability, or rate-limit residence does not decrease
