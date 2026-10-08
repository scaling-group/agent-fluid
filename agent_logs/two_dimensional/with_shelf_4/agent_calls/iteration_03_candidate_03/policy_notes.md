# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common held-fish prewarm sheet shows four fully developed, interacting
  vortex streets before release. The fish begins above and far to the right of
  the second-row target, outside the organized target-wake region; this is the
  shared initial condition, not candidate-specific evidence.
- The target-blind seed generates visible upstream propulsion but immediately
  turns into a steep bottom exit. It terminates after `50.13` units with head
  displacement `(-3.55,-13.30)L`, regresses from `8.61L` minimum to `12.12L`
  final distance, and reaches both velocity and acceleration caps. Its RMS yaw
  moment is `541.70`, so more oscillator gain is not a credible repair.
- The amplitude-regulated static-curvature policy improves the termination to
  a full `300`-unit horizon and lowers RMS yaw moment to `270.96`, but its
  keyframes show repeated far-right loops. It moves only `-1.19L` upstream and
  never gets closer than `10.28L`. This confirms the inherited negative lesson
  that stable mean-curvature bias is not sufficient route control.
- Two independent zero-mean, target-dependent half-cycle-asymmetry policies
  both reach the target. The current prefill arrives in `268.49` units with
  `8.04L` mean distance, `273.01` RMS moment, and actuator maxima below the
  hard envelope. The stronger sampled variant arrives in `179.22` units with
  `5.04L` mean distance and `-10.93L` upstream displacement. Its sheet shows a
  continuous alternating wave and a broad targetward arc into the interacting
  wakes rather than either failed loop/exit topology. This is replicated
  semantic evidence that half-cycle steering preserves useful propulsion.
- The faster success pays for its shorter route with higher command effort and
  yaw load: command-energy mean rises from `351.62` to `653.20`, RMS moment
  from `273.01` to `338.91`, and peak accelerations from about `19.5` to
  `30.4 rad/time^2`, still just below the `31.42` cap. At `L=64`, the two
  successful RMS moments normalize to about `0.067` and `0.083` in
  `moment_z_L2`. That observed range supplies a defensible soft scale for a
  small yaw-load residual; it does not establish a wake phase or route.

## Candidate hypothesis

Use the faster successful zero-mean oscillator and posterior-lagged bend as the
propulsion/route scaffold, with its period relaxed slightly to leave verified
acceleration headroom. Preserve its bearing-driven half-cycle mechanism, then
add one compact capability: a bounded residual from normalized body yaw moment.
The known bend-yaw sign maps positive measured moment to the bend request that
opposes positive yaw acceleration. Multiply the residual by unused route-command
headroom, so persistent bearing error retains authority and moment feedback
becomes material mainly near alignment or during a wake kick. This separates
slow target geometry from fast alternating disturbance without a clock, fixed
wake phase, cylinder probe, or global coordinate.

The candidate should retain target reach and the faster policy's upstream
translation while reducing unnecessary yaw reversals or load near the target.
Falsify it if it loses success, materially delays arrival, raises RMS moment or
cap contact, suppresses the alternating posterior wave, or reproduces the
far-right loop, bottom exit, or downstream exit topology. Because the formal
CFD runs after this worker exits, these remain rollout tests rather than claims.

bookshelf_consulted: true
source_domain: adaptive wake swimming and sensor-modulated robotic-fish rhythmic control
source_mechanism: separate slow target-route modulation from a small bounded fast yaw-disturbance residual
transferable_invariant: persistent body-frame target geometry should own route steering while measured alternating yaw load may use only the remaining steering authority to reject disturbances
nontransferable_details: published gains, dimensional beat settings, species kinematics, robot linkage geometry, prescribed vortex phase, cylinder layout, and source-task routes
policy_translation: keep the sampled state-feedback half-cycle controller, normalize moment by the successful-rollout RMS range, and blend a smooth moment residual through route-command headroom before modulating the two-joint traveling bend
falsification: reject if the residual overrides far-field bearing, slows or loses capture, increases moment or actuator clipping, destroys posterior lag, or repeats a sampled failed trajectory topology

## Pre-evaluation actuator audit

A joint-only semi-implicit integration (not CFD or rollout evidence) exposed
that copying the `0.72` successful period exactly could reach about
`1901 deg/time^2` under one fixed negative-bearing condition. Relaxing the
period to `0.76` retained the same mechanism while a grid of bearings and
constant/sinusoidal normalized moments kept joint angles, speeds, and raw
accelerations inside the `45/260/1800` envelope; the representative worst
case was about `25.4 deg`, `194 deg/time`, and `1740 deg/time^2`. This verifies
bounded state-feedback realization only. Hydrodynamic load rejection, route
shape, arrival, and target capture remain tests for the later formal rollout.
