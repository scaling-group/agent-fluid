# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The common prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. The sampled released sheets contain
  no failure: all show a rapid target-signed redirect, a sustained
  body-generated traveling wake, and a compact diagonal crossing into the
  `0.75L` capture circle without approaching a cylinder. The fish is
  self-propelled rather than passively advected; the ungated controller moves
  its head `(-10.912,-4.332)L` while mean local flow is only
  `(-0.197,-0.189)`.
- Three byte-identical sampled rollouts of the assigned ungated posterior
  half-cycle controller capture at `32.472`, with `1.64761L` mean distance and
  `68.70/931.60` lateral-force/yaw-moment RMS. These repeats establish
  deterministic fixed-snapshot reproducibility, not robustness to wake phase.
  The distinct response-gated extra-burst sample preserves capture but is
  dominated: it arrives at `32.824`, raises mean distance to `1.66402L`, and
  raises force/moment RMS to `70.97/945.05`.
- Inherited completed rollouts separate two superficially similar load gates.
  The assigned parent's nondirectional gate uses absolute posterior velocity
  and acceleration relative to hard limits; it delays capture to `33.9405`,
  worsens mean distance to `1.69143L`, and reduces force/moment RMS only to
  `60.11/828.12`. A directional gate instead normalizes posterior speed and
  prior applied acceleration by `amplitude * frequency` and `amplitude *
  frequency^2`, and withdraws the optional increment only when motion already
  reinforces it. That rollout retains the direct topology, captures at
  `32.7305` with `1.64927L` mean distance, and lowers force/moment RMS further
  to `56.29/800.58`, with slightly lower mean command energy and power.
- No failed keyframe is sampled here. The inherited negative boundary remains
  the downstream-exit bearing-trend controller that erased the traveling bend;
  therefore this candidate does not alter oscillator centers, bearing-rate
  paths, mean-curvature allocation, or the unit-gain posterior wave.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation interpreted through elongated-body posterior reactive propulsion
source_mechanism: sensor feedback regulates an incremental turn-congruent posterior half-cycle around a persistent lagged propulsive wave
transferable_invariant: preserve target-signed mean curvature and the traveling base gait while yielding only optional rhythmic asymmetry when observed posterior state already reinforces it near the gait's own state scale
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, actuator ratings, exact vortex phases, and source-task routes
policy_translation: normalize posterior joint speed and previous applied acceleration by oscillator-owned scales, detect directional reinforcement of the proposed posterior wave, and smoothly gate only the extra bearing-conditioned half-cycle gain
falsification: reject if direct capture or compact trajectory is lost, arrival regresses materially beyond the observed 0.80 percent trade, or force and moment fail to retain a meaningful reduction relative to the ungated controller

## Candidate hypothesis

Produce one evidence-selected candidate by promoting the completed directional,
gait-scale posterior headroom gate. Preserve the filtered body-frame bearing,
bounded `12 deg` curvature request, `40/60 -> 35/65` allocation, anterior
state-feedback oscillator, posterior lag, damping, and `8%` maximum helpful
half-cycle asymmetry.

The gate continuously withdraws only that `8%` increment when posterior speed
or previous applied acceleration is both large relative to the policy-owned
gait scale and aligned with the proposed posterior wave. Unit posterior-wave
gain is the lower bound, so the mechanism cannot cancel the propulsive
traveling bend. Prior CFD supports a direct capture with an observed `0.80%`
arrival trade and `18.1%/14.1%` lower force/moment RMS. The new rollout must be
treated as a reproducibility test, not a same-worker improvement claim or proof
of reduced saturation residence.
