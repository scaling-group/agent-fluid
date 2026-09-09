# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations report direct uniform quiescent initialization,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. I inspected each
  combined sheet from release to termination, including both the top-down
  mid-plane vorticity row and the oblique body/Lambda2 row. Every candidate
  self-propels with a coherent alternating planar street and compact 3D vortex
  chain, approaches on the same broad path, passes below the target, and
  remains powered to the lower virtual boundary. The limiting failure is
  terminal course control, not advection, weak propulsion, wake collapse,
  collision, or numerical instability.
- The unmodified alignment-gated carrier reaches `2.443L` at `17.869T`, with
  full body-frame target direction error `1.421 rad`, speed `0.685 U`, and only
  `0.009 L/T` instantaneous head-distance closure. Full-direction posterior
  gating reaches `2.494L`; a response-released opposite-sign posterior S-bend
  reaches `2.536L`; and cross-track/closure-gated posterior-wave attenuation
  reaches `2.429L`, only `0.014L` better in minimum while worsening mean
  distance from `8.443L` to `8.454L`. All four exit low near `31T`, and their
  planar and 3D wakes remain visually almost indistinguishable.
- The newly sampled `2.536L` result directly falsifies the assigned parent's
  remaining tail-only hypothesis: using head-distance closure and bearing
  trend does not rescue the opposite-sign posterior redirect. Together with
  the inherited `2.477L` geometry-persistent counterbend and `2.179L`
  course-conditioned tail hold that still exited low with worse
  mean/final distance, the evidence says to stop repackaging terminal gates
  around a six-to-seven-degree posterior residual. The carrier already clamps
  anterior/posterior acceleration for about `0.746/0.354` of its samples, so a
  higher scalar drive or command limit is also unsupported.

## Policy hypothesis

Preserve the far-field `7 deg` target-curvature carrier, posterior lag, and
command envelope. Change one controller mechanism when normalized geometry
shows an imminent lateral miss: blend continuously from the propulsive wave
into a bounded whole-body C-bend, add state-feedback damping to the anterior
rhythm, and attenuate the posterior traveling wave. Distance, full body-frame
direction error, and loss of head-distance closure activate the maneuver;
corrective bearing trend releases it. This is a maneuver allocation change,
not another posterior sign or scalar-gain trial.

The expected trace preserves the established cruise and coherent wake outside
the approach, then reduces the still-high `~0.68 U` translational drive while
both joint equilibria turn the body before the target reaches the flank.
Capture, a closest approach below the inherited `2.179L` benchmark, or a
meaningfully different non-lower-exit trajectory would support the mechanism.
Falsify it if activation changes far-field progress, makes a short tight curl,
increases clamp/load residence materially, releases while direction error is
growing, or retains the same powered lower exit without useful minimum or
integral improvement.

```text
bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG turning
source_mechanism: transiently replace a cruising rhythm with a strong bounded body bend, then release into propulsion when observed target-relative response appears
transferable_invariant: separate cruise propulsion from a state-triggered whole-body redirect whose persistence and release follow target-relative geometry rather than elapsed time or a single beat sample
nontransferable_details: published gains, dimensional frequencies, species-specific bend envelopes, robot duty ratios, exact vortex phases, burst durations, fixed approach distances, and task-specific routes
policy_translation: normalized body-frame target direction, distance, head-distance closure, and bearing-window response continuously blend the two-joint state-feedback carrier into a damped same-side equilibrium bend and back
falsification: reject on degraded cruise, lost wake coherence, a tight curl, greater actuator or load residence, premature geometric release, no improvement beyond 2.179L, or persistence of the powered lower exit
```

## Evaluation boundary

The diagnosis uses only completed assigned-parent, sampled-solver, and
inherited-log evidence. The current candidate has no CFD result; controller
probes can establish boundedness, locality, reflection behavior, and response
release only.

## Implemented candidate and pre-CFD checks

The candidate implements only the response-gated whole-body redirect above.
Deterministic replay of its gate on the completed `2.443L` carrier trace gives
a mean maneuver weight of `0.00165` before `15T`, `0.046` at the first `3L`
crossing while closure is still `0.59 L/T`, and `0.992` at the minimum where
closure has fallen to `0.009 L/T`. A separate far-field state differs from the
unmodified carrier by less than `5e-6 rad/T^2` in either command. These are
controller-locality checks, not hydrodynamic evidence for the candidate.

Direct probes pass global reflection, exact-centerline astern neutrality,
far-field carrier preservation, response release, finite outputs, and the
configured command bound. All `324` repository non-CFD assertions pass.
Formal CFD was not run and remains deferred to EvE.
