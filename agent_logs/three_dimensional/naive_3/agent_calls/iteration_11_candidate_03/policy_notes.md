# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, four sampled solver evaluations, and inherited optimizer
  notes all identify direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm state. The displacement
  and wake are therefore self-propelled rather than advected or inherited.
- I inspected both rows of every sampled combined keyframe sheet. The
  top-down views show a long coherent alternating wake from release through
  the near pass, and the oblique Lambda2 views show a compact three-dimensional
  vortex chain without wake collapse or instability. All four fish pass below
  the target while still swimming and then leave the lower virtual boundary.
- The alignment-gated carrier is the best sampled minimum (`2.443L` at
  `17.869T`, speed about `0.685U`). Full-direction gating (`2.494L`), a
  geometry-persistent opposite-sign posterior bend (`2.477L`), and the
  assigned same-sign response redirect (`2.601L`) reach their minima within
  about `0.09T` of it and retain the same lower-exit topology. Their anterior
  commands remain clamped for about `72--75%` of samples. This rules out
  treating the small score spread as evidence for another carrier gain or a
  more persistent equilibrium shift.
- Inherited completed evidence is more selective: an instantaneous
  wrong-side-velocity counterbend improved the minimum to `2.187L`, and adding
  a bounded target-ray course residual reached `2.011L`, but the latter still
  worsened mean/final distance to `8.740/9.836L` and powered through the lower
  boundary. The assigned-parent replay found large terminal cross-track speed
  with only `0.093 L/T` closure at that minimum. The remaining supported
  distinction is terminal propulsion versus steering, not more curvature.

## Policy hypothesis

Preserve the inherited alignment-gated carrier and bounded opposite-sign
posterior counterbend/course residual. Add one approach-hold mechanism: when
normalized target-ray motion is strongly cross-track, distance is near, and
windowed distance closure is inadequate, attenuate only the oscillatory
posterior wave toward a nonzero floor. Keep the posterior mean bend and
anterior oscillator active. Windowed closure is used instead of an
instantaneous velocity projection so one beat-side reversal is less likely to
toggle the terminal decision.

Expected evidence is unchanged far-field progress and coherent wake, followed
by weaker terminal shedding while steering remains active, a minimum below
`2.011L`, and preferably capture or a useful non-lower-exit trajectory. Reject
the mechanism if it changes the far-field route, coasts before useful closure,
raises limit/load residence, loses wake coherence outside the approach, or
retains the powered lower exit without a meaningful distance improvement.

```text
bookshelf_consulted: true
source_domain: terminal capture control, Lighthill-style posterior propulsion, and sensor-modulated robotic-fish CPG control
source_mechanism: continuously separate posterior traveling-wave propulsion from target-error-driven mean steering during a geometrically confirmed failed approach
transferable_invariant: when normalized cross-track motion is large and recent target closure is inadequate, reduce propulsive authority without discarding bounded steering authority
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, fixed burst durations, duty ratios, and task-specific routes
policy_translation: body-frame target geometry and velocity define a reflection-equivariant cross-track residual; normalized distance and window_closing_speed_L gate only the posterior oscillatory wave under the two-joint state-feedback contract
falsification: reject on altered far-field progress, premature coasting, lost wake coherence outside approach, increased actuator or load residence, no improvement beyond 2.011L, or persistence of the powered lower exit
```

## Evaluation boundary

The current candidate has no same-worker CFD evidence. Deterministic replay and
contract checks below can establish only gating, symmetry, finiteness, and
scope; formal hydrodynamic evaluation occurs after this worker exits.

## Implemented candidate and pre-CFD checks

The candidate replaces the assigned same-sign posterior redirect with the
inherited bounded opposite-sign counterbend/course scaffold and adds only the
windowed-closure posterior-wave hold described above. Every active scale,
threshold, envelope, carrier value, wave floor, and command bound is returned
by `target_policy_params`; the `28 rad/T^2` reserve clamp is unchanged.

Replay of completed trajectories through the hold equation is a controller
locality diagnostic, not a hydrodynamic result. Across the four sampled traces,
mean hold weight is `0.00084--0.00098` outside `4L`, `0.0647--0.0678` between
`3--4L`, and `0.383--0.420` inside `3L`. At their minima it is
`0.563--0.657`, where windowed closure is only `0.005--0.040 L/T` and
cross-track speed is `0.630--0.646U`; the posterior-wave fraction remains a
bounded `0.475--0.550`. Thus the implemented gate is dormant in cruise,
activates on the evidenced failed approach, and retains a nonzero tail wave.

The mandated guidance-semantic, lightweight Julia policy-contract, parameter-
schema, and solver-boundary checks pass. Direct probes also pass global
reflection equivariance, extreme finite-input handling, configured action
bounds, far-field locality (closure sensitivity `0.0016 rad/T^2`), and
near-field activation (`6.26 rad/T^2`). No CFD was run.
