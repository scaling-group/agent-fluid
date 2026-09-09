# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- All four sampled evaluations confirm direct uniform still-water
  initialization with `U_infinity=(0,0,0)` and no prewarm. In both the
  top-down mid-plane and oblique Lambda2 rows, every candidate forms a long,
  alternating three-dimensional wake, follows the same diagonal inbound path,
  passes below the target, and remains powered on a near-vertical leg until a
  lower-boundary `left_domain` exit near `31T`. This is a terminal steering
  failure, not advection, weak propulsion, wake collapse, or instability.
- The measured-yaw-selected posterior brake is the strongest sampled terminal
  action: it improves minimum/mean distance from the alignment-gated carrier's
  `2.443/8.443L` to `2.385/8.436L`. A joint-phase-selected half-cycle
  counterbend reaches only `2.512L`, and a response-released posterior
  equilibrium S-bend reaches only `2.536L`; all retain essentially the same
  final distance (`9.190--9.207L`) and powered lower exit. The best brake still
  has about `1.38 rad` full target-direction error, `2.19 rad/T` wrong-way yaw,
  near-zero closure, and about `0.705U` speed at its minimum.
- The sampled optimizer guidance and inherited notes report that yaw rate is
  almost entirely beat-locked to anterior joint velocity inside `3L`
  (`|r|=0.992--0.998`). They also record a later response-gated equilibrium
  residual at about `2.444L`, with no new termination class. Thus measured yaw
  is evidenced as a half-cycle selector, not a slow heading estimate, while
  braking, phase-only bias, persistent tail equilibrium, and scalar threshold
  edits are exhausted actions for this topology.

## Policy hypothesis

Start from the sampled response-gated brake and preserve its anterior
oscillator, target-relative mean curvature, posterior lag, alignment envelope,
approach/direction/response selector, command reserve, and exact far-field
behavior. During only the selected error-growing posterior half-cycle, map the
traveling-wave multiplier continuously from `+1` toward a bounded negative
value: the authority that the brake formerly removed becomes an opposite-side
counterstroke rather than another equilibrium offset. The full traveling wave
returns on corrective-response half-cycles. This changes actuator topology
without increasing the maximum posterior-wave magnitude or using time, world
coordinates, flow phase, or a hidden route.

The hypothesis is supported by capture, a useful new termination class, or a
minimum materially below `2.385L` with retained far-field progress and wake
coherence. It is falsified by a short tight curl, lost cruise wake or speed,
materially greater posterior clamp/load residence, a minimum no better than
`2.385L`, or the same powered lower-exit trajectory.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and asymmetric flapping
source_mechanism: measured directional response selects a bounded half-cycle amplitude and polarity asymmetry while the propulsive rhythm continues
transferable_invariant: preserve the traveling-wave carrier and redirect only posterior authority whose measured body response grows signed target error
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species kinematics, dimensional frequency, exact vortex phase, and prescribed routes
policy_translation: normalized body-frame target direction and distance plus bounded measured yaw select a smooth polarity reversal of the joint-state posterior wave on only the error-growing half-cycle
falsification: reject if far-field progress or wake coherence degrades, posterior limit or load residence rises, or closest approach and lower-exit topology do not improve over the response-gated brake

## Evaluation boundary

The candidate receives formal CFD only after this worker exits. Deterministic
contract, locality, symmetry, and bound checks below do not constitute evidence
of hydrodynamic improvement.

## Implemented candidate and pre-CFD checks

The candidate implements only the response-selected posterior-wave polarity
reallocation described above. At a representative `2.4L` lateral approach
with `2.19 rad/T` error-growing yaw, its response weight is `0.909` and its
wave multiplier is `-0.182`. Mirroring the yaw sign releases the response to
`0.00225` and restores multiplier `0.9971`; moving the same state to `8L`
reduces the response to `0.000655` and restores multiplier `0.99915`. A full
gate is bounded at multiplier `-0.30`, so the counterstroke cannot exceed the
unchanged cruise-wave magnitude. These are signal probes, not a coupled-flow
prediction.

The required guidance-semantic, lightweight Julia contract, deterministic
parameter-schema, and solver-boundary checks pass. All `21` direct
`params.FIELD` references are returned by `target_policy_params()`. Direct
probes also pass exact reflection equivariance, extreme finite-input handling,
configured command bounds, far-field locality, and corrective-response
release. All `324` repository non-CFD tests pass. Formal CFD was not run.
