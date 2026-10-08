# Persistent target-line response correction

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. No failed termination is
  present in this allocation, so the weaker finite captures and inherited
  regressions are the informative negative controls.
- I inspected the combined keyframe sheets for the strongest finite sample,
  the assigned prefill, and the distinct wave-handoff sample from release
  through capture. Their top-down rows show an initially quiescent field
  developing into a coherent alternating caudal wake behind a smooth
  target-directed trajectory. With zero background velocity and more than
  `11L` of travel, the motion is self-propelled rather than advected. Their
  oblique body/Lambda2 rows retain compact alternating three-dimensional wake
  structures without collision, boundary exit, wake collapse, or out-of-plane
  instability. The visible wake topology is effectively unchanged at sheet
  resolution, so route, action, and load histories distinguish the policies.
- `solver_1a8c73736b49` and `solver_e4b4c0604a5d` are independent evaluations
  of the same persistent-response policy and are byte-identical in physical
  outcome: capture at `15.686007T`, distance integral `1.916135L`, final
  distance `0.743392L`, `226` moving-window shifts, and score `-0.033442`.
  The inherited step-39 log reports that this policy advances every
  `8/6/4/2/1.25L` milestone relative to the assigned prefill while slightly
  lowering posterior acceleration-ceiling residence and excursion.
- The assigned prefill `solver_a3ebfdcbb7c5` hands supplemental moment
  correction back when carrier-demodulated yaw becomes target-aiding and uses
  translational rate only for terminal damping. It captures later at
  `15.713508T`, with integral `1.917987L`, `227` shifts, and score `-0.035331`.
  `solver_502dfb1f0223` instead lets aiding yaw hand posterior-wave relief back
  to propulsion; it also delays every inherited milestone, captures at
  `15.708008T`, raises the integral to `1.918172L`, uses `231` shifts, and
  scores `-0.035505`. Thus beat-local aiding body yaw is not interchangeable
  with persistent adverse translation of the target line, either for releasing
  mean correction or for restoring the target-opposing wave lobe.
- Inherited logs close nearby alternatives: response-conditioned adverse axial
  load relief delayed capture and worsened the integral; a moment-plus-lateral-
  load consensus lengthened the route; and redirect-phase allocation of the
  low-speed recovery increment scored `-0.039816`. Another load term,
  half-cycle selector, terminal threshold, or scalar retuning is therefore not
  supported by the present evidence.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: wake-interaction disturbance rejection and sensor-modulated robotic-fish direction control
source_mechanism: preserve a propulsive traveling bend while bounded steering correction remains tied to the measured adverse response that opened it
transferable_invariant: separate repeatable carrier motion from persistent target-relative response, retain one bounded correction while either demodulated yaw moment or target-line translation opposes the requested turn, and release it only when those same adverse signals clear
nontransferable_details: published gains, dimensional force and moment scales, species-specific kinematics, exact vortex or tail phase, clock-defined maneuvers, source wake geometry, world coordinates, and task-specific routes
policy_translation: use normalized anterior-joint phase to remove carrier yaw moment, body-frame target and velocity to measure target-line rotation, and smoothly union their opposition gates inside the already evaluated two-degree posterior mean-curvature ceiling; preserve the state-feedback carrier, axial-response propulsion allocator, base redirect, and terminal law
falsification: reject if capture or an established distance milestone regresses, distance integral or final crossing worsens, the coherent two-view wake is lost, joint limiting or force/moment loads grow without route benefit, or held-out geometry decouples adverse target-line translation from useful steering correction
```

## One candidate hypothesis

Produce exactly one candidate by adopting the twice-evaluated persistent-
response policy. Relative to the assigned prefill, add normalized target-line
translation as an independent corroborating opposition signal inside the
existing moment-correction envelope, remove the unrelated aiding-yaw veto, and
retain the winner's measured net line-of-sight terminal damper. The moment and
translation gates form a smooth union rather than stacked curvature, the
supplement remains capped at `2 deg`, and the correction remains subordinate
to reliable target-directed redirect duty and fades with approach proximity.

This is an evidence-backed response-release mechanism, not scalar-only gain
tuning. It preserves the anterior oscillator, posterior traveling wave,
positive-axial-response wave allocator, base target/course steering, approach
settling, actuator limits, and exact velocity-limit projection. The
falsifiable expectation is reproduction of the sampled coherent wake and
capture with all route milestones no later than the assigned prefill and a
lower distance integral. Formal CFD is post-exit evidence, so no new outcome
for this candidate is claimed here.
