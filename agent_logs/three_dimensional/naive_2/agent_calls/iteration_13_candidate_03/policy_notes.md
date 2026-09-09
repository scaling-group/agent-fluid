# Predictive-interception promotion candidate

## Evidence and visual diagnosis before editing

All four sampled evaluations satisfy the experiment contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm.  I inspected both the top-down vorticity row and oblique Lambda2 row
of every combined keyframe sheet.  Every policy is self-propelled behind a
body-connected alternating wake; the three failures are route/terminal-control
failures rather than passive advection, absent propulsion, or instability.

The assigned parent reaches only `2.664L` before curling above the target and
exiting the upper/left boundary at `26.29T`; its sibling course-handoff policy
similarly reaches `2.595L` and exits at `25.36T`.  Their late top-down sheets
show a broad target-side arc followed by a near-vertical escape, while the
oblique sheets retain wake structures through the miss.  They also accumulate
large joint angles or loads: the assigned parent spends `24.2%` of samples
with the tail beyond `40 deg` and reaches peak normalized force components of
`0.435/0.450` and moment `0.220`.

The predictive-miss sample is qualitatively different.  Its top-down sequence
continues down and left into the capture circle instead of crossing high and
curling away, and its oblique sequence retains a compact alternating 3D wake
through capture.  It captures at `16.01T` and `0.74772L`, with head position
`(9.656,9.140)L`, zero `>40 deg` joint dwell, peak normalized force components
`0.024/0.030`, and peak moment `0.0172`.  The rate envelope is still actively
used (`17.2%/17.0%` of samples within `10 deg/T` of the two rate limits), so
the evidence supports the interception architecture, not stronger carrier or
steering gains.

The assigned-parent log proposed a near-target course-response burst after
several distance, bend-release, and common-curvature variants missed.  The new
sampled capture resolves that uncertainty: small mean curvature is useful on
this carrier when recruited early by body-frame constant-course time-to-closest
and signed predicted miss, rather than by proximity, accumulated bend, or a
fixed-horizon aim point alone.

## Single candidate hypothesis

Promote the sampled capture policy as this workspace's single candidate,
without scalar tuning.  Preserve its joint-state traveling-bend carrier and
course-residual half-cycle steering.  Use normalized body-frame target and
velocity to predict whether the measured course will miss within a bounded
response horizon; only that signed miss (smoothly united with the `3L`
fallback) recruits an `8 deg` maximum mean bend while retaining both rhythmic
half-cycles.  This is a mechanism change from the assigned parent and the only
sampled architecture with semantic success.

Support is repeat capture with the coherent wake, no `>40 deg` dwell, and load
scale comparable to the sampled success.  Falsify on loss of capture, an early
false redirect for an aligned course, recurrence of the upper/left escape, or
material growth in joint dwell or normalized loads.  A later robustness test
should reflect or perturb the initial geometry before treating the one-case
curvature sign and prediction horizon as universal.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and fish terminal prey capture
source_mechanism: preserve a propulsive rhythm while terminal feedback acts on observed cross-track motion early enough to change the interception course
transferable_invariant: target-relative course predicts signed miss and response time, so bounded persistent curvature can enter before closest approach without suppressing the traveling wave
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional response horizons, exact vortex phases, prey behavior, and task-specific routes
policy_translation: use normalized body-frame target and velocity to gate a small two-joint carrier mean with time-to-closest and signed miss, while preserving the joint-state traveling bend and course-residual half-cycle steering
falsification: reject on loss of capture, false redirect on an aligned course, repeated upper or left escape, joint-limit dwell, load growth, or loss of the coherent alternating wake

## Dry validation after editing

The mandated guidance-materiality, Julia policy-contract, parameter-schema,
and editable-boundary checks pass.  All 22 direct `params.FIELD` references are
declared by `target_policy_params()`, and the candidate is byte-identical to
the sampled capture policy.  No CFD was run in this workspace; the capture and
physical metrics above are prior sampled evidence, not a same-worker result.
