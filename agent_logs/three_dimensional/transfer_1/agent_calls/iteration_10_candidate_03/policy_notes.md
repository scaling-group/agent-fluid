# Low-speed posterior position-seed candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts are finite captures from direct-uniform still
  water: `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  Three are
  behaviorally identical copies of the assigned v26 parent, capturing at
  `0.74819 L` and `23.9305 T` with score `-0.55178099`; the v25
  carrier-first-allocation control captures at `25.9545 T` with score
  `-0.64778945`.  Repackaging the v26 policy is therefore exhausted.
- I inspected both rows of the combined keyframe sheets for the v26 parent and
  v25 control from release through capture.  In quiescent water, both fish are
  visibly self-propelled: compact startup structures develop into a coherent
  alternating top-down vorticity wake and a chain of posterior three-
  dimensional Lambda2 packets.  Lateral oscillation stays organized around a
  targetward route rather than becoming a standing wiggle.  The v26 fish bends
  onto a stronger closing arc by the middle sheet and reaches the target about
  `2.024 T` sooner; neither sheet shows collision, passive advection, wake
  collapse, or numerical instability.
- Diagnostics agree with the visual interpretation.  Relative to v25, v26
  improves mean distance from `2.55008 L` to `2.45000 L`; at `12/16/20 T`,
  its distances are `8.4209/6.0297/3.3829 L`, versus
  `8.6331/6.5369/4.3294 L`.  Peak planar force and yaw-moment coefficients
  remain the same sampled `0.02974/0.01484` scale.  This is a useful
  middle/late route mechanism, not an improved launch: at `2 T`, v26 is
  slightly farther away (`12.2755 L` versus `12.2656 L`), while peak speed
  rises from `0.6672` to `0.7837 L/T` and any-joint acceleration-limit
  residence from `33.95%` to `45.62%`.
- The assigned-parent logs bound the obvious low-speed alternative.  A
  tail-velocity-aligned energy envelope improved the inherited v24 distance at
  `2--4 T`, but delayed capture from `26.0425` to `26.9170 T` and worsened
  mean distance from `2.59751` to `2.60943 L`.  Another cadence or
  velocity-aligned energy residual should not be stacked onto v26.

## One-candidate policy hypothesis

Retain v26's completion-gated redirect, phase-neutral yaw response,
progress-gated posterior lag, carrier-first steering allocation, and final
finite acceleration clamp.  Add one low-speed posterior position seed to the
traveling-bend target.  When normalized body speed and measured closure are
both deficient, use observed head-joint displacement to increase the
posterior target excursion modestly.  Withdraw the residual continuously as
body speed or closure establishes, the posterior bend grows, the target
approaches, or steering load rises.

Unlike the rejected energy envelope, the position term can initiate posterior
motion when joint velocity is near zero.  It remains a joint-state feedback
translation, not an open-loop kick, clocked startup stage, route coordinate,
or global carrier gain.  Expected evidence is better distance through
`2--4 T` without changing the established v26 wake or middle/late target arc.
Falsify it if early distance does not improve, capture is lost or later than
`23.9305 T`, mean distance exceeds `2.45000 L`, peak speed/limit residence
grows, or wake coherence and normalized load bounds regress.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and sensor-modulated robotic-fish oscillator control
source_mechanism: posterior kinematic emphasis in a traveling bend with feedback-based release of auxiliary amplitude
transferable_invariant: weak measured locomotor response may gate a bounded posterior state-feedback residual, but established response, large excursion, and steering demand should recover the proven base wave
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, clocked CPG phase, exact vortex phases, full-body splines, and prescribed routes
policy_translation: add a bounded head-joint-position component only to the posterior target, gated by normalized body-speed deficit, normalized closing response, posterior excursion, target-relative distance, and body-frame turn load
falsification: reject if distance at 2--4 T, capture time, or mean distance does not improve, or if later-route steering, wake coherence, actuator-limit residence, speed, force, or moment regresses

## Evidence boundary

All numerical and visual claims above are completed sampled or inherited CFD
evidence.  This candidate receives formal CFD evaluation only after worker
exit; no same-worker result is claimed.
