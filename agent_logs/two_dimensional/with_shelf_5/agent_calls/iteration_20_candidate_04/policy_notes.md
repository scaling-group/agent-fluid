# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis before the policy edit

- The shared prewarm sheet shows the common held fish above and downstream of
  four mature, interacting vortex streets whose merged wake crosses the target
  neighborhood. It is common initial-condition evidence, not evidence for a
  candidate-specific route, fixed vortex phase, or memorized cylinder layout.
- Every current sampled released sheet is a finite target capture; no sampled
  failure keyframe exists. The inherited naive-seed lower-boundary exit after
  `50.127` released time is therefore retained only as metric-backed context,
  with no invented visual diagnosis. The useful current comparison is between
  the evaluated direct-capture policies.
- All four sampled sheets visibly retain the same productive topology: a
  decisive downward-left redirect, an alternating self-generated wake, and a
  compact upstream-left diagonal transit through the cylinder wakes into the
  `0.75L` target circle. In the best-score sample, mean velocity
  `(-0.2781,-0.1162)` versus mean local flow `(-0.1531,-0.1687)` gives about
  `0.1250` mean relative upstream motion, confirming self-propulsion rather
  than passive advection.
- The evaluated route-history-only release (`solver_a7d11ae4462d`) closes the
  inherited missing factorial condition. Relative to the no-release prefill
  (`solver_df084fc68237`), it preserves the direct `39.1`-time capture class
  (`39.1159` versus `39.1104`) and nearly the same mean distance (`1.91432L`
  versus `1.91494L`), while reducing RMS force/moment from `57.21/783.64` to
  `51.63/734.35`. Its RMS crossflow also falls from `0.21935` to `0.21787`.
  The route-plus-half-cycle release (`solver_a68507de2b6a`) arrives slightly
  sooner at `39.0499` and has the best scalar score, but returns loads to
  `57.05/783.02`. Thus fading stale anterior route memory alone is the supported
  load mechanism; stacking posterior authority withdrawal is not.
- Both joints still reach the `260 deg/time` rate and `1800 deg/time^2`
  acceleration caps, and the route-only sample's command energy (`50066.5`)
  does not improve on the prefill (`50060.7`). Inherited alignment-conditioned
  oscillator attenuation and total-action outward-rate projection both
  delayed or worsened the route. Their thresholds should not be tuned again.

## Policy hypothesis before the edit

Start from the evaluated route-history-only release, preserving its oscillator,
distance-only approach envelope, posterior lag, half-cycle authority, and exact
large-error redirect. Add a bounded response lead to the current body-frame
bearing: after the existing scale-free gate observes both small bearing and a
decrease in bearing magnitude, project the bearing forward by a fraction of one
carrier period using `bearing_window_rate`. Clamp the projected bearing between
zero and the current bearing, so it can only release converged steering and can
never amplify or reverse the target-directed request. Padded release history,
large error, stationary error, and diverging error reproduce the evaluated
route-only controller exactly.

This is a derivative feedback pathway rather than a scalar-gain sweep. It tests
whether a response-predictive burst-to-cruise transition can reduce residual
mean curvature, effort, or cap contact while retaining the route-only sample's
direct self-propelled capture and demonstrated load class. Reject it if capture
is lost, arrival or mean distance regresses materially, force/moment rise above
the route-only class, effort does not improve, or the early redirect topology
changes. In that case retain route-history-only release and require calibrated
time-resolved flow/load histories before attempting a wake-disturbance residual.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological burst redirects
source_mechanism: use measured directional response to release strong mean curvature into rhythmic cruise without interrupting the carrier
transferable_invariant: after a target-directed turn is visibly converging, a bounded prediction of normalized body-frame error may reduce stale steering authority while preserving the propulsive rhythm
nontransferable_details: published CPG gains, dimensional lookahead times, species-specific burst shapes, robot kinematics, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: gate a carrier-period-normalized bearing-rate lead by small current bearing and observed convergence, clamp it between zero and current bearing, and use it only in the existing two-joint mean-curvature request
falsification: reject if direct capture or early redirect degrades, predicted bearing reverses or amplifies steering, or arrival, effort, cap, crossflow, force, and moment evidence fails to improve over the route-history-only sample

## Pre-evaluation verification

The mandated guidance-provenance check, pinned-Julia policy contract, and
solver editable-boundary check all pass. The contract finds finite two-joint
output and a consistent `15`-field parameter schema, including the new lead
horizon owned by `target_policy_params()`. A deterministic comparison with the
evaluated route-history-only policy covered `117612` states spanning normalized
range, wrapped current/oldest/history bearings, observation-window duration,
joint angles, and joint rates. All outputs were finite; all `104004` states in
which convergence was inactive or the bounded projection left current bearing
unchanged matched the evaluated parent exactly; and `13608` intended response
states changed. In every state the anticipated bearing remained between zero
and current bearing. No formal CFD was run; EvE evaluation remains the
falsification test for route, effort, saturation, crossflow, and load effects.
