# Course-biased rate-closed half-cycle candidate

## Evidence diagnosis before the edit

- All four sampled rollouts are contract-valid direct-uniform still water:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and an inertial moving
  window. The top-down and oblique rows therefore show self-propulsion and a
  three-dimensional caudal wake rather than background advection.
- The assigned parent, `solver_0334e73ca6df`, is the only sampled controller
  that escaped the near-`9T` upper curl. Its anterior half-cycle/rate-closed
  `0.90T`, `18 deg` traveling bend leaves a long alternating vortex street in
  the top-down row and a coherent Lambda2 trail in the oblique row. It survives
  to `39.088T` and reaches `5.156L`, versus the naive seed's `8.547T` exit and
  `12.078L` minimum.
- The parent is a useful carrier, not a target controller. Its center stays in
  the high corridor (`13.780L` to `14.961L`), passes the target-aligned x
  station near `(9.40,14.68)L`, then exits left at `(0.797,14.961)L`. The
  reconstructed body-frame target bearing grows to about `-1.5 rad`; the
  top-down marker visibly passes beneath and then behind the nearly horizontal
  wake. Joint speed is at its cap on roughly `53%` of samples and candidate
  acceleration is clamped on roughly `58%`, so more drive is unsupported.
- The parent trace exposes a route signal that its controller does not use.
  Once translation develops, the normalized cross product of body-frame
  velocity and target vectors remains positive, rising above `0.8` late in
  the useful approach, while body-frame lateral velocity remains positive and
  the fish drifts above the target. At the same time its instantaneous yaw
  closure keeps mean yaw near zero after the initial redirect and prevents the
  seed's tight curl. Thus the course miss and the stabilizing yaw loop should
  be combined rather than treating either as a complete steering command.
- The two current descendants are informative negative controls. Direct
  bearing-dominant anterior half-cycle forcing (`solver_4c2f69e357da`) returns
  to the upper exit at `9.295T` with only `11.954L` minimum distance. Direct
  velocity-course half-cycle forcing (`solver_614a9cbf562b`) does likewise at
  `8.778T`, reaching only `12.186L`. Both visual rows show coherent wakes that
  fold into the old curl. Consequently, replacing the parent's phase-correlated
  rate closure with a persistent geometric half-cycle command is falsified in
  these two formulations; another direct-command gain change is not supported.

## Policy hypothesis

Preserve the assigned parent's carrier, posterior lag, anterior actuator, and
instantaneous normalized yaw closure. Add one bounded body-frame course-error
term to the *desired mean yaw rate* tracked by that loop. Fade course demand to
zero before translation is observable and fall back to bearing alone at low
speed. This keeps the parent's beat-correlated stabilizing action while making
the persistent target-versus-course mismatch shift its mean setpoint; it does
not apply course error as an open half-cycle selector.

The candidate should retain a long alternating wake but acquire downward
cross-track motion before the target-aligned x station. Falsify the mechanism
if it returns to an approximately `9T` upper exit, repeats the parent's high-y
left-boundary overshoot without improving `5.156L`, loses coherent propulsion,
or increases angle/speed/acceleration residence beyond the already excessive
parent levels.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking
source_mechanism: slow route error biases a rhythmic steering command while gait feedback preserves the propulsive oscillation
transferable_invariant: keep the evidenced traveling rhythm and map persistent target-versus-course error into a bounded mean turn demand rather than replacing phase-correlated stabilization
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: blend normalized body-frame bearing with the normalized velocity-target cross product, speed-gate the course term, and track the resulting bounded yaw-rate ratio through the parent's joint-state half-cycle loop
falsification: reject if the tight upper curl returns, the high-y longitudinal overshoot persists without a closer approach, wake coherence collapses, or actuator-limit residence increases
