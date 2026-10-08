# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The current and inherited shared-prewarm sheets show the same held fish at
  the upper-right release pose while the four staggered-cylinder vortex streets
  develop across the target corridor. This is the certified common initial
  condition, not evidence for ranking controller changes.
- The four current samples reduce to two reproduced policies. The plain
  `20.25 deg`, `0.67`-period, `0.25` bearing-rate anchor captures at `244.547`
  with score `-4.439` and mean distance `6.452L`. Its sheet shows a broad
  far-field loop and several alternating wake-band crossings before a nearly
  horizontal target entry. Mean upstream velocity is `-0.04443` against mean
  local-flow x `-0.03649`, so its `0.00793` controller-relative upstream
  margin confirms self-propulsion rather than passive advection.
- Adding only the sampled `0.08` sign-gated body-frame lateral-velocity
  lookahead keeps the useful wake crossings but reaches the target by rendered
  frame `25` rather than the anchor's frame `28`. Metrics confirm a route and
  load improvement: capture advances to `224.488`, mean distance falls to
  `6.311L`, controller-relative upstream margin rises to `0.01602`, and RMS
  lateral force/moment fall from `18.263/362.214` to `17.943/361.014`.
  Maximum lateral target offset remains `4.293L` and maximum anterior
  acceleration remains `31.055 rad/time^2`, below the `31.2` policy guard, so
  the gain is steering timing rather than more thrust or a smaller envelope.
- The otherwise identical inherited `0.10` continuation is the strongest
  available visual negative contrast; every available sheet terminates in
  target capture, so this workspace contains no hard-failure keyframe sheet.
  The `0.10` sheet adds a pronounced late lower-corridor excursion and captures
  only at `263.346`. Mean distance worsens to `6.974L`, score to `-4.949`, RMS
  force to `18.310`, and controller-relative upstream margin falls to
  `0.00931`; total command energy rises from `157453.9` to `186311.4`.
  Unchanged `4.293L` maximum lateral offset and `31.055` anterior acceleration
  isolate a phase-sensitive steering regression rather than saturation or
  propulsion loss. The inherited logs' horizon miss remains the hard boundary:
  it lost corridor retention despite lower load and unchanged propulsion.
- The inherited aligned heading-rate continuation is an independent negative:
  it captures at `265.298` with `7.822L` mean distance, negative
  controller-relative upstream margin `-0.00282`, and higher RMS force
  `18.886`. Direct heading-rate feedback and increasing the instantaneous
  counter-drift magnitude therefore have no remaining positive evidence.

## Single candidate hypothesis

Preserve the demonstrated oscillator, posterior lag/damping, `10 deg` steering
limit, `0.30` bearing scale, `0.25` bearing-rate lookahead, `0.10` lateral-
velocity clamp, and `31.2` acceleration guard. Change only
`lateral_velocity_lookahead` from `0.08` to `0.07`. At the existing velocity
clamp this reduces the maximum added pre-nonlinearity correction from `0.008`
to `0.007 rad`; the correction remains smoothly sign-gated to target-away
translation and is exactly zero for stationary or targetward lateral motion.
It uses only normalized body-frame feedback and no coordinate, route, clock,
prescribed inflow, or remote wake probe.

This one-sided bracket tests whether the demonstrated `0.08` gain sits just
below the timing cliff exposed by `0.10`. The expected result is retained
capture and central-wake acquisition with less late counter-steering, mean
distance no worse than `6.311L`, arrival no later than `224.488`, positive
controller-relative upstream transport, and no load or guard regression.
Falsify it on a later or lost capture, mean distance above the `0.08` sample,
larger late corridor rebound, upstream margin below `0.01602`, greater
crossflow/force/moment, higher effort, guard contact, or visible switching.
The current worker claims no CFD result; held-out wake phase remains required
before treating any instantaneous counter-drift magnitude as transferable.
