# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed interacting vortex streets. It is the certified common
  initial condition, not candidate-specific evidence.
- All four sampled solver examples are behavior-equivalent replays of the
  ungated posterior-half-cycle controller. Their released sheets show an
  immediate targetward redirect, a sustained body-generated traveling wake,
  clear cylinder separation, and one compact diagonal crossing into the
  `0.75L` target circle. Head motion `(-10.912,-4.332)L`, compared with mean
  local flow `(-0.197,-0.189)`, confirms that the fish is self-propelled rather
  than merely advected. They reproduce capture at `32.472`, mean distance
  `1.64761L`, score `0.224538`, and force/moment RMS `68.70/931.60`.
- The best available visual contrast is the inherited direction-selective
  posterior-headroom gate; no failed released keyframe is present in this
  workspace. Its sheet preserves the same productive diagonal topology and it
  repeatedly captures at `32.7305`, while aggregate force/moment RMS falls to
  `56.29/800.58`. The `0.80%` arrival delay and score `0.223211` show that this
  repeated mechanism buys load relief, not a navigation improvement. Four
  consecutive assigned-parent evaluations reproduce exactly and add neither a
  new mechanism nor a semantic outcome, which triggers a new bookshelf
  consultation under the structured transfer protocol.
- The inherited unrestricted bearing-trend result remains the applicable
  negative boundary even though its failed sheet is unavailable here: it
  erased the developed traveling bend, reached only `0.140/0.163 rad` joint
  excursions, moved downstream, and exited after `16.956` with a `12.424L`
  closest approach. A response-triggered extra posterior burst also captured
  later and raised loads. Route-response feedback therefore must neither add
  posterior authority nor freely move the oscillator centers.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking combined with the biological C-start redirect-and-release pattern
source_mechanism: retain a rhythmic traveling gait, request bounded curvature for a large target error, and release into propulsion when observed heading response is already correcting that error
transferable_invariant: slower body-frame target geometry should own mean turn direction, while a verified correct-sign heading response may withdraw only part of the steering bias; the base oscillator, posterior lag, and target-helping half-cycle remain intact
nontransferable_details: published feedback gains, duty ratios, dimensional rates, species or robot kinematics, exact vortex phases, actuator ratings, source-task paths, and prescribed maneuver timing
policy_translation: compare normalized recent heading and bearing rates with the persistent body-frame bearing, require both targetward rotation and shrinking bearing plus gait-scale anterior activity, then smoothly release only a bounded fraction of distributed mean curvature
falsification: reject if the initial redirect weakens, the traveling bend collapses, the diagonal route becomes less direct, capture or score is lost, arrival exceeds the inherited `32.7305` low-load branch, or loads rise without better distance integral

## Candidate hypothesis

Produce exactly one candidate by adding a one-sided response-release mechanism
to the sampled high-score controller. Preserve the filtered body-frame bearing,
`12 deg` curvature envelope, bearing-conditioned `40/60 -> 35/65` allocation,
anterior state-feedback oscillator, posterior lag and damping, and the existing
maximum `8%` target-helping half-cycle residual.

The new gate activates only after anterior joint state demonstrates a developed
gait and only when recent heading rotates with the requested turn while the
body-frame bearing shrinks. It can withdraw a limited fraction of both mean-
curvature centers but cannot attenuate the traveling wave or posterior residual.
This is a safeguarded test of the inherited negative lesson: release steering
after measured response instead of feeding an unrestricted bearing trend into
the oscillator. The downstream CFD evaluation must determine whether it
straightens the productive diagonal and improves distance integral or load; no
same-worker improvement is claimed.
