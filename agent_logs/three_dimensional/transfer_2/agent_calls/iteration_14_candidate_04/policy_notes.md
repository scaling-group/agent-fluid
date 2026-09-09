# Sequential terminal-redirect release candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen direct-uniform contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window shifts,
  stable dynamics, and `capture` termination. Their narrow outcome band is
  `19.701--19.723T`, mean distance `2.10438--2.10634L`, and score
  `-0.21449-- -0.21675`, so the useful distinction is terminal geometry and
  control allocation rather than success versus failure.
- Both rows of the combined sheets for the sampled leader
  (`solver_12a0e2e3745e`) and least favorable finite capture
  (`solver_86d4118b6d89`) were inspected from direct release to termination.
  The top-down rows show self-propelled progress with compact, coherent
  alternating vorticity and a shared sharp terminal hook. The oblique rows
  show organized three-dimensional Lambda2 structures along both routes,
  without wake collapse, passive advection, collision, or instability. This
  evidence supports preserving the traveling-wave carrier.
- Metrics agree with the visual diagnosis. The sampled prefill's projected-
  miss blend plus anterior-only corridor release leads at `19.701T`, mean
  distance `2.10438L`, and score `-0.21449`, with mean absolute commands
  `(18.53,17.32) rad/T^2`, near-command-bound residence `(36.6%,33.4%)`, peak
  planar force/moment about `0.0241/0.0129`, and maximum joints
  `(30.4,33.4) deg`. The other three captures stay in the same load, joint,
  and command class; there is no evidence for changing propulsion, bounds, or
  scalar redirect gain.
- The leader already has a safe measured intercept at first crossing `2L`:
  closing speed is `0.742L/T` and reconstructed projected miss is about
  `-0.503L`, inside the `0.75L` capture radius. It crosses `1L` at `19.365T`
  with projected miss `0.028L`, but filtered yaw rate is still `0.511rad/T`;
  capture follows at `19.701T` with miss `0.150L` and yaw `0.482rad/T`.
  The anterior release improved the score/integral but did not remove the
  visible hook or late yaw growth.
- The assigned parent's completed range-gated release of both redirect shares
  is the relevant negative/positive control. It still captured, and reduced
  terminal yaw to about `0.012rad/T`, but activated around `2L` and regressed
  to `19.784T`, mean distance `2.10886L`, and score `-0.21870`. Therefore
  posterior release can straighten the terminal trajectory, but releasing it
  through the whole `2L--1.5L` approach sacrifices useful intercept authority.

## One-candidate hypothesis

Preserve the sampled leader exactly through the middle approach: the bounded
joint-state oscillator, posterior lag, signed body-frame target geometry,
distance/closing drive allocation, projected-miss blend, LOS-rate lead,
half-cycle steering, anterior intercept-corridor release, and soft command
limit. Add one sequential terminal-straightening gate. Only after range is
inside `1.2L`, closing remains positive, and the velocity-course projected miss
remains inside the existing normalized intercept corridor, smoothly release
the extra posterior redirect toward capture. Baseline route curvature and the
posterior propulsive wave remain active; the gate has no clock or route state.

Expected signature: retain capture, the leader's early trajectory, coherent
wake, and load/actuator class while beginning posterior release only after the
observed `1L` safe-intercept state; reduce terminal yaw and the visible hook
without the assigned parent's roughly `0.08T` delay. Falsify if capture is
lost, capture time or mean distance falls outside the sampled repeat band,
the late hook/yaw is not reduced, or wake coherence, force/moment class, joint
margin, or command headroom regresses.

bookshelf_consulted: true
source_domain: biological burst-turn recovery and sensor-modulated robotic-fish direction tracking
source_mechanism: continuously release transient turning curvature into a posteriorly supported propulsive rhythm once observed interception is secure
transferable_invariant: separate intercept acquisition from terminal straightening, and remove only excess steering after body-frame range, closing, and projected course jointly indicate a safe capture corridor
nontransferable_details: published gains, species-specific kinematics, dimensional burst timing, exact vortex or clock phase, fixed coordinates, exact capture radius, and task-specific routes
policy_translation: retain the sampled anterior release and traveling-wave controller, then use normalized `distance_L`, positive `closing_speed_L`, and body-frame `target_body_L`/`velocity_body_U` projected miss to release only posterior redirect inside a later smooth gate
falsification: reject if capture, arrival, distance integral, terminal yaw or path shape, coherent wake, load class, joint margin, or command headroom regress against the sampled leader and assigned-parent boundary
