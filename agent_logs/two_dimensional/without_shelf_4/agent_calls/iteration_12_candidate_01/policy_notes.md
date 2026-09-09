# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The current shared-prewarm sheet shows the fish held high and downstream of
  the four staggered cylinders while their interacting vortex streets develop
  through the target corridor. The sampled prewarm sheets are the certified
  common initial condition, so their flow structure cannot rank policies.
- Two current samples reproduce the plain `20.25 deg`, `0.67`-period,
  `0.25` bearing-rate-lead anchor exactly: capture occurs at `244.547`, mean
  distance is `6.452L`, and RMS relative crossflow/lateral force/moment are
  `0.13437/18.263/362.214`. Their released sheets show a self-propelled fish
  making a broad right-side loop and several wake-band reversals before an
  almost horizontal capture. Mean upstream head velocity is `-0.04443` versus
  mean local-flow x `-0.03649`, leaving `0.00793` controller-relative upstream
  transport; the route is wake-assisted, not passive advection.
- The strongest current sample changes only the normalized body-frame lateral
  counter-drift gate. Its sheet retains the broad acquisition turn and useful
  wake-band crossings, but reaches the target by rendered frame `25` rather
  than the anchor's frame `28`; there is no visible collision, domain exit,
  instability, or loss of the central-wake approach. Metrics confirm that this
  is a route gain: capture advances by `20.058` to `224.488`, mean distance
  falls by `0.141L` to `6.311L`, mean upstream head speed grows in magnitude
  to `-0.04895`, and RMS lateral force falls to `17.943`. RMS relative
  crossflow is essentially unchanged at `0.13427`, moment falls slightly to
  `361.014`, and total command energy drops from `170142.5` to `157453.9`
  despite a small rise in its per-time mean from `695.75` to `701.39`.
- The counter-drift sample keeps the gait feasibility boundary unchanged:
  maximum anterior acceleration remains `31.055 rad/time^2` under the `31.2`
  policy guard, maximum lateral target offset remains `4.293L`, and maximum
  joint states are effectively unchanged. The gain therefore comes from
  steering timing rather than more propulsion, a smaller excursion envelope,
  or actuator saturation.
- The current global heading-rate correction is a controlled negative contrast.
  It lowers moment to `357.284` but delays capture to `259.160`, worsens mean
  distance to `6.502L`, reduces controller-relative upstream transport to
  `0.00359`, and raises relative crossflow to `0.13610`. The inherited
  sign-asymmetric bearing-rate policy is the informative hard failure: its
  keyframes show repeated wide reversals and lost central-corridor retention;
  it misses the horizon at `3.632L` after a `3.290L` minimum, despite lower
  force and the same anterior acceleration maximum. These results support the
  translational gate, not another heading/bearing-rate decomposition or drive
  increase.

## Single candidate hypothesis

Adopt the evaluated counter-drift controller exactly as one candidate. Preserve
the demonstrated oscillator, posterior lag/damping, `10 deg` steering limit,
`0.30` bearing scale, `0.25` bearing-rate lookahead, and acceleration guard.
Clamp `state.velocity_body_U[2]` to `0.10` and add a `0.08` lateral lookahead
only when `bearing * lateral_velocity < 0`, with the same smooth normalization
by bearing scale and velocity bound. The correction is zero for stationary or
targetward translation and is bounded to `0.008 rad` before the steering
nonlinearity. It uses only normalized body-frame feedback and no coordinate,
route, clock, prescribed inflow, or remote wake probe.

Under the certified prewarm this candidate should reproduce capture near
`224.49`, mean distance near `6.31L`, positive controller-relative upstream
transport, and the sampled load/guard envelope. Falsify transfer on lost or
later-than-anchor capture, mean distance above `6.452L`, greater lateral
excursion, lower upstream margin, material crossflow/force/moment growth, guard
contact, or visible high-frequency steering chatter. Because only one fixed
wake phase has evaluated the gate, later workers should hold the `0.08/0.10`
bundle fixed and test a held-out wake phase before tuning its magnitude.
