# Phase 2 multi-wake policy diagnosis

## Evidence diagnosis

- All three finite samples report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`; the wake motion is therefore self-propelled, not
  background advection.
- In the assigned parent `solver_19f251537923`, both visual rows show a strong,
  coherent alternating wake. The fish approaches from `12.328L` to `6.138L`
  at `16.505T`, then its heading grows from `0.506` to `1.383 rad`, the route
  crosses below the target, and it exits the lower boundary at `26.147T` with
  `10.460L` range. Raw commands exceed `1800 deg/T^2` in 3346/4754 anterior
  and 3655/4754 posterior samples, so the attractive closest approach is not
  evidence that the transferred steering law is controllable in 3D.
- The strongest finite child `solver_97bc3c03d55b` preserves the same visibly
  coherent wake and decreases range monotonically to `9.175L`, but a bounded
  posterior mean-curvature loop over-rotates the heading to `-0.791 rad` and
  exits through the upper boundary at `11.132T`. Its raw actions still exceed
  the acceleration envelope in 830/2024 and 628/2024 samples. This establishes
  the useful initial yaw sign, but not adequate braking or envelope compliance.
- The informative finite failure `solver_e6325a747ec1` stays inside the command
  envelope, yet its `1.10T`, `10 deg` response-gated carrier produces visibly
  weak wake structures, force magnitudes below `0.0037`, negligible approach
  (`12.328L` to `12.323L`), and then a sharp upper-boundary turn ending at
  `13.616L`. Merely reducing carrier authority while retaining static mean
  curvature therefore trades saturation for lost thrust without fixing route
  topology.
- The oblique rows agree with the top-down diagnosis: the two fast carriers
  shed distinct three-dimensional alternating structures, whereas the slow
  carrier develops much weaker structures before the body yaws away. Local
  flow remains small relative to the commanded maneuver, so wake-rejection
  feedback is not justified in this still-water sample.

## Policy hypothesis

Use an envelope-bounded intermediate traveling-bend carrier and replace static
mean curvature with posterior half-cycle amplitude asymmetry. A normalized
body-frame line-of-sight error requests a modest yaw rate; recent measured yaw
closes the response loop. Joint angle and velocity identify the posterior wave
side, strengthening the half-cycle whose sign matches the requested turn and
weakening the opposite half-cycle. The expected result is correct-sign initial
yaw with faster release/reversal, a nonzero-mean steering effect without a
persistent C-bend, and a coherent wake without routine evaluator clipping.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and classical traveling-wave propulsion
source_mechanism: target-driven half-cycle amplitude asymmetry on a posterior-lagged traveling bend, released by measured yaw response
transferable_invariant: preserve a directed posterior-emphasized body wave while creating turn moment by smoothly strengthening only the target-consistent half-cycle
nontransferable_details: published gains, clock-driven CPG phases, species-specific joint envelopes, exact tail-beat frequency, and task-specific routes
policy_translation: normalized body-frame target geometry sets desired yaw; `turn_rate_recent` closes the response loop; observed joint state smoothly gates posterior half-cycle amplitude under an explicit acceleration bound
falsification: reject if the wake becomes weak, raw actions routinely meet the bound, initial yaw has the wrong sign, or the same upper-boundary over-rotation occurs without improved closest approach

## Pre-CFD contract sanity

A `100T` joint-only persistent-turn probe rejected the draft `18 deg`,
`0.75T` carrier because its Van der Pol limit cycle would exceed the joint
angle and rate envelope. The retained `12 deg`, `0.70T` carrier stayed below
`31.0/34.4 deg`, `240.8/236.8 deg/T`, and `1471.6/1491.5 deg/T^2` for the two
joints in the same deliberately conservative probe. This is only a wiring and
envelope check, not hydrodynamic evidence; the later CFD result must still test
wake strength, yaw sign, braking, and target progress.
