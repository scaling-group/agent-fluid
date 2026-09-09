# Candidate diagnosis and hypothesis

## Assigned evidence

- The assigned parent guidance is the fresh-lineage baseline and there are no
  inherited optimizer notes. The only sampled solver is
  `solver_2ce3d25ef5a2`, so its finite approach and terminal failure phases are
  the available within-rollout comparison rather than evidence from two
  distinct candidates.
- The rollout satisfies the experiment contract: direct uniform initialization
  in still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
- Both the top-down vorticity row and oblique Lambda2 row show self-propelled
  motion with a coherent alternating posterior wake. The fish is not merely
  advected, and propulsion persists as the moving window follows it.
- Distance falls from `12.3277L` to `6.1266L`, while representative trajectory
  samples move from `(21.0,14.0)L` through `(15.11,7.96)L`. The same trajectory
  then curls downward: heading grows from `0.741` rad near the closest approach
  to `1.383` rad, distance rises to `10.5423L`, and the head crosses the lower
  virtual boundary at `y=0.308L` at `26.13T`. The visual turn and the trajectory
  therefore agree that useful thrust survives but target alignment does not.
- Joint samples remain rhythmic and finite through termination, but a direct
  command audit shows that the raw joint-1 and joint-2 accelerations exceed the
  `1800 deg/T^2` (`31.416 rad/T^2`) envelope on `70.3%` and `76.8%` of logged
  steps. Their maxima are `73.44` and `125.48 rad/T^2`; the corresponding rate
  limits are reached on about `8.2%` and `10.0%` of steps. Thus the coherent
  wake and initial progress coexist with persistent actuator clipping, and the
  failure cannot support retaining the imported command scale unchanged.

## Policy hypothesis

Preserve the naive seed's state-feedback anterior oscillator and lagged
posterior target because the wake and initial closing progress demonstrate a
useful traveling bend, but slow its natural frequency enough that the nominal
restoring acceleration fits the fixed 3D envelope and bound the final command
inside that envelope. Replace the inherited 2D champion's many coupled
direction-specific gates with one normalized body-frame target-to-curvature
mechanism: use lateral target displacement divided by distance as the route
error, oppose measured recent yaw rate, bound the result, and express it as a
mean posterior tangent while leaving oscillatory phase in joint state. This
should brake the post-closest-approach downward curl without sacrificing the
coherent propulsive wake or relying on hidden clipping. Reject the mechanism if
the rollout retains the same lower-boundary exit, fails to beat `6.1266L`,
loses the alternating wake and initial closing segment, or spends substantial
time at the policy command bound.

bookshelf_consulted: true
source_domain: biological and robotic-fish mean-curvature direction tracking
source_mechanism: target-error-driven mean bend superposed on a posterior-lag propulsive rhythm
transferable_invariant: preserve the traveling bend while persistent target error requests bounded curvature and measured yaw rate damps overshoot
nontransferable_details: published gains, species kinematics, clocked CPG phases, exact vortex phases, and task-specific routes
policy_translation: normalize target_body_L[2] by distance_L, combine it with turn_rate_recent in body-frame feedback, and shift the two-joint posterior tangent without time or world coordinates
falsification: reject if target progress no longer reaches 6.1266L, the coherent alternating wake collapses, policy commands remain persistently bound, or the same downward left_domain topology remains

## Non-CFD command-envelope check

A 20T joint-only integration using the episode time step rejected the initial
`0.75T`, `24 deg` draft because its posterior rate still reached the fixed
`260 deg/T` limit. The retained `0.90T`, `14 deg` oscillator with a bounded
`12 deg` mean posterior tangent produced no acceleration, rate, or angle clips
for straight and constant normalized lateral-error probes through `|e_y|=1`.
Across those dry probes the largest policy command was about `21.4 rad/T^2`,
the largest rate about `208.3 deg/T`, and the largest angle about `43.3 deg`.
This check validates only algebraic envelope compatibility; it is not CFD
evidence of thrust, turning authority, or target success.
