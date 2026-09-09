# Actuator-consistent phase robustness candidate

## Evidence diagnosis recorded before the policy edit

- All four reference rollouts and the relevant inherited completed rollouts
  satisfy the frozen contract: direct uniform `U_infinity=(0,0,0)`
  initialization, no cylinders or prewarm, finite dynamics, and capture. In
  the fastest reference, assigned prefill, identical-hash repeat, and slow
  moment-forecast sheets, the top-down rows show body-led progress and a
  coherent alternating posterior vortex street from release through capture;
  the oblique rows show compact paired three-dimensional Lambda2 structures
  following the swimmer. None shows passive advection, wake collapse, a loop,
  collision, boundary exit, or instability. The sparse visuals are nearly
  indistinguishable, so route, actuator, and load histories decide the test.
- Persistent same-side actuator gating has the strongest single reference:
  capture at `18.67250T`, score `-0.13362`, mean distance `2.02129L`,
  anterior/posterior limit occupancy `42.68%/76.41%`, and force/moment RMS
  `0.01350/0.00703`. Its exact policy hash, however, captures at `19.00799T`
  and scores `-0.15441` in the inherited repeat, with `43.11%/75.32%`
  occupancy and `0.01336/0.00695` loads. That `0.33549T` same-controller
  spread is larger than every current architectural timing difference, so the
  fastest scalar is not a resolved mechanism improvement.
- The assigned prefill's full amplitude-to-phase handoff captures at
  `18.74950T` and lowers posterior occupancy to `74.48%`, but it has no
  replicated semantic advantage. Raw hydrodynamic-moment variants likewise
  preserve capture without resolving timing: sign-only phase release arrives
  at `18.78799T`, error-conditioned release at `18.77150T`, and a bounded
  moment forecast at `18.98599T`. The forecast is the concrete negative result:
  despite moment-to-next-yaw-acceleration correlation `0.972`, it is slower
  than the actuator-consistent run and its identical-hash repeat mean, while
  occupancy and force/moment RMS remain `44.70%/75.87%` and
  `0.01355/0.00705`. Instantaneous moment predictiveness is therefore not
  evidence that the signal should own route or beat-side correction.
- Local-flow RMS remains `0.01798--0.01839U` throughout these completed
  captures, agreeing with the visual diagnosis that this is self-generated
  propulsion in quiescent water. No external-wake rejection claim is
  supported.

## Policy hypothesis recorded before editing

Replace the complementary prefill with the exact sampled actuator-consistent
controller as one deliberate robustness candidate. Preserve normalized
body-frame bearing and LOS-rate guidance, recoil-conditioned yaw response,
continuous distributed C-bend, response-reversing half-cycle authority, the
traveling-wave carrier, persistent same-side demand/previous-action phase
gate, fixed-coefficient-norm posterior phase rotation, and explicit physical
projection. Do not add another raw-moment path, gain adjustment, range gate,
or task route. A third completed observation is more discriminating than an
untested combination of mechanisms already negative within same-hash spread.

Support requires capture with both wake views coherent, arrival inside the two
existing identical-hash outcomes (`18.67250--19.00799T`), posterior occupancy
no greater than `76.41%`, and force/moment RMS no greater than
`0.01350/0.00703`. A third result near the fast branch would support the
persistence gate; a result near `19T` would demote its apparent speed gain to
replicate variability. Falsify the architecture if capture is lost, arrival
exceeds the replicated half-cycle upper bound near `19.052T`, or load exceeds
the inherited failed-route bounds `0.01574/0.00810`. Later workers should test
a phase-conditioned fluid-response residual or genuine beat-scale history,
not another memoryless raw-moment selector, if this repeat does not separate.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and phase-lag turning
source_mechanism: sensory state recruits bounded posterior timing changes while preserving a propulsive traveling rhythm
transferable_invariant: preserve the carrier and modulate posterior phase only while observed actuator response remains consistent with the current body-frame route correction
nontransferable_details: published gains, clock phase, robot geometry, species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: retain normalized LOS feedback and use the positive signed product of current posterior demand and previous feasible action to gate bounded reflection-equivariant posterior phase rotation
falsification: reject if capture or wake coherence is lost, arrival exceeds 19.052T, posterior occupancy exceeds 76.41%, or force/moment RMS exceeds 0.01574/0.00810

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
