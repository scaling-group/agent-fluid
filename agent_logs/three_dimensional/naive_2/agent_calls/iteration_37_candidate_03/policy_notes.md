# Quadrant-selective posterior-lag candidate

## Visual and metric diagnosis before editing

All assigned evaluations satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
no prewarm, finite dynamics, and capture termination. I inspected the combined
keyframe sheets from release through capture, including the top-down
mid-plane-vorticity row and the oblique body/Lambda2 row. The score-leading
tail-only residual `solver_e749afa61520`, the prefilled receiver-safe allocator
`solver_3f9023504354`, and the assigned parent's completed phase-decomposed
rollout `solver_241ec16a3591` all visibly self-propel along the same direct
down-left route. Each leaves a compact alternating mid-plane wake and a sparse,
body-connected three-dimensional vortex train. None shows passive advection,
wake breakup, boundary interaction, or an initialization artifact. No current
sheet is a semantic failure, so the parent's phase-decomposed capture is the
informative actuator-quality failure; inherited `1.01--1.22L` left exits remain
the actual termination boundary. The carrier, far-field route, and common
response-plus-miss handoff should remain intact.

The completed trajectories isolate a failed family of residual allocators.
Tail-only cubic carrier-magnitude modulation arrives earliest and scores best
(`15.1403T/-0.01094`) but crosses on a `0.651L` constant-course miss, keeps the
posterior joint beyond `40deg` for `1.269%` of samples, and reaches
`0.04041/0.01902` peak normalized planar force/moment. Directional allocation
improves miss and posterior dwell to `0.461L/0.681%` with no anterior dwell,
but receiver-safe absolute-tail allocation gives inconsistent repeats: the
prefill captures at `15.2823T` with `0.516L` miss, zero `>40deg` dwell, and
`0.03988/0.01906` loads, whereas the identical inherited controller captures
at `15.2308T` with `0.619L` miss, `0.397%` posterior dwell, and higher
`0.04087/0.01968` loads. Its apparent reserve quality is therefore not a
stable terminal-margin mechanism.

The assigned parent's analytic carrier-phase decomposition fails its stated
boundary despite preserving the visual wake. It captures at
`15.2469T/-0.01832`, but terminal miss is `0.619L`, posterior `>40deg` dwell
rises to `2.233%`, and peak force/moment rises to `0.04184/0.01961`. These are
all worse than directional allocation, and dwell/load are also worse than both
receiver-safe repeats. Together with the prior one-step-action phase failure
(`0.631L`, `1.878%`, `0.03930/0.01922`), the evidence rejects using either a
delayed command or instantaneous carrier acceleration as the direction proxy
for gating more `abs(carrier)` residual. Another reserve threshold, phase
softness, or spillover gain would remain in the falsified mechanism family.

## Single candidate hypothesis

Preserve the state-feedback oscillator, posterior lag and pulse, normalized
body-frame pursuit/course blend, constant-course predictor, common
response-plus-miss release, far-field half-cycle steering, and smooth action
envelope. Replace only the terminal cubic carrier-magnitude residual and its
joint-reserve allocator with a bounded waveform-level actuator. The signed
cubic predicted miss modulates posterior lag according to the observed
centered anterior-bend quadrant: the product of miss sign and bend sign is
reflection-even and changes the lag coefficient, while multiplication by
anterior joint rate keeps the posterior target reflection-odd. This advances
one posterior quadrant and retards the other without adding a persistent bend,
amplifying `abs(carrier)`, copying an exact vortex phase, or transferring
unavailable torque between joints. The existing response-plus-miss consensus
smoothly releases the modulation back to cruise.

The hypothesis is that redistributing posterior timing within the preserved
traveling wave can retain terminal course authority with less posterior angle
dwell and lower force/moment peaks than carrier-magnitude allocation. Support
requires capture on the direct compact-wake route, terminal constant-course
miss no worse than the prefill's `0.516L` and preferably at or below the
directional allocator's `0.461L`, zero anterior `>40deg` dwell, posterior dwell
at or below `0.681%`, force/moment no worse than about `0.040/0.019`, and
arrival within the sampled `15.14--15.34T` class. Falsify on lost capture,
wider miss, repeated left exit, new limit exchange, higher load class, slower
arrival without a joint-quality gain, far-field route change, wake
decoherence, nonfinite action, or loss of reflection equivariance. Formal CFD
is deferred to EvE and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG phase modulation and asymmetric-flapping turning
source_mechanism: preserve an autonomous propulsive oscillator while sensor feedback reshapes posterior phase timing and releases the redirect after observed response
transferable_invariant: steer by a bounded target-relative redistribution of rhythmic wave timing while retaining the traveling carrier and returning continuously to cruise
nontransferable_details: published gains, dimensional beat frequency, robot linkage geometry, duty ratios, species-specific envelopes, exact vortex phases, world coordinates, task routes, and waypoints
policy_translation: use normalized body-frame cubic predicted miss and centered anterior joint phase to modulate the posterior lag coefficient inside the two-joint state-feedback carrier, gated by the inherited response-plus-miss handoff
falsification: reject if capture margin, direct routing, compact wake, posterior reserve, normalized loads, boundedness, or exact reflection equivariance worsens

## Dry validation boundary

The prescribed guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass without CFD. A deterministic `2,187`
state grid over normalized body-frame target/course geometry, heading response,
and both joint angles and rates produced finite commands strictly inside the
owned `30 rad/T^2` smooth envelope with exact left/right reflection (maximum
error `0.0`). On the same grid, posterior-lag shaping changed `1,944` states
relative to the receiver-safe prefill and reached a maximum command difference
of `7.40873 rad/T^2`, confirming an active feedback mechanism rather than a
comment or scalar-only edit. These algebraic checks do not establish capture,
wake, loads, or joint histories; those remain for EvE's formal CFD evaluation.
