# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release while four developed cylinder wakes merge around the target. The
  released sheets therefore compare policy response from the same mature wake
  rather than different flow initialization.
- The assigned parent is the strongest sampled finite result. Its sheet shows
  a coherent body-generated traveling wake and a continuous diagonal
  down-left approach through the merged wake to `target_reached` at `45.61`.
  Metrics confirm `0.158830` score, `1.7222L` mean and `0.7471L`
  final/minimum distance, and `-11.06/-4.73L` head displacement. This is
  active upstream propulsion: mean body velocity is `-0.241` while mean local
  streamwise flow is `-0.174`.
- The parent's new course-consistency envelope is a narrow positive scalar
  result with a physical tradeoff. Relative to the otherwise matched policy,
  it improves score from `0.156386` to `0.158830` and mean distance from
  `1.7244L` to `1.7222L`, but arrival slows from `45.48` to `45.61` and
  force/moment RMS rises from `405/4029` to `453/4406`. Both joints still
  touch the `4.538` rate limit and acceleration approaches the candidate soft
  cap. The evidence supports preserving, but not amplifying, the small
  course-conditioned posterior residual.
- A sibling's aligned closure-conditioned posterior phase-lag shift is a
  concrete negative mechanism result. It preserves capture but regresses to
  `0.146573` score, `46.22` arrival and `1.7346L` mean distance versus the
  unshifted `0.156386`, `45.48` and `1.7244L` baseline; command energy mean and
  force/moment RMS also rise to `1036` and `424/4253`. Its sheet retains the
  same broad route topology, so extra posterior phase lag is not supported as
  a useful next propulsion edit.
- No failed candidate sheet is present in the current sampled set; all four
  reach the target. The informative failure boundary remains inherited log
  evidence: a propulsive-priority allocator passed below the circle and hit
  the lower-left cylinder despite farther travel. That rules out treating
  scalar range closure as sufficient course evidence.

## Candidate hypothesis

Preserve the complete successful oscillator, lagged posterior wave,
distributed half-cycle steering, yaw-moment gate, alignment/closure envelope,
course-consistency residual, and soft limiter. Add one bounded line-of-sight
trend response to the predicted body-frame bearing used by route steering. A
short windowed bearing trend is already an available normalized observation:
when the bearing is converging, the lead term releases a turn that is already
working; when it is diverging, it strengthens the route request before scalar
range closure becomes an off-course pass. A smooth cap smaller than the
existing heading-response cap prevents beat-scale wake motion from dominating
the target geometry, and missing history leaves the parent output unchanged.

The next CFD rollout falsifies the candidate if it loses `target_reached`,
does not improve the parent's `0.158830` score or `1.7222L` mean-distance
baseline, recreates a lower collision/exit, or raises joint-limit residence,
command effort, or hydrodynamic loads without a meaningfully tighter route.
Success in the fixed wake snapshot would not establish robustness to changed
wake phase, inflow, cylinder geometry, or target.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and wake-interaction control
source_mechanism: bounded target-response feedback shapes a preserved rhythmic locomotion generator while route response is separated from wake-scale oscillation
transferable_invariant: combine body-frame direction error with its observed trend so a correcting turn is released and a diverging course receives bounded additional steering without changing the propulsive rhythm
nontransferable_details: published gains, dimensional lookahead times, robot linkage geometry, species-specific kinematics, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: add a smoothly capped windowed-bearing-rate lead to the parent's predicted bearing before the existing two-joint half-cycle steering and alignment gates
falsification: reject if capture, score, mean distance, route topology, saturation, or load tradeoffs regress relative to the assigned parent
