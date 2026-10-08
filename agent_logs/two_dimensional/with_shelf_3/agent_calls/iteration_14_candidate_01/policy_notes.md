# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the certified common initial
  condition, not evidence that any candidate selected a favorable wake phase.
- All four sampled released sheets show active upstream self-propulsion on the
  same compact diagonal: immediate targetward redirection, a persistent
  posterior-traveling bend, cylinder clearance, and nose-first entry into the
  `0.75L` target circle. For the best-scoring branch, mean fish velocity
  `(-0.3362,-0.1404)` versus local flow `(-0.1961,-0.1918)` confirms that the
  fish is not passively advected. No released failure sheet is available, so
  none is invented as a visual contrast.
- The assigned parent combines response-confirmed mean-curvature release with
  trajectory-supervised posterior headroom. Its two code-equivalent samples
  reproduce capture at `32.4555`, mean distance `1.64548L`, score `0.226804`,
  force/moment RMS `67.83/914.09`, and posterior peak excursion `0.58180 rad`.
  The sheet retains the direct route but shows a broader late tail/body-wake
  oscillation than either component branch.
- The separately evaluated trajectory-supervised headroom branch captures at
  `32.3400`, improves mean distance to `1.63773L` and score to `0.234663`, and
  lowers force/moment RMS to `65.12/888.56` with posterior excursion
  `0.57530 rad`. The response-release-only branch is faster at `32.1365` and
  has marginally better mean distance `1.63696L`, but its score `0.234607` and
  loads `67.22/907.46` are slightly worse than the headroom-only branch. All
  three see nearly the same relative-crossflow RMS (`0.2437-0.2446`), so the
  combined regression is not explained by wake avoidance.
- The inherited combination hypothesis explicitly required rejection if it
  regressed beyond the trajectory-supervised branch without compensating load
  relief or exceeded both component branches in load. Both boundaries fired:
  the combination is slower with a worse distance integral than either
  component and has the largest force, moment, and posterior excursion. The
  useful negative result is that independently positive steering-withdrawal
  gates are not composable merely because they act on nominally different
  layers of this coupled two-joint gait.
- Inherited textual failures remain relevant boundaries: unrestricted
  bearing-rate recentering erased the traveling bend and exited downstream,
  blanket physical-limit damping delayed capture, and an added posterior burst
  raised loads while arriving later. The candidate therefore removes one
  interacting gate rather than adding authority, route memory, flow
  cancellation, or another scalar adjustment.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG residual modulation interpreted through elongated-body posterior reactive propulsion
source_mechanism: retain a persistent lagged propulsive rhythm and supervise one bounded optional steering residual with slow body-frame goal progress
transferable_invariant: preserve the traveling base gait and mean target curvature, and change only one optional residual mechanism at a time when two-joint coupling makes independently useful feedback paths interact
nontransferable_details: published gains, duty ratios, dimensional frequencies, robot or species kinematics, exact vortex phases, actuator ratings, source-task routes, and fixed approach distances
policy_translation: remove response-confirmed mean-curvature release and retain the evaluated normalized trajectory-efficiency supervisor around only the direction-selective posterior half-cycle residual; keep the filtered bearing, distributed mean curvature, anterior oscillator, posterior lag, and unit-gain traveling wave unchanged
falsification: reject if direct capture or the compact diagonal topology is lost, arrival exceeds `32.3400`, mean distance exceeds `1.63773L`, force or moment exceed `65.12/888.56` without a navigation improvement, or a held-out wake reveals switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate by reverting the falsified combination to the
separately evaluated trajectory-supervised headroom branch. Remove the four
response-release parameters and the response-confirmed mean-curvature-release
path. Retain the bounded `12 deg` target-signed curvature, bearing-conditioned
`40/60 -> 35/65` allocation, state-feedback anterior oscillator, posterior lag
and damping, maximum `8%` helpful half-cycle residual, and the slow normalized
trajectory-efficiency supervisor that gates only that optional residual.

This ablation is expected to recover the sampled branch's better score,
distance integral, force/moment loads, and smaller posterior excursion while
preserving the visible direct route. The policy remains normalized body-frame
state feedback with no time, fixed coordinates, or case identity. The current
sample is fixed-snapshot evidence, not proof of held-out wake robustness, and
no same-worker CFD outcome is claimed.
