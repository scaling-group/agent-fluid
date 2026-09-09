# Carrier-separated predicted-miss candidate

## Visual and metric diagnosis before editing

All four sampled solver rollouts and the two completed inherited parent
rollouts satisfy the frozen experiment contract: direct uniform still-water
initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
dynamics, and capture termination. I inspected the sampled combined keyframe
sheets from release through capture, including both top-down vorticity and
oblique body/Lambda2 rows, and compared the score-leading tail-only residual
with the actuator-stressed absolute-reserve allocator and the assigned
parent's posterior-wave result. Each fish genuinely self-propels down-left;
the top-down rows retain an alternating reverse-street-like wake and the
oblique rows retain a compact body-connected three-dimensional vortex train.
No sheet shows passive advection, wake breakup, boundary interaction, or
instability. The common carrier and broad route should therefore remain.

The completed evidence closes two tempting terminal representations. The
assigned parent's envelope-preserving posterior target retained capture and
the compact wake but slowed to `15.8431T/-0.02283`, widened head-relative
constant-course miss to `0.725L`, and retained `0.174%` posterior `>40 deg`
dwell despite reducing peak normalized force/moment to `0.03506/0.01724`.
The inherited approach-scheduled phase-space reserve recovered
`15.2650T/-0.01575`, reduced miss to `0.529L`, posterior dwell to `0.360%`,
and peak loads to `0.03781/0.01864`; however, it did not beat the sampled
directional allocator's `0.461L` margin. More posterior amplitude
contraction or another reserve threshold is not supported.

The synchronized trajectories expose a different mechanism. For `t>3T` and
distance above `3L`, body-frame lateral velocity in the four sampled captures
and parent rollout is explained with `R^2=0.842--0.927` by a stable carrier
proxy spanning only `-0.1384-- -0.1419` times anterior joint rate plus
`0.0783--0.0852` times posterior joint rate. Raw constant-course miss inside
`3L` consequently oscillates with the propulsive beat. Subtracting the common
`-0.141/0.084` proxy offline reduces its standard deviation from
`0.728L` to `0.483L` for the scheduled-reserve rollout and from
`0.709--0.739L` to `0.468--0.493L` for the other sampled allocators. This
diagnostic is not a counterfactual CFD result, but it shows that the terminal
predictor currently mistakes coherent carrier sway for persistent course
error.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target-directed correction from fast alternating rhythmic lateral motion while preserving the autonomous propulsive carrier
transferable_invariant: a course predictor should act on motion residual to the productive carrier rather than repeatedly reject carrier-phase sway as persistent route error
nontransferable_details: published gains, Karman-vortex phases, cylinder layouts, dimensional beat frequencies, robot linkage geometry, species-specific kinematics, task coordinates, routes, and waypoints
policy_translation: retain raw normalized body-frame velocity for far-field course steering, but use the existing near-target gate to subtract an evidence-fitted normalized two-joint-rate sway proxy from lateral velocity only for the constant-course terminal miss request
falsification: reject if capture, direct routing, compact wake, arrival, terminal miss, joint reserve, load scale, finite bounded commands, or reflection equivariance worsens; refit or remove the proxy under a different carrier if joint-rate explanatory power is not stable

## Single candidate hypothesis

Start from the inherited approach-scheduled phase-space reserve and change one
feedback mechanism. Normalize both joint rates by the owned carrier rate
`omega*amplitude`, form a reflection-equivariant lateral carrier-sway proxy,
and use the inherited smooth distance gate to remove it only from the velocity
used to calculate signed predicted miss. Keep raw measured velocity for
pursuit/course blending, closing alignment, time-to-closest gating, and all
far-field behavior. Preserve the oscillator,
posterior lag, shared response-plus-miss handoff, tail pulse, directional
reserve allocation, approach-scheduled projection, and smooth acceleration
limit.

The hypothesis is that a phase-cleaner miss request will stop the terminal
residual from re-engaging on ordinary beat sway while retaining the useful
redirect and translation. Support requires capture with the direct compact
wake, miss at or below the directional benchmark's `0.461L`, zero anterior
`>40 deg` dwell, posterior dwell at or below `0.681%`, peak normalized
force/moment no worse than about `0.040/0.019`, and arrival in the
`15.14--15.34T` class. Falsify on a wider course, slower arrival without a
margin gain, loss of capture/wake coherence, renewed joint/load exchange, or
observable far-field route change. Formal CFD remains deferred to EvE and is
not evidence available to this worker.

## Dry validation boundary

The prescribed guidance-materiality/parameter-schema check, lightweight Julia
policy contract, and solver editable-boundary check pass without CFD. A
deterministic `58,320`-state grid over normalized target/course geometry,
heading response, both joint angles, and both joint rates produced finite
commands inside the owned `30 rad/T^2` smooth envelope with exact left/right
reflection (maximum error `0.0`). The new observation changed `30,672` grid
states from the inherited scheduled-reserve parent, confirming an active
feedback change. Replay-style evaluation on each sampled trajectory left the
outer route above `5L` effectively unchanged (mean command difference below
`1e-5 rad/T^2`, maximum below `0.0017`) while changing all logged states inside
`3L` (mean `0.724--0.923`, maximum `4.54--6.18 rad/T^2`), matching the intended
terminal localization. These algebraic and same-state comparisons establish
boundedness, symmetry, localization, and activity only; they do not establish
counterfactual capture, wake, margin, joint history, loads, or arrival.
