# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- The four sampled evaluations and the assigned-parent evaluation all report
  direct uniform initialization at `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Motion is released self-propulsion rather than ambient advection.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the best-scoring sampled capture (`solver_6b0e320e2f55`, `0.74939L`) and the
  assigned-parent phase-compensated-course failure (`solver_8e1d49afc401`,
  `1.54446L`). The capture lays down a coherent alternating street from the
  early frames through arrival; its oblique row shows compact bilateral 3D
  structures and an active body wave at capture. The failure has the same
  productive qualitative wake and remains self-propelled through closest pass
  and lower-boundary exit. It turns onto a steeper lower branch rather than
  losing its carrier, being swept away, or becoming numerically unstable.
- Three sampled files are exact-byte
  `dogfish3d_intercept_guarded_speed_reserve_v1` repeats, and all three capture
  at `0.74664--0.74939L` after `18.32--18.60T`. Their terminal paths vary by a
  substantial fraction of a body length and their instantaneous achieved-
  course errors differ within each beat, yet the normalized target/course
  feedback, interception guard, additive steering, and sparse carrier reserve
  survive that variation (`3/3`).
- The prefilled posterior-wave pulse captures in the current sampled sheet,
  but inherited exact-policy evidence is only `2/3`: its third replay retains
  an active alternating wake, misses below at `1.25888L`, and exits. It has no
  arrival, load, clipping, or wake advantage outside the exact speed-reserve
  baseline envelope. That evidence rejects retaining or scalar-tuning this
  phase-dependent residual.
- The assigned parent replaced the pulse with a bounded terminal observation
  compensator inferred offline from the correlation between anterior joint
  speed and lateral body velocity. Its sheet remains coherent, but closed-loop
  evaluation misses below at `1.54446L`, exits at `32.02T`, and finishes
  `10.4040L` away. At first `4L/3L/2L` crossings its head is approximately
  `0.36/0.50/0.77L` lower than the best sampled baseline capture; it never
  enters `1.5L`. Thus reduced recorded route-error variation was not a valid
  causal proxy for interception, and tuning the `0.42U` cancellation scale
  would be another scalar response to an already falsified observer.
- Inherited guidance also rejects cadence relief, terminal carrier collapse,
  total-command speed governors, half-cycle allocation, projected-miss route
  replacement, yaw braking, posterior phase shaping, and mean-curvature
  tracking for this coherent lower-pass topology.

## One candidate hypothesis

Restore the exact repeat-backed
`dogfish3d_intercept_guarded_speed_reserve_v1` controller. Relative to the
prefilled posterior-pulse candidate, remove only the phase-dependent tail
residual and its parameter. Do not add the failed course compensator or any
new actuation term. This preserves the sampled controller whose three exact
repeats all captured while retaining its posteriorly lagged traveling bend,
body-frame target/course feedback, LOS and closest-pass release guard, full
additive steering, and conditional outward-carrier reserve.

Expected test: recover the `3/3` sampled capture topology with the same
coherent two-view wake and approximately `0.83--0.91L/T` terminal
self-propulsion. The improvement sought over the prefill is repeat-supported
semantic reliability, not a scalar score claim or reduced clipping.

Falsification: reject robustness of the restored baseline if an exact-policy
repeat loses capture, weakens either wake view, changes far-field closure, or
moves speed residence, clipping, force, or moment outside its sampled
envelope. Such a failure should motivate a genuinely phase-invariant
task-error observation with repeated diagnostics, not renewed tuning of the
posterior pulse or phase-sway cancellation.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a posteriorly lagged traveling bend for propulsion and keep bounded route feedback subordinate to that active rhythm
transferable_invariant: a directed posterior-emphasized body wave can sustain propulsion while target steering is closed through normalized observed geometry; a source mechanism is retained only while rollout evidence supports it
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact oscillator or vortex phase, task coordinates, and memorized routes
policy_translation: retain the observed-joint-state carrier, posterior lag, normalized body-frame target/course servo, and bounded two-joint steering; remove the unsupported phase-dependent posterior residual without changing gains
falsification: reject if exact repeats lose capture or wake coherence, alter far-field closure, or leave the evaluated actuator and load envelope
