# Complementary amplitude-to-phase candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. The fastest actuator-consistent rollout and the
  slowest half-cycle-only rollout both show body-led self-propulsion in the
  combined sheets. Their top-down rows develop coherent alternating vortex
  streets from release through capture, while their oblique rows show compact
  three-dimensional Lambda2 structures following the fish. Neither view shows
  passive advection, wake collapse, collision, a terminal loop, or instability.
- The assigned parent leads phase recruitment from the current posterior
  demand and previous feasible action. It captures at `18.7880T`, scores
  `-0.14000`, and has mean distance `2.02833L`, improving slightly on the
  current-demand gate at `18.7990T`, `-0.14330`, and `2.03111L`. Its lead comes
  with `75.67%` posterior acceleration-limit occupancy and
  `0.01333/0.00694` force/moment RMS, between the current-demand gate's
  `74.20%` and `0.01315/0.00684` and the half-cycle-only path's `76.41%` and
  `0.01357/0.00707`.
- The sampled actuator-consistent gate is the decisive new result. Requiring
  current unclipped demand and previous applied action to have persistent
  same-side stress captures at `18.6725T`, scores `-0.13362`, and lowers mean
  distance to `2.02129L`. It preserves the coherent wake and low local-flow RMS
  (`0.01809U`), but its `76.41%` posterior occupancy and
  `0.01350/0.00703` force/moment RMS give back the load relief of broader phase
  recruitment. Thus temporal selectivity improves the route, while stacking
  full half-cycle amplitude asymmetry with the recruited phase path leaves the
  actuator tradeoff unresolved.

## Policy hypothesis recorded before editing

Start from the fastest actuator-consistent policy. Preserve its normalized
body-frame bearing and LOS-rate guidance, recoil-conditioned yaw response,
distributed C-bend, coherent carrier, persistent same-side phase gate,
coefficient-norm-preserving posterior phase rotation, and componentwise
physical projection.

Change only how the two fast steering actuators combine. As the existing
phase activation rises, continuously fade the half-cycle amplitude-asymmetry
fraction by its complement before scaling the phase-rotated posterior wave.
At zero recruitment this is exactly the fastest sampled half-cycle path; under
persistent stress it hands authority from amplitude asymmetry to phase instead
of stacking both. No carrier gain, route gain, phase angle, limit, clock,
coordinate, range schedule, or mutable state is added.

Support requires capture no later than the replicated half-cycle lower bound
`18.931T`, preferably retaining the actuator-consistent `18.6725T` timing,
while reducing posterior occupancy or force/moment load below
`76.41%` and `0.01350/0.00703`. Falsify the handoff if capture is lost, arrival
exceeds `18.931T` without material load relief, the alternating wake weakens,
or the route reverts toward the broader current-demand phase trajectory.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and phase-lag or asymmetric-flapping steering
source_mechanism: sensory feedback switches bounded steering authority between rhythmic amplitude asymmetry and posterior timing while retaining propulsion
transferable_invariant: preserve the traveling-wave carrier and use observed actuator response to recruit one bounded steering mode while releasing the competing mode
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: keep normalized body-frame LOS and two-joint feedback, use persistent same-side normalized actuator stress for phase recruitment, and multiply half-cycle asymmetry by the complementary phase authority
falsification: reject if capture is lost or later than 18.931T without load relief, wake coherence degrades, or posterior occupancy and force or moment loads exceed the actuator-consistent sample
