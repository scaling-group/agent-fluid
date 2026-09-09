# Continuous closing-approach relief candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable dynamics, and
  `capture` termination. They reduce distance from `12.328L` to about
  `0.747L` in `19.706--20.207T`, so this batch contains no semantic failure.
  The slower capture is used only as an informative underperformer.
- Both rows of the combined sheets for the best sample
  (`solver_1b6df3d71b19`) and the slowest sample
  (`solver_7b0034b927d0`) were inspected from release through termination.
  Their top-down rows show self-propulsion with a coherent alternating wake,
  not advection, followed by a bounded terminal arc. Their oblique rows retain
  compact three-dimensional Lambda2 structures along the route. Neither shows
  collision, wake collapse, disorderly lateral excursion, or instability.
- The metrics discriminate changes that the nearly identical sheets cannot.
  Adding body-frame line-of-sight-rate lead to the half-cycle course redirect
  improves the slow sample's `20.207T`, `2.11794L` distance integral, and
  `-0.22712` score to `19.706T`, `2.10594L`, and `-0.21598` in the best sample.
  The prefilled policy differs from that best sample only by multiplying the
  established distance-and-closing drive relief by course-redirect demand;
  it remains a capture but regresses to `19.949T`, `2.11694L`, and `-0.22666`.
- Inherited completed logs bound further steering redistribution. Releasing
  extra redirect curvature after aligned yaw response captured at `19.850T`
  with score `-0.22093`, while extending half-cycle modulation into posterior
  redirect curvature captured at `20.168T` with score `-0.24199`. These do not
  support stacking another response or phase gate around a scaffold whose
  visible wake, joint margins, and load class are already coherent.
- The reusable negative result is therefore specific: on this captured
  LOS-led scaffold, retaining more carrier amplitude when the velocity course
  looks aligned did not speed capture. The course-error signal already owns
  redirect geometry; reusing it to suppress closing-approach relief couples
  two control roles and worsens the otherwise matched distance history.

## One-candidate hypothesis

Preserve the evaluated traveling-bend carrier, posterior lag, fore/aft-aware
body-frame target vector, bounded route steering, joint-state half-cycle
asymmetry, velocity-course redirect, and line-of-sight-rate lead. Remove only
the prefilled course-demand multiplier from drive relief, restoring the
best-sampled continuous product of normalized distance approach weight and
positive closing-speed gate. This is a mechanism rollback, not scalar gain
tuning: course error remains a steering observation, while distance and
closing behavior exclusively allocate terminal carrier relief.

Expected signature: reproduce the `19.7T` capture class, coherent alternating
top-down wake, compact oblique structures, and established command/load class,
with a lower distance integral than the prefill. Falsify the selection if it
loses capture, repeats the prefill's slower integral, coasts before necessary
redirect authority is available, increases joint/command-limit residence or
loads, or degrades either wake view. A later worker should test a new
observation or actuator primitive only if this plain allocation fails on a
held-out pose or inflow; it should not add another nested course gate merely to
make the terminal formula more elaborate.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated rhythmic swimming
source_mechanism: continuous approach hold that reduces excess drive from observed distance and positive closing behavior while retaining the propulsive rhythm
transferable_invariant: near a target, allocate carrier relief from normalized proximity and measured closing rather than from a second copy of the steering error
nontransferable_details: published gains, species-specific amplitudes, dimensional cadence, clock phase, exact vortex phase, and task-specific routes
policy_translation: restore bounded drive relief as approach_weight times positive closing_gate while leaving body-frame course error and line-of-sight rate solely in the two-joint redirect feedback
falsification: reject if capture timing or distance integral regresses, terminal coasting causes a miss, coherent propulsion is lost, or command, joint, force, and moment histories worsen
