# Terminal line-of-sight-rate candidate

## Evidence diagnosis before the policy edit

- The four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected the combined keyframe sheets for the best-scoring finite sample
  (`solver_6eb170b0d70a`) and the assigned parent
  (`solver_2c7a9d1d6ee7`), including both top-down mid-plane vorticity and
  oblique body/Lambda2 rows. Both self-propel from rest with coherent,
  alternating planar wakes and compact three-dimensional structures. The
  parent traces broad powered return loops; the stronger sample contracts
  those loops around the target, so passive advection, wake collapse,
  collision, and instability do not explain either miss.
- The assigned parent's response-held C-turn reaches only `2.377L` minimum,
  `4.458L` mean, and `4.163L` final distance. Inherited notes show that it
  preserved the carrier and improved the second return, but its persistent
  geometry-selected bend still settled into a broad orbit.
- The sampled course-response curvature reserve
  (`solver_951085a20092`) is the clear semantic improvement. Acting on turn
  authority only when the target is behind and course is nonclosing contracts
  the orbit to `1.314L`, improves mean/final distance to `4.056/3.077L`, and
  lowers anterior acceleration-clamp residence from about `0.727` to `0.249`
  without larger sampled load tails. Its coherent first pass and carrier are
  therefore the scaffold to preserve.
- Two attempts to persist that same equilibrium curvature through terminal
  geometry delimit the next mechanism. The broad course hold
  (`solver_6eb170b0d70a`) marginally improves the minimum to `1.241L` and final
  distance to `2.082L`, but worsens mean distance to `4.158L` and remains a
  powered noncapturing loop. The narrower barely-ahead bridge
  (`solver_34419dc4414e`) regresses minimum/mean/final distance to
  `1.371/4.121/3.303L`. More persistence, threshold tuning, or static
  curvature is not supported.
- At the reserve scaffold's `1.314L` minimum, inherited trace analysis records
  finite speed (`0.652U`), target-ray/course error `1.672 rad`, and small yaw
  rate (`-0.137 rad/T`). The target ray therefore continues to rotate faster
  than the body turns. The missing terminal response is a rate match capable
  of producing an intercept, rather than another position-error hold that
  sustains pure-pursuit orbiting.

## Policy hypothesis

Start from `solver_951085a20092` and preserve its oscillator, posterior lag,
far-field bearing curvature, posterior brake, joint-state phase modulation,
geometry-released C-turn, response-selected curvature reserve, wave envelope,
and command reserve. Add one terminal feedback primitive: compute inertial
line-of-sight angular rate from the normalized body-frame target vector and
translational velocity, compare it with measured yaw rate, and apply a small
bounded curvature residual only inside the evidenced near-target envelope.
Matching body turn rate to target-ray rotation should lead the moving course
into the capture disk instead of holding a static C-bend around it. The
residual vanishes when yaw response matches the ray and is reflection
equivariant; it adds no clock, maneuver state, route, or world-frame command.

Support requires capture, a minimum below `1.24L`, or a materially better
near-target residence/mean-distance combination while preserving the coherent
first pass and comparable clamp/load residence. Reject the mechanism if the
first pass changes, yaw-rate feedback induces chatter or a tight curl, the
wake loses its alternating structure, limit/load residence rises, or the same
`1.2--1.7L` powered orbit persists.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological response-released turning
source_mechanism: retain the propulsive rhythm while observed directional response continuously adds or releases a bounded turn residual
transferable_invariant: terminal steering should regulate measured body-turn response against target-ray rotation rather than persist a fixed curvature from position error alone
nontransferable_details: published CPG gains, species-specific burst kinematics, dimensional frequencies, exact vortex phases, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target and velocity form line-of-sight angular rate; its signed residual from measured yaw rate adds bounded equilibrium curvature to both joints inside a state-selected terminal envelope
falsification: reject if cruise or first-pass geometry changes, yaw chatters, wake coherence or load margins degrade, or no capture, closer pass, or useful orbit contraction follows
```

## Evaluation boundary

The new coupled CFD rollout occurs only after this worker exits. Frozen-trace
replay and dry controller checks can establish selector locality, rate-error
sign, action scale, reflection equivariance, finiteness, bounds, and parameter
ownership, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed course-response reserve policy and
adds four owned parameters for one terminal line-of-sight-rate residual. The
residual uses only normalized body-frame target and velocity, measured yaw
rate, distance, and finite-speed authority. It adds to both joint equilibria
without changing the sampled redirect, response reserve, oscillator, wave
envelope, posterior brake, phase lag, or command limit.

Frozen replay on the completed `solver_951085a20092` trace requests only
`-0.073 deg` of rate curvature at the preserved `2.377L` first pass, changing
actions from `(23.95,-2.84)` to `(23.78,-3.05) rad/T^2`. At the `1.314L` best
pass, line-of-sight rate is `-0.494 rad/T` while yaw rate is only
`-0.137 rad/T`; the signed residual requests `-1.697 deg` and materially
changes actions from `(1.68,-0.11)` to `(-2.19,-5.29) rad/T^2` without a
clamp. Across the frozen trace, absolute terminal curvature averages
`0.139 deg`, peaks at `1.828 deg`, and averages only `0.00023 deg` beyond
`3L` (maximum `0.00487 deg`). These establish locality and a response-correct
sign only, not a coupled-flow outcome.

All `44` direct parameter references are returned by
`target_policy_params()`. Full scaffold-trace replay, zero-target/zero-speed
probes, and representative mirrored states remain finite and within the
declared `+/-28 rad/T^2` command reserve; mirrored actions negate exactly.
The mandated material-guidance check, lightweight Julia policy contract, and
solver boundary check pass. No formal CFD was run.
