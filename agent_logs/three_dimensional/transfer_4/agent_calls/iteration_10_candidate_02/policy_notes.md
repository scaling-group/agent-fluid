# Candidate diagnosis and hypothesis

## Evidence reviewed

- Read the assigned parent guidance and all four sampled `score.yaml`,
  `wake_observation.md`, `wake_metrics.csv`, `wake_diagnostics.json`, and
  trajectories. No inherited optimizer log exists in this rendered workspace.
- Inspected both rows of the combined keyframe sheets for the best sampled
  controller (`solver_c668b8e0b865`), the least efficient captured trajectory
  (`solver_6a68ab190967`), and the assigned solver parent
  (`solver_da4e7c2190b0`). All four diagnostics confirm direct uniform
  still-water initialization, `U_infinity=[0,0,0]`, and stable capture.

## Visual and metric diagnosis

The top-down sheets show self-propelled motion rather than ambient advection:
an alternating signed-vorticity street grows behind the fish from release to
capture. The oblique sheets confirm a persistent three-dimensional Lambda2
wake with paired structures shed by the posterior body and caudal fan. Neither
the slower mean-curvature-only line-of-sight variant nor the parent terminal
course variant visibly loses this carrier. Their difference is therefore a
route/steering integration defect, not weak propulsion or wake collapse.

The error-qualified line-of-sight controller is the strongest sampled result:
it captures at `17.7265T`, has mean distance `1.967391L`, center path
`12.8468L`, maximum head straight-line cross-track `0.5120L`, and final yaw rate
`-0.9008 rad/T`. The mean-curvature-only translation keeps a coherent wake but
captures at `18.6175T`, raises mean distance to `1.978602L`, path to
`13.6033L`, and head cross-track to `0.7700L`. Thus the slow route residual must
retain authority through the ordinary mean-curvature plus beat-synchronous
steering path; isolating it to posterior mean curvature is a negative result.

The assigned parent adds target-to-course steering as the far line-of-sight
residual releases. It captures, but at `17.8805T` with mean distance
`1.974576L`, center path `12.9674L`, head cross-track `0.5477L`, and final yaw rate
`-3.1956 rad/T`. The otherwise nearly identical no-course sampled controller
ends at `-3.1526 rad/T` and scores slightly better, while the error-qualified
far-only controller is better on arrival, distance integral, path, cross-track,
and rate-limit residence. Direct terminal course injection therefore has no
surviving positive evidence in this batch.

## Policy hypothesis

Preserve the sampled posterior-priority state-feedback carrier and the
direction-selective rate governor unchanged. Replace the parent's unqualified
line-of-sight/terminal-course handoff with one smooth route-observer gate: the
co-windowed line-of-sight residual is multiplied by current normalized
body-frame target error and fades exactly to zero on entry to the existing
`2.10L` approach controller. Apply that residual through both existing
steering channels. This is a feedback-architecture transfer, not a carrier
gain change.

Expected result: retain the coherent wake and capture while recovering the
sampled winner's earlier, shorter, lower-cross-track route and avoiding the
parent's late yaw sweep. Falsify the candidate if it loses capture or wake
coherence, fails to improve the parent's mean distance/path/arrival, or if a
reflected or disturbed condition shows that error qualification suppresses a
necessary line-of-sight correction.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal target capture
source_mechanism: sensor-qualified modulation of a low-dimensional propulsive rhythm with continuous release between route and approach regimes
transferable_invariant: preserve the stable rhythmic carrier while a bounded correction acts only in the observed error regime that requires it and vanishes continuously when that regime ends
nontransferable_details: published oscillator gains, clock phase, duty ratios, species kinematics, dimensional distance thresholds, and task-specific routes
policy_translation: multiply co-windowed line-of-sight drift by normalized body-frame target-error and forward gates outside approach, then pass it through the existing two-joint mean-curvature and half-cycle steering contract
falsification: reject if capture, distance integral, path, cross-track, wake coherence, or held-out reflection/disturbance behavior is worse than the assigned parent or the sampled error-qualified controller
