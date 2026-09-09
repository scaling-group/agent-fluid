# Multi-wake target-policy candidate notes

## Evidence read before the edit

- The shared prewarm sheet shows the common held fish above and downstream of
  four fully developed, interacting cylinder streets. It is identical
  initial-condition evidence for all candidates, not evidence for a
  policy-specific route.
- All four sampled released sheets terminate at the target, so this workspace
  contains no sampled failure keyframe. The inherited naive-seed lower-domain
  exit is retained only as metric-backed context and is not assigned an unseen
  visual diagnosis. The useful visual comparison is the fastest finite prefill
  against the slower, lower-load directional-guard sample.
- The prefill makes one decisive downward-left redirect, develops a strong
  alternating body wake, and self-propels along a compact upstream-left
  diagonal into the target. Its mean velocity `(-0.2675,-0.1111)` differs
  materially from mean local flow `(-0.1489,-0.1618)`, including `0.1187`
  mean relative upstream motion, so its `40.6285` capture and `1.9759L` mean
  distance are not passive advection. It is the strongest sampled route, but
  RMS relative crossflow/force/moment are `0.2248/63.65/868.82`, both joint
  rates and accelerations reach their caps, and maximum joint excursions are
  `0.574/0.510` rad.
- The inherited fully history-driven policy captured at `41.5030` with
  `2.0216L` mean distance and RMS force/moment `61.80/862.48`. Feeding current
  bearing only to posterior half-cycle steering therefore materially improved
  arrival and distance, but did not decouple the route improvement from loads:
  force and moment rose slightly and both actuator caps remained active.
- The unfiltered directional-guard sample follows the same broad direct route
  more slowly (`43.9505`) while lowering RMS force/moment to `44.47/657.47`.
  However, the two guard-plus-history samples capture at `41.4205` with
  `63.05/872.36`, worse load evidence than the unguarded history filter.
  Reusing or threshold-tuning that response guard on the faster split is not
  supported. The current sheets also show no route-scale yaw reversal that
  would justify indiscriminate crossflow, force, or moment cancellation.

## Policy hypothesis before the edit

Keep the fastest prefill's circular-history anterior route curvature,
target-favored half-cycle structure, approach envelope, oscillator, posterior
lag, and all proven large-error behavior. Replace only the posterior signal
selector: smoothly pass the current-bearing turn request when it agrees in
sign with the persistent route request, and fall back toward the persistent
request when the two signs conflict. Early padded history makes the two
requests agree during the decisive release redirect; later disagreement is a
body-frame signature of fast bearing motion contradicting the slower route,
not a clock, fixed route, or inferred vortex phase.

Expected evidence is retention of the direct target-reaching topology and the
prefill's early redirect, with less contradictory posterior steering during
aligned transit and consequently lower crossflow, force, moment, excursion, or
cap contact. Falsify the selector if capture is lost or materially delayed,
the direct topology changes, or completed load/actuator evidence does not beat
the prefill. If falsified, do not tune the agreement transition; test a truly
observed disturbance-response mechanism only after its sign and scale are
available in rollout histories.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-feedback robotic-fish direction tracking
source_mechanism: separate persistent route error from fast alternating sensory disturbance while preserving the rhythmic carrier
transferable_invariant: grant a fast corrective channel authority only when its body-frame request is coherent with the slower target-directed request
nontransferable_details: recurrent-network architecture, published gains, species or robot kinematics, dimensional frequencies, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: keep circular-history bearing on anterior mean curvature, then smoothly blend posterior half-cycle steering from persistent to current bearing according to the sign coherence of their bounded turn requests
falsification: reject if the direct capture degrades or if crossflow, force, moment, excursion, and cap evidence do not improve over the fastest prefill

## Pre-evaluation verification

The required guidance semantic check and solver boundary check pass. Static
schema comparison found all `14` direct `params.FIELD` references among the
`14` fields returned by `target_policy_params()`, with no unused field. An
algebraic sweep of `135000` states spanning range, wrapped and empty bearing
histories, agreeing and contradictory route/current signs, both joint limits,
and both rate limits produced finite actions. The coherence gate remained in
`[0.0000443,0.999999998]`, and padded release history reproduced the prefill's
posterior turn request exactly. The prescribed Julia include check could not
start because the workspace image has no `julia` executable. No formal CFD was
run; this candidate's outcome remains evidence for a later worker.
