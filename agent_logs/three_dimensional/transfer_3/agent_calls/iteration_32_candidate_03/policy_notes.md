# Carrier-demodulated route-bearing candidate

## Evidence and visual diagnosis recorded before editing

- All four sampled evaluations satisfy the fixed experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture at `18.6560--18.6890T`. The assigned-parent
  `dogfish3d_actuator_consistent_tail_phase_v1` policy is present twice and
  captures at exactly `18.6725T`; its scores differ by `0.00144`, so changes
  inside that spread are not robust improvements by themselves.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the best-score parent replicate, the one-sided demodulated allocator, and
  the less favorable sampled capture from release through termination. In
  every top-down row the fish translates from a wake-free release and sheds a
  compact alternating body-led street by `4T`; the street remains coherent
  through capture. The oblique rows independently show paired three-
  dimensional structures trailing the moving tail, with no detached flow
  feature advecting the body, wake collapse, boundary event, or instability.
  Local-flow RMS is only `0.01808--0.01816U`, confirming self-propulsion.
- The sampled physical-response allocators do not separate route from effort
  robustly. Helpful raw-moment amplitude relief is fastest at `18.6560T`, but
  inherited logs report an exact-policy repeat near `18.99T`. The one-sided
  carrier-demodulated residual captures here at `18.6890T`, score `-0.13525`,
  mean distance `2.02295L`, posterior acceleration occupancy `75.34%`, and
  force/moment RMS `0.013286/0.006917`. It therefore preserves the wake and
  capture but again misses the inherited `74.44%` and
  `0.013105/0.006822` effort-replication bounds. Another moment gate or scale
  is not supported.
- The common route defect is instead synchronized with the carrier. In both
  exact-parent replicates, raw bearing moves from about `0.04 rad` at `1T` to
  `0.38 rad` at `2.5T` while only `0.19L` of range is closed, and briefly
  changes sign near `3.5T`. A centered one-period offline diagnostic finds
  `0.1496 rad` RMS carrier content in raw bearing. Regressing that content on
  normalized `(q1,q2,qd1/omega,qd2/omega)` leaves `0.02135 rad` RMS; the four
  independent fitted coefficient sets are close, including across both exact
  parent runs and both allocator variants. This supports a new observation
  semantic rather than more actuator authority.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and phase-lag steering of a propulsive traveling wave
source_mechanism: separate slow directional feedback from self-generated rhythmic carrier motion while preserving the productive traveling bend
transferable_invariant: route feedback should respond to the target geometry left after subtracting repeatable joint-phase recoil, while the carrier and bounded state-feedback steering remain intact
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, target coordinates, and task-specific routes
policy_translation: subtract the sampled normalized two-joint carrier projection from instantaneous body-frame bearing, then use that reflection-odd conditioned bearing in the existing LOS route and anterior recruitment paths without adding physical-response authority
falsification: reject if capture is lost, arrival leaves the inherited `18.6560--19.0520T` band, either wake view loses coherence, mean distance exceeds `2.02295L`, posterior acceleration occupancy exceeds `76.2%`, or force/moment RMS exceeds `0.01350/0.00703`; also reject the interpretation if raw-to-conditioned bearing carrier RMS is not reduced in the evaluated trace

## Candidate hypothesis

Create one candidate by changing only the route observation in the replicated
actuator-consistent parent. Estimate the carrier-correlated bearing component
from bounded joint angles and velocities using the pooled sampled coefficients,
and subtract it before the bearing yaw-rate and anterior redirect calculations.
Keep raw bearing as a diagnostic, and preserve the rotation-invariant LOS-rate
term, distributed C-bend, traveling carrier, response-reversing half-cycle
steering, persistent same-side stress gate, coefficient-norm-preserving phase
rotation, and feasibility projection exactly.

The intended effect is to stop self-generated body recoil from repeatedly
recruiting and releasing the slow route loop during an otherwise coherent
beat. This is not a claim of new CFD evidence. A later evaluation must test
whether the conditioned bearing improves early range closure and mean distance
without leaving the replicated capture, wake, load, and saturation boundaries
above.

## Pre-CFD static audit

Replaying the observation transform on the four completed traces lowers raw
bearing RMS from about `0.250 rad` to `0.158--0.161 rad` and lowers the
counterfactual combined-yaw-demand RMS from `0.281--0.286` to
`0.241--0.248 rad/T`; demand saturation falls in every trace. This replay does
not predict the closed-loop trajectory and is not outcome evidence. A mirrored
synthetic-state check gives exactly sign-reversed finite joint actions, so the
new projection preserves the parent's reflection equivariance.
