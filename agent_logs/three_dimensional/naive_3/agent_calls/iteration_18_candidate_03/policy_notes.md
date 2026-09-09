# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the assigned-parent evaluation report
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. I inspected both the top-down vorticity and
  oblique body/Lambda2 rows for the strongest sampled response-selective brake
  (`2.385L` minimum), the sampled response-released S-bend failure (`2.536L`),
  and the assigned parent's closure-gated anterior redirect (`2.569L`). Each
  fish self-propels along the established diagonal approach, sheds a sustained
  alternating planar wake with compact three-dimensional vortices, turns
  nearly vertical below the target, and remains powered until a lower-boundary
  exit near `31T`. There is no passive advection, collision, wake collapse, or
  instability; the unresolved defect is terminal steering response.
- The assigned parent's new anterior equilibrium mechanism fails its stated
  test: it worsens closest approach from the brake's `2.385L` to `2.569L`,
  retains the same `left_domain` termination and nearly the same final distance
  (`9.195L` versus `9.190L`), and visibly preserves the same long lower-exit
  trajectory. The sampled persistent course/differential redirect also reaches
  only `2.469L`. Combined with inherited failures for shared course bending,
  same-sign and opposite-sign posterior equilibrium shifts, posterior
  counterstrokes, and gait-yaw residualization, this closes off another static
  curvature request or posterior reallocation as the next useful test.
- The response-selective posterior brake remains the strongest sampled
  mechanism, improving the alignment-gated carrier from `2.443L` to `2.385L`.
  At its minimum the target is still about `1.38 rad` lateral, speed is about
  `0.705U`, and error-growing yaw is `2.19 rad/T`; anterior joint rate is about
  `-4.46 rad/T` while anterior acceleration is only `7.71 rad/T^2`. Inherited
  traces report `|r|=0.992--0.998` phase lock between yaw and anterior joint
  rate inside `3L`. The parent changed the anterior equilibrium but left that
  error-growing gait half-cycle fully energized. This supports testing
  state-feedback damping of the evidenced anterior beat phase rather than
  adding more mean bend.

## Policy hypothesis

Start from the strongest sampled response-selective brake and preserve its
target-bearing steering equilibrium, anterior state-feedback oscillator,
posterior lag and alignment envelope, posterior wrong-way-yaw brake, command
reserve, and exact far-field behavior. Reuse the existing approach, full target
direction, and measured wrong-way-yaw weight to add bounded damping only to the
anterior joint velocity during the error-growing half-cycle. Corrective yaw
restores the unmodified anterior oscillator continuously, and the posterior
brake remains unchanged. This is a new two-joint half-cycle allocation, not a
new threshold, static curvature residual, or scalar drive retune.

Support requires capture, a useful termination-class change, or a minimum
materially below `2.385L` while retaining far-field progress and wake
coherence. Reject the mechanism if it changes cruise, suppresses both beat
halves, causes premature speed loss or a tight curl, increases actuator/load
residence, or retains the powered lower exit without a useful closest-approach
improvement.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and half-cycle amplitude asymmetry
source_mechanism: measured directional response selects extra damping on only the body-wave half-cycle that grows target error while the corrective half-cycle remains propulsive
transferable_invariant: preserve the traveling-wave carrier and alter rhythmic authority only when signed target geometry and measured body response agree that the current beat phase is counterproductive
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species-specific kinematics, dimensional frequency, duty ratios, exact vortex phase, fixed burst duration, and task routes
policy_translation: normalized distance and target_body_L plus bounded heading_rate reuse the evidenced reflection-equivariant response gate; that gate applies a bounded velocity-damping residual only to joint 1 while leaving its mean curvature and the joint-2 response brake intact
falsification: reject on changed far-field route, damping of corrective half-cycles, lost wake coherence or speed, a tight curl, greater actuator/load residence, no material improvement below 2.385L, or persistence of the powered lower exit
```

## Evaluation boundary

Formal coupled CFD runs only after this worker exits. Replay and static checks
can establish gate locality, symmetry, boundedness, and parameter ownership but
cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD checks

The candidate implements only the response-selected anterior damping described
above. It starts from the sampled `2.385L` posterior brake, reuses that policy's
existing response weight, and adds a joint-1 velocity-damping residual; the
mean-curvature equilibrium and complete joint-2 command remain unchanged. On
replay of the best completed trajectory, the anterior-command change averages
about `0.015 rad/T^2` beyond `4L`, `0.372 rad/T^2` between `3--4L`, and
`1.382 rad/T^2` inside `3L`. At the completed minimum-distance state the
response weight is `0.913` and the change is about `+11.64 rad/T^2`, opposing
the measured `-4.46 rad/T` anterior velocity. Replayed anterior/posterior clamp
fractions are about `0.747/0.356`, effectively unchanged from the baseline.
These are action-local diagnostics on inherited states, not a coupled-flow
prediction.

The mandated material-guidance check, lightweight Julia contract, and solver
boundary check pass. All `22` direct `params.FIELD` references are declared by
`target_policy_params()`. A grid of `303750` mirrored states remains finite and
inside the configured `28 rad/T^2` command reserve with zero numerical
reflection residual. All `324` repository non-CFD assertions pass when invoked
directly; the isolated `Pkg.test()` wrapper itself cannot load Julia's `Test`
stdlib because this repository does not declare it in the package test target.
Formal CFD was not run.
