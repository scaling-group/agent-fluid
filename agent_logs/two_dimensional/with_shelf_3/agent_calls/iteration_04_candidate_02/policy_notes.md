# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent and current prefill use the successful `0.55`-period,
  `28 deg` state-feedback traveling bend with a `12 deg` target-signed total
  curvature split `45/55` across the anterior and posterior joints. The two
  equation-identical baseline samples reproduce the same compact diagonal
  capture at `39.737` released time, `1.934L` mean distance, `50,816` total
  command energy, `53.7` lateral-force RMS, and `762` moment RMS. This is
  deterministic replay evidence at the common prewarm state, not robustness
  evidence.
- The shared prewarm sheet shows the fish held above and downstream of four
  interacting, fully developed vortex streets. All current candidates inherit
  that same wake state. In every successful released sheet, the fish makes an
  early targetward turn, keeps a visible posterior traveling bend, crosses the
  developed wakes under its own propulsion, and enters the capture circle on a
  direct diagonal path. None shows a late near-miss, collision approach, or
  passive downstream advection.
- `solver_2bde45adf1e2` makes one structural change from the baseline: an
  exponentially weighted circular mean of body-frame `bearing_history` over
  `0.35` gait periods replaces instantaneous bearing in the curvature request.
  It preserves capture while improving arrival to `36.564` and mean distance
  to `1.808L`. The benefit is not free: mean command energy rises from `1279`
  to `1417`, joint excursions rise from `0.536/0.539` to `0.548/0.562 rad`,
  lateral-force RMS rises from `53.7` to `66.2`, and moment RMS rises from
  `762` to `902`. Thus history filtering is evidence for a quicker trajectory,
  not for disturbance rejection or load reduction.
- `solver_e3c2e0960563` instead keeps instantaneous bearing and moves the same
  total curvature allocation from `45/55` to `40/60`. It also preserves
  capture and improves arrival to `37.955` and mean distance to `1.858L`, while
  total command energy falls to `49,166`, power proxy to `3646`, joint
  excursions to `0.502/0.492 rad`, lateral-force RMS to `45.9`, and moment RMS
  to `670`. This is a Pareto improvement over the baseline at this common wake
  state, but only one completed rollout supports the allocation.
- The current sampled set contains no failed release sheet. The inherited
  optimizer notes provide the informative failure boundary: concentrating up
  to `10/5 deg` of bias anteriorly, or weakening the proven gait to
  `0.9/20 deg`, destroyed upstream propulsion and produced downstream exits at
  `18.683` and `16.984` time units. The present candidate therefore changes
  neither oscillator strength nor the total curvature budget and does not add
  uncalibrated flow/force cancellation.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: organized-wake swimming and sensor-feedback robotic-fish direction tracking
source_mechanism: separate persistent route error from fast oscillatory yaw before modulating the mean of a propulsive rhythm
transferable_invariant: target-directed mean curvature should respond to a short body-frame average of direction error rather than each beat-scale bearing fluctuation, while posterior lag continues to carry the traveling wave
nontransferable_details: published filter constants and gains, dimensional beat rates, species or robot geometry, exact vortex phases, task routes, and actuator allocations
policy_translation: circular-average the testbed-provided body-frame bearing history with an owned gait-relative horizon, map that persistent bearing through the existing bounded total-curvature law, and retain the evidenced oscillator and posterior lag; the 40/60 split is selected independently from sampled CFD evidence
falsification: reject the combination if it loses target capture, delays arrival beyond the baseline, returns to downstream or lower-domain exit, or retains the filtered child's high force and moment without a compensating trajectory benefit

## Candidate hypothesis

Produce one factorial synthesis of the two individually successful child
changes: use the sampled gait-relative circular bearing filter and allocate the
unchanged `12 deg` total-curvature request `40/60` across the joints. This is
one candidate, not two sibling variants. The filter is the architecture
mechanism; the posterior shift is an allocation already supported by the
current CFD comparison rather than a bookshelf-derived scalar. The oscillator
period, amplitude, nonlinear drive, posterior lag, damping, bearing scale, and
curvature budget remain fixed.

If the effects are compatible, formal evaluation should retain the filtered
child's earlier, lower-distance capture while avoiding at least part of its
load and joint-excursion increase. The interaction is untested: later workers
should reject additivity if capture is lost, arrival exceeds `39.737`, or
moment/lateral-force RMS remain at or above `902/66.2` without a clear distance
benefit. No new CFD outcome is claimed in this worker.
