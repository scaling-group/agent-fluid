# Evidence-selected bearing-divergence candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled evaluations are valid direct-uniform, quiescent-water
  rollouts with no cylinders or prewarm; all terminate in capture with finite
  dynamics.  I inspected the combined top-down vorticity and oblique
  body/Lambda2 sheets for the strongest sampled controller, the prefilled
  parent, and the response-arbitrated alternative from release through
  capture.  Each fish is self-propelled rather than advected: a compact startup
  wake develops into a coherent alternating posterior street in both views,
  with a smooth target-directed arc and no wake collapse, collision, domain
  exit, or visible instability.  The meaningful difference is route progress,
  not wake existence or termination class.
- The bearing-divergence controller is the only sampled semantic improvement.
  It captures at `18.403006 T`, score `-0.140449`, total distance integral
  `2.027810 L`, and observed integral `1.418099 L`, versus the prefilled
  bidirectional-allocation parent's `18.765995 T`, `-0.170272`, `2.058347 L`,
  and `1.451295 L`.  It leads the parent by
  `0.0611/0.1487/0.2454/0.2693 L` at `4/8/12/16 T`; the advantage therefore
  precedes the discrete terminal sample.  The one-way-like response-arbitrated
  sibling also remains at `18.754995 T` and `1.448969 L` observed integral, so
  merely suppressing reverse allocation does not explain the improvement.
- The improved route retains the parent's physical envelope.  Mean/max speed
  changes from `0.6855/0.9402` to `0.6961/0.9476 L/T`, any-joint
  acceleration-limit residence from `41.35%` to `42.14%`, peak normalized
  planar force remains `0.03068`, and peak normalized yaw moment changes only
  from `0.01565` to `0.01587`.  This is added target response with a modest
  action/speed cost, not effort relief.
- The inherited optimizer log supplies the isolating comparison: adding the
  same mechanism to the completed one-way closing-response carrier improves
  capture from `18.7550 T` and total integral `2.05886 L`.  Its reconstructed
  de-gaited bearing had spent long middle/late intervals outside the centerline
  band while increasing in magnitude even though closure and the coherent wake
  persisted.  The completed CFD result confirms that this was actionable route
  divergence rather than harmless within-beat recoil.
- Terminal-only bidirectional recovery and closure-arbitrated reverse recovery
  both capture near `18.755 T` but do not reproduce the middle-route lead.
  Therefore the candidate removes posterior-to-anterior reverse allocation and
  does not combine another steering-recovery path with the positive geometric
  mechanism.

## One-candidate policy hypothesis

Reproduce the evaluated bearing-divergence controller as the single candidate.
Preserve its state-feedback traveling wave, posterior lag, raw large-error
redirect, mean-preserving whole-wave pose projection, head-only route-rate
correction, raw half-cycle steering, response-released cadence, approach
scheduling, head-to-tail rejected-steering allocation, and componentwise
physical bounds.  Outside the de-gaited centerline band, add bounded
target-signed curvature only while `bearing * bearing_trend > 0`; release it
when the observed bearing contracts and attenuate it on approach.  This is a
geometric response mechanism, not scalar-only carrier tuning.

The candidate should reproduce capture near `18.403 T`, preserve the coherent
two-view wake, retain the `0.9476/42.14%/0.03068/0.01587`
speed/saturation/force/moment envelope, and keep its established lead by
`8--16 T`.  Falsify the transfer if capture is lost or materially later than
`18.403 T`, observed distance integral rises above `1.41810 L`, the bearing
oscillation or target arc worsens, or speed, saturation, force, or moment grows
without compensating closure.  The new CFD evaluation occurs only after this
worker exits, so the completed sampled rollout—not this worker—is the outcome
evidence.

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: retain bounded redirect authority while observed target geometry worsens and release it when the geometric response contracts the error
transferable_invariant: gate extra steering by normalized observed error response rather than elapsed time or exact beat phase, while keeping rhythmic propulsion separate
nontransferable_details: published gains, species-specific C-start kinematics, full-body envelopes, clocked CPG phase, dimensional cadence, exact vortex phase, and prescribed routes
policy_translation: outside the de-gaited body-frame centerline band, add smooth target-signed two-joint curvature only for positive bearing divergence and fade it with normalized approach distance
falsification: reject if capture or middle-route closure regresses, the alternating wake loses coherence, or the established speed, saturation, normalized force, or yaw-moment envelope is materially exceeded
```
