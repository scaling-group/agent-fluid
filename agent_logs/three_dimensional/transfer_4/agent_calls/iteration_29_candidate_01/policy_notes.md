# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- All four sampled episodes satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
  The two identical v12 samples establish deterministic evidence rather than
  independent mechanisms.
- In both the top-down vorticity row and oblique Lambda2 row, the fish builds a
  coherent alternating traveling wake by `4T`, sustains it through transit, and
  turns into the capture circle without passive advection. The v12, v16, and
  v20 sheets have the same useful wake class; there is no visible wake breakup,
  collision, domain exit, or instability to repair.
- The v16 terminal posterior envelope changes only the approach and improves
  final course alignment/absolute yaw from v12's `0.0678/1.0892 rad/T` to
  `0.1818/0.4200 rad/T`, with a shorter `13.2111L` center path and `0.7232L`
  maximum head cross-track. The v20 instantaneous yaw-power selector has the
  best sampled scalar/mean distance (`-0.064028/1.950358L`) but gives back most
  of that terminal control: final alignment is `0.1092`, absolute yaw is
  `0.9840 rad/T`, cross-track is `0.7317L`, and inherited diagnostics report
  increased near posterior acceleration-ceiling residence. Its score gain is
  therefore not evidence that raw yaw or moment sign identifies useful
  terminal damping half-cycles.
- On every distinct sampled trace, a reflection-odd least-squares model of
  approach yaw from anterior angle normalized by the `24 deg` envelope and
  anterior rate normalized by the base carrier phase rate explains
  `99.24%`--`99.40%` of yaw variance. Angle/rate coefficients span
  `0.5194`--`0.5298` and `-3.4842`--`-3.3059`; the residual is only
  `0.1704`--`0.1828 rad/T` RMS versus `2.1005`--`2.2133 rad/T` raw RMS.
  Although the residual RMS is not a usable gate scale, `0.060 rad/T` makes
  mean `tanh(abs(residual)/scale)` authority `0.8467`--`0.8770`, matching the
  existing raw-yaw gate's `0.8630`--`0.8738` without a scalar authority cut.

## Policy hypothesis

Keep the v16 route request, traveling-wave propulsion, and approach envelope.
Replace only the envelope's raw-yaw selector with a carrier-demodulated yaw
residual: subtract the anterior phase-locked yaw prediction from measured yaw,
then apply the existing approach and course-misalignment qualifiers. This is a
new observation mechanism, not a gain sweep. Far/middle behavior remains
exactly inactive because the approach gate is unchanged, and the residual gate
is authority-matched so the rollout tests phase discrimination rather than a
generic weakening of posterior propulsion.

The candidate is falsified if pre-approach action or wake topology changes; if
capture, mean distance, or arrival regresses materially; if final alignment,
yaw, cross-track, loads, and joint-limit residence do not improve together; or
if reflection/disturbance evidence fails to retain the odd carrier model.

bookshelf_consulted: true
source_domain: robotic-fish CPG state feedback and terminal capture control
source_mechanism: infer rhythmic phase from observed joint state, separate the fast locomotor carrier from slower directional response, and schedule only the necessary terminal allocation
transferable_invariant: normalized joint phase can identify gait-locked motion that should not be mistaken for target-route response
nontransferable_details: published oscillator gains, dimensional cadence, species kinematics, exact vortex phase, fitted coefficients outside these sampled rollouts, and task-specific routes
policy_translation: use normalized anterior angle and rate to predict the reflection-odd carrier component of yaw; gate the existing posterior-wave approach relief with only the remaining yaw residual while leaving body-frame target feedback unchanged
falsification: reject if the residual model or matched gate authority is unstable under reflection or disturbance, or if transit, capture, closure, terminal alignment/yaw, actuator residence, loads, or either wake view worsens
