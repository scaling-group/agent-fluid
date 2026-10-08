# Wake-policy candidate diagnosis

## Evidence read before the edit

All four sampled evaluations satisfy the frozen-flow contract: direct uniform
initialization, `U_infinity=[0,0,0]`, no cylinders, finite dynamics, and capture
at the logged `23.375013T` sample. The prefilled policy is the course-demand
handoff evaluated by `solver_04760fa01847`; `solver_e584ff748453` differs only
in a provenance comment and produces a bit-identical trajectory.

The combined and view-specific sheets for the strongest finite sample
`solver_477c7f626e4f` and the informative full-reserve regression
`solver_e7cd0978d380` were inspected from release to termination. In both
top-down rows the fish moves through still water under its own gait, creates a
coherent alternating mid-plane vortex street by `5T`, retains that street
through `18T`, and curves toward the capture circle near `23T`; there is no
visible passive advection or wake collapse. Both oblique rows show compact,
alternating three-dimensional Lambda2 structures convecting behind the body
and a continuous target-directed trajectory. The sheets are visually almost
indistinguishable at their sampling cadence, so the scalar difference is not a
new route or a dramatic vortex event.

Trajectory and diagnostic cross-checks locate the useful difference in the
terminal controller. The full progress release scored `-0.50515772` with
scoring mean/final distance `2.402131/0.748882L`; inside `3L` its mean/peak
absolute yaw were `1.71255/3.29199 rad/T`, mean/peak target-line cross-track
speed were `0.23513/0.61953U`, and peak absolute moment was `0.014507`. The
assigned-parent course-only handoff improved score and mean/final distance to
`-0.50341472` and `2.400748/0.747085L`, with inside-`3L` yaw
`1.71472/3.27552 rad/T`, cross-track speed `0.23486/0.62108U`, and peak moment
`0.014923`. The sampled stabilization-envelope handoff is strongest at
`-0.50260322` and `2.400102/0.746257L`; it also lowers inside-`3L` mean yaw and
mean cross-track speed to `1.70656 rad/T` and `0.23432U`. Its peak yaw,
cross-track speed, and moment (`3.28817 rad/T`, `0.62616U`, `0.015118`) expose a
real peak-load trade rather than a comprehensive terminal improvement. All
three retain essentially the same joint-speed and smoothly projected command
envelopes.

## Candidate hypothesis

Reproduce the evidence-backed stabilization-envelope policy rather than add an
unsupported fast-signal gate or scalar retune. Preserve the target-progress-
qualified traveling carrier, continuous anterior-only course response,
distributed-rate phase classifier, anterior phase-selected correction,
posterior lag, and smooth command projection. Form a bounded union with
`max(abs(terminal_yaw_brake), abs(terminal_halfcycle_yaw_counter))`; while that
union is active, yield only the small target-progress cadence reserve. Do not
sum the demands, remove base cadence, alter steering authority, or introduce a
distance-only fade. The sampled result predicts preservation of capture and
wake topology with a narrow improvement in distance integral, final crossing,
mean terminal yaw, and mean cross-track speed relative to the assigned parent.
It does not predict lower peak moment or peak cross-track motion.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and terminal approach control
source_mechanism: sensor feedback modulates a rhythmic carrier while preserving the traveling-wave gait; near-target excess drive can yield to measured stabilization demand
transferable_invariant: coordinate only surplus propulsive cadence with bounded observed steering demand, while retaining the base posterior-lagged carrier
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phase, body spline, and task-specific routes
policy_translation: use normalized body-frame target progress and the bounded union of the existing course and phase-selected terminal feedback roles to withdraw only the extra cadence reserve
falsification: reject if deterministic CFD does not retain capture and the coherent alternating 3D wake, fails to match or improve parent-scale distance progress and mean terminal yaw/cross-track speed, or materially worsens peak loads or actuator feasibility

The new CFD result is unavailable to this worker. A later worker should treat a
non-reproduction or further peak-load growth as evidence against this replay,
not as permission for another envelope-gain or fast-cue retune.
