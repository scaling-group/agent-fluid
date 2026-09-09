# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite moving-window transport, and capture. I inspected both
  rows of the combined sheets for the best-scoring
  `solver_649d7e789a5a` and the lowest-scoring current capture
  `solver_a1b6333c00d2`, then cross-checked the visual comparison against
  `wake_metrics.csv`, `wake_diagnostics.json`, trajectories, executable policy
  diffs, the assigned-parent guidance, and inherited optimizer notes.
- Both sheets show genuine self-propulsion: body-attached alternating
  top-down vorticity develops into a coherent target-bending street, while the
  oblique row retains compact caudal Lambda2 structures through capture.
  Neither sampled run is a wake-topology failure. Their mean planar force and
  moment magnitudes are also indistinguishable at the reported precision.
- The common half-cycle envelope redistribution in `solver_649d7e789a5a` is
  the only sampled architectural improvement. Relative to three baseline or
  response-coupled captures at `18.6505--18.6835T` and mean distance
  `2.09340--2.09405L`, it lowers mean distance to `2.08855L` and improves score
  to `-0.20041`. It reaches the `2--10L` thresholds earlier, but captures later
  at `18.8265T`. Demand is unchanged: its anterior/posterior acceleration
  contacts are `60.85%/73.27%` and rate contacts are `11.07%/14.93%`, inside
  the comparison band.
- The delay is geometry-specific, not a loss of propulsion. At `2L` the best
  sample still has the target almost longitudinally ahead (forward alignment
  `0.997`), but by capture its body-frame lateral target fraction has grown to
  `0.887` and forward alignment has fallen to `0.461`; the three comparison
  captures finish with lateral fractions from `-0.229` to `-0.054`. Across the
  best rollout, forward alignment remains at least `0.878` above `2L`, then
  spans `0.461--0.989` inside `1L`.
- The inherited completed distance-release test is the informative failure.
  It kept redistribution unchanged above `3L`, removed it below `1L`, and
  smoothstepped between those distances. It did not repair arrival: it reached
  only `2.2485L`, exited left with final distance `9.8890L`, and scored
  `-10.93255`. Therefore proximity is not evidence that the additional
  half-cycle allocation can be released; the controller must retain observed
  geometry as the authority signal.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological redirect-to-cruise transitions
source_mechanism: sensor-conditioned release of an added rhythmic turning modulation while a target-owned mean turn remains active
transferable_invariant: release auxiliary beat redistribution only when normalized body-frame geometry shows that its longitudinal approach role has ended, while preserving the traveling wave and persistent target-signed mean curvature
nontransferable_details: published gains, dimensional distances, clock phase, species-specific kinematics, full-body waveforms, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: start from the captured common-envelope half-cycle redistribution; multiply only that added redistribution by a smooth gate of normalized forward target alignment, leaving common amplitude relief, both curvature shares, displacement phase, response release, posterior lag, and acceleration projection unchanged
falsification: reject if capture or either coherent wake view is lost, progress above `2L` regresses outside the sampled capture band, the route repeats the distance-release left exit, terminal lateral alignment and arrival do not improve, or rate/acceleration contact or planar loads materially worsen

## Single-candidate policy hypothesis

Adopt the evaluated common-envelope half-cycle redistribution and add one
geometry-conditioned release. Define forward target alignment as the bounded
body-frame direction cosine `-target_body_L[1] / distance_L`. Keep full
redistribution when this alignment is at least `0.90`, remove it when alignment
falls to `0.75` or below, and use a cubic smoothstep between those normalized
boundaries. Both boundaries are parameter-owned.

This differs from the failed distance schedule: it remains essentially the
evaluated parent throughout the evidenced far/middle route and releases only
when the target becomes strongly lateral rather than merely close. Only the
added half-cycle envelope redistribution is gated; target-signed mean
curvature remains authoritative, so the controller does not coast or discard
route steering. Formal CFD occurs only after this worker exits. Accept the
mechanism only if it retains capture and both coherent wake rows, preserves the
parent's progress advantage above `2L`, and improves terminal alignment or
arrival without worsening the established demand/load boundary.

## Implementation and non-CFD validation

The candidate adds the sampled `half_cycle_relief_redistribution` mechanism
and two parameter-owned direction-cosine boundaries. A trace-only replay of
the gate on the evaluated parent geometry—not a closed-loop or CFD result—has
mean gate `0.9998` above `2L`, with full redistribution on `99.17%` of those
rows and no zero-gate rows. It falls mainly after the evidenced target swing:
mean gates are `0.7949` over `1--2L` and `0.6013` inside `1L`. This audit
supports localization but does not establish the candidate's trajectory.

The configured guidance/provenance and parameter-schema check passes, as does
the solver boundary check. The required check-runner was invoked independently
and reproduced both passes. Julia was absent from its `PATH`; after resolving
the workspace-local Julia 1.10.9 executable, the exact lightweight interface
command returned two finite accelerations and passed every assertion. No CFD
was run.
