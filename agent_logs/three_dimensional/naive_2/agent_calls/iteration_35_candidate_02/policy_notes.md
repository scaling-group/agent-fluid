# Directional phase-plane reserve candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected every combined keyframe sheet from release through
capture, including the top-down mid-plane vorticity row and the oblique
body/Lambda2 row. Each fish visibly self-propels down-left on nearly the same
direct route. The alternating top-down vortex street and three-dimensional
oblique structures remain compact and connected to the posterior body; none of
the sheets shows passive advection, wake breakup, boundary interaction, or
instability. The useful differences are therefore terminal course and actuator
allocation, not far-field propulsion or wake topology.

The tail-only residual is still the fastest and best-scoring sample
(`15.1403T/-0.01094`), but crosses with `0.651L` reconstructed head-relative
constant-course miss, `1.269%` posterior `>40 deg` dwell, and
`23.685/21.654%` two-joint near-rate occupancy. Absolute posterior-reserve
allocation improves miss to `0.362L`, but transfers limit exposure rather than
solving it (`0.285/0.996%` anterior/posterior dwell) and arrives at `15.4464T`.
The sampled directional allocator is the best balanced contrast: it captures
at `15.3385T`, reduces miss to `0.461L`, removes anterior dwell, and lowers
posterior dwell to `0.681%`, with `0.03959/0.01890` peak normalized planar
force/moment. The assigned dual-absolute-reserve parent captures sooner at
`15.2957T` and lowers the force peak to `0.03872`, but worsens miss to `0.556L`
and posterior dwell to `0.898%`; its `23.751/21.488%` near-rate occupancy is
indistinguishable from the directional allocator's `23.755/21.498%`. Thus
discarding authority from absolute reserve is not the terminal-margin solution.
The evidence supports preserving signed restorative capacity while testing an
earlier, phase-aware boundary signal.

## Single candidate hypothesis

Start from the sampled directional allocator and preserve its state-feedback
traveling carrier, posterior lag and pulse, normalized body-frame pursuit/course
blend, constant-course predictor, common response-plus-miss handoff, cubic
predicted-miss residual, tail-first spillover, and smooth acceleration envelope.
Change one mechanism: replace instantaneous directional angle capacity with a
directional phase-plane excursion estimate. For each joint, outward rate is
normalized by the inherited carrier frequency and added to signed angle before
the soft angle gate; inward rate adds no projected excursion. Retain the
separate signed rate gate. This uses observed joint state to anticipate loss of
angle reserve by approximately the carrier's natural response scale, while
leaving restoring motion and all nonterminal carrier behavior unchanged.

The hypothesis is that the directional allocator acts too late because current
angle alone does not represent a rapidly outward-moving joint. Anticipatory
capacity should transfer or shed only the terminal residual before an outward
soft-boundary excursion, reducing posterior dwell without the parent's loss of
course margin or the unconditional allocator's anterior-limit exchange.
Support requires capture with reconstructed terminal miss no worse than the
directional sample's `0.461L`, zero anterior `>40 deg` dwell, posterior dwell
below `0.681%`, near-rate occupancy no higher than the sampled `23.8/21.5%`
class, arrival no later than `15.45T`, and peak normalized planar force/moment
within about `0.040/0.019`. The direct route and compact alternating 3D wake
must survive. Falsify on lost capture, miss above `0.461L`, transferred head
dwell, no posterior-reserve improvement, slower arrival without margin gain,
wake decoherence, increased load/rate class, nonfinite commands, or loss of
reflection equivariance. Formal CFD is deferred to EvE and is not evidence
available to this worker.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded residual path following
source_mechanism: preserve an autonomous propulsive rhythm while target-relative modulation is admitted through observable actuator capacity
transferable_invariant: keep the traveling carrier intact and allocate a bounded rhythmic redirect only through joints whose normalized phase-plane state predicts directional kinematic reserve
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: use body-frame predicted miss for redirect sign and each joint's signed angle plus outward rate normalized by carrier frequency to gate tail-first residual allocation without changing the two-joint carrier
falsification: reject if capture margin, arrival, compact wake, two-joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The mandated guidance-materiality, lightweight Julia policy-contract, solver
editable-boundary, and deterministic parameter-schema checks pass. A
`270,000`-state sweep over normalized target geometry and velocity, heading
response, and both joint angles and rates produced finite commands no greater
than the owned `30 rad/T^2` envelope and below the physical acceleration limit.
Exact left/right reflection error was `0.0`. Relative to the sampled
instantaneous directional allocator, the phase-plane gate changed `45,110`
states at numerical tolerance with maximum command difference
`0.58165 rad/T^2`, confirming an active feedback mechanism rather than a
comment or scalar-only edit. All `33` direct `params.FIELD` references resolve
to the `33` returned parameter fields. These are algebraic checks only; formal
CFD remains deferred to EvE.
