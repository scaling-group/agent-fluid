# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four asymmetric cylinder streets develop and merge
  around the target. It is common initial-condition evidence and does not
  support a memorized route, wake phase, coordinate, or clock command.
- Three current sampled policies are executable replications of the assigned
  `tail_steering_gain=0.65` parent. Their sheets and diagnostics are identical:
  each turns down-left, sustains productive beating through the developed wake,
  passes just below the target, and turns into the capture circle without a
  loop, collision, exit, or instability. Capture takes `72.160` release units,
  mean distance is `2.4638L`, and upstream-relative x speed is `0.06732`, so
  the visible upstream crossing is materially self-propelled rather than local
  flow advection.
- The distinct `tail_steering_gain=0.70` sample retains that compact diagonal
  topology and reaches the target. It improves score from `-0.565611` to
  `-0.555772` and mean distance from `2.4638L` to `2.4541L`; RMS relative
  crossflow falls from `0.13603` to `0.13063`, RMS force/moment from
  `25.32/420.32` to `23.85/408.89`, and peak anterior/posterior speeds from
  `3.125/3.367` to `3.086/3.293`. The benefit is mixed rather than monotone:
  arrival is `0.297` units slower, upstream-relative x speed falls to
  `0.06620`, total command energy rises from `51284` to `51842`, and both
  accelerations still touch the `28` guard.
- The most informative inherited failed optimization hypothesis is the isolated
  static `oscillator_energy_gain=2.075` midpoint. Its keyframes show a visibly
  deeper lower approach, corroborated by `77.264` arrival, `2.5512L` mean
  distance, `0.06386` upstream-relative x speed, `53643` energy, and
  `31.45/454.27` RMS force/moment. This rejects combining the posterior-share
  result with restoration-gain interpolation and reinforces the inherited
  warning that small parameter steps can switch wake routes. No current sampled
  rollout is a semantic failure; the inherited reversed-sign instability is a
  safety boundary, not newly available visual evidence.

## Single candidate hypothesis

Adopt the exactly evaluated `tail_steering_gain=0.70` controller. Preserve the
assigned parent's `0.75` period, `22 deg` requested orbit, static `2.1` energy
restoration, bounded positive-bearing `0.75/10 deg` anterior steering, `0.55`
posterior lag, `0.65` damping, and common `28/28 rad/time^2` guard. This changes
only posterior sharing of the already bounded steering center and adds no new
observation, switching surface, coordinate, route, timing signal, or wake probe.

The falsifiable expectation is reproduction of finite compact capture with
mean distance below the `0.65` parent's `2.4638L` and RMS loads no higher than
`25.32/420.32`, accepting the observed sub-unit arrival tradeoff. Reject the
mechanism if reevaluation selects a deeper route, loses capture or meaningful
upstream-relative propulsion, or increases effort/load without the distance
benefit. This confirmation candidate deliberately avoids extrapolating above
`0.70`; same-snapshot success remains falsifiable under held-out wake phase,
inflow, geometry, and target position. No CFD outcome for this new candidate is
claimed here.
