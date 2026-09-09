# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common prewarm sheet shows the held fish above and to the right of the
  target while four developed vortex streets interact around the second-row
  corridor. This fixes the initial flow field, but it does not provide a
  transferable vortex phase or route.
- Three sampled copies of the progress-qualified incumbent reproduce the same
  successful topology: a decisive initial redirect, a persistent alternating
  posterior-lagged bend, self-propelled upstream entry into the interacting
  wakes, and target capture after `137.357` released units. Their matching
  metrics are `4.18356L` mean distance, `-10.9139L` upstream head displacement,
  `0.12955` RMS relative crossflow, and `14.75/303.02` RMS lateral force/yaw
  moment. This is a stable baseline under the common snapshot, not evidence of
  robustness to a different wake phase.
- The rate-only causal baseline preserves the same gait and still captures,
  but later at `149.605` with `4.35835L` mean distance and higher RMS
  crossflow/force/moment (`0.13206/15.49/308.48`). Preserve instantaneous
  bearing and its closing-progress-qualified rate damping.
- The inherited loop/exit failure turns upward, closes an upper-right loop,
  and leaves the domain after `126.428` units. Its `-1.116L` upstream
  displacement and regression from `8.610L` minimum distance to `12.046L`
  final distance show loss of route topology rather than useful wake
  interaction, despite sub-cap joint extrema and only moderately higher RMS
  moment (`317.27`).
- Three later single-observation extensions all retain capture but regress the
  strongest route. Circularly averaging bearing reaches in `149.853` with
  `4.42329L` mean distance; adding normalized lateral target displacement
  reaches in `159.302` with `4.72194L`; and direct relative-crossflow rejection
  reaches in `154.110` with `4.68696L` while raising RMS force/moment to
  `15.85/310.83`. Their sheets show wider or delayed corridor entry. Do not
  reopen route smoothing, lateral-target augmentation, or indiscriminate slip
  cancellation on this scaffold.
- The incumbent already reaches `30.846 rad/time^2` anterior acceleration
  against the `31.416` cap, whereas the posterior peak is `25.552`; posterior
  angle is also lower (`0.346` versus `0.402 rad`). The visible broad redirect
  and this asymmetric actuation margin support moving a small share of
  phase-coupled steering to the posterior joint rather than adding anterior
  gain or another observation residual.

## Policy hypothesis

Make exactly one controller-mechanism change: extend the proven target-signed
half-cycle asymmetry to the posterior traveling-wave target. Infer posterior
beat side from the existing lagged tail target, then smoothly strengthen the
tail half-cycle whose sign agrees with the bounded `turn_request`. This creates
a small target-signed mean-curvature contribution from posterior actuation
while reverting exactly to the incumbent traveling wave when the request is
zero. Preserve the incumbent oscillator, anterior half-cycle steering,
instantaneous-bearing route owner, progress-qualified bearing-rate damping,
direct `moment_z_L2` residual, gait parameters, and posterior lag.

The expected formal test is retained capture and alternating propulsion with a
tighter initial redirect or smaller distance integral, without increasing the
already near-cap anterior acceleration. Falsify the mechanism if capture or
upstream translation is lost, mean distance or loads regress, posterior action
hits its cap, the lagged wave collapses into static curvature, or the inherited
loop/boundary-exit topology returns. The new CFD evaluation occurs after this
worker exits, so these are expectations rather than same-worker results.

bookshelf_consulted: true
source_domain: reactive fish propulsion and closed-loop robotic-fish turning by asymmetric flapping
source_mechanism: preserve a traveling bend while allocating a bounded target-signed half-cycle imbalance to posterior actuation
transferable_invariant: observed target-directed mean curvature can be produced by state-phased left/right amplitude asymmetry, and available posterior authority can share that steering without replacing the zero-request propulsive wave
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, clock phase, exact vortex phases, cylinder layout, and source-task routes
policy_translation: retain normalized body-frame route and wake feedback, infer posterior beat side from the lagged two-joint target, and apply one small bounded tail half-cycle envelope driven by the existing turn request
falsification: reject if capture, upstream translation, distance integral, loads, actuator margin, alternating bends, or posterior lag worsen, or if a loop or boundary exit returns
