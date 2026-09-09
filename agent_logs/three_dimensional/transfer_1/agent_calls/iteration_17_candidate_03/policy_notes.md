# Wake-policy candidate diagnosis

## Evidence read before policy edit

- All four sampled rollouts, the assigned-parent rollout, and the inherited
  terminal-steering failures report direct uniform initialization at
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Translation in both
  visual rows is therefore self-propulsion rather than ambient advection or a
  reused-flow artifact.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets from
  release to termination for the highest-scoring sampled capture
  (`solver_6b0e320e2f55`) and the informative inherited failures
  (`solver_6c5d98621185` and `solver_eabef54fa5c2`). The capture develops a
  coherent alternating wake by about `4T`, retains a traveling bend and compact
  three-dimensional structures, and crosses at `0.7494L` and `18.6010T` with
  speed about `0.8268L/T`. Both failures retain the same qualitative wake and
  continue moving after passing below the target; neither shows advection,
  carrier collapse, collision, or numerical instability before the miss.
- The prefilled speed-reserve policy bytes (`567de354...`) captured in the
  three sampled repeats at `18.2050--18.6010T`, and the assigned-parent replay
  captured at `0.7473L` and `18.4085T`. This fourth exact-policy capture makes
  the achieved-course request, projected-intercept release veto, selective
  outward-carrier reserve, and uninterrupted traveling bend the baseline to
  preserve. The scores span `-0.16591` to `-0.15140`, so small score ordering
  is less informative than the repeated capture class.
- The inherited half-cycle steering candidate changed nothing outside the
  existing `2.75L` intercept gate and visibly retained the alternating wake,
  yet it reached only `1.6860L`, passed below the target, and exited the lower
  boundary at `31.4875T` with final distance `10.3091L`. Together with the two
  failed projected-miss replays, this shows that terminal steering semantics
  are sensitive even when propulsion remains coherent. Carrier-acceleration
  phase alone is not an evidenced basis for redistributing the steering
  request.

## One candidate hypothesis

Retain the repeat-supported speed-reserve controller and add one approach-hold
mechanism: while inside the existing intercept range, approaching within the
projected capture corridor, and already releasing steering because the
phase-compensated yaw response has the requested sign, apply a small bounded
yaw-rate damping residual. The residual uses the already-calibrated
joint-compensated body yaw rate, opposes only the released response, and does
not attenuate or phase-redistribute either carrier. It is identically zero
outside the intercept gate and whenever the LOS/intercept checks re-engage the
full achieved-course steering request.

Expected test: preserve early distance closure, the coherent top-down and
oblique traveling wake, and the repeat-supported capture class while reducing
terminal yaw carry-through and capture-time variability. Falsify the mechanism
if capture is lost, far-field output changes, terminal oscillation weakens,
force or yaw-moment peaks exceed the baseline envelope, actuator residence
increases materially, or the same below-target lower-exit topology appears.

bookshelf_consulted: true
source_domain: biological burst-to-cruise redirection and sensor-modulated robotic-fish approach control
source_mechanism: release strong curvature after the observed heading response develops, then damp residual yaw while retaining the propulsive rhythm
transferable_invariant: near an interception corridor, response-gated yaw damping can stabilize approach without replacing target geometry or suppressing a traveling bend
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed maneuvers, exact gait or vortex phase, and task-specific routes
policy_translation: keep normalized body-frame achieved-course and projected-intercept feedback; add a bounded residual from joint-compensated yaw rate only when the existing release and intercept gates agree
falsification: reject if far-field commands change, capture is lost, the traveling wake weakens, loads or saturation rise, or a below-target lower exit replaces the repeat-supported capture topology

## Non-CFD verification

- The final candidate SHA-256 is
  `49e952f27094dc4547ad9c45b6113a31270c27b5b8e91ce516b84b0861bedd7e`.
  The mandated Julia contract returns two finite accelerations, and static
  inventory confirms all 44 directly referenced `params.FIELD` names are
  present in the 46-field parameter object.
- A direct Julia comparison with the assigned-parent policy gives exactly
  equal actions at a representative `5L` state outside the intercept gate.
  Mirrored terminal states give exactly sign-mirrored two-joint actions. In an
  intercept-compatible release state the new damping is finite, bounded, and
  active (`release=0.7274`, residual `-1.2968 rad/T^2`).
- Offline replay of the gate over the four successful baseline traces makes
  the residual active on `20.3--60.8%` of rows inside `2.75L`, with mean
  absolute magnitude `0.105--0.465 rad/T^2` and peaks below the owned
  `2.0 rad/T^2` limit. This verifies that the candidate tests a real but small
  terminal mechanism; it is not a version-only change or a formal CFD result.
- The required semantic-guidance check and solver editable-boundary check
  pass. The checker initially found two identical assigned-parent markers in
  the rendered workspace `README.md`; the redundant marker was removed and the
  check was rerun successfully. No CFD rollout was run.
