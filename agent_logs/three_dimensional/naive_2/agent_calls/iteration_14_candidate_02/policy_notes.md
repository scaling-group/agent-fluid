# Candidate diagnosis and policy hypothesis

## Visual and metric diagnosis before the edit

- Every assigned rollout and inherited completed rollout reports direct uniform
  still-water initialization with `U_infinity=[0,0,0]`, no cylinders, and no
  prewarm. In the compared combined sheets, the top-down rows show leftward
  self-propulsion and persistent alternating vortex streets, while the oblique
  rows retain tail-connected three-dimensional Lambda2 structures through the
  useful transit. The common upper-boundary exit is a route-control failure,
  not advection, wake collapse, or numerical instability.
- The assigned examples preserve one failure topology. The best scalar sample
  reaches only `5.126L`; the closest sample reaches `4.530L`; all four exit the
  upper boundary at `20.52--21.72T`. Distance relief, signed agreement, and
  closure-conditioned posterior relief therefore do not supply capture or a
  useful terminal redirect even though their wakes remain propulsive.
- The inherited response-deficit posterior half-cycle controller is still the
  strongest completed route: it reaches `2.169L` at `18.453T` with speed
  `0.767U`, then misses laterally and exits high at `28.04T`. At the miss, the
  target is `[-0.738,-2.039]L` in body coordinates and measured yaw is
  `-2.281 rad/T` against a calibrated requested yaw near `+0.800 rad/T`.
  Posterior mean curvature is already saturated, and posterior half-cycle
  relief improved the preceding result by only `0.130L`.
- The assigned parent's newly completed near-abreast anterior equilibrium
  shift is a concrete regression. It worsens closest approach from `2.169L`
  to `2.931L`, exits through the same upper boundary earlier at `24.79T`, and
  reaches its minimum with the head still at `y=12.351L` and world lateral
  velocity `+0.283U`, away from the lower target. The baseline minimum had
  reached `y=11.667L` while moving at `-0.276U`. Peak planar force and yaw
  moment remain comparable (`0.0328/0.0171` versus `0.0335/0.0170`), and both
  visual rows retain a coherent carrier. The extra mean center altered the
  useful course rather than fixing a propulsion or load failure.

## Single candidate hypothesis

Return to the stronger inherited response-deficit controller, preserving its
full-amplitude anterior state-feedback oscillator, approach-aware course
center, calibrated posterior-curvature-to-yaw mapping, bounded posterior mean,
posterior lag, and response-gated posterior half-cycle relief. Replace the
failed extra anterior mean center with one distinct actuator use: when the
target is near the head's transverse plane, distance is small, forward speed
is established, and measured yaw is still short of the calibrated request,
add damping only while joint 1 is entering the half-cycle opposing that route
request. The useful anterior half-cycle is untouched, correct or excessive yaw
releases the addition, and the oscillator equilibrium is never displaced.

This phase-selective damping translates asymmetric-flapping duty control rather
than retuning posterior gain. On the completed `2.169L` history, an algebra-only
replay bounds the added pre-soft-limit damping acceleration at
`8.21 rad/T^2`; mean absolute addition is `1.20 rad/T^2` inside `3L` and only
`0.00007 rad/T^2` beyond `8L`. These values establish localization and
boundedness, not a counterfactual hydrodynamic result. Expected behavior is to
retain the deep first approach and coherent wake while clipping only the
counter-turning anterior excursion near the lateral pass, producing capture,
re-approach, or a meaningfully different termination path.

Reject the mechanism if it worsens the inherited `2.169L` approach, repeats
the upper exit without a tighter or re-approaching arc, raises joint-limit or
acceleration residence, increases peak force or moment materially, or disrupts
either wake view. The current candidate has no CFD result yet.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and asymmetric flapping
source_mechanism: preserve a rhythmic carrier while measured directional-response deficit gates damping on only the counter-turning half-cycle
transferable_invariant: separate propulsion from turning by continuously weakening only the observed joint-state phase that opposes a calibrated route request, and release the asymmetry when directional response appears
nontransferable_details: published gains, dimensional frequencies, robot geometry, species kinematics, prescribed duty ratios, exact vortex phases, maneuver timing, and task-specific routes
policy_translation: combine normalized body-frame target geometry, velocity, and measured yaw with joint angle and velocity; near the failed pass, damp only entry into the opposing anterior half-cycle while leaving its equilibrium and the posterior traveling wave intact
falsification: reject if the inherited 2.169L approach or coherent wake is lost, upper-boundary topology persists without re-approach, or actuator residence and hydrodynamic loads worsen materially

## Evaluation boundary

The later CFD evaluation should compare capture and termination first, then
minimum distance, target body-frame components at the first pass, re-approach,
post-minimum recession, requested-versus-measured yaw, anterior half-cycle
amplitudes, acceleration residence, force/moment peaks, and both visual rows
against the inherited `2.169L` response-deficit rollout.
