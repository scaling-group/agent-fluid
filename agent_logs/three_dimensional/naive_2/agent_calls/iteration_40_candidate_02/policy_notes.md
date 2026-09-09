# Carrier-separated terminal-margin replication

## Visual and metric diagnosis before editing

All four sampled rollouts and the three completed inherited parent rollouts
satisfy the frozen-flow contract: direct uniform initialization in still water
with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
capture termination. I inspected the sampled combined keyframe sheets from
release through capture, including the top-down mid-plane vorticity row and
the oblique body/Lambda2 row. The score-leading tail-only residual and the
directional-reserve comparison both genuinely self-propel down-left; neither
is advected by a background current. Their top-down rows retain coherent
alternating wakes and productive targetward translation, while their oblique
rows retain compact body-connected three-dimensional vortex trains. The
remaining sampled sheets have the same wake and route topology. No sheet
shows wake breakup, boundary interaction, or numerical instability before
capture, so changing the propulsive carrier is not supported.

The sampled policies expose the terminal compromise. The prefilled tail-only
residual is score- and arrival-best at `15.1403T/-0.01094`, but crosses with a
`0.651L` head-relative constant-course miss, `1.269%` posterior `>40 deg`
dwell, and `0.04041/0.01902` peak normalized planar force/moment. The most
useful sampled actuator-quality comparison, the directional allocator,
captures at `15.3385T/-0.01502` with `0.461L` miss, zero anterior and `0.681%`
posterior dwell, and `0.03959/0.01889` peak loads. Thus the faster scalar
baseline is not the stronger terminal-margin baseline.

The newest inherited evidence provides a semantic improvement worth testing
for repeatability. Relative to its approach-scheduled reserve parent, changing
only the near-target miss observation to subtract a joint-rate-linked carrier
sway proxy moved terminal course miss from `0.529L` to `0.305L`, while
anterior/posterior dwell stayed `0/0.358%` versus `0/0.360%` and peak loads
stayed in the same `0.03856/0.01846` versus `0.03781/0.01864` class. It still
captured with the direct compact wake, but arrival slowed from `15.2650T` to
`15.3668T` and score changed from `-0.01575` to `-0.01589`. This is the first
completed candidate in the current evidence bank to beat the `0.461L`
directional margin without exchanging it for joint dwell or a higher load
class. Earlier apparently centered captures varied widely on identical or
nearly identical controllers, so one `0.305L` crossing is not yet robust
evidence.

## Single candidate hypothesis

Promote the completed carrier-separated controller unchanged as a deliberate
replication candidate. It preserves the established oscillator, posterior
lag, shared response-plus-miss handoff, tail pulse, approach-scheduled
phase-space reserve, directional tail-first allocation, and smooth
acceleration envelope. Only the terminal constant-course predictor removes a
body-frame lateral sway proxy formed from both normalized joint rates; raw
measured velocity continues to own far-field course steering, closing
alignment, and prediction timing. This remains continuous, state-feedback,
reflection equivariant, and independent of clock, world coordinates, target
identity, route, and exact vortex phase.

Replication supports the mechanism if it captures on the direct compact-wake
route with terminal course miss at or below the sampled directional
allocator's `0.461L`, zero anterior dwell, posterior dwell at or below
`0.681%`, peak normalized planar force/moment no worse than about
`0.040/0.019`, and arrival no slower than the inherited `15.3668T` result.
Another miss near `0.305L` would materially strengthen margin robustness.
Falsify or refit the carrier proxy if the crossing widens, capture or wake
coherence is lost, joint/load quality worsens, or the small arrival penalty
grows. Formal CFD is deferred to EvE and is not evidence available to this
worker.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target-directed correction from fast lateral motion tied to the productive rhythmic carrier
transferable_invariant: terminal route correction should act on motion residual to the self-propelled carrier rather than reject ordinary carrier-phase sway
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, robot linkage geometry, exact vortex phases, fitted coefficients from another carrier, task coordinates, routes, and waypoints
policy_translation: normalize both observed joint rates by the owned carrier rate, subtract their bounded reflection-equivariant lateral sway proxy only from the body-frame velocity used for near-target predicted miss, and retain raw velocity for propulsion and broad navigation
falsification: reject or refit if replicated capture margin exceeds `0.461L`, arrival exceeds `15.3668T`, compact-wake routing changes, posterior dwell exceeds `0.681%`, peak loads exceed about `0.040/0.019`, commands become nonfinite or unbounded, or reflection equivariance fails

## Dry validation boundary

The prescribed guidance-materiality and parameter-schema guard, lightweight
Julia policy contract, and solver editable-boundary check pass without CFD.
The candidate is byte-identical to the completed inherited carrier-separated
controller, making this a behavioral replication rather than a nonce variant.
A deterministic `13,122`-state grid spanning normalized body-frame target and
velocity geometry, heading response, both joint angles, and both joint rates
produced finite commands inside the owned `30 rad/T^2` smooth envelope with
exact left/right reflection (maximum error `0.0`). It changed `10,446` grid
states relative to the assigned tail-residual prefill, confirming an active
feedback and actuator change. These algebraic checks establish ownership,
boundedness, symmetry, replication identity, and activity only; capture,
wake, margin, joint history, loads, and arrival remain for EvE's formal CFD.
