# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All sampled and inherited evaluations are finite, stable, direct-uniform
  still-water releases with `U_infinity=[0,0,0]`, no cylinders, and no
  prewarm. Every completed policy remains a `left_domain` failure, so the
  visible translation is self-propulsion and there is no success to claim.
- Both rows of the combined sheets were inspected. The `3.0031L` and
  `3.1135L` upper/left failures retain coherent alternating top-down streets
  and compact oblique Lambda2 structures but do not acquire the terminal
  route. The `1.5454L` mean-curvature and `1.7708L` energy-guarded policies
  turn below the target and keep the same lower-exit topology. These outcomes
  reject cadence, scalar route gain, wholesale mean curvature, and carrier
  attenuation as sufficient fixes in this regime.
- The assigned parent's motion-aligned duty allocation was intended to expose
  more actuator headroom than the inherited carrier-aligned pulse. Its own
  counterfactual predicted more surviving signed steering, but the completed
  CFD pass regressed from `0.9532L` to `1.2222L` and again exited through the
  lower boundary. The top-down and oblique rows show continued propulsion and
  an alternating terminal wake, so more surviving open-loop pulse is not
  sufficient to correct the flyby.
- Two inherited sibling logs sharpen the next test. Adding target-normal slip
  as posterior mean curvature reached `1.0561L` and retained the lower exit,
  whereas releasing direct shared steering after joint-compensated yaw
  response reached `0.9312L`, the best completed closest approach, while its
  carrier and three-dimensional wake remained visible. Thus observed response
  is more useful as a release condition than as another additive curvature
  channel, although the remaining `0.1812L` capture gap falsifies release of
  the unallocated shared-steering baseline as sufficient.

## One candidate mechanism

Preserve the normalized target-versus-achieved-course servo, cadence schedule,
state-feedback oscillator, posterior lag, and physical output clamp. Retain
the inherited carrier-aligned half-cycle allocation that produced the
`0.9532L` pass, then apply the evaluated joint-compensated yaw-response gate
only as a continuous release of that allocated steering inside `4L`. The
response gate never reverses the route request and never scales either carrier
acceleration. This is one small compatible combination: phase-selective
steering owns where bounded turn authority is applied, while measured yaw
response owns when that steering is released.

Expected test: the far trajectory remains identical to the carrier-aligned
baseline; near the target, the pulse initiates the established correct-sign
redirect and the response gate releases it into the still-active posterior
beat, reducing the below-target flyby enough to cross `0.75L` without raising
the acceleration envelope. Reject the mechanism if it loses early closure,
weakens the alternating wake, increases acceleration or joint-speed
saturation, fails to beat `0.9312L`, or retains the same lower-exit topology.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: initiate a bounded asymmetric redirect, then release steering when observed signed yaw response is established while propulsion continues
transferable_invariant: steering placement and steering release can be separated; measured turn response should release the bounded steering channel without suppressing the traveling wave
nontransferable_details: species-specific C-start shapes, published gains, robot kinematics, dimensional cadence, prescribed clock or vortex phase, and task-specific routes
policy_translation: use normalized body-frame target-versus-course error for the request, carrier acceleration for memoryless half-cycle allocation, and joint-compensated measured yaw response for terminal release under the two-joint clamp
falsification: reject if the policy does not beat the 0.9312L pass or improve termination while preserving early closure, carrier wake, joint reserve, and saturation

## Non-CFD verification

- The mandated Julia contract loaded the candidate and returned two finite
  accelerations within the owned `1800 deg/T^2` limit. A mirrored grid of far
  and terminal synthetic states produced exactly sign-reversed actions, and a
  deterministic scan found every direct `params.FIELD` reference in the
  object returned by `target_policy_params()`.
- Replaying only the composed control law on the completed response-release
  trace confirmed zero action difference outside `4L`; this establishes the
  intended far-field isolation, not a CFD outcome on the changed trajectory.
  The material-guidance and solver-boundary checks also pass. Formal CFD after
  this worker must decide the capture, wake, and saturation falsifiers.
