# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled examples are valid direct-uniform, zero-inflow L64
  moving-window rollouts and capture at `18.6615--19.0520T`. The two combined
  sheets inspected in detail (`solver_8687829e1d01` and
  `solver_072da2f3a45e`) show self-propelled motion: body-attached alternating
  top-down vorticity develops into a regular street, while the oblique view
  retains compact paired Lambda2 structures around the caudal region. Both
  routes bend toward the capture circle without a visible loss of wake
  coherence. The slower terminal velocity/range compound has no distinct wake
  advantage over the simpler parent.
- The parent and its comment-only/response-coupled repeats establish a local
  capture band near `18.6505--18.7550T` and inherited guidance reports mean
  distance `2.09340--2.09542L`. Reconstructed sampled traces still contact the
  acceleration limit on about `60.7--61.0%` of anterior and
  `73.0--73.2%` of posterior rows; capture therefore does not establish demand
  relief.
- Assigned-parent evidence shows that enhancing the posterior zero-mean wave
  during anterior relief kept both wakes coherent but missed the target
  (`3.1465L` closest approach, `left_domain`). Sampled optimizer guidance adds
  an independent posterior mean-curvature release failure (`4.5218L` closest
  approach, `left_domain`). The reusable boundary is to preserve common
  anterior/posterior allocation rather than assigning redirect and cruise
  recovery to separate joints.

## Policy hypothesis

Keep the captured geometry-scheduled carrier unchanged except for one
state-feedback mechanism: redistribute its existing common rhythmic-envelope
relief across the observed anterior displacement half-cycle. Preserve the
average geometry-owned relief, but apply less relief when the anterior bend is
aligned with the target-signed steering bias and more during the opposed
half-cycle. This is a common-envelope duty redistribution, not a posterior-
specific allocation and not a gain-only retune. It should retain the traveling
wave, both target-signed mean-curvature shares, displacement-only phase,
one-sided response release, posterior lag, and final acceleration projection
while reducing unproductive saturated drive. Reject it if capture or either
wake view is lost, if arrival/mean distance falls outside the established
repeat band without a compensating semantic improvement, or if posterior and
anterior demand do not measurably decrease.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric flapping
source_mechanism: sensor-modulated half-cycle amplitude or duty redistribution for turning
transferable_invariant: redistribute bounded rhythmic effort between observed beat halves while preserving the traveling wave and target-owned mean turn
nontransferable_details: published gains, servo geometry, clock phase, species kinematics, duty ratios, and task-specific routes
policy_translation: use normalized body-frame target side and anterior joint displacement to redistribute the existing common envelope relief; keep both curvature shares and posterior lag unchanged
falsification: reject on loss of capture, route outside the replicated capture band, degraded top-down or oblique wake coherence, or no measurable demand reduction
