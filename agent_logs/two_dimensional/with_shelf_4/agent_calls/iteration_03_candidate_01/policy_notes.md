# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common held-fish prewarm sheet shows the same developed, interacting
  four-cylinder streets for every candidate. The fish is released above and
  to the right of the target, outside the organized second-row wake corridor;
  this common initial flow does not support a phase- or route-specific command.
- The target-blind seed is visibly self-propelled but not navigated. Its strong
  body wave drives the head `(-3.55,-13.30)L`, reaches only `8.61L` minimum
  target distance, then exits the lower boundary after `50.13` units. Both
  joints reach the velocity and acceleration caps, while RMS yaw moment is
  `541.70`; more oscillator gain is contradicted by this failure.
- The assigned-parent mean-curvature controller removes the early exit and
  cuts RMS moment to `270.96`, but its released sheet remains a compact
  far-right loop for the full `300`-unit horizon. It advances only `-1.19L`
  upstream and finishes `10.48L` from the target. Inherited notes also report
  two simpler static-curvature variants leaving the right boundary in under
  `20` units, so another persistent joint-center bias is not supported.
- Both sampled zero-mean half-cycle-asymmetry policies are semantic successes.
  The slower two-joint modulation reaches the target in `268.49` units with
  RMS relative crossflow/moment `0.1067/273.01`; the simpler anterior
  modulation reaches it in `179.22` units with mean distance `5.04L`, but at
  higher RMS relative crossflow/moment `0.1333/338.91` and mean command energy
  `653.20`. Their sheets show sustained upstream translation into the wake
  instead of the seed's lower exit or the parent's far-right loop. This is
  positive evidence to preserve zero-mean half-cycle steering, not to reopen
  static-curvature or scalar-only gait tuning.
- The faster success still shows sharp yaw changes in the upper-right approach
  and while crossing alternating wake structures. Since target reaching is
  already established but its yaw load exceeds the slower success by about
  `24%`, a small load-feedback residual is a narrower test than changing the
  propulsive scaffold. The available `moment_z_L2` is body-length normalized;
  the successful rollout's RMS world-frame moment corresponds to an order
  `0.08` normalized scale at `L64`, which is suitable only for soft saturation,
  not exact load cancellation.

## Candidate hypothesis

Preserve the faster successful state-feedback radial oscillator, posterior
lag, and bearing-driven anterior half-cycle asymmetry. Add one compatible
wake-disturbance mechanism: a small bounded term from normalized instantaneous
yaw moment to the half-cycle turn request. Target bearing continues to own the
slow route; the load residual can only trim the active beat while a wake event
is applying torque. It has no clock, fixed wake phase, cylinder coordinates,
or persistent offset, and the zero-mean propulsive equilibrium is unchanged.

The next formal rollout should retain target success and upstream translation
while reducing sharp wake-driven yaw and RMS moment without increasing arrival
time enough to lose the faster policy's advantage. Reject the mechanism if it
turns with the wrong sign, suppresses the traveling bend, recreates looping or
domain exit, misses the target, raises command/load metrics, or merely reacts
to self-generated beat torque without improving trajectory smoothness.

bookshelf_consulted: true
source_domain: biological and computational wake-adaptive swimming in organized vortex streets
source_mechanism: separate slow route regulation from bounded sensor-mediated response to fast alternating wake loads
transferable_invariant: persistent body-frame target geometry should set the route while a much smaller normalized yaw-load signal may reject fast disturbances without cancelling the propulsive wave
nontransferable_details: published gains, species and robot kinematics, single-cylinder Karman-gait phase, recurrent-network state, dimensional frequencies, exact vortex phases, cylinder coordinates, and source-task routes
policy_translation: retain bearing-controlled state-inferred half-cycle amplitude asymmetry and add one softly saturated `moment_z_L2` residual to its turn request before the existing amplitude envelope
falsification: reject if target success or upstream thrust is lost, arrival materially slows, the residual has the wrong yaw sign, RMS moment and visible yaw reversals do not fall, or joint/load saturation increases

## Pre-evaluation actuator audit

A joint-only semi-implicit parity calculation of the candidate equations (not
CFD and not rollout evidence) kept the zero-bearing gait near `+/-22 deg`,
`192/164 deg/time` peak joint speeds, and `1675/1428 deg/time^2` peak raw
accelerations. Applying constant normalized moments of `+/-0.08` shifted the
anterior half-cycle extrema by only about `0.35 deg` per side and kept peak raw
acceleration near `1702 deg/time^2`. Constant bearings of `+/-0.5 rad` retained
the inherited mirrored `-18.3/+23.1 deg` anterior response and stayed near
`1770 deg/time^2`, below the `45/260/1800` envelope. This checks bounded
equation realization only; the missing Julia runtime prevented the configured
contract execution, and formal hydrodynamic sign, target success, arrival, and
load reduction remain for the later EvE rollout.
