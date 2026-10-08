# Distributed carrier-rate observer candidate

## Evidence read before editing

The four sampled solver examples are exact replications: their policy files
share SHA-256 `76326f8c...48a0d`, their combined keyframe sheets share
SHA-256 `d75b3184...21947`, and their scores and trajectories are identical.
They therefore provide one replicated v33 baseline rather than four distinct
controller comparisons. The rollout satisfies the experiment contract with
direct uniform still-water initialization (`U_infinity=[0,0,0]`), no prewarm,
no cylinders, and a stable capture.

The top-down row starts with no wake, develops a strong alternating red/blue
vorticity street by `4T`, and retains a coherent staggered multi-vortex wake
through the target-directed bend and capture. The oblique row likewise grows
an organized three-dimensional Lambda2 chain behind the moving body rather
than showing passive advection or a diffuse standing wiggle. Near the target,
the visible path curves sharply while the wake remains coherent; there is no
collision, exit, or numerical breakup. Metrics agree: capture occurs at
`23.8425T`, mean distance is `2.433543L`, final distance is `0.746165L`, and
the run is not unstable. The remaining terminal cost is oscillatory handling:
inside `3L`, mean/peak absolute yaw are `1.680/3.185 rad/T`, mean/peak
cross-track speed are `0.239/0.572U`, and peak absolute moment is `0.013730`.
Both joints touch the `260 deg/T` velocity envelope and projected acceleration
approaches, but does not exceed, `1800 deg/T^2`.

No distinct failure keyframe exists in the sampled set. The evidence-backed
failure contrast is therefore inherited rather than visual: fixed transfer of
course curvature toward the anterior joint reduced yaw/load but regressed
score, mean/final distance, and arrival, while posterior phase-lag damping and
stronger posterior counter-tangent also failed to improve the v33-scale
capture. Those results rule out another allocation share, damper, or stronger
tail correction as the present test.

## Diagnosis and policy hypothesis

The v33 residual observer subtracts anterior carrier motion via
`heading_rate + 0.5*phi_dot[1]`, yet replay inside `3L` shows that residual is
still correlated `-0.95396` with the full posterior-tangent rate
`phi_dot[1] + phi_dot[2]`. Its RMS-scale periodic content is therefore being
misclassified as route-scale excess yaw. A least-squares diagnostic on the
completed trajectory gives a `+0.17288` correction on the full-tail rate; the
candidate uses a conservative `0.17` and makes no other control change. Static
replay reduces the residual/tail-rate correlation from `-0.95396` to
`-0.05299` and residual RMS from `0.635` to `0.216 rad/T`; these are observer
diagnostics only, not claims about the unevaluated closed-loop CFD response.

The hypothesis is that a distributed body-shape rate is a better observable
of the fast propulsive carrier than anterior rate alone. Adding it only to the
existing carrier-rejected yaw estimate should reduce beat-synchronous false
terminal counter-curvature while preserving v33's target geometry, continuous
course bend, posterior traveling wave, wake coherence, and command projection.
This is an observation/feedback mechanism change, not extra steering authority
or a cadence-gain retune.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and adaptive wake-interaction control
source_mechanism: separate the rhythmic locomotor carrier from slower route error before applying a bounded residual correction
transferable_invariant: use observed joint phase and distributed shape rate to reject fast periodic carrier motion while target geometry continues to define the route
nontransferable_details: published CPG gains, species-specific envelopes, dimensional beat frequencies, exact vortex phase, and source-task routes
policy_translation: augment the normalized body-frame terminal yaw observer with `0.17*(phi_dot[1]+phi_dot[2])`, leaving the two-joint gait and target controller unchanged
falsification: reject if capture is lost or delayed, mean/final distance regresses, the coherent alternating wake degrades, or terminal yaw/moment and velocity-limit exposure fail to hold or improve against v33
