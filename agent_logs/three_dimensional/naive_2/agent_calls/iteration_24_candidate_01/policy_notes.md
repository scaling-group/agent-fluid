# Closure-qualified yaw-response hold candidate

## Visual and metric diagnosis before the policy edit

- The assigned parent is the phase-demodulated yaw/lateral-response carrier
  with posterior half-cycle steering and a final-one-percent outward-speed
  guard. All four sampled solvers satisfy the released direct-uniform
  still-water contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite
  moving-window dynamics, and capture. Three are exact evaluations of the
  assigned candidate at `16.604496T`, score `-0.113729`, final distance
  `0.743958L`, and scored distance integral `1.998146L`. The raw-lateral
  ablation captures one `0.0055T` step later at score `-0.115560`, final
  distance `0.745621L`, and integral `1.999656L`. The repeats establish
  fixed-case reproducibility, not held-out robustness.
- I inspected both rows of the combined keyframe sheets for a strongest
  residualized capture, the raw-lateral ablation, and the latest inherited
  line-of-sight-rate descendant. Their top-down rows show self-propelled
  targetward translation, the same shallow target-crossing arc, and a coherent
  alternating mid-plane vorticity street. Their oblique rows show finite,
  compact, tail-connected three-dimensional Lambda2 structures through
  capture. There is no passive advection, wake breakup, collision, domain
  exit, or instability. No sampled semantic failure exists, so the weaker
  captures are controlled mechanism regressions rather than a different wake
  class.
- The assigned parent's improvement is narrow and route-specific. Relative to
  the raw-lateral ablation, mean absolute requested actions remain nearly
  unchanged (`21.733/22.674` versus `21.738/22.691 rad/T^2`), while peak
  planar force/moment increase from `0.035828/0.017759` to
  `0.037165/0.018356`. This supports preserving the carrier and the lateral
  observer; it does not support stronger actuation.
- Inherited completed controls rule out transforming the target geometry or
  adding another response residual on this carrier. Two approach-only
  phase-demodulated line-of-sight-rate feedforwards retained capture but
  regressed to scores `-0.118996` and `-0.118543`, with distance integrals
  `2.002387L` and `2.001984L`. Approach-bearing demodulation delayed capture
  to `17.094002T` and score `-0.121357`; yaw-moment residual rejection scored
  `-0.115946`. The connected wake surviving these tests does not validate
  their directional semantics, and none should be gain-tuned again here.
- Reconstructing the current policy's normalized terminal signals from its
  completed trajectory shows a different, directly gateable condition.
  Inside `3L`, the phase-demodulated target--velocity cosine has mean `0.927`
  and stays positive; in the final `0.9L` it averages `0.950`. Nevertheless,
  the bounded yaw-response error has mean absolute magnitude about `0.742`
  inside `3L`, while the demodulated course angle reverses sign five times.
  Thus the successful fish is already closing strongly while the fast yaw
  correction continues to chase beat-scale directional error. The evidence
  supports testing conditional release of that response, not weakening the
  traveling wave or altering raw target geometry.

## Sole candidate hypothesis

Preserve the evaluated anterior oscillator, raw bearing, raw-course anterior
center, lateral and yaw phase demodulators, posterior route and crossflow
terms, half-cycle steering, acceleration bound, and one-sided speed guard.
Add one terminal approach-hold mechanism: below `3L`, compute a scale-free
closure alignment from the phase-demodulated body-frame target and velocity.
When forward speed is qualified and this alignment is already high, smoothly
release at most `35%` of only the additive yaw-response correction in the
posterior turn state. Raw route geometry and the propulsive wave remain at full
authority, and the yaw response returns continuously if closure deteriorates.

This is a bounded, reflection-equivariant, clock-free state-feedback test. It
is exactly inactive outside `3L` and does not change carrier amplitude,
desired-yaw semantics, curvature limits, or actuator guards. Expected test:
retain capture and the connected two-view wake while reducing terminal
beat-scale steering, distance integral, force/moment, or near-limit residence.
Falsify it if capture is lost; if any pre-`3L` action changes; if target
alignment, arrival, final crossing depth, score, joint feasibility, effort, or
loads regress; or if the late directional oscillation is unchanged.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal prey-capture approach control
source_mechanism: preserve rhythmic locomotion while a separate observed approach condition advances or releases directional feedback
transferable_invariant: keep the productive traveling carrier and raw route request intact, but release a bounded fast correction when normalized targetward closure is already reliable and restore it when closure degrades
nontransferable_details: published CPG gains, species kinematics, dimensional speeds, maneuver timing, exact vortex phase, and task-specific routes
policy_translation: below `3L`, use speed-qualified phase-demodulated target--velocity alignment to attenuate only the posterior yaw-response addend while leaving carrier, route, crossflow, half-cycle, and actuator mechanisms unchanged
falsification: reject if capture or the pre-approach route changes, closure or late steering does not improve, the connected wake changes class, or distance cost, joint feasibility, effort, force, moment, or score worsens

## Evaluation boundary

No CFD result is claimed for this unevaluated candidate. The evidence for the
baseline belongs to three completed sampled rollouts; the negative controls
belong to completed inherited logs and sampled optimizer guidance. Later
evaluation should require capture and the same top-down/oblique wake class
first, then compare pre-`3L` action identity, arrival, scored and observed
distance integrals, final crossing depth, closure alignment, yaw-response
activity, joint contact, speed/acceleration residence, action effort, and peak
force/moment against the `-0.113729` parent. A fixed-pose still-water success
would not establish held-out pose, flow, or carrier-family robustness.
