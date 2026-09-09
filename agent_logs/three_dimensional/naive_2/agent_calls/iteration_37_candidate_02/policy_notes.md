# Envelope-preserving posterior wave-target candidate

## Visual and metric diagnosis before editing

All four sampled solver rollouts and both completed inherited step-36
rollouts satisfy the frozen-flow contract: direct uniform initialization in
still water with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite
dynamics, and capture termination. I inspected their combined keyframe sheets
from release through capture, including the top-down mid-plane vorticity and
oblique body/Lambda2 rows. Every sheet shows genuine self-propulsion on the
same direct down-left route, a coherent alternating mid-plane wake, and a
compact body-connected three-dimensional vortex train. None shows passive
advection, wake breakup, boundary interaction, or numerical instability. The
score-leading tail-only residual is therefore the strong finite baseline, and
the newer reserve allocators are informative actuator-quality failures rather
than route or propulsion failures.

The sampled traces isolate the trade. Tail-only acceleration asymmetry arrives
at `15.1403T/-0.01094` but has `0.651L` terminal constant-course miss,
`1.269%` posterior `>40 deg` dwell, and `0.04041/0.01902` peak normalized
planar force/moment. Fully directional reserve improves that compromise to
`15.3385T/-0.01502`, `0.461L` miss, `0/0.681%` anterior/posterior dwell, and
`0.03959/0.01889` loads. Authority shedding eliminates angle dwell in the
receiver-safe sample, but its miss remains `0.516L`. The completed inherited
receiver-safe repeat then captures at `15.2308T/-0.01818` with `0.619L` miss,
`0/0.397%` dwell, and higher `0.04087/0.01968` loads. Contemporaneous
carrier-phase decomposition also captures at `15.2469T/-0.01832` but retains
`0.619L` miss while worsening posterior dwell and loads to
`2.233%` and `0.04184/0.01961`. Thus more gates around the same
`residual * abs(carrier_acceleration)` channel do not jointly preserve margin,
reserve, and loads. The established far-field carrier and shared
response-plus-miss handoff should remain; the terminal residual needs a
different actuator representation.

## Single candidate hypothesis

Replace only the cubic posterior acceleration-asymmetry residual with an
envelope-preserving posterior wave target. The same normalized body-frame
predicted miss supplies a bounded terminal wave-center offset. As that offset
grows, contract the posterior traveling-wave component by the offset divided
by the inherited oscillator amplitude, so steering mean and rhythmic
excursion share a fixed nominal angular envelope. Preserve the oscillator,
posterior lag and existing pulse, pursuit/course blend, constant-course
predictor, response-plus-miss release, common half-cycle steering, and smooth
acceleration limit. This is current-state feedback, continuous, reflection
equivariant, and independent of clock, route, world coordinates, target
identity, or exact vortex phase.

The hypothesis is that moving predicted-miss authority into the posterior
target shape preserves the useful terminal translation without repeatedly
amplifying an already large carrier acceleration. Support requires capture on
the direct compact-wake route, terminal course miss at or below the directional
allocator's `0.461L`, zero anterior `>40 deg` dwell, posterior dwell no worse
than `0.681%`, peak normalized planar force/moment no worse than about
`0.040/0.019`, and arrival within the sampled `15.14--15.34T` class. Falsify
on lost capture, a wider course, renewed limit exchange, higher load class,
slower arrival without better margin/reserve, changed far-field behavior,
nonfinite commands, or loss of reflection equivariance. Formal CFD is deferred
to EvE and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and closed-loop direction tracking
source_mechanism: couple bounded rhythm offset and amplitude modulation while preserving the autonomous propulsive carrier
transferable_invariant: steering displacement and rhythmic excursion should share a fixed actuator envelope instead of adding steering authority on top of an already large carrier
nontransferable_details: published gains, dimensional beat frequencies, hardware duty ratios, robot linkage geometry, species-specific kinematics, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: map normalized body-frame cubic predicted miss to a posterior wave-center offset and contract the two-joint lagged carrier by the offset's fraction of inherited oscillator amplitude
falsification: reject if capture margin, arrival, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The required guidance-materiality/parameter-schema check, lightweight Julia
policy contract, and solver editable-boundary check pass without running CFD.
A deterministic `1,620`-state grid spanning normalized body-frame target and
velocity geometry, heading response, and both joint angles and rates produced
finite commands inside the owned `30 rad/T^2` smooth envelope with exact
left/right reflection (maximum error `0.0`). The wave-target mechanism changed
`1,035` grid states relative to the assigned tail-residual parent, confirming
an active feedback/actuator change rather than a comment or scalar-only edit.
These algebraic results do not establish capture, wake, load, joint-history,
or terminal-margin improvement; those remain falsifiable in EvE's formal CFD.
