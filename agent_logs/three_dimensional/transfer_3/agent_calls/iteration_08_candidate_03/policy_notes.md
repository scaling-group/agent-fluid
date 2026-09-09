# Geometry-gated two-joint redirect candidate

## Evidence read before the policy edit

- Every sampled and inherited rollout reports direct uniform initialization in
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The
  translation in both visual rows is therefore self-propulsion rather than
  advection or a moving-window artifact.
- The score-leading sampled policy `solver_adc862529891` sustains a coherent
  alternating top-down street and compact oblique Lambda2 structures, but
  rises to the upper boundary at `16.77T` after reaching `5.658L`. The raw-slip
  and assigned phase-separated-slip policies retain similarly coherent wakes
  and improve closest approach to `4.158L` and `4.128L`; both nevertheless
  cross the target x station roughly `4.1L` high and continue to the left
  boundary near `29.5T`, finishing about `9.05L` away. Their local flow remains
  only about `0.02--0.03U`, so the shared failure is route topology, not lost
  propulsion, imposed flow, or numerical instability.
- The assigned parent is a direct negative test of projected slip as a
  complete mechanism: the evidenced projection changes the raw-slip minimum
  by only `0.030L` and preserves the same left exit. Its target is already
  abeam at about `16T` and behind by about `20T`, while the body needs several
  more lengths to turn; a forward-cone mean-tail loop does not supply a compact
  return once the fish has passed the target line.
- The inherited step-7 logs reject two tempting continuations. Full
  phase-separated course release (`solver_f080e10f704b`) exits upward at
  `11.30T` with a minimum/final distance of `8.507L`. Response-damped posterior
  half-cycle steering (`solver_5c3c1ecb1b6b`) makes an even tighter wrong-side
  turn, exits upward at `8.70T`, and reaches only `12.072L`. The corresponding
  keyframes show curved self-generated wakes rather than wake collapse, so
  neither another full-course algebraic release nor half-cycle authority is a
  supported next step.
- In the four sampled mean-tail-curvature traces, the raw posterior action
  exceeds the `1800 deg/T^2` adapter envelope in `63--74%` of rows (the assigned
  parent is `3986/5392`, or `73.9%`). Posterior-only steering is therefore
  frequently mixed with carrier clipping. This is evidence to change where a
  large redirect is expressed, not to claim another curvature-gain retune.

## Policy hypothesis recorded before editing

Preserve the assigned parent's joint-state traveling bend, projected lateral
course cue, and phase-separated yaw response while the target remains in the
forward body cone. Add one geometry-gated redirect mode: when normalized
target forward projection falls below a soft threshold and bearing is large,
blend the existing posterior bias into a bounded mean C-bend shared by both
joints. Centering the anterior oscillator on part of the requested bend keeps
the traveling wave alive while moving some redirect authority out of the
posterior-only clipped path. The gate depends only on current body-frame target
geometry, so it releases continuously when the turn brings the target forward;
there is no clock, stage counter, coordinate, or memorized route.

Expected evidence is the same coherent wake and early minus-x progress as the
assigned parent, followed by a materially tighter turn after the target becomes
abeam: lower target-line crossing, minimum distance below `4.128L`, or a
termination better than the repeated left exit. Reject the transfer if it
repeats either inherited short upper exit, weakens the alternating wake, hits
joint-angle limits persistently, or leaves the target behind while continuing
to the left boundary; that would show the missing mechanism is a genuinely
beat-scale route estimator or a different carrier, not curvature distribution.

bookshelf_consulted: true
source_domain: biological burst redirection and robotic-fish mean-curvature turning
source_mechanism: large observed direction error recruits a bounded whole-body C-bend, then releases back to rhythmic propulsion when observed geometry realigns
transferable_invariant: preserve the propulsive rhythm for ordinary pursuit but distribute a large redirect across available bending joints and release it from sensed response rather than elapsed time
nontransferable_details: species-specific C-start kinematics, published robot gains and link geometry, dimensional timing, clock phase, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target forward projection and bearing to gate a bounded two-joint mean bend around the existing state-feedback carrier, while retaining the parent's projected course and yaw residual in the forward cone
falsification: reject if wake coherence or early propulsion degrades, either short upper-exit topology returns, joint-angle saturation becomes persistent, or the abeam/behind redirect does not improve the 4.128L minimum or repeated left exit
