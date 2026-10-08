# Phase-demodulated yaw-response candidate

## Visual and metric diagnosis before the edit

- All four sampled rollouts and the inherited parent rollouts report direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders,
  and no prewarm. Their top-down rows show self-propelled motion with coherent
  alternating vortex streets, while the oblique rows retain tail-connected
  three-dimensional Lambda2 structures. The recurrent upper-boundary failures
  are directional-control failures, not advection, wake collapse, or numerical
  instability.
- The prefilled distance-relief controller reaches only `5.126L` and exits the
  upper boundary at `20.86T`. The other two sampled half-cycle variants reach
  `4.743L` and `4.530L`, then share the same upper-exit topology. The inherited
  yaw-moment residual preserves the coherent carrier and reaches `2.358L`, but
  still recedes to `7.485L` and exits high at `27.69T`; selective moment
  rejection therefore does not survive as the next useful mechanism.
- The strongest comparison isolates beat-phase demodulation. The inherited
  response-deficit controller without demodulation reaches `2.169L`, recedes to
  `7.727L`, and exits high at `28.04T`. Adding a joint-state estimate of the
  repeatable carrier yaw before computing requested-versus-measured directional
  response produces the sampled capture at `0.748L` in `16.64T`, with mean
  distance `2.003L`. Its top-down path remains targetward through the final
  sheet and its oblique wake stays tail-connected through capture.
- The semantic gain is not free: the capturing rollout raises acceleration
  near-limit residence from `52.4%` to `74.0%`, maximum speed from `1.010U` to
  `1.153U`, peak planar force coefficient from `0.0335` to `0.0369`, and peak
  yaw-moment coefficient from `0.0170` to `0.0186`. All remain finite and the
  result is a capture, but this evidence does not justify increasing authority
  or copying the phase-estimator coefficients into unrelated morphologies.

## Single candidate hypothesis

Replace the prefilled approach-relief failure with the sampled capturing
controller exactly as evaluated. Preserve the full-amplitude anterior
state-feedback oscillator, lagged posterior wave, bounded body-frame bearing,
course and crossflow steering, approach-aware anterior redistribution, and
response-gated opposing-half-cycle relief. Before comparing physical yaw with
the empirically opposite-sign posterior curvature request, subtract the
joint-angle/joint-velocity estimate of beat-synchronous yaw. This separates
fast carrier response from slow route response without an external phase,
clock, fixed route, or world-frame direction.

This is an evidence-backed champion adoption, not a scalar gain experiment.
The immediate expectation is reproduction of capture while retaining the
coherent alternating top-down wake and tail-connected 3D structures. Reject
the mechanism if the same formal task no longer captures, if it returns to the
upper-exit topology, or if instability, persistent hard-limit contact, or
materially larger force/moment peaks appear. For held-out poses or
hydrodynamics, treat the two carrier-yaw coefficients as morphology- and
filter-dependent hypotheses rather than universal constants.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and phase-selective fish turning
source_mechanism: separate slow target-directed response from fast rhythm-locked body motion, then modulate only the turn-opposing beat portion while preserving the propulsive carrier
transferable_invariant: estimate repeatable carrier-correlated yaw from observable joint state before closing the directional-response loop, and recruit bounded asymmetry only for the residual route deficit
nontransferable_details: published gains, dimensional beat frequency, robot or species geometry, exact vortex phase, task routes, and the sampled phase-estimator coefficients
policy_translation: use normalized body-frame target, velocity, crossflow and yaw with joint angle and velocity as an internal phase proxy; subtract carrier-correlated yaw and gate only posterior opposing-half-cycle attenuation from the residual
falsification: reject if capture or the targetward route is lost, the alternating carrier degrades, or actuator residence and hydrodynamic loads increase beyond the already elevated sampled envelope

## Evaluation boundary

No new CFD outcome is claimed. The post-worker rollout should compare capture
and arrival first, then route topology, mean distance, acceleration residence,
joint-limit contact, force/moment peaks, and both visual rows against the
completed capturing sample and the matched non-demodulated `2.169L` miss.
