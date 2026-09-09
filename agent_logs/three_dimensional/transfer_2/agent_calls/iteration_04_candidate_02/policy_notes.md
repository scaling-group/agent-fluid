# Shifted-wave course-steering candidate

## Evidence diagnosis before policy edit

- All four sampled evaluations are valid direct-uniform still-water episodes:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and moving-window entering
  fluid also at zero velocity.  Translation in both visual rows is therefore
  self-propulsion.  The top-down alternating vorticity and oblique Lambda2
  structures are wakes made by the fish, not ambient advection.
- The strongest finite sample by score (`solver_b6bb94d9cdaf`, `-7.6367`)
  sustains the clearest bounded traveling wake and reaches `5.3570 L`, but it
  crosses reconstructed body-frame bearing from `+8.4 deg` to `-5.2 deg` by
  `4 T`, then holds roughly `-29` to `-85 deg` while passing about `5 L` above
  the target and exiting the upper boundary at `21.79 T`.  Its logged yaw rate
  reaches `3.03 rad/T`, and its soft-bounded commands exceed 95% of the
  `31 rad/T^2` controller limit on about `34%/53%` of rows.  This supports the
  posterior-lag propulsion scaffold, not its beat-contaminated yaw-rate brake.
- The branch-heavy prefill (`solver_e450df1efa49`) has the longest clean axial
  wake and the closest sampled pass (`4.1281 L` at `21.80 T`), but it continues
  above and then left of the target: bearing progresses from `-2.3 deg` at
  `4 T` to `-144.2 deg` at exit, final distance is `9.1538 L`, and raw actions
  exceed the physical acceleration envelope on about `73%/70%` of rows.  Its
  many recovery, trend, rate, and half-cycle branches are not a reusable
  steering solution.
- The sampled course/half-cycle controller (`solver_b43b85a4f60c`) is the
  informative visual failure.  It forms only a short wake, reduces bearing to
  `-6.5 deg` at `4 T`, then curls to `-79.1 deg` by `8 T` and exits the upper
  boundary at `8.59 T`; minimum distance is `11.9932 L`.  Thus course geometry
  acting through posterior half-cycle amplitude is not enough to preserve
  productive translation.
- The assigned parent guidance proposed coordinating anterior acceleration and
  posterior mean tangent.  Its inherited completed result
  (`solver_8019a82512ce`) scored `-14.7619`, reached only `12.1609 L`, and
  exited with `12.3200 L` final distance.  The next inherited posterior
  half-cycle candidate (`solver_369f0b43550e`) likewise scored `-14.7660`,
  reached only `12.0424 L`, and exited at `12.3285 L`.  These outcomes falsify
  the notes' predicted semantic improvements: later workers should not retry
  direct same-sign mean-bend coordination or posterior half-cycle asymmetry as
  scalar variants.  The durable positive element that survives is only the
  centered joint-state oscillator with posterior lag.

## Policy hypothesis

Test one different steering actuator: shift the equilibrium of the anterior
joint-state oscillator and express the posterior target relative to that same
moving equilibrium.  This translates the whole traveling bend around a small
mean body-wave offset, instead of adding an acceleration bias to a still-
centered head oscillator or imposing a tail-only static tangent.  Once the fish
has observed translation, blend instantaneous body bearing into target-minus-
course angle.  Because target and velocity are both represented in the body
frame, their angular difference cancels beat-scale body yaw and supplies a
slower route signal without mutable history, time, or a yaw-rate servo.

The candidate preserves the evidenced `0.55 T`, posterior-lag propulsive
scaffold and controller-owned smooth acceleration bounds.  It is falsified if
the short upper curl remains, minimum distance does not improve on the
immediate inherited `12.0424 L` result, the alternating wake or forward speed
collapses, target-course error does not contract after speed develops, or
command-limit residence is worse than the bounded samples.  Beating the
`5.3570 L` compact-controller minimum is the stronger architecture test; no
sample supports wake rejection or terminal scheduling because there are no
cylinders and no fish reaches the `0.75 L` capture neighborhood.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and oscillator-parameter turning
source_mechanism: sensor-driven mean offset of a rhythmic propulsive oscillator
transferable_invariant: preserve the relative phase and amplitude of a traveling propulsive bend while persistent observed route error shifts the rhythm around a bounded average curvature and zero error restores a centered gait
nontransferable_details: published offset gains, duty ratios, dimensional cadence, species kinematics, clock phase, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: blend normalized body-frame bearing into body-frame target-minus-course angle as observed speed develops; map it to a bounded anterior oscillator center and define the lagged posterior wave relative to the same center
falsification: reject if the early upper curl or near-zero progress remains, target-course error fails to contract, the coherent wake collapses, or actuator-limit residence increases
