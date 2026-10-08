# Progress-gated posterior-thrust candidate

## Evidence and visual diagnosis before editing

- The four sampled solvers are repeated evaluations of the same effective
  controller.  Each satisfies the direct-uniform contract (`U_infinity=0`, no
  cylinders, no prewarm), remains finite, and captures at `0.7496068 L` and
  `26.411 T` with score `-0.71050181`.  Their candidate files differ only in
  policy-boundary acceleration projection or metadata, and all combined
  keyframe sheets have the same hash.  There is therefore no distinct current
  failure sheet to compare; the inherited speed-guard capture and earlier
  `left_domain` misses are the available poorer controls.
- In the shared top-down row, the fish is self-propelled along a continuous
  closing arc.  An alternating red/blue wake develops by `8 T`, remains
  coherent through the broad redirect, and enters the capture circle without
  visible collapse.  The oblique row likewise shows compact alternating
  Lambda2 structures shed behind the posterior body at `8`, `16`, `24`, and
  `26.411 T`.  The lateral body oscillation is large but organized around net
  progress rather than a standing wiggle.
- Metrics support that reading: distance falls monotonically from `12.3277 L`
  to capture, mean/max speed is `0.501/0.667 L/T`, maximum local-flow magnitude
  is only about `0.0288 L/T`, and peak force/moment coefficients are about
  `0.0297/0.0148`.  Motion is not ambient advection or a large-load event.
  The remaining visible weakness is launch response: distance is still
  `12.263 L` at `1.99 T`, whereas established closure is roughly
  `0.5--0.6 L/T` after `10 T`.
- The captured carrier already reaches the joint-speed limit and its projected
  accelerations sit at the component limit in about `69.5%` of head-command
  rows and `35.0%` of tail-command rows.  This rules against another global
  frequency/amplitude increase.  The inherited outward joint-speed guard also
  supplies a negative control: it left the wake and load family essentially
  unchanged but delayed capture by `0.4015 T`, worsened mean distance from
  `2.6134 L` to `2.6382 L`, and reduced score to `-0.73429`.

## Policy hypothesis

Preserve the evaluated completion-gated redirect, target guidance, cadence
schedule, half-cycle steering, and final acceleration projection.  Add one
state-feedback mechanism to the carrier: when normalized measured closure is
poor, modestly increase only the posterior lag term that turns head-joint
motion into a traveling bend.  Scale that residual by far/approach authority
and suppress it continuously as steering load rises.  Once closure is
established, the residual vanishes and the evaluated capture controller is
recovered.

This is a posterior-thrust response gate, not a global scalar retune.  It uses
the existing normalized `closing_speed_L`, distance gate, turn request, and
observed joint state; it adds no clock, route, target identity, wake phase, or
mutable oscillator.  Expected result: shorten the low-progress launch while
retaining the established wake and terminal arc.  Falsify it if capture is
lost or delayed, early distance does not improve, tail angle/speed residence
or command saturation increases materially, the coherent wake degrades, or
force/moment extrema rise without better distance integral.

bookshelf_consulted: true
source_domain: Lighthill-style reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: emphasize posterior traveling-wave action while using measured task response to release an auxiliary propulsive command
transferable_invariant: poor observed closure may gate a bounded posterior-only thrust residual, while established closure and large steering demand should recover the proven base gait
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, clocked CPG phase, exact vortex phase, and prescribed routes
policy_translation: multiply only the posterior joint's observed-head-velocity lag term by a bounded residual from normalized closing deficit, distance authority, and inverse turn load; retain the existing two-joint state-feedback carrier and target-relative redirect
falsification: reject if launch distance, capture time, or distance integral does not improve, or if terminal steering, wake coherence, actuator-limit residence, force, or moment materially regresses

## Scope

No same-worker CFD result is claimed.  Formal evaluation of this candidate
occurs after worker exit; the current evidence supports the isolation and
falsification boundary, not the candidate's eventual outcome.
