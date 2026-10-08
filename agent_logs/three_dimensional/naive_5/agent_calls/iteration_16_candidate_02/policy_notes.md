# Sampled inertial line-of-sight response candidate

## Visual and trace diagnosis before the edit

- All four sampled evaluations use direct uniform still-water initialization
  (`U_infinity=(0,0,0)`) with no cylinders or prewarm.  In both the top-down
  mid-plane row and oblique body/Lambda2 row, each fish translates with its
  body-attached wake, so the route differences are controlled self-propulsion
  rather than moving-window advection.
- The assigned parent `solver_b723810e389c` preserves a coherent alternating
  wake and reaches `0.875770L` at `27.269T`, but the visible route passes above
  the target and continues to a left-domain exit at `39.925T`.  Its terminal
  curved-gait reactivation therefore does not cross the `0.75L` capture
  boundary despite a low-load approach (peak planar force/yaw moment
  `0.02142/0.00979`).
- The sampled inertial line-of-sight response in `solver_0ce6bb065e92` is the
  only semantic success: its top-down path turns through the target while the
  oblique row retains an organized three-dimensional wake, producing capture
  at `27.605T` and `0.749769L`.  At capture it is still self-propelled at about
  `0.642L/T`; terminal force and moment are small, and rollout peaks
  (`0.03397/0.01548`) remain well below the high-load failure class.  The
  policy does touch the `45 deg` angle boundary for three joint samples and
  spends about `11.8%` of joint samples at the speed cap, so this is a thin,
  evidenced success rather than proof of robust terminal margin.
- The other sampled mechanisms remain informative failures.  The
  intercept-qualified C-start (`solver_b3b6be8f076f`) releases onto an upper
  curl and exits after reaching only `4.278L`; the course-biased yaw-rate
  closure (`solver_12fc3441a636`) exits the upper boundary at `6.268L`, with
  about `21.7%` joint-speed-cap residence and larger peak loads.  Neither
  scalar redirect/release logic nor stronger yaw-rate closure rivals the
  line-of-sight response.

## Policy hypothesis

Replace the parent's unevidenced terminal curved traveling wave with the exact
sampled line-of-sight response controller.  Preserve the productive carrier,
posterior follower, large-error same-sign redirect, and approach miss veto.
Use body-frame bearing-window rate plus recent body turn to reconstruct
inertial line-of-sight rotation, compare a bounded desired yaw magnitude with
phase-rejected measured yaw, and add only the positive response deficit through
the established anterior half-cycle channel while closing and within joint
angle headroom.  Copying the evaluated mechanism and parameters intact makes
this iteration a test of whether the sampled semantic success transfers from
the assigned parent, not a scalar tuning experiment.

The falsifiable expectation is repeat capture inside `0.75L` near `27.6T`
with the same coherent wake and without materially exceeding the sampled
limit/load profile.  Reject the transfer if it returns to `left_domain`, loses
the late downward route rotation, worsens the `0.749769L` crossing, creates
persistent angle contact, or materially raises speed/acceleration residence,
force, or yaw moment.  Even on repeat capture, do not infer held-out robustness
until a later evaluation demonstrates more clearance than the current
`0.000231L` capture margin or succeeds on varied initial conditions.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and bounded CPG residual control
source_mechanism: preserve a productive rhythmic carrier while measured target-line rotation requests only the steering response still missing from observed body turn
transferable_invariant: add bounded state-feedback steering authority only for a positive measured response deficit, without cancelling adequate turning or replacing the traveling-wave carrier
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional timing, exact vortex phases, world coordinates, and task-specific routes
policy_translation: normalized body-frame bearing-window rate plus recent turn rate reconstruct inertial line-of-sight rotation; phase-rejected yaw, closing speed, carrier speed, joint phase, and angle headroom gate a bounded joint-1 half-cycle residual
falsification: reject if capture does not repeat, line-of-sight correction fails to rotate the trajectory through the target, the coherent carrier changes, or joint-limit, load, and actuator-limit exposure materially exceed the sampled success
