# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their finite travel
  and alternating wakes therefore demonstrate self-propulsion rather than
  advection or inherited-flow contamination.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows for
  the best sampled alignment-gated carrier (`2.443L` minimum), the assigned
  parent's same-sign response redirect (`2.601L`), and the sampled persistent
  opposite-sign posterior counterbend (`2.477L`). Each develops a coherent
  planar vortex street and compact three-dimensional vortex chain, turns into
  a nearly vertical path below the target, remains powered after the miss, and
  exits the lower virtual boundary near `31--32T`. Instability, wake collapse,
  collision, and passive advection are not the limiting failures.
- The newly completed persistent-counterbend sample invalidates the assigned
  parent's remaining hypothesis: making the opposite-sign posterior S-bend
  follow lateral target geometry worsens minimum/mean distance from
  `2.443/8.443L` to `2.477/8.452L` and preserves the lower exit. The assigned
  parent's more complex same-sign response redirect is worse again at
  `2.601/8.517L`. This evidence does not support more equilibrium persistence,
  another redirect gain, or scalar carrier effort.
- At the best carrier's minimum, its world-frame target ray and velocity imply
  about `0.24 L/T` closure but `0.64U` cross-track speed at total speed
  `0.685U`. For the persistent-counterbend sample those values are about
  `0.12 L/T`, `0.65U`, and `0.656U`: it trades closure away without arresting
  the lateral transit. This cross-check matches the visible strong terminal
  wake and supports separating terminal propulsion from steering only after
  poor closure and cross-track motion agree.

## Policy hypothesis

Start from the strongest sampled alignment-gated carrier and add one approach
hold mechanism. Preserve its anterior oscillator, bounded mean curvature,
posterior lag, and posterior steering equilibrium. From normalized body-frame
target and velocity, form rotation-invariant target-ray closure and cross-track
speed. Only when a smooth near-target envelope, a closure deficit, and high
cross-track speed all agree, attenuate the oscillatory posterior wave toward a
nonzero floor while leaving the posterior mean curvature intact.

Expected evidence is the established coherent inbound route, followed by a
weaker terminal wake and reduced cross-track overshoot while steering remains
available. Capture, a useful new termination class, or a minimum below
`2.443L` without degraded mean distance would support the mechanism. Falsify
it on changed far-field progress, premature coasting, loss of wake coherence
outside approach, greater actuator/load residence, or the same powered lower
exit without a useful distance improvement.

```text
bookshelf_consulted: true
source_domain: terminal capture control and Lighthill-style separation of posterior thrust-producing kinematics from bounded turning bias
source_mechanism: preserve the traveling-bend carrier in cruise, then reduce posterior oscillatory propulsion without releasing steering during a geometrically confirmed lateral near miss
transferable_invariant: when normalized target-ray motion shows large cross-track transit and inadequate closure, schedule propulsion and steering authority separately instead of increasing persistent curvature
nontransferable_details: published gains, dimensional frequencies, species-specific body envelopes, robot duty ratios, exact vortex phases, fixed routes, and timed braking stages
policy_translation: normalized target_body_L and velocity_body_U produce reflection-equivariant closure and cross-track magnitudes that continuously gate only the lagged posterior wave within the two-joint state-feedback carrier
falsification: reject on altered far-field progress, premature coasting, lost cruise-wake coherence, increased limit or load residence, no improvement below 2.443L, or persistence of the powered lower exit
```

## Evaluation boundary

The current worker cannot claim CFD evidence for the new candidate; formal CFD
runs only after exit. Deterministic replay and contract checks below establish
only signal locality, symmetry, boundedness, and implementation correctness.

## Implemented candidate and pre-CFD checks

The candidate starts from the sampled `2.443L` alignment-gated carrier and
adds only the target-ray cross-track/closure approach hold described above.
All carrier values, thresholds, smooth scales, and the nonzero hold floor are
owned by `target_policy_params`; the `28 rad/T^2` command reserve is unchanged.

Replay of completed trajectories through the new gate is a signal diagnostic,
not a hydrodynamic result. Across the four samples, mean hold weight is only
`0.0013--0.0017` beyond `4L`, about `0.116--0.129` between `3--4L`, and about
`0.590--0.615` inside `3L`. On the best carrier at its `2.443L` minimum, the
observed `0.243 L/T` closure and `0.640U` cross-track speed yield hold weight
`0.666` and posterior-wave scale `0.434`. On the failed persistent counterbend
at its `2.477L` minimum, `0.115 L/T` closure and `0.646U` cross-track speed
yield weight `0.851` and scale `0.277`. Thus the gate is negligible in cruise,
becomes modest in middle approach, and responds strongly to the evidenced
lateral miss without changing the steering equilibrium.

The mandated guidance-semantic check, lightweight Julia policy contract, and
solver boundary check pass. All `324` repository non-CFD assertions pass.
Direct probes also pass reflection equivariance, extreme finite-input handling,
configured command bounds, and state-local near/far activation. Formal CFD was
not run.
