# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The common prewarm sheet shows mature interacting streets from all four
cylinders reaching the held fish at the upper-right release pose.  It is a
shared initial condition, not candidate-specific evidence.  In the successful
released sheets, the fish immediately redirects, retains a traveling bend, and
self-propels on a broad diagonal through the developed wake before entering the
target circle.  The base bearing-biased carrier reaches the `0.75L` boundary in
`93.032` release time with `0.940` progress and `4.033L` mean distance.  Its
mean body motion differs materially from mean local flow, confirming controlled
upstream motion rather than passive advection.

All four sampled successful policies preserve essentially this same topology.
Their arrival times span only `93.027` to `93.071`, all hit both `260 deg/time`
joint-rate caps and both `1800 deg/time^2` acceleration caps, and their RMS
lateral force/moment remain near `95.5/1147`.  The terminal oscillator-amplitude
envelope is therefore not useful effort relief: relative to the base, it leaves
arrival unchanged and changes command-energy and power means by less than
`0.001%`, while force and moment increase slightly.  The lateral-miss blend is
also not preferred because it delays capture to `93.071`.

The bounded terminal bearing-rate sample is the only sampled variant with a
small coherent approach benefit: it reaches in `93.027`, lowers command-energy
mean from `972.515` to `972.399`, lowers power mean from `66.869` to `66.835`,
and slightly lowers RMS relative crossflow from `0.167731` to `0.167635`.
However, it was combined with the empirically inert amplitude envelope and its
RMS force/moment increase slightly, so the evidence supports isolating the rate
mechanism rather than claiming load relief.

The inherited direct terminal acceleration-limiter rollout is the informative
failure.  Its keyframes match the successful diagonal route through the first
five samples, but it stops just outside capture (`0.803L` minimum), terminates
`unstable_dynamics` at `93.095`, and increases RMS crossflow/force/moment to
`0.611/16457/157725` even though command-energy mean falls to `967.13`.  Both
joint-rate and acceleration caps are still reached.  Thus lowering aggregate
command effort by suppressing the carrier near capture is not a safe proxy for
lower FSI load, and the inherited proposal to test direct smooth terminal
limiting is falsified.

## Policy hypothesis

Retain the assigned parent's `0.55`-period, `28 deg` joint-state carrier, its
posterior lag, and its bounded `8 deg` body-frame bearing-to-mean-curvature
steering.  Add exactly one localized state-feedback mechanism: inside `2.5L`,
smoothly add a bounded portion of `bearing_window_rate` to current bearing
before the existing curvature saturation.  Opposite-sign bearing and bearing
rate reduce a converging turn; same-sign values reinforce a worsening redirect.
The correction is identically zero outside the approach region and does not
attenuate either joint's propulsion command.  Omitting the ineffective
amplitude envelope makes this an ablation of the sampled useful signal rather
than another coupled terminal edit.

Falsify the candidate if any pre-approach command differs from the assigned
parent, target capture is delayed or lost, terminal path/crossflow does not
improve, or the sampled small arrival/effort benefit disappears.  Treat higher
force or moment as a rejection even if arrival improves.  No force, moment, or
wake-flow residual is added because the compact evidence lacks sign-resolved
event history for calibrating one.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal target capture
source_mechanism: sensor feedback modulates steering around a preserved rhythmic propulsive carrier
transferable_invariant: separate the proven carrier from a bounded target-error-rate correction and localize anticipatory steering to the final approach
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: preserve the two-joint joint-state oscillator and bearing bias; within a smooth normalized-distance gate add bounded body-frame bearing-window rate before the existing mean-curvature saturation
falsification: reject if far-route commands change, capture is delayed or lost, terminal trajectory or crossflow does not improve, or lateral force and moment increase

## Pre-evaluation verification

The prescribed Julia contract check passes and every direct `params.FIELD`
reference is exercised against the returned parameter object.  A separate
algebraic check against the assigned-parent implementation confirms identical
two-joint actions across sampled joint states, bearings, and bearing rates for
every `distance_L >= 2.5`; extreme near-target bearing/rate cases remain finite.
The guidance semantic validator and solver edit-boundary check also pass.  No
CFD rollout was run; this candidate's physical outcome remains evidence for a
later worker.
