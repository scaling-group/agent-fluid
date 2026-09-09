# Capture-corridor redirect candidate

## Evidence diagnosis before the policy edit

- All four sampled episodes satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window shifts,
  stable dynamics, and `capture` termination. They capture in
  `19.701--19.850T`; the useful comparison is therefore path and control
  semantics rather than success versus failure.
- Both rows of the strongest finite sample (`solver_1b6df3d71b19`) and the
  informative full-redirect-release underperformer (`solver_788c33d018cf`)
  were inspected from release to termination. Their top-down sheets show
  coherent alternating self-propelled wakes and nearly identical sharp
  terminal arcs; their oblique Lambda2 sheets show compact three-dimensional
  structures along those routes, with no wake collapse or instability. The
  visual evidence does not support changing the propulsive carrier.
- Metrics agree. The strongest plain LOS-led sample captures at `19.706T`,
  mean distance `2.10594L`, and score `-0.21598`. Full redirect release slows
  to `19.850T`, `2.11128L`, and `-0.22093`; anterior-only release remains in
  the same outcome class at `19.701T`, `2.10634L`, and `-0.21675`.
- The assigned parent's inherited notes proposed a bounded projected-miss
  blend after several release/phase gates failed to improve semantics. Its
  completed rollout also remains in the repeat band: `19.723T`, mean distance
  `2.10565L`, score `-0.21601`, and the same visible terminal hook. Thus the
  blend preserved capture but did not establish a useful new trajectory.
- A sharper geometric signature survives all four trajectories. On first
  crossing `2L` range, their projected straight-line misses are only
  `0.38--0.45L`, safely inside the `0.75L` capture radius, and closing speeds
  remain `0.74--0.75L/T`. Nevertheless yaw rate rises from about
  `0.24--0.26rad/T` there to `0.36--0.47rad/T` at capture, while projected
  miss crosses through zero and ends at `0.15--0.21L` on the opposite side.
  The extra redirect is continuing after the measured velocity course already
  predicts capture; this is stronger evidence for a geometric release
  condition than for another scalar course-error or response gain.

## One-candidate hypothesis

Start from the assigned range-aware policy but restore the evidenced plain
course-error redirect outside terminal capture. Preserve the joint-state
carrier, posterior lag, full signed body-frame target geometry,
distance/closing drive allocation, LOS-rate lead, half-cycle route steering,
and soft command bounds. Add one smooth, reflection-invariant capture corridor:
compute signed projected miss from normalized body-frame target and velocity,
and continuously release only the extra two-joint redirect when the target is
ahead/closing and the predicted miss lies within a conservative sub-radius.
The baseline target steering and propulsive traveling wave remain active.

Expected signature: retain capture and coherent wake structure, begin relaxing
the terminal C-bend near `2L`, reduce miss sign reversal and late yaw growth,
and improve arrival or mean distance beyond the executable repeat band without
raising load, joint-limit, or command-limit residence. Falsify the mechanism
if capture is lost, the fish passes outside the target, arrival/mean distance
regress without a useful path change, or wake coherence, loads, or actuator
headroom worsen.

bookshelf_consulted: true
source_domain: terminal interception guidance and sensor-modulated robotic-fish direction tracking
source_mechanism: observation-gated release of a bounded terminal turn into a continuing posterior-lagged propulsive rhythm
transferable_invariant: when measured target-relative geometry and velocity already predict interception inside a tolerance corridor, release only extra steering continuously instead of sustaining a turn that can overshoot the collision course
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, exact capture radius, clock phase, vortex phase, world-frame coordinates, and task-specific routes
policy_translation: form projected miss from normalized body-frame `target_body_L` and `velocity_body_U`, use closing geometry to gate a smooth corridor weight, and apply it only to the existing anterior and posterior redirect contributions under the two-joint state-feedback contract
falsification: reject if capture, arrival, distance integral, terminal path shape, coherent wake, load class, joint margin, or command headroom regress against the plain LOS-led repeat band
