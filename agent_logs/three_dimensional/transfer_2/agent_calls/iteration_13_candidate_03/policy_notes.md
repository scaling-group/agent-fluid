# Intercept-corridor anterior-release candidate

## Evidence diagnosis before the policy edit

- All four sampled episodes are valid direct-uniform releases in still water:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window shifts,
  stable dynamics, and `capture` termination. They capture in
  `19.701--19.850T`, score from `-0.22093` to `-0.21598`, and hold mean distance to
  `2.10565--2.11128L`; there is no semantic failure, so the weakest sample is
  an informative mechanism underperformer rather than a failed trajectory.
- The combined sheets for the strongest plain LOS-led sample
  (`solver_1b6df3d71b19`) and the slowest full-response-release sample
  (`solver_788c33d018cf`) were inspected in both rows from release to capture.
  Their top-down rows show self-propelled motion and coherent alternating
  vorticity, not background advection, followed by nearly the same sharp late
  hook. Their oblique rows retain compact three-dimensional Lambda2 structures
  along the route without wake collapse, collision, or instability. The
  response gate produces no visibly useful new wake or trajectory class.
- Metrics agree with that visual diagnosis. The plain LOS-led controller
  captures at `19.706T`, mean distance `2.10594L`, and score `-0.21598`.
  Releasing the whole redirect after aligned yaw response is slower at
  `19.850T`, `2.11128L`, and `-0.22093`; preserving posterior redirect while
  releasing only the anterior part remains in the repeat band at
  `19.701T/2.10634L/-0.21675` in the current sample and
  `19.877T/2.11339L/-0.22325` in inherited completed evidence. Therefore
  detected yaw is not a supported release trigger, and the posterior redirect
  should remain continuous.
- The range-aware projected-miss sample preserves the coherent/load class and
  captures at `19.723T`, mean distance `2.10565L`, and score `-0.21601`, close
  to the strongest plain sample and better than the executable repeat band.
  Its reconstructed inertial projected miss shrinks from about `1.14L` at
  `3L` range to `0.38L` at `2L`, `0.13L` at `1.5L`, and `0.21L` at capture,
  while heading error and yaw continue evolving. This separates an already
  viable collision course from mere yaw response and provides a geometric
  release observation.
- Command/load histories delimit the experiment: the four current samples
  have no joint-angle-limit residence, peak planar force/yaw-moment
  coefficients near `0.023/0.0132`, and roughly `32.5--35.3%` residence above
  90% of the smooth `31 rad/T^2` command bound. The inherited independent
  `8L--2L` middle-field course allocation was already tested with half-cycle
  steering and remained a coherent capture but regressed to
  `19.872T/2.11310L/-0.22294`; another distance window or scalar course gain is
  not the next mechanism.

## One-candidate hypothesis

Start from the evaluated range-aware intercept geometry while preserving the
state-feedback carrier, posterior lag, fore/aft-aware body-frame target vector,
distance/closing drive relief, route half-cycle steering, LOS-rate lead,
continuous posterior redirect, and soft command limit. Add one smooth
body-length-normalized intercept-corridor gate only to the transient anterior
redirect bias. Keep full anterior burst outside the corridor, retain a bounded
floor inside it, and never gate the posterior contribution. This should retain
the middle-field intercept and coherent traveling wave but release excess
anterior C-bend once the measured velocity course already passes close enough
to the target, producing a less hooked final arc without coasting.

Expected signature: retain capture and both coherent wake views, remain in the
established force/moment and joint-margin class, and improve arrival or mean
distance beyond the `19.888T/2.11324L` semantic repeat while making the final
trajectory visibly less hooked. Falsify the mechanism if capture is lost; the
arrival/integral falls in or below the repeat band without a useful path
change; the gate produces chatter or premature coasting; or command residence,
joint margin, loads, and wake coherence regress.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish direction tracking
source_mechanism: release a transient anterior C-start-like bend after an observed viable intercept while retaining the posterior propulsive rhythm
transferable_invariant: transient anterior curvature should continuously relax once measured target-relative course geometry indicates that extra burst authority is no longer needed, while posterior wave support remains active
nontransferable_details: species kinematics, published gains, dimensional burst duration, exact capture radius, clock phase, exact vortex phase, and task-specific route or coordinates
policy_translation: compute bounded projected miss from normalized body-frame target and velocity course, use a smooth corridor weight only on anterior redirect bias, and leave posterior redirect and all two-joint bounds continuous
falsification: reject if capture, arrival, distance integral, terminal path shape, wake coherence, force and moment class, joint margin, or command headroom regress against the plain and range-aware sampled controllers
