# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held in the upper-right while the
  four staggered cylinders develop interacting streets around and downstream
  of the target. This is a common release condition, not a transferable wake
  phase or route.
- All four sampled solver results are replications of one finite success:
  identical released keyframes and physical metrics show capture after
  `137.357` released units, `4.184L` mean distance, `-10.914L/-4.371L`
  head displacement, `90228` total command energy, and
  `0.12955/14.75/303.02` RMS relative crossflow/force/moment. The released
  sheet shows an active initial redirect, alternating bends throughout a broad
  lower-midcourse wake crossing, and final entry from the right. The upstream
  displacement and mean body velocity `(-0.0791,-0.0330)` versus mean local
  flow `(-0.0542,-0.0521)` agree that this is self-propelled targetward
  motion rather than passive advection.
- The assigned parent's latest inherited rollout is the informative negative
  comparison. Gating yaw-moment rejection by positive growth of absolute
  bearing preserves capture but makes the lower wake excursion visibly deeper,
  delays arrival to `149.490`, worsens mean distance to `4.428L`, raises
  total energy to `97418`, and raises RMS crossflow/force/moment to
  `0.13148/16.38/318.46`. Thus helpful-versus-adverse yaw cannot be inferred
  reliably from that slow bearing-divergence product, and the successful
  direct moment residual should be restored rather than gated again.
- The replicated success reaches `30.846 rad/time^2` anterior acceleration
  against the `31.416` hard cap, whereas posterior acceleration peaks at
  `25.552 rad/time^2`. More unconditioned anterior authority is unsupported,
  but the posterior actuator has roughly `5.86 rad/time^2` of observed
  headroom. The broad midcourse turns therefore motivate sharing slow route
  curvature with the posterior wave, not another additive route/flow signal.

## Policy hypothesis

Make exactly one controller-mechanism change from the successful prefill.
Preserve instantaneous body-frame bearing as route owner, progress-qualified
bearing-rate damping, the direct normalized yaw-moment residual, anterior
half-cycle steering, oscillator regulation, and posterior lag. Add a bounded
posterior half-cycle asymmetry driven only by the existing slow `route_turn`.
Infer posterior phase from the desired tail-tangent wave already encoded in
joint state; strengthen its target-consistent half-cycle and weaken the
opposite half-cycle without adding a static tail offset or reducing lag. This
uses posterior acceleration headroom to coordinate steering across the two
joints while retaining an alternating traveling bend.

The formal expectation is capture earlier than or near `137.357` with a
tighter lower-midcourse arc, no increase in distance integral or load/effort,
and preserved upstream translation. Falsify the candidate if it delays or
loses capture, produces a static-curvature loop, erases posterior alternation,
contacts the posterior acceleration cap, or increases force/moment and command
effort. CFD is run only after this worker exits, so this is an unevaluated
hypothesis rather than a claimed result.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and averaging models, informed by reactive-tail propulsion
source_mechanism: target-driven tail-beat half-cycle asymmetry distributes turning through the posterior propulsive wave
transferable_invariant: a bounded body-frame route request can bias the useful posterior half-cycle while state-encoded phase and alternating traveling-wave propulsion remain intact
nontransferable_details: published gains, robot linkage geometry, species-specific envelopes, dimensional beat frequencies, exact phase lags, vortex phases, cylinder layout, and source-task routes
policy_translation: modulate the desired posterior tail-tangent wave by its joint-state-derived sign and the normalized route turn; retain direct normalized moment rejection in the anterior half-cycle envelope
falsification: reject if capture or upstream translation is lost or delayed, the posterior wave becomes a static bend, posterior acceleration reaches its cap, or mean distance, effort, force, and moment fail to improve together
