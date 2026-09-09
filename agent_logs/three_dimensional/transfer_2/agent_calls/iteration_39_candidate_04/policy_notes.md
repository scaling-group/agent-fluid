# Directional-demand carrier handoff candidate

## Evidence diagnosis

All four sampled episodes are valid direct-uniform `U_infinity=0` still-water
captures. In both the best-score sheet (`0.0878125`, `15.6035T`) and the most
informative weak sheet (`0.0757487`, `15.7300T`), the top-down row shows the
fish translating under its own alternating, compact shed wake and turning
toward the target; the oblique row shows coherent three-dimensional Lambda2
structures rather than passive advection or a prewarm artifact. Both retain a
shallow terminal curve. The visual difference is subtle, consistent with the
small `0.1265T` timing separation and common capture class.

The metrics reject choosing the apparent best scalar as an actuator
improvement. The steering-aware common guard has the longest sampled head path
(`13.137L`) and the largest force/moment peaks (`0.04226/0.02076`) despite its
best score. The posterior-priority, carrier-only preview shortens the path to
`12.848L` and lowers peaks to `0.03558/0.01724`, but delays the `6/4/2/1L`
milestones and worsens the distance integral. Most importantly, the prefilled
joint-local full-demand guard has two byte-identical rollouts spanning
`15.5595--15.7080T`, scores `0.08493--0.08671`, and paths
`12.994--13.132L`; the common-guard scalar advantage lies inside that repeat
spread and carries no load or rate-residence benefit. The retained scaffold is
therefore coherent and successful, but a same-sign yaw response alone remains
an under-specified trigger for withdrawing carrier reversal.

## Policy hypothesis

Keep the prefilled joint-local full-demand preview, positive-work-only rate
governor, targeting scaffold, posterior wave, and all gains. Change only the
far-field release of negative-work carrier reversal. Construct a bounded
unresolved directional demand from normalized body-frame turn request,
velocity-course redirect magnitude, and measured same-sign yaw response.
Release reversal continuously when demand is small or already fulfilled;
retain redirect priority when demand is large and yaw response has not yet
appeared. This should avoid suppressing phase-coherent deceleration during an
already aligned cruise without confusing same-sign yaw with fulfilled course
steering.

bookshelf_consulted: true
source_domain: biological C-start/burst redirect and sensor-modulated robotic-fish CPG control
source_mechanism: strong curvature receives priority under large directional error, then measured heading response continuously releases the oscillator toward propulsive cruise
transferable_invariant: allocate steering and rhythmic carrier authority from bounded observed directional demand and response, without a clock or hidden stage
nontransferable_details: species kinematics, burst duration, published CPG gains, prescribed phase, and source-specific routes
policy_translation: combine body-frame target turn magnitude and velocity-course redirect magnitude; subtract bounded same-sign yaw fulfillment; use the remaining demand to govern reversal release in the existing two-joint carrier decomposition
falsification: reject if capture is lost, any 6--1L milestone or distance integral regresses beyond the byte-identical repeat spread, or path, greater-than-90-percent rate residence, peak planar load, joint margin, terminal course, or coherent two-view wake fails to improve as a class

No result from this unevaluated candidate is claimed here; its CFD outcome
belongs to a later worker.
