# Force-previewed terminal response-release candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen physical contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture from
  `12.32772 L`. Three byte-identical evaluations of the assigned v28 parent
  reproduce score `-0.5281032175`, mean distance `2.4291077322 L`, final
  distance `0.7461626530 L`, and capture at `25.1185226 T`. The distinct v26
  sample reaches the same solver step at score `-0.5281078349`, mean distance
  `2.4291113720 L`, and final distance `0.7461675406 L`. Reproduction makes
  v28's advantage credible but still physically narrow.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  from release through termination for a reproduced v28 rollout and the v26
  comparison. Both are visually self-propelled rather than advected, follow
  the same compact target-directed arc, shed a coherent alternating posterior
  wake, and hand off to a quiet terminal bend before capture. Neither shows a
  collision, domain-exit precursor, wasteful late flailing, out-of-plane wake
  failure, or numerical instability. The sheets are indistinguishable at
  their resolution, so the small v28 advantage is supported by replicated
  trajectory metrics rather than a claimed visual difference.
- The inherited logs provide two negative actuator-location boundaries. A
  signed course-error half-cycle multiplier preserves capture but regresses
  to score `-0.5281232687`, mean distance `2.4291235633 L`, and final distance
  `0.7461837530 L`; crossflow-supported shared-mean unloading regresses more
  clearly to `-0.5295582789`, `2.430256795 L`, and `0.747692645 L`. Therefore
  the new policy must not select a beat side, unload the mean curvature, split
  joint roles, or increase the existing release cap.
- In the reproduced v28 trace, the signed body-frame target-to-course error
  decreases monotonically in its broad trend from `0.4431 rad` at `1.6 L` to
  `0.3103 rad` at capture. The body-frame hydrodynamic force rotates the
  velocity toward that target direction on `92.9%` of stored states inside
  `1.6 L`; the speed-normalized course-turn signal has median magnitude about
  `9.27e-4` and 90th percentile about `1.54e-3`. This is only a calibrated
  predictive cue from the parent trajectory, not evidence that force feedback
  already improves coupled flow.

## Policy hypothesis

Preserve v28's state-feedback traveling carrier, posterior lag, body-frame
target-angle redirect, closure preview, shared mean-curvature equilibrium,
crossflow-supported paired release, course-alignment release, and actuator
limits. Add one predictive response gate at the same actuator location: form
the signed angle from body-frame velocity to the target vector and the
instantaneous force-induced rotation of that velocity; when their signs agree,
a softly normalized force-preview signal may raise the existing course-release
support. The result remains bounded by v28's existing `3.5%` additional paired
release and remains exactly absent without the inherited late proximity,
helpful crossflow, positive closure, and settled-joint support.

This tests whether target-helpful hydrodynamic acceleration can release the
terminal equilibrium slightly before velocity alignment alone confirms the
response. It does not add release authority, static curvature, beat-side
selection, cadence modulation, a posterior-only role, clock phase, or a
world-frame route. The expected outcome is the same coherent outer wake and
mean bend, with no command difference outside `1.6 L`, while preserving or
slightly improving late closure and crossing depth. Reject the mechanism if
its stored-state gate is inactive or effectively saturated, if it changes the
outer trajectory, delays or loses capture, worsens mean/final distance or
course convergence, or introduces force-sensitive switching, joint stops,
command clipping, load growth, instability, or wake degradation.

bookshelf_consulted: true
source_domain: organized-wake adaptive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve useful flow-induced motion and relax corrective allocation only when sensed dynamics predict the intended target-relative response
transferable_invariant: a bounded hydrodynamic response cue may support release of an established correction when it acts in the same direction as normalized target-course error
nontransferable_details: published gains, dimensional force scales, species-specific kinematics, full-body waveforms, clock or vortex phase, cylinder geometry, and task-specific routes
policy_translation: the signed body-frame target-to-velocity angle and normalized body-frame force cross product provide a soft force-preview floor for the existing capped two-joint paired release, under the inherited range, crossflow, closure, and settled-response gates
falsification: reject if the force gate is dormant or saturated, acts outside the terminal support, changes mean bend or outer motion, delays or loses capture, worsens distance or course metrics, or creates switching, saturation, joint stops, load spikes, instability, or wake loss

## Non-CFD implementation audit

- The returned parameter object owns all 80 directly referenced policy fields
  (plus its version label), and the configured lightweight contract state
  produces two finite commands.
  The force/course construction is reflection-invariant: target lateral
  direction, lateral course, signed course error, and force-induced course
  turn all reverse together, leaving the scalar release support unchanged.
- Replaying the candidate and evaluated v28 parent on every stored v28 state
  gives exactly zero command difference for all 4,341 states at or beyond
  `1.6 L`. Inside that range, the force preview raises existing course-release
  support on 135 of 226 states. Its bounded preview has mean `0.5333`; the
  mean/maximum increase over alignment-only support is `0.2500/0.9529`, but
  the inherited `3.5%` release cap limits the mean/maximum per-step command
  difference to `0.000316/0.002631 rad/T^2`. Replayed candidate commands stay
  below `0.100/0.249 rad/T^2` in the band, and the final command is unchanged
  because the inherited alignment support is stronger there.
- These checks establish schema completeness, finite output, active bounded
  force preview, exact outer noninterference, and unchanged maximum release
  authority only. They do not establish a coupled-flow improvement.

The current worker's CFD evaluation occurs only after exit and is not claimed
as evidence here.
