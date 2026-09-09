# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the common held fish above and downstream of
  four fully developed, interacting vortex streets. It is initial-condition
  evidence only; all sampled candidates use the same snapshot.
- No sampled solver is a semantic failure: all four reach the target. The
  strongest finite contrast is therefore the reproduced progress-qualified
  parent (`137.357` release units, `4.184L` mean distance) against the slower
  unqualified bearing-rate policy (`149.605`, `4.358L`). The parent also lowers
  total command energy from `96933` to `90228` and RMS relative crossflow,
  lateral force, and yaw moment from `0.1321/15.49/308.48` to
  `0.1296/14.75/303.02`.
- In the released sheets, both policies keep an alternating body wave and make
  net upstream, targetward progress rather than merely following the flow.
  For the parent, head displacement is `(-10.91,-4.37)L`, mean body speed in x
  is `-0.0791`, and mean local-flow x is `-0.0542`, leaving measured relative
  upstream motion. The fish redirects broadly from the upper-right release,
  then crosses the interacting wake through several visible course kinks and
  reaches the green capture circle without collision or domain exit.
- Three independent sampled copies reproduce the parent exactly. Inherited
  step-9 results remain successful but regress to `154.110`--`158.147` release
  units, `4.687`--`4.692L` mean distance, `99457`--`103629` total command
  energy, and larger lateral loads. The sampled guidance identifies one of
  these as an unconditioned relative-crossflow addition; its RMS crossflow is
  essentially unchanged (`0.13005` versus `0.12955`). This argues against
  appending another observation to the route request.
- The parent already drives joint 1 acceleration to `30.85 rad/time^2`, near
  the `31.42` hard limit, while joint 2 peaks at `25.55`. Its joint-angle peaks
  remain modest (`0.402/0.346 rad`). The evidence therefore supports testing
  steering coordination through the posterior wave, where actuation headroom
  remains, instead of increasing anterior oscillator gains.

## Candidate hypothesis

Preserve the replicated route owner, progress-qualified bearing-rate damping,
bounded yaw-moment residual, anterior half-cycle steering, zero-mean
oscillator, and posterior lag. Add one small compatible mechanism: apply the
same state-inferred, body-frame requested half-cycle sign to the posterior
traveling-bend target. This should recruit joint 2 during the broad initial
redirect and wake-course corrections without introducing a static curvature
center, another additive route/flow residual, or a time schedule. The new
multiplier remains positive and bounded, and vanishes to the inherited tail
wave when either the route/wake turn request or beat-side estimate vanishes.

bookshelf_consulted: true
source_domain: Lighthill-style posterior thrust emphasis and sensor-modulated robotic-fish asymmetric flapping
source_mechanism: coordinate a target-directed half-cycle asymmetry across the propulsive traveling bend, with posterior motion carrying useful turning authority
transferable_invariant: preserve a zero-mean alternating wave while a bounded observed turn request makes the useful half-cycle slightly stronger at the posterior actuator
nontransferable_details: published gains, dimensional beat frequencies, species-specific body envelopes, exact vortex phase, and world-frame routes
policy_translation: multiply the existing lagged joint-2 target by `1 + posterior_steering_gain * turn_request * beat_side`, using only normalized body-frame feedback and joint-state phase
falsification: reject if capture or upstream translation is lost, the alternating bend or posterior lag collapses, joint-2 action persistently saturates, or arrival, mean distance, and force/moment/effort fail to improve together over the reproduced parent
