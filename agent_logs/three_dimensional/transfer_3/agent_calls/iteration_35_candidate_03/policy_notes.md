# Closing-speed carrier-envelope candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct-uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture at `18.6560--18.7330T`. I inspected the assigned
  actuator-consistent parent and the best-score exact repeat from release to
  capture in both rows of their combined sheets. The top-down views show
  body-led translation and a coherent alternating caudal-vorticity street by
  `4T`; the oblique views show compact Lambda2 structures shed behind the
  moving tail. Neither view shows passive advection, wake breakup, collision,
  boundary contact, or numerical instability.
- The exact `dogfish3d_actuator_consistent_tail_phase_v1` policy now has three
  current captures: `18.6725T` twice and `18.7330T` once. Its score spans
  `-0.13362-- -0.13142` and mean distance spans `2.01959--2.02129L` without a
  semantic route change. Helpful-moment amplitude relief captures at
  `18.6560T`, only `0.0165T` ahead of the fastest exact instances and well
  inside same-policy timing spread. The nearly indistinguishable wake sheets
  and low local-flow regime near `0.018U` support preserving the route rather
  than adding another instantaneous physical-response allocator.
- The inherited nonlinear recoil-observer result is the informative failure
  unavailable in the current all-capture quartet: it retains a coherent
  body-led wake but delays capture to `22.0110T`, raises mean distance to
  `2.31828L`, and loses early speed (`0.267U` at `4T` versus
  `0.536--0.539U`). Its lower posterior occupancy and loads therefore came
  from weakening productive route/carrier coupling, not better yaw response.
  The available recent-rate window is only about `0.0385T`, so it cannot
  honestly supply the missing causal `0.55T` beat history.
- The replicated route remains fast through terminal approach: distance falls
  from `2.68--2.71L` at `16T` to `1.21--1.25L` at `18T`, with body speed still
  about `0.72--0.77U`; at capture the assigned parent still travels about
  `0.74U`, carries roughly `0.50 rad` bearing error, and commands the posterior
  acceleration limit. This supports testing bounded approach-envelope relief,
  while the previous `1.62L` pass and `49.742T` capture from memoryless
  near-range curvature allocation rule out coasting or withdrawing steering.

## Policy hypothesis recorded before the policy edit

Preserve the evaluated normalized bearing-plus-LOS-rate guidance, distributed
C-bend, response-reversing half-cycle steering, persistent same-side posterior
phase recruitment, and feasible-action projection. Add one continuous
approach mechanism: when normalized range is near, radial closing speed is
already above the observed approach scale, and the target is still forward in
the body frame, contract only the anterior Van der Pol amplitude parameter by
at most `20%`. Natural frequency, posterior lag, all steering centers, phase
recruitment, and command limits remain unchanged. The smooth state-feedback
envelope should reduce late carrier energy and posterior clipping without the
premature coast or curvature withdrawal already falsified by inherited
range-only allocation.

Support requires capture with coherent wakes in both views, arrival no later
than the replicated exact-policy upper bound of `19.0520T`, mean distance no
greater than `2.02129L`, and either posterior acceleration-limit occupancy
below `75.46%` or force/moment RMS below `0.01331/0.00693` without moving
saturation upstream. Falsify the mechanism if it loses capture, delays beyond
that bound, weakens early translation or either wake, repeats a near pass/loop,
or merely changes load within exact-policy spread.

An offline replay of only the new memoryless gate on the three completed exact
traces verifies its intended scope without predicting the altered CFD result.
Relief first exceeds `1%` at `15.65--15.68T` and `2.92--2.94L`, then peaks at
only `16.3--16.9%`; it is therefore negligible during early wake formation and
never reaches the configured `20%` bound on those source trajectories.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture control
source_mechanism: retain a productive rhythmic carrier while target-relative feedback contracts its amplitude envelope during an already-fast near approach
transferable_invariant: route feedback and the directed posterior-lagged traveling bend remain active while normalized body-frame range and radial closing speed bound only surplus carrier effort
nontransferable_details: published CPG gains, dimensional frequencies, species or robot kinematics, prescribed gait envelopes, exact vortex phases, and task-specific routes
policy_translation: multiply only the anterior oscillator amplitude parameter by a smooth bounded function of `distance_L`, body-frame target-forward fraction, and target-relative closing speed; preserve the two-joint LOS route, posterior phase actuator, and physical limits
falsification: reject on lost or delayed capture, weaker wake or early propulsion, a repeated near-pass loop, upstream saturation transfer, or effort changes that do not separate from the exact-policy replication envelope

The current candidate's CFD evaluation occurs only after this worker exits and
is not used as evidence here.
