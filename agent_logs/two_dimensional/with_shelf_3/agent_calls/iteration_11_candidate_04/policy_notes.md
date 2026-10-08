# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the common initial condition,
  not candidate-specific evidence. The released incumbent sheet shows an
  immediate correct-sign redirect, a persistent body-generated traveling wake,
  a compact diagonal crossing through the developed wake, and first entry into
  the `0.75L` target circle. The fish is self-propelled rather than passively
  advected: mean body velocity is `(-0.334,-0.140)` while mean local flow is
  `(-0.197,-0.189)`, and head displacement is `(-10.912,-4.332)L`.
- All four sampled sheets are byte-identical and all four evaluations capture
  at `32.472` release time with `1.64761L` mean distance, `0.747485L`
  final/minimum distance, and score `0.224538`. Their policy files differ only
  cosmetically. This is fixed-snapshot reproducibility for one mechanism, not
  independent robustness evidence across wake phases.
- The successful path is not low-load evidence. Both joints reach the
  `260 deg/time` velocity and `1800 deg/time^2` acceleration envelopes, with
  `68.70` lateral-force RMS and `931.60` moment RMS. The inherited
  direction-selective residual-headroom gate preserves an almost identical
  visual route and lowers those loads to `56.29/800.58`, but arrives later at
  `32.7305` and scores `0.223211`; a physical-envelope gate arrives at
  `33.9405` and scores `0.181716`. These completed tests falsify another
  posterior-residual headroom or scalar-amplitude adjustment as the next
  score-seeking move.
- No failure keyframe exists in the sampled or inherited visual artifacts. The
  available negative boundary is therefore text-and-metric evidence from
  inherited logs: unrestricted additive bearing-trend feedback collapsed the
  traveling bend and exited downstream at `16.956`, while anterior-heavy
  recentering also lost propulsion. This candidate must not add bearing rate
  to either joint center, reverse target-signed curvature, or attenuate the
  base oscillator/posterior wave.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological fast-start redirect and closed-loop robotic-fish CPG direction tracking interpreted through elongated-body posterior propulsion
source_mechanism: apply strong bounded target-signed curvature for redirect, then release mean curvature continuously when observed heading response is already reducing body-frame direction error while the traveling propulsive wave persists
transferable_invariant: separate persistent target geometry from its observed alignment response; response may withdraw only part of the mean-turn bias and must leave the target sign, anterior oscillator, and lagged posterior traveling wave intact
nontransferable_details: published gains, dimensional response rates, species or robot kinematics, duty ratios, exact vortex phases, actuator allocations, and source-task routes
policy_translation: derive a dimensionless helpful-alignment ratio from bounded body-frame persistent bearing and bearing-window rate, gate it by observed anterior oscillator activity, and multiplicatively release only a bounded fraction of total mean curvature without changing the posterior half-cycle residual
falsification: reject if target capture or the compact diagonal topology is lost, arrival is later than `32.472`, mean distance exceeds `1.64761L`, the redirect stalls, or force/moment and saturation histories fail to improve enough to justify any navigation regression

## Candidate hypothesis

Keep the incumbent filtered body-frame bearing, `12 deg` bounded curvature,
`40/60 -> 35/65` allocation, state-feedback anterior oscillator, lagged
posterior target, damping, and `8%` maximum target-helping posterior half-cycle
residual. Add exactly one mechanism: a smooth response-conditioned release of
only the mean-curvature request. Helpful alignment is the component of the
windowed bearing rate that reduces the sign-consistent persistent bearing,
normalized by bearing magnitude over one owned control period. Release is
enabled only after the observed anterior joint has developed the base
oscillation, is capped below unity, and can never reverse curvature or erase
the propulsive traveling wave.

The hypothesis is that the incumbent's correct early redirect needs its full
curvature initially, but continuing the same mean bias after alignment has
begun is unnecessary steering load. Anticipatory release should preserve the
direct capture while reducing curved-path distance and load. The downstream
CFD evaluation is intentionally left to EvE; this worker claims only an
evidence-backed, falsifiable candidate.
