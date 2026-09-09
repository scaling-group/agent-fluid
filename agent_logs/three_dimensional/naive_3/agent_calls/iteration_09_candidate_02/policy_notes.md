# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts and the assigned-parent rollout used direct uniform
  still water (`U_infinity=(0,0,0)`), no cylinders, and no prewarm snapshot.
  Their finite motion is self-propulsion, not advection or initialization
  contamination.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows for
  the strongest-score `2.443L` carrier, the direct-slip phase-modulation
  failure, and the best-closest-approach posterior-counterbend run. The carrier
  leaves a coherent alternating planar street and compact three-dimensional
  vortex chain while approaching the target, then passes below it and remains
  powered into the lower boundary. The slip controller retains a wake but
  reaches only `2.822L`; it changes the course without fixing its topology.
  The counterbend keeps the long coherent wake and improves minimum distance to
  `2.187L`, versus `2.443L`, while preserving nearly the same mean distance
  (`8.446L` versus `8.443L`) and lasting to `32.126T`, but it also exits low.
- The other sampled full-direction posterior gate reaches `2.494L`, and the
  assigned parent's inherited same-sign response-gated posterior redirect
  reaches `2.601L`; neither beats the unmodified carrier. Thus neither global
  full-direction steering nor another same-sign late redirect is supported.
- Replaying the completed `2.187L` trace through its own lateral-velocity gate
  shows why its useful effect is incomplete. Inside `3L`, its normalized
  counterbend magnitude averages `0.299` and exceeds `0.05` on only `57%` of
  samples, even though the target remains strongly lateral. Representative
  samples at `16.33T`, `17.81T`, and `18.80T` have target lateral fractions
  `0.709`, `0.914`, and `0.982`, yet the gate falls to `0`, `0`, and `0.005`
  as beat-scale lateral velocity changes sign. The target-geometry envelope
  proposed below is zero outside `6L`, averages `0.784` inside `3L`, and does
  not mistake an instantaneous corrective half-cycle for completed redirection.
  This replay is a gating diagnostic, not a hydrodynamic result for the new
  candidate.

## Policy hypothesis

Preserve the strongest sampled alignment-gated `7 deg` anterior oscillator,
posterior lag, mean-curvature steering, and command bound. Add one continuous
terminal posterior S-bend: normalized body-frame lateral target error sets its
side and persistence, while a steep distance envelope confines it to the
near-target region. The posterior equilibrium moves opposite the anterior mean
curvature, matching the sign of the only sampled modification that improved
closest approach. It releases as lateral error vanishes rather than whenever
instantaneous lateral velocity happens to be corrective.

Expected evidence is unchanged far-field motion and coherent wake, followed by
sustained correct-side redirection inside about `3L`, a closest approach below
`2.187L`, and preferably capture or a trajectory that no longer continues to
the same lower exit. Falsify the mechanism if early progress changes, the wake
shortens into a tight curl, posterior clamp/load residence grows materially, or
the same lower-exit topology persists without a better minimum.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior-kinematics emphasis and robotic-fish mean-curvature turning, with terminal approach scheduling
source_mechanism: preserve the traveling propulsive carrier while a bounded posterior S-bend supplies sustained near-target turning authority
transferable_invariant: separate the propulsive rhythm from a continuous target-error-driven posterior equilibrium shift, and release that shift on geometric correction rather than a single oscillatory velocity sample
nontransferable_details: published gains, dimensional frequencies, species-specific body waves, robot duty ratios, exact vortex phases, burst durations, and task-specific routes
policy_translation: normalized target_body_L lateral error and distance_L gate an opposite-sign posterior mean residual around the unchanged two-joint state-feedback oscillator and lagged tail
falsification: reject on changed far-field progress, lost wake coherence, a short-radius curl, materially higher posterior clamp/load residence, no improvement beyond 2.187L, or persistence of the powered lower exit
```

## Implemented candidate and pre-CFD checks

The candidate implements only the approach-localized, geometry-persistent
posterior counterbend above. At `8L` its maximum equilibrium contribution is
below `0.0001 rad`; a representative `2.2L` target with lateral fraction
`0.818` produces more than `0.08 rad`. These are deterministic controller
probes, not evidence of improved hydrodynamics.

The mandated guidance-semantic, lightweight policy-contract, and solver-boundary
checks pass. All `324` repository non-CFD tests pass. Direct probes also pass
global reflection, zero-lateral-error release, far-field locality, near-field
activation, extreme-input finiteness, and configured command bounds. Formal CFD
was not run; the candidate's outcome remains for the downstream evaluator.
