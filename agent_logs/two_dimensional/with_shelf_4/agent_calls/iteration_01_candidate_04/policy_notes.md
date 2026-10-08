# Multi-wake candidate diagnosis

## Evidence read before the edit

The assigned parent is the deliberately target-blind state-feedback oscillator
with a lagged posterior target.  The only sampled solver result is a finite but
informative seed failure; there is no sampled successful or near-successful
controller and no inherited candidate-specific optimizer log in this fresh
lineage, so no positive controller comparison is available to claim.

The common held-fish prewarm sheet shows the four developed, interacting vortex
streets and the target between the second-row wakes.  In the released sheet the
fish starts at the upper right on a broadly useful diagonal, but rapidly turns
into a steep downward path, never enters the target corridor, and exits the
bottom boundary after only `50.1269` release-time units.  The scalar diagnostics
support that reading: head displacement is only `-3.545L` upstream but
`-13.300L` cross-stream; distance improves transiently to `8.615L` and then
regresses to `12.123L`; progress is only `0.0243`.  Both joints also reach the
`260 deg/time` velocity cap and both acceleration commands reach the
`1800 deg/time^2` cap.  Thus the seed demonstrates some upstream propulsion,
but not target-directed yaw regulation, and its nominal `0.55`-period,
`28 deg` oscillator demands more velocity and acceleration than the actuator
envelope can realize cleanly.

## Candidate hypothesis

Retain a state-encoded traveling bend, but make target bearing the slow route
error for a bounded mean-curvature setpoint shared across both joints.  Use the
windowed bearing rate only as damping so steering authority relaxes while the
bearing is converging.  Center the anterior oscillator and posterior lagged
wave on that setpoint, rather than adding an easily clipped scalar acceleration.
Choose an intrinsic gait whose sinusoidal velocity and acceleration estimates
fit within the hard limits.  This should keep the initial useful upstream
propulsion while preventing the sustained downward departure.  Falsify the
mechanism if the next rollout retains the same bottom-exit topology, turns with
the wrong sign, or loses upstream progress despite reduced saturation.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking by mean tail-beat or curvature bias layered on a rhythmic gait
source_mechanism: bounded target-relative mean-curvature modulation with sensor-feedback damping
transferable_invariant: a slow persistent body-frame bearing error can bias the mean of a propulsive traveling bend while the oscillatory component continues to supply thrust
nontransferable_details: published gains, robot linkage geometry, species-specific amplitudes and frequencies, clock-driven CPG phase, and prescribed routes
policy_translation: map bounded body-frame bearing plus windowed bearing-rate damping to joint curvature setpoints, then track them through the existing two-joint state-feedback oscillator and lagged posterior target
falsification: reject or reverse the translation if bearing grows, the fish again exits the bottom boundary, joint saturation remains persistent, or upstream target progress collapses

## Pre-evaluation contract audit

A joint-only numerical integration of the candidate law (not CFD and not new
rollout evidence) under constant bearings from `-0.5` to `0.5` rad kept the
anterior/posterior oscillations near `20/21 deg`, angular speeds near
`148/154 deg/time`, and raw accelerations near `1092/1141 deg/time^2`.  These
are below the formal `45/260/1800` envelope and preserve slight posterior
amplitude emphasis.  This audit checks only command realizability; it cannot
validate the hydrodynamic steering or target-reaching hypothesis.
