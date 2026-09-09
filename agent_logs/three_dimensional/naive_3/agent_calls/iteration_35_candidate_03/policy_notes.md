# Wake-policy candidate notes

## Evidence diagnosis

All four sampled evaluations report direct uniform initialization at
`U_infinity=(0,0,0)` with no cylinders, so their displacement is self-propelled
rather than imposed-flow advection. The combined top-down and oblique sheets
show coherent alternating 3D wakes and finite motion through the horizon. The
`1.241L` course-hold sample is visibly different after the first return: it
keeps an active body wave and bends onto a tight target-side loop, whereas the
assigned parent's rear-crossing selector and the equilibrium-release/restart
variants settle into similar broad powered loops around a common negative
C-bend.

The diagnostics agree with the images. The course hold reaches
`1.241/4.158/2.082L` minimum/mean/final distance and has mean anterior speed
`|phi_dot_1|=1.372 rad/T` inside `3L`. The assigned parent reaches
`2.366/3.875/3.502L` with only `0.149 rad/T`, while the joint-unbend and signed
restart reach `2.215L` and `2.369L` with `0.224` and `0.213 rad/T`. All four
still translate near `0.67U` there, so the failure is loss of active bending,
not loss of vehicle speed or wake formation. At the useful sample's minimum,
the course is slightly receding, the requested course turn is negative,
`phi_dot_1=-0.260 rad/T`, and anterior acceleration is only
`+0.747 rad/T^2`: there is measured phase motion and command reserve, but the
base oscillator is already braking that motion.

The sampled inherited optimizer guidance and score logs prevent repeating the
obvious one-sided shelf transfer. A requested-sign useful-half-cycle pulse
reached only `1.702L`, parked both joints, and regressed final distance to
`3.574L`. In contrast, low-activity velocity feedback on both half-cycles
reached `1.175L`, stayed inside `1.25L` for about `2.35T`, and preserved active
near-target joint motion, although its `3.243L` final distance shows the return
orbit remained too large.

## Policy hypothesis

Restore the evidenced continuous course-hold selector and add one compact
mechanism: a bounded radial energy correction about its already moving
anterior equilibrium. Compute dimensionless anterior phase-plane activity from
`(phi_1-anterior_mean)/effective_amp` and
`phi_dot_1/(omega*effective_amp)`. Only under the existing terminal course
gate, apply positive velocity feedback proportional to `phi_dot_1` when that
activity is below a target; because the sign follows measured velocity, both
half-cycles receive energy and neither equilibrium nor turn handedness moves.
Release continuously as activity returns. The posterior lag remains unchanged
and carries the recovered traveling bend to the tail.

Expected result: preserve the course hold's first return and coherent wake,
avoid the parked C-bend, and improve closest approach and near-target residence
without a large rise in clamp/load residence. Falsify the mechanism if the
first return changes, phase activity still collapses, the wake/orbit broadens,
clamp or load residence rises materially, or minimum/final distance does not
improve.

bookshelf_consulted: true
source_domain: robotic-fish CPG amplitude regulation and asymmetric-flapping turning
source_mechanism: state-feedback regulation of rhythmic amplitude around a commanded locomotor equilibrium
transferable_invariant: restore a deficient oscillation by phase-balanced feedback tied to measured phase motion, without moving the mean turn command
nontransferable_details: published oscillator gains, clock phases, species kinematics, full-body waveforms, and task-specific routes
policy_translation: normalize anterior displacement and velocity about the course-hold equilibrium; add bounded low-activity feedback proportional to measured anterior velocity on both signs, gated by normalized body-frame terminal course geometry
falsification: reject if it changes the first return, creates a parked bend, degrades wake coherence, increases clamp/load residence, or fails to improve near-target and final-distance statistics
