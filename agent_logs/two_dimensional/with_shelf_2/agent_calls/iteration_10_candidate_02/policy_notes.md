# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release while four developed cylinder streets merge around the target. The
  released comparisons therefore share a mature initial wake; none supports a
  candidate-specific flow-initialization explanation.
- All four sampled sheets show active, self-propelled upstream motion with a
  coherent body-generated traveling wake and continuous diagonal capture. The
  best-scoring course-consistency child reaches the `0.75L` circle at `45.61`,
  with `1.722L` mean distance, `-11.06/-4.73L` head displacement, and mean
  upstream body velocity `-0.241` against mean local flow `-0.174`. It is not
  being passively advected to the target.
- The direct parent comparison isolates a tradeoff. The otherwise matched
  closure-efficiency controller reaches slightly earlier at `45.48`, whereas
  course-consistency reallocation improves score `0.15639 -> 0.15883`, mean
  distance `1.724L -> 1.722L`, and mean command energy `1034 -> 1029`. The
  reallocation also raises force/moment RMS `405/4029 -> 453/4406`, while both
  policies touch the `4.538` joint-rate caps. The inherited phase-lag child is
  a negative timing result: despite analytic amplitude compensation it slows
  capture to `46.22`, worsens mean distance to `1.735L`, and raises mean
  command energy to `1036`; another lag or amplitude scalar is not supported.
- No current sampled failure keyframe exists: every sampled solver reaches the
  target. The inherited logs, rather than a new visual claim, provide the
  informative failure contrast: a propulsion-priority headroom allocator
  passed below the circle and collided with the lower second-row cylinder at
  `58.93`, with `1.872L` closest approach and `537/4995` force/moment RMS.
  Preserve the established steering composition, yaw-load gate, and base
  traveling wave.

## Candidate hypothesis

Start from the best-scoring course-consistency controller. Add one compact
wake-response mechanism only around its optional course-trend modulation: use
normalized yaw-moment magnitude to fade that modulation toward a nonzero floor
when the wake/body interaction is already imposing a strong turn. The base
oscillator, target steering, yaw-gated route residual, alignment-conditioned
posterior emphasis, and closure-earned posterior bonus remain unchanged. Thus
low-load motion is the sampled best controller, while strong-load events move
only the new course reallocation toward the lower-load closure-efficiency
parent rather than weakening propulsion or route authority.

The next CFD rollout falsifies this candidate if it loses `target_reached`,
does not preserve the useful diagonal topology, regresses materially from the
`45.61` arrival or `1.722L` mean-distance baseline, or fails to reduce the
`453/4406` load cost without compensating score, effort, or progress benefit.
A success in the fixed snapshot would still not establish robustness to
changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: wake-interaction control combined with sensor-modulated robotic-fish rhythmic control
source_mechanism: separate slower target-course feedback from fast wake/body yaw loading while preserving the rhythmic propulsion generator
transferable_invariant: attenuate only an optional course-shaping propulsion residual when normalized yaw-load magnitude says the wake/body interaction is already turning strongly
nontransferable_details: published gains, dimensional load thresholds, species-specific envelopes, robot linkage geometry, moment sign, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: multiply body-frame bearing-trend modulation of the closure-earned posterior bonus by a smooth gate of absolute `moment_z_L2`, leaving the two-joint traveling wave, base posterior envelope, and target-steering law unchanged
falsification: reject if capture or route topology is lost, arrival or mean distance regresses materially, or force/moment and limit residence do not improve without compensating score or effort benefit
