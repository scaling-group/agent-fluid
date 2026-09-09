# Multi-wake policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled rollouts satisfy the frozen contract: direct uniform
initialization in still water with `U_infinity=[0,0,0]`, no prewarm or
cylinders, finite dynamics, and valid moving-window transport. Their
executable controller equations and parameters are identical; source-file
differences are comments. All four capture at `0.7482--0.7497L` in
`19.228--19.784T`, with mean scored distance `2.119--2.132L` and score
`-0.2433` to `-0.2299`. The spread is repeat variability, not a gain result.

I inspected the combined top-down vorticity and oblique body/Lambda2 rows for
the best-scored capture (`solver_9f4d1c41c5e1`), the prefilled lowest-score
capture (`solver_610ca5f49cc1`), and the assigned-parent failure
(`solver_e44b404d3e8b`). The captures visibly self-propel along a curved,
target-directed path while retaining a coherent alternating top-down street
and compact finite caudal Lambda2 structures through first crossing. Their
distance histories are broad-scale monotone (only about `2.5--2.6%` of steps
increase distance), and force/moment RMS remain about `0.0144--0.0145` and
`0.00747--0.00751`. This supports preserving the oscillator, posterior lag,
normalized lateral target request, opposite-sign mean curvatures, and
one-sided yaw release as one package.

The assigned parent added a per-joint rate barrier at `85%` of the physical
rate envelope and clamped returned acceleration. It removed anterior exact
rate contact, held posterior rate below `259 deg/T`, and slightly lowered
force/moment RMS to about `0.0127/0.00664`, but lost the target-directed bend.
Its wake remains coherent while the fish travels left and increasingly up,
reaches only `5.0277L` at `18.128T`, then exits the upper boundary at
`22.132T` with final distance `5.9506L` and score `-7.6152`. An independently
inherited `80%` barrier repeats the same semantic failure (`5.3386L` minimum,
upper exit, score `-7.5871`). Thus lower rate contact or load is not a useful
surrogate when obtained by this pointwise carrier shaping; do not repeat a
per-joint outward rate guard in this candidate. The inherited posterior-only
policy with `tanh` compression remains a bundled failure, so it warrants
distrust rather than a claim that compression alone has been falsified.

## Policy hypothesis

Preserve the successful controller equations and unshaped acceleration path.
Add one bounded half-cycle steering mechanism only to the posterior lag
target. The joint-state phase proxy
`clamp(-turn_request * phi_dot1 / (omega * oscillator_amplitude), 0, 1)` is
positive only while the anterior carrier moves toward the target-signed mean
curvature. On that stroke, strengthen the existing posterior steering bias by
at most `20%`; on the return stroke, leave it exactly unchanged.
Target geometry continues to own sign, the response gate cannot invert it,
and the base traveling wave and anterior steering remain untouched.

The hypothesis is that concentrating a small share of posterior steering on
the already turn-consistent half-cycle will produce the required redirect no
later than the repeated-capture package without the phase damage caused by
rate barriers. Falsify it if capture is lost, arrival or mean distance worsens
beyond the sampled repeat band, the lower-curl or upper-exit topology returns,
the alternating/Lambda2 wake loses coherence, or actuator/load contact grows
materially without a route benefit.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: superpose bounded target-signed half-cycle asymmetry on a persistent rhythmic carrier
transferable_invariant: concentrate incremental steering on the joint-state stroke moving toward the requested mean curvature while preserving carrier phase and target-owned turn sign
nontransferable_details: published CPG gains, motor models, dimensional frequencies, species kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized anterior joint rate as a bounded phase proxy and strengthen only the existing posterior target bias on the turn-consistent stroke
falsification: reject if semantic capture, route topology, wake coherence, arrival band, or load history is worse than the repeated unmodulated captures
