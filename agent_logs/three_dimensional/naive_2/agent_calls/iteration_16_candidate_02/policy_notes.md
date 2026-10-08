# State-energy carrier-startup candidate

## Visual and metric diagnosis before the edit

- All four sampled evaluations confirm direct uniform still-water initialization
  with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their candidate
  files, trajectory CSVs, and combined keyframe sheets are byte-identical; after
  excluding path and timing metadata, their diagnostics are also identical.
  They are deterministic reproductions of one completed policy, not four
  independent pose or flow tests.
- I inspected that capture's combined sheet and the inherited `3.254L`
  closure-loss burst-redirect failure. In both top-down rows the fish is
  self-propelled and leaves a coherent alternating vortex street; both oblique
  rows retain tail-connected three-dimensional Lambda2 structures. The failure
  keeps this wake while bending sharply upward and leaving the virtual domain at
  `25.05T`, whereas the demodulated-response controller bends through the
  capture sphere at `0.7477L` and `16.637T`. The discriminating mechanism is
  route-response semantics, not background advection, wake collapse, or a lack
  of terminal mean curvature.
- The reproduced capture is finite but actuator-heavy: maximum joint angles
  are `0.550/0.560 rad`, both joint rates reach `4.538 rad/T`, peak planar
  force/moment are `0.0369/0.0186`, and at least one acceleration exceeds 95%
  of the released limit in about `74.0%` of samples. The connected wake and
  target crossing argue against altering its established posterior steering or
  shedding the mature carrier.
- The reproducible startup is the remaining score-relevant transient. Starting
  from `8 deg`, successive anterior extrema grow only to about `16.2 deg` at
  `3.24T`, `21.7 deg` at `3.89T`, and `26.3 deg` at `4.24T`; appreciable
  target progress likewise begins after the first several beats. A bounded
  joint-state energy injection can address that delay without changing the
  mature phase-demodulated route loop.

## Single policy hypothesis

Preserve the completed capture controller's posterior lag, body-frame
bearing/course/crossflow route, joint-phase-demodulated yaw response, anterior
course redistribution, and opposing-half-cycle steering. Add one clock-free
amplitude-acquisition mechanism to the anterior carrier: estimate normalized
oscillator radius from `(q1 - course_center, q1_dot/omega)`, inject bounded
negative damping only while that radius is below the requested carrier
amplitude, and smoothly release the addition as the radius is acquired. This
changes a feedback mechanism rather than a scalar carrier gain. The mature
oscillator and all steering expressions remain unchanged.

A joint-only integration using the released position/rate/acceleration limits
is only a scale check, not CFD: with the proposed bounded deficit gate, the
anterior envelope reaches about `26.6 deg` by `3.22T` and releases near the
`28 deg` requested radius, about one second earlier than the reproduced trace,
without asking for a larger steady amplitude or a higher acceleration limit.
The falsifiable expectation is an earlier onset of self-propelled progress and
an earlier capture while retaining the demonstrated targetward arc and mature
wake. Reject the mechanism if capture is lost, the route diverges before the
prior crossing, joint contact or load peaks worsen, or the faster acquisition
does not improve arrival/distance integral.

bookshelf_consulted: true
source_domain: robotic-fish central-pattern-generator amplitude regulation and classical traveling-wave propulsion
source_mechanism: acquire a rhythmic carrier through state-dependent amplitude feedback, then preserve posterior-lagged propulsion and sensor-modulated steering
transferable_invariant: regulate carrier acquisition from normalized oscillator state while keeping the mature propulsive rhythm distinct from the slower route-response loop
nontransferable_details: published CPG gains, dimensional startup times, species-specific envelopes, prescribed waveforms, exact vortex phases, and task-specific routes
policy_translation: form a body-controller phase radius from anterior joint angle relative to its bounded course center and joint rate divided by natural frequency; add smooth energy injection only for a positive radius deficit and leave posterior steering unchanged
falsification: reject if onset and capture are not earlier, if the completed targetward route or connected wake is lost, or if joint contact, acceleration residence, force, or moment materially worsen

## Evaluation boundary

The candidate's CFD evaluation occurs after this worker exits. Compare semantic
capture first, then arrival time, observed distance integral, early displacement
through `4T`, anterior envelope acquisition, mature joint amplitude/rate,
acceleration residence, peak force/moment, and both wake views against the
reproduced `16.637T` capture.
