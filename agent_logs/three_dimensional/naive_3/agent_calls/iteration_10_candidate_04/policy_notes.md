# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts report direct uniform initialization in still
  water (`U_infinity=(0,0,0)`), no cylinders, and no prewarm snapshot. Their
  finite translation and wakes therefore show self-propulsion rather than
  advection or inherited-flow contamination.
- I inspected every combined keyframe sheet from release through termination,
  including both the top-down mid-plane vorticity row and the oblique
  body/Lambda2 row. The `2.443L` alignment-gated carrier, the `2.494L`
  full-direction gate, the assigned-parent `2.601L` response-gated redirect,
  and the `2.187L` posterior counterbend all retain a coherent alternating
  planar wake and compact three-dimensional vortex chain. None collides or
  becomes unstable; each passes below the target and remains powered into the
  lower virtual boundary near `31--32T`.
- The sampled comparison isolates actuator allocation more strongly than gate
  sophistication. The assigned parent adds approach distance, full-direction,
  closing-deficit, and recent-turn-response gates but applies a same-sign
  posterior redirect; it worsens minimum/mean distance from the carrier's
  `2.443/8.443L` to `2.601/8.517L`. The simpler opposite-sign posterior
  counterbend improves minimum distance to `2.187L` while retaining nearly the
  same mean distance (`8.446L`) and the coherent long wake. Full-direction
  posterior propulsion gating reaches only `2.494L`. Thus the supported new
  mechanism is a persistent posterior S-bend, not another scalar carrier tune
  or another same-sign C-bend gate.
- The inherited optimizer replay identifies the incompleteness of the useful
  `2.187L` mechanism: its instantaneous lateral-velocity guard exceeds `0.05`
  on only `57%` of samples inside `3L`, repeatedly dropping out while
  normalized lateral target error remains `0.7--1.0`. That is consistent with
  beat-scale velocity sign changes, not completed geometric correction.
  Carrier acceleration is already clamped for roughly `74.6%/35.4%` of
  anterior/posterior samples, so increasing drive or command bounds is not a
  supported remedy.

## Policy hypothesis

Preserve the sampled `7 deg` anterior mean-curvature oscillator, alignment
gating, posterior lag, and command bound. Replace the assigned parent's
same-sign response-gated redirect with one terminal posterior S-bend: the sign
and persistence come from normalized body-frame lateral target error, and a
steep continuous distance envelope makes the residual negligible outside the
approach. The posterior equilibrium shifts opposite the anterior curvature,
matching the only sampled actuator allocation that improved closest approach;
it releases only as lateral geometry is corrected, rather than on a single
corrective velocity half-cycle.

Expected evidence is unchanged far-field progress and wake coherence followed
by sustained target-side correction inside about `3L`. A minimum below
`2.187L`, capture, or a non-lower-exit useful trajectory would support the
mechanism. Falsify it if far-field motion changes, the wake collapses into a
tight curl, posterior limit/load residence rises materially, or the same
powered lower exit persists without improving the minimum.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior-kinematics emphasis and robotic-fish mean-curvature turning, combined with continuous terminal-approach scheduling
source_mechanism: preserve the traveling propulsive carrier while a bounded posterior S-bend supplies sustained terminal steering authority
transferable_invariant: separate rhythmic propulsion from a target-error-driven posterior equilibrium shift, and release the shift on geometric correction rather than an oscillatory instantaneous velocity sample
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes and body waves, robot duty ratios, exact vortex phases, burst timing, and task-specific routes
policy_translation: normalized target_body_L lateral error selects and sustains an opposite-sign posterior mean residual; normalized distance_L continuously localizes it around the unchanged two-joint state-feedback oscillator and lagged posterior wave
falsification: reject on degraded far-field progress, lost wake coherence, a short-radius curl, materially greater posterior command/load residence, no improvement beyond 2.187L, or persistence of the powered lower exit
```

## Evaluation boundary

The current worker does not have CFD evidence for this candidate. Any
deterministic contract or symmetry probes below establish only implementation
properties; the hydrodynamic hypothesis remains for downstream evaluation.

## Implemented candidate and pre-CFD checks

The candidate implements only the geometry-persistent terminal counterbend
described above. A deterministic probe with lateral target fraction `0.8`
changes the posterior acceleration by about `-13.54 rad/T^2` at `2.2L` but by
only `-0.0093 rad/T^2` at `8L`; zero lateral error releases the residual at
both distances. These values are controller-locality checks, not CFD evidence.

The mandated semantic-guidance, lightweight policy-contract, parameter-schema,
and solver-boundary checks pass. All `324` repository non-CFD tests pass.
Direct probes also pass reflection equivariance, zero-lateral-error release,
far-field locality, near-field activation, extreme finite-input handling, and
configured command bounds. Formal CFD was not run.
