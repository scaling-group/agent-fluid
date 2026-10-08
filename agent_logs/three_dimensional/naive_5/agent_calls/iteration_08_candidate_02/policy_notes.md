# Miss-conditioned terminal redirect candidate

## Visual and trace diagnosis before the edit

- All four sampled rollouts satisfy the Phase-2 evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. Their top-down rows show body-attached alternating vorticity
  streets and their oblique rows show three-dimensional Lambda2 trails, so the
  observed translation is self-propulsion rather than background advection or
  moving-window transport.
- The assigned parent, `solver_b6ed3f84ab58`, preserves an alternating wake but
  does not validate posterior half-cycle redistribution. It stays above the
  target, reaches only `5.386L`, and exits the upper margin at `26.043T`.
  Trace maxima of about `0.212` planar force and `0.0968` yaw moment are roughly
  ten times those of both redirect samples, while speed- and acceleration-cap
  residence are about `50.6%` and `47.1%`. The posterior transform is therefore
  discarded rather than strengthened.
- `solver_29282ff8dbf4` is the strongest semantic trajectory. Both visual rows
  retain a coherent wake through a broad downward redirect and past the target
  neighborhood. It reaches `0.8307L` at `27.484T`, only `0.0807L` outside the
  capture radius, with the head at `(8.294,9.938)L`, speed `0.661L/T`, small
  local flow, and no numerical breakup. At that instant the joints and commands
  are nearly static (`q=(-0.216,-0.136) rad`, `qdot=(-0.120,-0.039) rad/T`,
  `a=(0.236,-0.232) rad/T^2`) even though the velocity-projected miss remains
  about `0.82L`. The failure is a finite-course skim during a slowly completed
  redirect, not insufficient far-field propulsion.
- The intercept-qualified `solver_b3b6be8f076f` is the informative negative
  control. Globally withholding yaw release until an intercept exists reduces
  cap residence but settles into a same-side bend well before the target: at
  its `4.278L` minimum, joint rates and commands are already small, its wake
  remains high, and it exits through the upper margin at `27.066T`. Hence
  projected miss is useful as a terminal urgency signal but is falsified as a
  global veto on the response/bend release that created the productive turn.

## Policy hypothesis

Recover the sampled `solver_29282ff8dbf4` state-feedback traveling carrier,
posterior lag, calibrated steering side, and union of yaw-response and
joint-bend release. Add one continuous terminal-approach mechanism: when the
head is within a small body-length neighborhood and the measured body-frame
velocity projects outside a capture-width corridor, smoothly raise the natural
frequency of the bounded two-joint redirect, including its matched damping.
Outside that joint proximity-and-miss gate, the sampled policy is unchanged.
This uses current normalized distance, target vector, velocity, joint state,
and yaw response; it does not use time, world position, or a memorized route.

The expected signature is the same coherent downward approach, followed by a
faster controlled same-side bend between about `2L` and capture so the head
crosses `0.75L`. Falsify the mechanism if it worsens the `0.8307L` minimum,
recreates the early high/static trajectory of the global intercept veto,
destroys the alternating three-dimensional wake, or materially increases
angle/cap residence or the redirect family's approximately `0.022/0.010`
peak planar-force/yaw-moment levels.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish direction tracking, combined with terminal capture scheduling
source_mechanism: preserve rhythmic cruise and response-released turning, but increase bounded curvature-response urgency only when sensed proximity and projected course miss jointly indicate a near-target skim
transferable_invariant: final approach is a distinct continuous feedback regime in which course miss and remaining distance should schedule redirect responsiveness without suppressing the propulsive rhythm or far-field maneuver release
nontransferable_details: species-specific C-start stages, published gains and joint angles, clocked CPG phase, robot linkage geometry, dimensional cadence, exact vortex phases, capture route, and world coordinates
policy_translation: compute proximity from `distance_L`, projected miss from normalized body-frame target and velocity, smooth their conjunction, and use it only to interpolate the state-feedback redirect frequency and matched damping while retaining the sampled joint/yaw release logic
falsification: reject if the head does not beat `0.8307L`, if terminal urgency produces an early static bend or upper exit, if coherent propulsion is lost, or if actuator-limit residence and hydrodynamic loads materially exceed the sampled redirect class

## Non-CFD implementation audit

The policy is finite at zero speed, bounded by the existing acceleration
envelope, and exactly reflection-equivariant in a mirrored state test. Replayed
on the frozen `solver_29282ff8dbf4` observations, it is bit-for-bit identical
to that sampled controller at and beyond `2.25L`. Inside the terminal gate its
mean absolute command change is about `1.05 rad/T^2` and its maximum change is
`4.42 rad/T^2`; frozen-state acceleration-clamp incidence is unchanged both
within the gate and over the full trace. This verifies locality, activity, and
headroom only; it is not a claim about the unevaluated CFD response.
