# Candidate diagnosis and hypothesis

The assigned parent is byte-identical to sampled solver `bf9554cfba28`: the
response-aware far-amplitude/near-lag traveling-wave handoff. Its direct,
uniform still-water rollout captured at `19.1620T`, with distance integral
`2.06924L`, head path `12.3093L`, and coherent alternating vorticity and
Lambda2 structures in the top-down and oblique rows. Thus the fish is
self-propelled rather than advected, turns generally toward the target, and
does not need another route or terminal-slip mechanism.

The strongest finite sample, `435f3fac7d39`, changes only actuator allocation:
it withdraws acceleration that is aligned with joint velocity when either
joint approaches the normalized rate envelope. Its two visual rows retain the
parent's coherent traveling wake and target-directed hook, without a collision,
domain exit, or visible three-dimensional instability. Cross-checking the
diagnostics shows capture at `18.7550T`, distance integral `2.04031L`, and
progress already ahead of the parent at `4/8/12/16T` (`11.625/9.115/5.978/
2.932L` versus `11.645/9.229/6.186/3.209L`). Mean anterior/posterior command
fell from `18.46/17.56` to `17.87/17.07 rad/T^2`; posterior residence above 90%
of the smooth command bound fell from `33.96%` to `30.65%`, and posterior rate
residence above 99% of the envelope fell from `4.36%` to `3.28%`.

The tradeoff is explicit: the guarded trajectory is longer (`12.4211L` versus
`12.3093L`) and peak planar force/yaw-moment coefficients rise from
`0.02537/0.01357` to `0.02686/0.01397`. The result nevertheless has a distinct,
better timing/integral trajectory and the best sampled score (`-0.152143`
versus `-0.180466` for the parent and `-0.192032` for the slower
response-released failure comparison). Inherited optimizer score logs also
place `435f3fac7d39` above the available prior captures (`-0.19093` to
`-0.20967`), so this candidate adopts that one tested mechanism exactly rather
than composing another steering residual.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a phase-lagged posterior propulsive wave while bounded state feedback modulates rhythmic authority
transferable_invariant: protect an already productive traveling bend by withdrawing only outward acceleration as normalized measured joint rate approaches its envelope
nontransferable_details: published CPG gains, species kinematics, dimensional frequencies, prescribed phases, and task-specific routes
policy_translation: keep the body-frame target and joint-state scaffold; add a shared smooth rate-proximity gate and per-joint acceleration-velocity alignment so reversal authority remains available
falsification: reject if repeat or held-out evidence loses capture or early milestones, fails to lower near-envelope residence, destroys either coherent wake view, reduces joint margin, or sustains the observed higher force/moment class without timing or integral benefit

Candidate hypothesis: the sampled rate guard will reproduce the faster
distance-progress trajectory while retaining capture and wake coherence. It is
not justified as generic gain reduction; its effect must remain conditional on
measured joint-rate proximity and outward command alignment.
