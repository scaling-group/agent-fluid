# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled episodes satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`) and terminate in capture. The two executable-identical
  assigned-parent redistribution samples capture at `18.8265T` and `18.8815T`,
  with held-horizon mean distances `2.08855L` and `2.08896L`. Their top-down
  sheets show a target-bending alternating street from release through capture,
  and their oblique sheets show compact, repeated caudal Lambda2 structures.
  The motion is self-propelled rather than advection: sampled local-flow speed
  stays below about `0.026U` while fish speed reaches about `0.93U`.
- The clean-envelope comparator captures earlier at `18.6010T` but has a
  slightly worse held-horizon mean distance (`2.09042L`) and the same visible
  wake class. The rearward-route multiplier captures at `18.9640T` and
  `2.09072L`, but the target remains forward, so it demonstrates branch
  non-interference rather than exercised recovery. Across the four current
  samples, anterior/posterior acceleration contact remains about
  `60.85--61.17%`/`72.95--73.27%`, rate contact about
  `10.93--11.07%`/`14.73--14.96%`, peak planar force
  `0.03066--0.03259`, and peak moment `0.01603--0.01656`; none is actuator
  relief or a distinct wake mechanism.
- There is no failed keyframe sheet among the four current solver samples.
  The inherited higher-Elo optimizer guidance supplies the informative failure
  boundary: an executable-equivalent clean controller retained an energetic
  two-view wake, passed below the target at `0.96285L`, and exited left at
  `33.979T` and `10.44465L`. Its reconstruction found nominally correcting yaw
  while target bearing was non-improving on `1376/3033` correcting-yaw rows
  (`315` inside `3L`), versus only `8/1603` in the best current redistribution
  capture. Thus wake coherence and correcting body yaw do not prove that
  target-relative route error is improving.

## Policy hypothesis

Preserve the assigned parent's target-signed differential curvature,
displacement-only half-cycle steering, common-envelope redistribution,
posterior lag, response-release fraction, and final acceleration projection.
Replace only the response observation: release curvature when the short-window
body-frame target bearing is moving toward zero, rather than when body yaw has
the nominal correcting sign. This is an observation/feedback architecture
change, not propulsion or envelope gain tuning. It directly tests whether
target-relative progress prevents the inherited below-target divergence while
leaving the evidenced carrier intact.

The current CFD result is not available to this worker. Falsify the candidate
if it loses capture or either wake row, repeats the below-target miss/left-exit
topology, moves held-horizon mean distance outside the established carrier
range without a robustness gain, or raises acceleration/rate contact or planar
loads beyond the sampled bands. A normal capture alone establishes
compatibility/replication, not performance improvement; credit the mechanism
only when multimodal independent evidence excludes the known miss topology.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and asymmetric-flapping turning
source_mechanism: sensory route error modulates a bounded curvature asymmetry around an intact rhythmic carrier
transferable_invariant: release target-signed turning authority only when normalized body-frame target error itself is improving, while preserving the coordinated traveling bend
nontransferable_details: published gains, clock phases, robot geometry, species kinematics, exact vortex phases, and task-specific paths
policy_translation: replace yaw-sign response release with bounded signed `bearing_window_rate` progress; retain target-owned turn sign and the existing two-joint oscillator, lag, curvature shares, and envelope
falsification: reject on loss of capture or either wake view, recurrence of the below-target miss/left exit, route or load degradation beyond repeat spread, or evidence that bearing-progress release chatters and disrupts the carrier
