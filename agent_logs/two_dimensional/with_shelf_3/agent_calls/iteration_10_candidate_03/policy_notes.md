# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. The released sheets for both the
  strongest sampled controller and the assigned prefill show an immediate
  correct-sign redirect, a sustained body-generated traveling wake, a compact
  diagonal crossing, and first entry into the `0.75L` target circle. Neither
  trajectory is passive advection or a cylinder approach. The prefill's late
  body wake is visibly wider, consistent with excess rather than useful
  posterior authority.
- Three byte-identical sampled realizations of the filtered-bearing,
  bounded-curvature controller with an `8%` target-helping posterior half-cycle
  residual capture at `32.472` release time with `1.64761L` mean distance and
  score `0.224538`. They establish deterministic fixed-snapshot
  reproducibility, not robustness across wake phases.
- The assigned prefill adds a bearing-response-gated positive burst on top of
  that residual. It still captures, but degrades arrival to `32.824`, mean
  distance to `1.66402L`, and score to `0.208280`, while raising force/moment
  RMS from `68.70/931.60` to `70.97/945.05`. Its peak posterior excursion also
  rises from `0.5834` to `0.5941 rad`. Recent improvement in target-bearing
  therefore does not identify a need for more posterior authority; this
  extension is falsified by navigation, load, and visual-wake evidence.
- The inherited logs clarify the alternative trade. Direction-selective
  headroom gating normalized by `amplitude*frequency` and
  `amplitude*frequency^2` preserves the compact capture at `32.7305` and cuts
  force/moment RMS to `56.29/800.58`, but its score is slightly lower at
  `0.223211`. A blanket gate normalized by physical actuator limits arrives at
  `33.9405` with score `0.181716`. Because higher score is the task objective,
  the direction-selective gate remains a useful low-load branch rather than
  the selected candidate.
- No failed rollout is present among the current solver samples. Failure
  boundaries therefore come from inherited logs: unrestricted bearing-trend
  feedback and anterior-heavy recentering destroyed the traveling bend and
  exited downstream. This candidate changes neither oscillator centers nor the
  distributed mean-curvature scaffold.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping interpreted through elongated-body posterior reactive propulsion
source_mechanism: add bounded turn-congruent half-cycle asymmetry to a persistent lagged propulsive wave while slower target geometry owns mean curvature
transferable_invariant: infer rhythmic side from current joint state and let normalized body-frame bearing gate only a small posterior steering residual so alignment continuously recovers the base traveling wave
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator allocations, and source-task routes
policy_translation: remove the falsified response-triggered extra burst and promote the sampled controller that combines filtered body-frame bearing, a bounded distributed curvature request, and one state-inferred posterior half-cycle residual
falsification: reject the transfer if a repeat or held-out wake loses capture or the compact diagonal topology, capture is not near `32.472`, mean distance exceeds `1.64761L`, or the observed force, moment, and saturation cost outweigh the navigation gain

## Candidate hypothesis

Produce exactly one evidence-selected candidate by reverting the prefill's
uneconomic response-triggered extra burst while preserving its successful
filtered bearing, bounded `12 deg` total curvature, smooth `40/60 -> 35/65`
allocation, state-feedback anterior oscillator, posterior lag, damping, and
`8%` maximum target-helping posterior half-cycle residual. This is a structural
mechanism selection, not scalar-only gain tuning.

The downstream evaluation should reproduce the sampled direct capture near
`32.472` and restore the score from `0.208280` toward `0.224538`. The sampled
controller's higher load than the direction-selective headroom branch remains
an explicit tradeoff, and the fixed prewarm snapshot does not establish
robustness to wake phase or held-out conditions.
