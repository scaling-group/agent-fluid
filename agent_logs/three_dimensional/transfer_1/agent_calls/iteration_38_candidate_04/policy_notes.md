# Reject beat-correlated terminal course feedback

## Completed evidence and visual diagnosis before policy selection

- All four sampled rollouts are finite captures initialized directly from
  uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  The two byte-identical v50 evaluations are the strongest completed policies:
  both capture at `17.41299 T`, score `-0.0595203`, final distance
  `0.745094 L`, and total/observed distance integrals
  `1.945327/1.329976 L`.
- The v53 desired-yaw-rate course response is an informative mechanism-level
  failure.  It follows the same checkpoint route and reaches the same capture
  step, but crosses more shallowly at `0.745498 L` and worsens score and
  total/observed integrals to `-0.0599362` and
  `1.945663/1.329978 L`.  Maximum speed, any-joint acceleration-limit
  residence, and peak normalized force/moment remain at
  `0.98310 L/T`, `40.11%`, and `0.032252/0.016092`, so there is no
  compensating stability or load benefit.
- Localizing the same signed course cue to posterior wave shape also fails.
  The sampled v53 posterior residual captures on the same step and changes no
  checkpoint meaningfully, but worsens final distance and total/observed
  integrals to `0.745115 L` and `1.945350/1.329982 L`.  It raises any-joint
  acceleration-limit residence from `40.11%` to `40.90%` while leaving the
  `0.98310/0.032252/0.016092` speed/force/moment envelope unchanged.
  Inherited v52 evidence already showed a larger regression when instantaneous
  course slip entered the ordinary route request: total/observed integrals
  `1.946671/1.329989 L`, shallower `0.746705 L` capture, and more posterior
  clipping.  Route, desired-rate, and posterior-shape placement therefore
  agree on the negative result.
- I inspected the combined top-down and oblique sheets for the reproduced v50
  comparator and both v53 failures from release through capture.  Every
  top-down row shows active self-propulsion on the same smooth target-signed
  arc: a compact startup wake develops into a coherent alternating street with
  no reversal, boundary exit, collision, or visible wake collapse.  The
  readable oblique frames show the same compact three-dimensional caudal
  structures at release, `4 T`, `12 T`, `16 T`, and capture; an intervening
  black frame is a rendering limitation shared by the comparison, not a
  physical failure.  Neither v53 mechanism creates a useful wake or trajectory
  change.
- Frozen-trace reconstruction explains the repeated null.  During the final
  approach, instantaneous normalized course slip has `0.94` correlation with
  anterior joint rate and `0.99` correlation with posterior joint angle.  It
  is primarily a carrier-phase observation, not demonstrated persistent route
  drift.  Moving that cue among steering channels either cancels across the
  beat or spends posterior headroom without improving radial closure.

## Sole candidate and falsifiable expectation

Keep the materialized
`dogfish_target_control_v50_geometrically_qualified_posterior_response` as the
only candidate.  It preserves the reproduced state-feedback traveling-wave
carrier, posterior lag and launch allocation, normalized body-frame target
sensing, selective crossflow pose confidence, base route and redirect
steering, carrier-first spillover, half-cycle steering, geometry-qualified
posterior response, approach priority, and componentwise actuator projection.
No instantaneous course-slip residual is retained in the route request,
desired-yaw-rate loop, or posterior wave shape.

The next evaluation should reproduce capture near `17.413 T`, score near
`-0.05952`, total/observed integrals near `1.94533/1.32998 L`, the coherent
target-signed two-view wake, and the established speed/saturation/load
envelope.  Falsify this selection if the completed result does not reproduce,
loses capture or middle/late closure, changes the wake topology, or materially
exceeds that envelope.  A later course controller should be attempted only
after a completed trace demonstrates a normalized de-gaited or history-
consistent direction signal with target-signed authority and actuator
headroom; moving the same instantaneous velocity cross product to a fourth
channel is not a distinct test.  Formal CFD occurs only after this worker
exits.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction control
source_mechanism: preserve a productive traveling-wave oscillator while separating persistent navigation error from fast carrier-correlated lateral motion
transferable_invariant: supplementary direction feedback needs a normalized response-coherent cue that survives carrier-phase rejection; instantaneous sway is not automatically route error
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body oscillator state, exact vortex phase, and task-specific routes
policy_translation: retain completed v50 and remove raw course slip from all steering channels; revisit course feedback only after a de-gaited or history-consistent body-frame signal is evidenced
falsification: reject the retained candidate if v50 performance fails to reproduce, and reject any future course cue if it lacks checkpoint improvement, consumes headroom, or degrades capture, wake coherence, speed, saturation, force, or moment

## No-CFD implementation boundary

The candidate is byte-identical to the two completed v50 examples with
SHA-256 `cf9ca6aa2892b1aa4298d75c1359d84c467330129e0ea6167857742403b046ab`.
All `68` direct `params.FIELD` references resolve among the `70` fields
returned by `target_policy_params()`.  The required check-runner was invoked,
but its pinned `gpt-5.4-mini` model is unavailable for this ChatGPT account;
its three exact checks were then run locally and separately.  The material
guidance/notes check, lightweight Julia policy contract, and solver editable-
boundary check all pass.  The current worker claims no new CFD result.
