# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the common initial condition: the held fish is
  above and to the right of four developed, interacting vortex streets, while
  the `0.75L` target circle lies between the two downstream wakes. Candidate
  differences therefore begin only after release.
- The target-blind seed is visibly self-propelled but not navigational. Its
  repeated traveling bend drives a steep lower-boundary path, with head
  displacement `(-3.545,-13.300)L`; it briefly reaches `8.615L` distance but
  exits after `50.127` released time units at `12.123L`. Both joint speeds and
  accelerations hit their hard limits, while RMS force/moment are
  `21.943/541.704`, so more oscillator gain is not a supported repair.
- The assigned static-curvature parent survives the full `300` units and lowers
  RMS moment to `270.955`, but its keyframes show compact far-right loops rather
  than useful translation. Head motion is only `(-1.187,-3.785)L` and the
  closest/final distances remain `10.276/10.484L`. Inherited notes also record
  two simpler mean-bias descendants that leave the downstream boundary within
  `16.63`--`19.87` units. Together these outcomes reject another scalar change
  to a persistent shifted oscillator center.
- Both sampled zero-mean, target-dependent half-cycle policies are semantic
  improvements: they traverse the wake and reach the tight target circle. The
  slower bearing-rate-damped variant arrives at `268.488` with mean distance
  `8.038L`, RMS crossflow/force/moment `0.107/17.158/273.010`, and joint maxima
  safely below the hard envelope. The faster variant arrives at `179.218` with
  mean distance `5.041L`, but its sheet shows a more strongly curved,
  correction-rich path and its RMS crossflow/moment rise to `0.133/338.915`;
  peak acceleration `30.402 rad/time^2` is also close to the `31.416` cap.
  Thus the faster gait and single coherent half-cycle steering wave are worth
  preserving, while a small damping mechanism has evidence to target excess
  route correction without suppressing propulsion.

## Policy hypothesis

Use the faster successful zero-mean radial oscillator and posterior-lagged
traveling bend as the candidate scaffold. Keep bearing-driven half-cycle
amplitude asymmetry as the only mean-turn mechanism, but combine current
body-frame bearing with a softly bounded windowed bearing rate. While bearing
is converging, its rate opposes the persistent route request and releases some
asymmetry; when it is diverging, it adds corrective authority. This is a
state-feedback steering damper, not a fixed route, a wake-phase command, or a
scalar-only gait increase.

The candidate is supported if it retains target capture and the strong
upstream displacement of the faster sampled success while shortening visible
zigzags or lowering yaw/crossflow load. It is falsified if it loses capture,
delays arrival toward the slower `268.488` result, recreates the far-right loop
or a domain exit, reverses the turn sign, collapses the posterior traveling
wave, or increases cap contact and loads.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and asymmetric-flapping CPG control
source_mechanism: sensor-driven half-cycle amplitude asymmetry with direction-error-rate damping layered on a propulsive rhythm
transferable_invariant: persistent body-frame direction error can select the stronger beat half-cycle while measured convergence releases steering authority without removing the alternating posterior-lagged wave
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, clock-driven phase, exact vortex phases, cylinder layout, and source-task routes
policy_translation: infer beat side from normalized anterior joint angle and velocity, drive its amplitude asymmetry with bounded bearing plus bounded windowed bearing rate, and retain the zero-mean state-feedback oscillator and lagged second-joint target
falsification: reject if rate damping removes the sampled fast policy's target capture or upstream thrust, preserves correction-rich motion and high yaw load, causes wrong-sign steering, or produces looping, domain exit, instability, or persistent actuator clipping

## Pre-evaluation actuator audit

A joint-only semi-implicit integration of the candidate equations (not CFD and
not rollout evidence) tested bearings `-0.5`, `0`, and `+0.5 rad` crossed with
windowed bearing rates `-0.25`, `0`, and `+0.25 rad/time`. Across those checks,
peak joint angles were approximately `23.11/19.66 deg`, speeds
`192.10/163.84 deg/time`, and raw accelerations
`1770.35/1447.31 deg/time^2`, within the `45/260/1800` envelope. This audit
establishes only bounded, sign-responsive joint realization; wake loads, path
damping, arrival time, and target capture remain the formal rollout tests.
