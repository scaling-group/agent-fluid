# Terminal traveling-bend candidate

## Evidence diagnosis

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, so the visible translation is self-propulsion,
  not prewarm or imposed-flow advection.
- In both rows of `solver_4f3d51f38935/wake_keyframes.jpg`, the fish maintains
  a coherent alternating top-down wake and compact oblique Lambda2 structures
  while following the only sampled capture-scale path. It reaches `0.832836L`
  at `27.473T`, but passes the target and exits left. At closest approach its
  inertial speed is `0.662L/T`, while joints 1/2 have nearly settled together
  at about `-24.1/-25.0 deg`, joint speeds are only about `-0.21/-0.35 rad/T`,
  and commands are only `0.165/0.011 rad/T^2`. The corresponding projected
  miss is about `0.806L`, just outside the `0.75L` capture circle. This is a
  terminal lateral-authority deficit in a settled C-bend, not weak propulsion,
  a load spike, or a moving-window artifact.
- The contrast cases preserve wakes but do not support spending more scalar
  authority. The yaw-rate closure (`solver_12fc3441a636`) remains in the high
  corridor, reaches only `6.268L`, and spends about `57%/43%` of samples at an
  acceleration/speed limit. The prefilled posterior redistribution
  (`solver_b6ed3f84ab58`) reaches only `5.386L`, touches the angle limit, and
  raises peak planar force/yaw moment to about `0.212/0.0968`, roughly ten
  times the near-miss loads. The intercept-qualified redirect
  (`solver_b3b6be8f076f`) is low-load but releases far too early and reaches
  only `4.278L`.
- Assigned-parent guidance and inherited completed results close the static
  curvature and one-shot recovery branches: unconditional and closing-gated
  depth, anterior reflex, posterior S-bend, coordinated recoil, and anterior
  counter-sweep all remain `left_domain` near `0.828--0.847L`. The inherited
  step-13 results (`0.831067L` and `0.875770L`) add no semantic improvement.
  The reusable open question is therefore dynamic two-joint authority during
  the pass, not another threshold, fixed bend depth, isolated-joint pulse, or
  posterior damping edit.

## Policy hypothesis

Use `solver_4f3d51f38935` as the evidenced carrier/redirect baseline, preserve
its far-field cruise, turn-side convention, C-redirect entry, and miss-qualified
release, but remove the miss-gated scalar extra bend. While the same normalized
body-frame approach and projected-miss signals veto release, blend the settled
redirect into a bounded oscillator about the calibrated joint-1 mean and make
joint 2 track a phase-lagged, posterior-emphasized displacement about its
calibrated mean. Joint state supplies phase; there is no clock or route memory.
An angle-headroom gate smoothly returns to the settled redirect near the hard
envelope.

This should retain the far trajectory exactly, but replace the nearly static
terminal C-shape with a small traveling bend that produces time-varying lateral
reactive force and rotates the velocity vector enough to reduce the measured
`~0.806L` projected miss. Reject the mechanism if evaluation does not beat the
best inherited `0.827823L`, if the terminal velocity direction does not rotate
toward the target, if the far path changes, or if wake coherence, load peaks,
angle margin, or limit residence approaches the posterior-redistribution
failure.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and closed-loop robotic-fish CPG modulation
source_mechanism: a directionally traveling lateral bend with posterior lag, modulated by measured task error
transferable_invariant: an active phase-lagged body wave can generate directional reactive forcing, and feedback can confine that wave to the regime where the observed course needs correction
nontransferable_details: published gains, species envelopes, dimensional frequencies, exact joint phases, prescribed routes, and open-loop oscillator clocks
policy_translation: use joint-state phase for a small mean-centered anterior oscillator and lagged posterior follower, gated only by normalized body-frame distance, projected miss, and joint-angle headroom while preserving the calibrated C-bend side
falsification: reject if the candidate fails to beat 0.827823L, moves the body without rotating terminal velocity, perturbs the far carrier, loses the coherent wake, or materially increases loads or actuator-limit residence
