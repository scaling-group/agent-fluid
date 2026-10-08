# Posterior half-cycle wave-redistribution candidate

## Visual and quantitative diagnosis before editing

- All four sampled evaluations satisfy the frozen contract: direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, no cylinders or
  prewarm, stable dynamics, and capture. In every combined sheet the wake is
  empty at release, develops into an alternating mid-plane vortex street and
  paired oblique Lambda2 structures, and remains coherent through the curved
  approach. The fish is therefore self-propelled rather than advected. The
  sheets are visually near-identical at their sparse keyframe cadence, so the
  terminal histories distinguish the mechanisms.
- The continuous-course v24 carrier captures at `23.8315T` with scoring mean
  distance `2.434073L`. The sampled v25 yaw/course-consensus gate arrives later
  at `23.8590T`, with essentially unchanged inside-`3L` mean yaw
  (`1.6827` versus `1.6839 rad/T`), confirming the assigned-parent lesson that
  another cue-arbitration gate is not useful.
- Posterior half-cycle amplitude relief is the informative positive result.
  It retains capture and the coherent wake, slightly improves scoring mean
  distance to `2.433993L`, and lowers inside-`3L` mean/peak absolute yaw from
  v24's `1.6839/3.2076` to `1.6060/3.0632 rad/T`. Mean target-transverse speed
  falls from `0.2393U` to `0.2335U`, and mean absolute yaw moment falls from
  `0.006402` to `0.006137`. Its cost is slower capture at `23.8755T`, consistent
  with removing useful posterior wave authority as well as yaw impulse.
- The assigned-parent logs report that a posterior counter-tangent arrived
  quickly but increased terminal yaw and moment. The newly sampled
  load-selective counter-tangent improves scoring mean distance to
  `2.433642L` at v24's `23.8315T` arrival, but still raises peak yaw to
  `3.2645 rad/T`, mean target-transverse speed to `0.2449U`, and peak moment to
  `0.01438` versus v24's `0.01406`. Hydrodynamic-load gating therefore does
  not turn that counter-tangent into the requested yaw/load cleanup.
- All sampled candidates have zero joint-angle-limit exposure, about `8.1%`
  component-wise joint-speed-cap exposure, and projected acceleration below
  `31.40 rad/T^2`. The next test should address the amplitude-relief propulsion
  trade without changing the carrier, course bend, projection, cadence, or
  actuator envelope.

## Policy hypothesis

Use the evaluated amplitude-relief candidate as the sole base. Preserve its
target-relative continuous course bend and relief of the posterior wave on the
observed half-cycle that supports carrier-rejected excess yaw. Add only a
bounded partial return of oscillatory posterior wave authority on the opposite
half-cycle. Both stroke selectors come from normalized excess-yaw demand and
the observed two-joint tail tangent; the mean tail curvature remains owned by
the existing target-course controller.

This posterior wave redistribution should retain the relief candidate's yaw,
cross-track, and mean-moment improvement while recovering some of its lost
approach rate. Falsify it if capture or the alternating three-dimensional wake
is lost; arrival remains at or above `23.8755T` without additional yaw/load
benefit; scoring mean distance exceeds `2.4341L`; terminal yaw, cross-track
speed, moment, joint-speed exposure, or projected-command exposure regresses
toward the counter-tangent results; or the result depends on the sampled world
pose rather than body-frame target geometry. This worker does not claim the
unavailable new CFD result.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and Lighthill-style posterior reactive propulsion
source_mechanism: preserve a traveling propulsive bend while turning with bounded posterior half-cycle amplitude asymmetry
transferable_invariant: redistribute a small amount of posterior wave authority between observed stroke sides so yaw impulse changes without discarding the whole propulsive rhythm
nontransferable_details: published gains, dimensional cadence, robot linkage geometry, species-specific envelopes, exact vortex phase, full-body waveforms, and task-specific routes
policy_translation: normalized carrier-rejected excess yaw supplies direction; normalized observed q1+q2 supplies stroke side; retain the evaluated relief on the yaw-supporting stroke and return only part of it on the opposing stroke while preserving continuous body-frame target-course curvature
falsification: reject if capture or wake coherence is lost, if arrival is not recovered, or if distance integral, terminal yaw/cross-track/load, joint-speed exposure, and projected-command exposure fail to preserve the relief candidate's cleanup while improving its progress
```

## Non-CFD validation

- The configured check-runner was invoked, but its fixed model is unavailable
  in this account. Its three commands were then run directly: the material
  guidance check, lightweight Julia policy contract, and solver boundary check
  all pass. The guidance check initially exposed a duplicated assigned-parent
  marker in the rendered workspace `README.md`; removing only that duplicate
  made the check pass.
- Every direct `params.FIELD` reference is declared by
  `target_policy_params()`. A `32,805`-state grid over distance, target side,
  velocity, yaw, joint angle, and joint velocity produced finite commands
  within `31.416 rad/T^2`. It exercised both active and inactive opposing-stroke
  return, kept posterior wave gain within `[0.82,1.09]`, matched the evaluated
  amplitude-relief base exactly at and outside `3L`, and safely handled a
  non-finite observation probe. No CFD rollout was run.
