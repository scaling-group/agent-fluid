# Multi-Wake Policy Candidate Notes

## Evidence read before architecture selection

- Assigned parent: the fresh-lineage guidance identifies the common seed as a
  target-blind state-feedback oscillator with a lagged posterior target. No
  inherited optimizer rollout notes are present in this workspace.
- Sampled result: `solver_4b03cd285d3a` failed by `left_domain` after only
  `50.1269` released time units. It briefly reduced distance to `8.61495L`, but
  finished at `12.1226L` with only `0.02425` net progress. Head displacement
  was `(-3.5452,-13.3003)L`, compared with a target initially roughly
  `(-12,-4.5)L` from the fish.
- Visual diagnosis: the shared prewarm sheet shows the fish held above the
  developed interacting vortex streets. After release, the fish sustains a
  visible traveling bend and moves left, but its path curls steeply downward;
  it becomes nearly vertical, never recovers toward the target marker, and
  exits through the lower domain. Thus this is useful self-propulsive motion
  without target-direction regulation, not evidence that propulsion scalar
  tuning or indiscriminate wake cancellation is the first missing capability.
- Metric cross-check: the large downward displacement agrees with mean
  velocity `(-0.0725,-0.2633)` and mean local flow
  `(-0.0414,-0.2414)`. RMS relative crossflow `0.1747`, force-y `21.9428`, and
  moment-z `541.704` show material wake disturbance, but a single target-blind
  failure cannot identify the sign or value of a flow/force residual.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological and robotic-fish turning with closed-loop CPG modulation
source_mechanism: body-frame direction error biases the mean curvature of an otherwise propulsive rhythm
transferable_invariant: a bounded, target-signed average bend can redirect a traveling body wave without replacing its posterior lag
nontransferable_details: published gains, dimensional frequencies, species envelopes, duty ratios, exact vortex phases, and world-frame routes
policy_translation: map normalized `state.bearing` through a smooth saturation to a total curvature bias, distribute that bias across the two joint-state attractors, and retain the seed's state-feedback oscillator and lagged posterior wave
falsification: reject or reverse the translation if the rollout preserves the downward exit or turns with the wrong sign; reject excessive authority if joint saturation grows, the traveling bend collapses, loads spike, or target progress worsens

## Candidate hypothesis

The candidate adds one controller mechanism: target-vector-to-bounded-mean-
curvature feedback. The `12 deg` total bias stays below the `17 deg` nominal
head-joint margin between the seed's `28 deg` oscillation and the `45 deg` hard
angle limit, and it is split between the two incremental bends so it does not
replace the traveling wave. A `20 deg` bearing scale produces a moderate
correction for the roughly `8 deg` initial target error while reserving full
authority for the large error visible during the downward departure.

Expected evidence is a correct-sign recovery that keeps the fish in-domain
longer and turns the initially useful leftward motion into lower mean/final
distance. This proposal does not claim same-worker CFD improvement. A later
evaluation should compare termination, trajectory topology, distance, angle
and acceleration saturation, command effort, and force/moment loads with the
sampled seed.
