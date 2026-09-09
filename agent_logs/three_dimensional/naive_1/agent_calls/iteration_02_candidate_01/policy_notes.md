# Multi-wake target-policy candidate notes

## Prior-evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and finite dynamics. None
  captures the target; every termination is `left_domain`.
- The naive seed's top-down alternating street and oblique Lambda2 chain show
  genuine self-propulsion, but the street curves upward with the fish. It
  improves only from `12.328L` to `12.064L` and exits the upper boundary at
  `8.613T`, so the joint-state rhythm is useful while its uncontrolled mean
  turn is not.
- The best-scoring posterior-only, yaw-damped curvature candidate preserves a
  coherent wake and makes monotonic `1.232L` progress, but it still exits the
  upper boundary at `10.026T`. Its final bearing reconstructed from the logged
  head and heading is about `-0.83rad`, showing that posterior-only authority
  did not arrest the seed's sweep soon enough.
- The prefilled shared-bias candidate produces the most useful distinct
  trajectory: the top-down and oblique rows retain a strong three-dimensional
  wake through a decisive downward turn, and distance reaches `8.174L` at
  `16.494T`. It then continues below the target and exits the lower boundary at
  `26.043T`, with distance back at `12.336L`. Cross-checking its trace shows
  mean reconstructed bearing `+0.719rad` and heading increasing from `+0.506`
  to `+1.693rad`; therefore, for this *shared anterior/posterior bias
  distribution*, positive bias has sustained positive-yaw authority, opposite
  to the sign assumed from posterior-only calibration. Raw acceleration also
  exceeds the envelope on `57.3%/61.3%` of samples, so increasing the bias is
  not a defensible response.
- The equal `9deg/9deg` bias candidate is the informative control failure. Its
  top-down sheet has little early alternating wake before a tight target-away
  U-turn, both joints settle near the static bias, minimum distance improves by
  only `0.008L`, and it exits at `15.361L`. This rules out treating equal joint
  offsets or a distribution-independent curvature sign as a reusable answer.
- The inherited first-generation notes correctly preserve the seed carrier,
  but their claimed positive-bend-to-negative-yaw sign does not survive the
  two completed shared-bias rollouts. The actuator distribution must be part of
  the empirical sign convention.

## Policy hypothesis before edit

Retain the prefill's state-feedback oscillator, posterior lag, and modest
`8:6.4` anterior/posterior bias distribution because they preserve a strong
wake and produced the best closest approach. Reverse only this distribution's
observed steering sign: positive normalized body-frame bearing requests
negative shared mean bias. Add bounded recent-yaw response inside the same turn
request so an already developing negative yaw continuously releases and then
brakes that bias. Saturating the yaw observation before combining it with
bearing prevents beat-scale rate spikes from becoming an unbounded
acceleration correction. This is one response-damped mean-curvature mechanism,
not a route, clock, vortex-phase command, or carrier gain sweep.

Expected evidence is target-bearing contraction, a left/down trajectory that
does not continue through the lower boundary, retained alternating top-down
and oblique wakes, and a better termination class or materially better final
distance. Falsify the mechanism if the initial turn sign remains positive, the
upper or lower boundary topology repeats without added target progress, the
coherent traveling wake collapses, joint angles approach `45deg`, or raw
acceleration clipping becomes more persistent than the prefill.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and fish burst-redirect turning
source_mechanism: preserve a propulsive rhythm while target error commands bounded mean curvature that is released as measured yaw response appears
transferable_invariant: signed target-side error should create bounded curvature, and observed turn response should reduce that curvature before overshoot
nontransferable_details: published gains, robot or species kinematics, clocked CPG phase, exact vortex phases, world routes, and actuator sign from a different joint-bias distribution
policy_translation: map clamped body-frame bearing plus bounded recent-yaw response to the empirically signed shared two-joint equilibrium shift inside the existing state-feedback traveling bend
falsification: reject if bearing does not contract, turn sign is still wrong, either boundary-exit topology repeats without useful progress, propulsion loses coherence, or saturation increases
