# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled evaluations satisfy the frozen-flow contract: direct
  uniform initialization, `U_infinity=(0,0,0)`, no cylinders, stable finite
  dynamics, and capture termination. Thus the fish is self-propelled rather
  than advected.
- Both combined visual rows were inspected for every sample. From roughly
  `4T` through capture, the top-down sheets show a substantial alternating
  signed wake laid down behind the fish, and the oblique Lambda2 sheets show
  compact alternating three-dimensional structures rather than wake collapse.
  The fish turns and translates toward the target; nothing immediately before
  capture indicates collision, instability, or passive coasting.
- The two exact speed-reserve samples (`solver_2d0a4a628957` and
  `solver_6b0e320e2f55`) capture at `0.7466--0.7494L` in
  `18.320--18.601T`. The two exact posterior-pulse samples, including assigned
  parent `solver_591f46d260e7`, capture at `0.7480--0.7492L` in
  `18.199--18.469T`. Their wake, mean-distance, load, and actuator envelopes
  overlap: action clamps on about `68.2--68.7%` / `70.6--70.9%` of rows,
  exact joint-speed residence is about `10.4--11.6%`, terminal speed is about
  `0.827--0.932L/T`, lateral force coefficient remains about
  `-0.029--0.030`, and yaw-moment coefficient about `-0.017--0.016`.
- No failed rollout keyframe sheet is present among the four sampled solver
  examples. The inherited parent guidance records the informative exact-pulse
  failures: the same posterior-pulse policy kept an active coherent wake but
  passed below at `1.2589L` and `1.3584L` and exited the lower boundary. The
  inherited score logs independently contain stable `left_domain` outcomes,
  including minima `0.8615L`, `1.4597L`, and `1.7276L`. These data make the
  diagnosed weakness terminal path sensitivity, not deficient propulsion.
- Across the accumulated exact-policy evidence, the speed-reserve baseline has
  four captures, whereas the posterior pulse has three captures and two
  failures with no secondary improvement in score, clipping, speed residence,
  loads, or wake structure. The pulse should therefore be removed rather than
  scalar-tuned.

## Architecture proposal

Retain the state-feedback traveling-bend drive, achieved-course outer loop,
intercept-compatible response release, additive phase-independent steering,
and sparse outward-carrier speed reserve. Remove the posterior wave-shape
acceleration and its parameter, restoring the exact evaluated
`dogfish3d_intercept_guarded_speed_reserve_v1` candidate. This makes the only
candidate-level change a rollback of the falsified phase-dependent terminal
mechanism; it does not alter far-field closure, cadence, route gain, steering
gain, actuator limits, or any environmental contract.

Expected result: recover the repeat-supported capture class while retaining
the visually coherent traveling wake and the sampled load/actuator envelope.
Falsify the rollback if the new exact evaluation loses capture, disrupts either
wake view, changes far-field closure, increases force/moment or actuator use,
or if additional exact posterior-pulse repeats establish reliable capture and
a distinct secondary benefit.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and robotic-fish mean-curvature turning
source_mechanism: posterior-lagged propulsive wave with bounded average bend for steering
transferable_invariant: preserve directional joint-to-joint phase lag and realize the slow route request as phase-independent mean curvature so steering does not erase thrust
nontransferable_details: published gains, dimensional beat rates, species-specific body envelopes, exact vortex phases, full-body splines, and task-specific routes
policy_translation: keep normalized body-frame target/course feedback, the two-joint state-feedback oscillator, posterior lag, and additive steering; remove the phase-synchronized posterior terminal bias while retaining conditional outward-carrier reserve
falsification: reject if exact replay misses, weakens the alternating top-down or oblique wake, changes far-field approach, or worsens actuator and load envelopes; reconsider only after repeated evidence favors a different observation-to-curvature mechanism
