# Closing-course phase-reversal candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the assigned parent's inherited evaluation
  satisfy the Phase 2 contract: direct uniform initialization in still water
  with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and
  `horizon` termination at `100T`. I inspected both the top-down
  mid-plane-vorticity and oblique body/Lambda2 rows in their combined sheets.
  They show self-propelled fish, coherent alternating planar wakes, compact 3D
  wake structures, and repeated return loops. Passive advection, collision,
  domain exit, wake collapse, and numerical instability do not explain the
  misses.
- The prefilled terminal course hold is the useful scaffold. It reaches
  `1.241/4.158/2.082L` minimum/mean/final distance and is the only current
  sample to enter `1.8L`. At its `97.092T` minimum it still travels at
  `0.669U`; the target is fully behind/lateral (`forward=-0.855`,
  `lateral=0.518`), course is slightly receding (`course_dot=-0.121`), and the
  target-ray/course error is `1.692 rad`. Earlier returns remain powered too:
  speed is about `0.658U` at the `1.641L` return near `43.37T` and `0.684U`
  while closing at `1.695L` near `95T`. The visible tight loop therefore
  preserves thrust but overshoots the capture disk.
- Three sampled terminal changes lose the parent's near-target topology while
  keeping coherent wakes: a turn-rate-driven posterior phase residual reaches
  `2.137L`, a rear-crossing direction blend reaches `2.366L`, and an anterior
  response burst reaches `2.125L`. Near their minima the joints are nearly
  parked in a common negative C-bend, whereas the parent retains anterior wave
  motion (`phi_dot_1=-0.260 rad/T`) at `1.241L`. This rejects more static
  curvature, course-direction blending, turn-rate lag authority, or another
  response burst as the next mechanism.
- The assigned parent's fully-behind target-ray/yaw-rate curvature reserve is
  also a completed negative result, not an unevaluated hypothesis. Its own
  inherited wake sheet remains coherent but its evaluation regresses to score
  `-4.809`, `1.418L` minimum, and `3.233L` final distance. Together with the
  sampled failures, this closes another late curvature-residual branch even
  when frozen replay predicts ahead-side locality.

## Policy hypothesis

Preserve the terminal course hold's oscillator, target-relative curvature,
C-turn direction, response reserve, wave envelope, and command limit. Add one
different actuator mechanism only while a nearby target is fully behind and
the measured translational course is still closing: smoothly reverse the sign
of the posterior derivative-lag term. This retains an oscillatory two-joint
wave but changes its propagation direction to test active braking rather than
the already ineffective scalar carrier contraction. The gate releases on a
tangent or receding course, returning exactly to the evidenced propulsive lag.

The mechanism is selected by normalized body-frame target direction, distance,
and target-ray/course dot product. It contains no time, step count, mutable
state, world coordinate, target identity, route, cylinder data, or copied
dimensional frequency. Support requires capture, a minimum below `1.241L`,
longer near-target residence, or a contracting return with lower speed and
improved final/mean distance while the coherent wake and first recovery are
preserved. Reject it if the `2.466L` first recovery moves materially, measured
speed does not fall on closing returns, the wake stalls or loses its traveling
structure, action-limit residence rises, or the same powered orbit remains.

```text
bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and sensor-modulated robotic-fish approach control
source_mechanism: posterior phase propagation determines whether a joint wave supplies forward reactive thrust; observed approach state can switch gait mode without a clock
transferable_invariant: when scalar amplitude relief does not slow a coherent powered swimmer, change the direction of the traveling-wave contribution only under measured closing geometry, then restore the propulsive wave continuously
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes and braking kinematics, full-body joint count, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: blend the owned posterior derivative-lag coefficient from the evidenced propulsive sign toward the opposite sign using normalized body-frame distance, target-forward projection, speed-valid course dot, and the existing two-joint state-feedback oscillator
falsification: reject if closing-return speed and orbit radius do not fall, if the 2.466L first recovery or coherent wake changes materially, if the wave parks or destabilizes, or if closest, mean, and final distance retain the noncapturing class
```

## Evaluation boundary

The new coupled CFD result is unavailable until this worker exits. Frozen-trace
replay and dry checks can establish gating locality, finite bounded actions,
reflection equivariance, and parameter ownership, but not hydrodynamic braking
or improved capture.

## Implemented candidate and non-CFD probes

The candidate introduces three owned parameters for one posterior phase-
reversal gate. At the sampled parent's `2.466L` first recovery the braking
weight and action change are zero. On later returns the weight is `0.327` at
`1.730L` while closing and `0.673` at `1.693L` while closing, but releases to
`0.0011` at the receding `1.241L` minimum. Over the full parent trace its
maximum-joint action difference has mean/maximum `0.247/3.693 rad/T^2` inside
`2L`, compared with `0.000074/0.003718 rad/T^2` beyond `3L`. The change is
posterior-only on a frozen state; anterior equilibrium, all steering
curvatures, oscillator envelope, and command limit are unchanged. These probes
establish material closing-return authority and far-field locality, not a
coupled-flow benefit.

All `47` direct `params.FIELD` references are returned by
`target_policy_params()`. Parent-trace actions and representative terminal,
zero-speed, and large finite probes remain finite within the owned
`+/-28 rad/T^2` reserve. Mirrored target, velocity, joint, bearing, and yaw
states negate both actions to less than `1e-10`. The required material-
guidance check, Julia policy contract, and solver editable-boundary check pass.
No formal CFD was run.
