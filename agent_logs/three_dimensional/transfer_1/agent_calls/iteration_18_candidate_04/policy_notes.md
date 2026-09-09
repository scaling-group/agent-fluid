# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, stable `capture`, and minimum/final
  distance `0.7466--0.7494L`. Three are exact-byte repeats of the assigned
  `dogfish3d_intercept_guarded_speed_reserve_v1` parent and arrive over
  `18.2050--18.6010T`; the distinct LOS-guarded controller arrives at
  `18.6065T`.
- Both rows of every combined keyframe sheet were inspected. Top-down
  vorticity shows self-propulsion with a coherent alternating reverse wake
  from early travel through capture, rather than passive advection or terminal
  coasting. The oblique Lambda2 row agrees: compact alternating three-
  dimensional structures remain attached to the traveling bend and persist
  into the capture corridor. The sheets show no collision, domain exit, or
  visible wake collapse. No sampled failure sheet is present, so inherited
  failure topology is used only through its recorded metrics and traces.
- Trace diagnostics distinguish terminal control from wake quality. The three
  parent repeats capture with final speed `0.827--0.908L/T`, action clamping
  `68.48--68.66%` / `70.64--70.97%`, speed-limit residence
  `10.44--10.63%` / `11.27--11.59%`, peak lateral force coefficient
  `0.0274--0.0292`, and peak yaw-moment coefficient `0.0157--0.0163`.
  Thus the carrier is productive and repeatable, while substantial steering
  and carrier superposition is still lost to the acceleration envelope.
- Inherited logs contain a new exact capture at `0.7486L`, but also lower-exit
  failures at `1.4601L`, `1.6860L`, and `1.7680L`. Together with the curated
  negative results for total-command governing and projected-miss replacement,
  this supports preserving the repeat-backed route/intercept observation and
  carrier rather than stacking another terminal geometry signal or suppressing
  cadence.

## Policy hypothesis

Keep the parent course/intercept logic, response release, traveling bend, and
sparse outward-carrier reserve unchanged. Redistribute the same signed
steering residual within each joint's locally observed beat: smoothly increase
it while that joint moves toward requested curvature and decrease it while the
joint returns. This is a state-feedback half-cycle asymmetry, not an external
phase or scalar gain-only edit. It should preserve mean turn direction and the
posterior phase lag while wasting less steering against the return half-cycle.

The candidate is falsified if it loses capture, changes far-field closure,
breaks or weakens the alternating wake, increases force/moment peaks or clamp
fractions materially, drives longer speed-limit residence, or produces a
terminal coast/overshoot. A useful result would retain capture and active
terminal propulsion while improving arrival, distance integral, or actuator
metrics relative to the three exact parent repeats.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and fish mean-curvature/half-cycle steering
source_mechanism: bounded half-cycle amplitude asymmetry superposed on a propulsive rhythm
transferable_invariant: turn by reallocating signed curvature authority within an observed beat while preserving the traveling carrier
nontransferable_details: published gains, dimensional cadence, robot/species kinematics, oscillator clocks, and task-specific paths
policy_translation: use joint velocity normalized by the joint-speed envelope to strengthen the existing body-frame route steering only while each joint moves toward requested curvature, and weaken it on that joint's return half-cycle
falsification: reject if capture reliability, wake coherence, distance closure, loads, clipping, or speed-limit residence worsens versus the exact parent repeats
