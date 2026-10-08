# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed interacting vortex streets. It is the certified common
  initial condition, not evidence for candidate-specific wake selection or
  release-phase robustness.
- Every current released sheet shows a self-propelled traveling bend, an
  immediate targetward redirect, cylinder clearance, and the same compact
  diagonal entry into the `0.75L` target circle. Head displacement of about
  `(-10.91,-4.24 to -4.33)L`, versus mean local flow near
  `(-0.19,-0.19)`, confirms that upstream progress is not passive advection.
- The ungated posterior half-cycle benchmark captures at `32.472`, with
  `1.64761L` mean distance and `68.70/931.60` force/moment RMS. The sampled
  verified-heading-response branch releases only part of distributed mean
  curvature and improves arrival to `32.1365`, mean distance to `1.63696L`,
  and loads to `67.22/907.46`. The sampled progress-supervised posterior
  headroom branch captures at `32.340`, with `1.63773L` mean distance and
  lower `65.12/888.56` loads; its `0.234663` score narrowly leads the
  response-release branch's `0.234607`.
- These two branches improve complementary control channels while preserving
  the same visible route: response release acts only on target-signed mean
  curvature, whereas headroom supervision acts only on the optional `8%`
  posterior half-cycle residual. Their aggregate evidence does not prove
  shorter saturation residence, wake-phase robustness, or benefit from their
  combination; downstream evaluation must test those claims.
- No failed released keyframe is present in the sampled workspace. The most
  informative inherited failure remains unrestricted bearing-rate
  recentering: it erased the traveling bend, moved downstream, and exited at
  `16.956`. The inherited response-triggered extra posterior burst also
  arrived later and raised loads. The candidate therefore neither feeds a
  route rate into oscillator centers nor adds posterior authority.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking combined with biological redirect-and-release turning and elongated-body posterior reactive propulsion
source_mechanism: keep a persistent traveling rhythm while observed targetward response releases mean steering and normalized actuator state regulates only an incremental posterior asymmetry
transferable_invariant: slow body-frame target geometry owns bounded mean curvature, verified correct-sign response may withdraw only part of that curvature, and actuator headroom may yield only the optional rhythmic residual during coherent closure
nontransferable_details: published gains, dimensional frequencies, duty ratios, species or robot kinematics, exact vortex phases, actuator ratings, prescribed maneuver timing, and source-task routes
policy_translation: preserve the sampled response-release controller and multiply only its optional target-helping posterior half-cycle increment by the sampled progress-supervised direction-selective headroom gate using normalized joint speed, prior acceleration, and target-vector closure
falsification: reject the combination if capture or the compact diagonal topology is lost, arrival exceeds the `32.472` ungated benchmark, mean distance exceeds `1.64761L`, or force and moment fail to improve on the `67.22/907.46` response-release branch without matching its faster arrival

## Candidate hypothesis

Produce exactly one candidate by combining the two independently positive,
channel-separated sampled mechanisms. Preserve the parent response-release
controller's filtered body-frame bearing, bounded `12 deg` total-curvature
request, `40/60 -> 35/65` allocation, anterior oscillator, posterior lag and
damping, and maximum `8%` target-helping half-cycle residual. Add the sampled
trajectory-efficiency-supervised posterior headroom gate only to that optional
residual.

The response-release gate continues to withdraw a bounded part of both mean
curvature centers only after gait activity, targetward heading response, and
shrinking bearing agree. The headroom gate then withdraws only the incremental
posterior half-cycle gain when normalized posterior speed or prior acceleration
reinforces it and the target-vector history shows coherent closure. The base
lagged traveling wave and remaining target-signed centers cannot be suppressed
by either gate. This worker claims no same-worker CFD improvement; the next
rollout must determine whether the combination retains the faster approach
while inheriting some of the lower-load branch's benefit.
