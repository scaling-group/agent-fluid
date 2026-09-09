# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled evaluations are valid direct-uniform still-water episodes:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window shifts,
  and stable dynamics. Their translation is self-propelled rather than
  environmental advection.
- In the strongest finite comparison, `solver_28bd83fceb82` captures at
  `21.1695T` with a `0.7493L` final distance. Its top-down row shows a coherent
  alternating wake during the leftward transit and a controlled downward arc
  into the target; the oblique row shows organized three-dimensional caudal
  Lambda2 structures without body loss or a locked-axis escape. Inside `2L`,
  the joints settle near a C-bend, mean absolute command falls to
  `0.186 rad/T^2`, and speed remains about `0.755U`, so the terminal motion is
  a redirected coast rather than wake-free advection or bang-bang thrust.
- The informative failure `solver_8cbc18979df7` retains an organized far-field
  wake and stable self-propulsion but reaches only `1.733L`, then makes a broad
  return arc and exits high at `52.481T`. Its combined sheet and trajectory
  agree that the allocator reduced beat-scale drive near the miss, but target
  direction and actual velocity course remained misaligned. Thus wake onset
  and raw route gain are not the remaining distinction.
- Both newly sampled redirect mechanisms are semantic improvements over that
  failure. The velocity-course-gated policy captures slightly earlier and with
  lower observed distance integral than the response-gated burst
  (`21.1695T`, `1.5871L` versus `21.2245T`, `1.5937L`). It is also much calmer
  inside `2L`: mean absolute command is `0.186` versus `11.918 rad/T^2`, mean
  speed is `0.755` versus `0.700U`, and terminal yaw rate is about `0.183`
  versus `1.455 rad/T`. Stronger burst authority is therefore not supported.
- The assigned-parent logs establish why this matters: full-vector steering
  and half-cycle asymmetry preserved the same pass-and-left-exit topology, and
  distance/closing allocation alone improved command headroom but still
  missed. The successful addition is measured velocity-course feedback that
  converts the available headroom into a terminal C-bend.

## One-candidate hypothesis

Preserve the captured policy's joint-state traveling-wave carrier, aligned
two-joint approach bend, distance/closing drive relief, yaw-rate brake, smooth
command bounds, and velocity-course redirect. Replace only the redirect's
angle-magnitude gate with a normalized capture-corridor residual. The full
body-frame target direction and current body-frame velocity define the
projected straight-course miss distance. Strong redirect authority remains
while that projection lies outside a controller-owned `0.55L` corridor, then
releases continuously as the velocity line enters the corridor; the ordinary
approach curvature remains active throughout.

Expected signature: preserve the coherent far wake and the successful
middle-field turn, retain capture, and straighten the final fraction of the
arc after a safe collision course has formed. This should capture no later
than the sampled velocity-course policy with no increase in command or yaw
activity. Falsify if capture is lost, the closest approach exceeds `0.75L`,
arrival or distance integral worsens materially, or terminal command/yaw
activity rises.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and biological burst redirect for terminal capture
source_mechanism: use observed course error for a bounded redirect, then release the burst into ordinary propulsion once the measured response establishes an intercept
transferable_invariant: gate strong curvature by normalized body-frame target/velocity geometry and release it continuously when the projected course enters a safe target corridor
nontransferable_details: published gains, dimensional frequencies, species-specific C-start shapes, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: retain the two-joint approach allocator and C-bend; compute projected miss distance from full target direction, distance, and body-frame velocity course, and use only its excess above a normalized corridor to gate the extra redirect
falsification: reject if the corridor release loses capture, delays approach, raises terminal command or yaw activity, or disrupts the coherent far-field wake
