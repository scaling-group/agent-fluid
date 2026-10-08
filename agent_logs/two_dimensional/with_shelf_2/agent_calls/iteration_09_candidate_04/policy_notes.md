# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release while the four cylinder streets develop and merge around the target.
  The released sheets therefore compare controllers from the same mature wake,
  not different flow initialization.
- The assigned parent visibly retains a coherent traveling body wake, follows
  a continuous diagonal down-left route, and bends into the capture circle. It
  is the strongest sampled finite result: `target_reached` at `45.48`,
  `1.724L` mean and `0.748L` final/minimum distance, with `-10.97/-4.59L` head
  displacement and `405/4029` force/moment RMS. Both joint rates still touch
  the `4.538` limit, so added authority must remain bounded.
- The sampled posterior-envelope contrasts preserve success but separate useful
  response structure from scalar effort. Fixed alignment emphasis reaches at
  `46.80` with `1.745L` mean distance; dimensional signed closing modulation
  reaches at `46.66` with `1.731L` mean distance and higher `453/4371` loads;
  progress-deficit emphasis reaches at `46.31` with `1.736L` mean distance and
  lower `393/3878` loads. The parent's body-speed-normalized, positive-closure
  bonus is faster and lower-load than the first two while retaining the same
  useful trajectory topology.
- No current sampled failure sheet exists: all four released examples reach the
  target. The informative negative contrast is therefore inherited log
  evidence rather than a new visual claim. A propulsive-priority allocator
  traveled farther upstream/downward, passed below the capture circle, and
  collided with the lower-left cylinder at `58.93`; its `1.872L` closest
  approach and `537/4995` force/moment RMS show that scalar range progress and
  extra travel do not certify cross-track course consistency.

## Candidate hypothesis

Preserve the parent's oscillator, predicted-bearing half-cycle steering,
yaw-moment gate, alignment gate, normalized positive-closure feedback, and
soft limiter. Add one bounded course-consistency modulation only to the small
closure-earned posterior bonus. The signed product of normalized body-frame
bearing and windowed bearing rate distinguishes decreasing bearing magnitude
from range closure that is drifting off-course: converging bearing modestly
strengthens the bonus, while diverging bearing relaxes it. Zero history leaves
the parent's startup output unchanged, and neither the base traveling wave nor
the target-steering residual is altered.

The next CFD rollout falsifies the candidate if it loses `target_reached`,
fails to improve the parent's `45.48` arrival or `1.724L` mean-distance
baseline, recreates a lower collision/exit, or raises joint-limit residence,
command effort, or hydrodynamic loads without a shorter useful route. A fixed
wake success would not establish robustness to changed phase, inflow,
geometry, or target.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-interaction control
source_mechanism: preserve the rhythmic propulsion generator while bounded target-response feedback redistributes only a small propulsion-envelope residual
transferable_invariant: reward range closure with extra propulsion only when normalized body-frame direction error is also converging, and relax that residual when cross-track error grows
nontransferable_details: published gains, dimensional rates, robot linkage geometry, species-specific envelopes, learned routes, cylinder coordinates, and exact vortex phases
policy_translation: multiply the parent's closure-earned posterior emphasis by a bounded function of bearing times windowed bearing rate, leaving the base two-joint traveling bend and yaw-gated steering unchanged
falsification: reject if capture or useful diagonal topology is lost, arrival and mean distance do not improve, or the modulation increases saturation or loads without better course-consistent closure
