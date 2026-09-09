# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheet shows the fish held above and downstream of four
  mature, interacting cylinder streets whose merged wake already crosses the
  target neighborhood. This is a common initial condition, not evidence for a
  candidate-specific route.
- All four sampled released sheets are finite target captures, so there is no
  sampled failure keyframe to invent a visual diagnosis for. The inherited
  naive-seed lower-boundary exit remains metric-backed context only. Across the
  current finite sheets, the fish makes one decisive downward-left redirect,
  sheds a strong traveling wake, and self-propels on a compact upstream-left
  diagonal through the developed streets into the `0.75L` target circle. For
  the assigned parent, mean velocity `(-0.2773,-0.1145)` versus mean local
  flow `(-0.1535,-0.1656)` includes `0.1238` mean relative upstream motion,
  so target progress is not passive advection.
- The assigned parent `solver_625dccf30dc5` is the completed test of extending
  bearing-response completion from posterior steering to an aligned gait
  amplitude envelope. It retains target success but is dominated by its
  evaluated response-release parent `solver_f878079fe7ba`: capture slows from
  `39.1104` to `39.2149`, mean distance rises from `1.91533L` to `1.91592L`,
  command energy/power rise from `50044.8/3768.3` to `50246.0/3783.2`, and
  RMS relative crossflow/force/moment rise from `0.21986/54.19/754.87` to
  `0.22014/55.32/764.02`. Both joints still reach the `260 deg/time` rate and
  `1800 deg/time^2` acceleration caps. This falsifies amplitude-envelope
  relief for this carrier; its floor should not be tuned.
- The sampled route-memory-release candidate `solver_a68507de2b6a` is slightly
  faster (`39.0499`) and uses less command energy (`49942.8`) than the
  response-release carrier, but raises RMS force/moment to `57.05/783.02` and
  still reaches both actuator caps. Together with the failed gait envelope,
  this says that further edits to anterior curvature or amplitude trade small
  arrival/effort changes against loads without resolving clipped two-joint
  coordination. The released sheets show no route-scale reversal that would
  support an uncalibrated force, moment, or crossflow residual.

## Policy hypothesis before the edit

Restore the evaluated `solver_f878079fe7ba` response-release carrier: preserve
its oscillator, range approach envelope, circular-history anterior curvature,
route/current sign-coherence selector, half-cycle response release, posterior
lag, and every large-error action. Add one actuator-allocation mechanism after
the raw two-joint accelerations are formed. During aligned, converging transit
only, radially project an over-limit acceleration pair into the known box
envelope by one common positive scale. This preserves the raw pair's signs and
ratio, whereas the episode's independent per-joint clipping can flatten that
relationship when both requests exceed the cap. Padded history, large error,
diverging response, and every already-in-envelope request reproduce the
evaluated carrier exactly.

Expected evidence is the same decisive redirect and direct self-propelled
capture, with lower secondary-joint command effort, force, or moment because
the traveling-bend acceleration relationship is retained through saturation.
Falsify this mechanism if capture is lost or materially delayed, the direct
topology changes, command/load evidence does not improve over
`solver_f878079fe7ba`, or the projection is never active in the completed
rollout. If falsified, preserve the response-release carrier, avoid tuning a
projection threshold, and require signed load/flow histories before testing a
wake-disturbance residual.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming models and low-dimensional coupled-oscillator robotic-fish control
source_mechanism: coordinate anterior and posterior actuation so a directed traveling bend, posterior lag, and steering asymmetry survive actuator constraints
transferable_invariant: when an aligned-transit acceleration pair exceeds its box envelope, reduce both components by one bounded positive factor so joint-action sign and ratio are preserved
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot motor models, full-body waveforms, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: restore the evaluated response-release carrier, form its raw two-joint accelerations, and blend toward their common-factor L-infinity projection using the existing normalized body-frame convergence-and-alignment gate
falsification: reject if direct capture degrades or if command effort, force, and moment do not improve; do not retune the projection boundary after a negative result

## Pre-evaluation verification

The mandated guidance semantic check and solver editable-boundary check pass.
Static schema validation finds all `15` direct `params.FIELD` references among
exactly the `15` fields returned by `target_policy_params()`, with no unused
field or prohibited coordinate/time input. A deterministic algebraic sweep of
`61236` states spanning range, wrapped and ordinary bearing histories, bearing
response, both joint limits, and both rate limits produced finite actions. The
projection was active in `14576` states and gave exact evaluated-carrier
pass-through in `46660`; all `40824` large-bearing-error states were exact
pass-through. The common scale stayed in `[0.0960533,1]`, and the normalized
response gate reached both `0` and `1`. The prescribed Julia include check was
invoked but could not start because this image has no `julia` executable. No
formal CFD was run; the candidate's rollout remains evidence for a later
worker.
