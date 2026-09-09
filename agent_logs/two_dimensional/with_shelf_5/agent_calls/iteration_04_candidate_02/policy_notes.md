# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The shared prewarm sheet shows the common initial condition: four mature,
interacting cylinder wakes reach the held fish at the upper-right release
location. In the inherited seed evidence, the target-blind oscillator is
largely advected into a lower-boundary curl after `50.127` released time; it
moves `(-3.545,-13.300)L`, reaches only `8.615L` minimum target distance, and
hits both joint-rate and acceleration caps. The sampled `12 deg` bias failure
provides a complementary boundary: excessive static mean curvature suppresses
the visible traveling bend and exits right after `16.791` with negative
progress. More scalar drive or more static bend is therefore unsupported.

All four current solver samples instead reach the `0.75L` target boundary in
about `93.03` released time. Their sheets show the same useful behavior: an
immediate correct-sign redirect, self-propelled upstream-diagonal traversal
through the developed wake, a sustained traveling body wave, and monotone
terminal entry. The baseline bearing-biased carrier has mean/final distance
`4.0325/0.7487L`, relative streamwise motion `0.0773U`, and RMS lateral
force/moment `95.50/1146.61`, but both joints still attain the `260` and `1800`
degree-based rate and acceleration caps.

Three terminal mechanisms leave that visible topology and aggregate behavior
essentially unchanged. The amplitude taper has identical `93.032` arrival and
`972.5145` mean command energy; blending steering toward lateral miss delays
arrival to `93.071` while mean command energy changes by only `0.20`; and a
bounded bearing-rate lead arrives at `93.027` with mean effort changed by only
`0.12`. Their RMS force and moment do not improve. Direct terminal acceleration
relief is a concrete negative result: despite slightly lower mean command and
power, it misses the capture radius (`0.803L` closest approach), becomes
`unstable_dynamics` at `93.095`, and raises RMS force/moment to
`16457/157725`. Terminal scalar shaping is thus either dynamically inert or
unsafe when it removes the restorative authority needed for capture.

## Policy hypothesis

Start from the strongest simple successful controller: the `0.55`-period,
`28 deg` joint-state carrier, `8 deg` bounded body-frame bearing bias,
posterior lag, and the already sampled smooth amplitude taper. Remove the
ineffective lateral-miss blend. Add one new actuator-distribution mechanism:
apply part of the posterior steering bias only on the half-cycle whose anterior
bend has the same sign as the target turn. A smooth joint-state gate identifies
that half-cycle without time or external phase. Reduce the always-on posterior
bias by the approximate cycle-average of the new boost, so the test changes
half-cycle distribution rather than simply increasing mean curvature.

The anterior oscillator and its route command remain exactly the demonstrated
ones. The posterior target still carries the demonstrated velocity-dependent
lag; only its target-favored half-cycle receives extra bounded curvature. The
expected benefit is a more effective turn/thrust allocation that shortens the
diagonal approach or reduces effort without the wave collapse seen with a
larger static bias. Falsify it if the initial redirect or broad route changes
adversely, capture is lost or delayed, joint/load peaks grow without better
distance progress, or the terminal metrics remain indistinguishable from the
four sampled successes.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological turning by asymmetric tail beats
source_mechanism: target-directed half-cycle asymmetry superposed on a traveling propulsive bend
transferable_invariant: persistent body-frame turn error can redistribute posterior steering toward the target-favored joint-state half-cycle while retaining an oscillatory carrier and approximately preserving cycle-average curvature
nontransferable_details: published duty ratios and gains, clocked CPG phase, robot or species kinematics, dimensional frequencies, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: retain the sampled bearing-biased anterior state oscillator and posterior lag; use the sign of bounded bearing request times anterior wave state to gate a parameter-owned posterior curvature boost, offset by a lower always-on posterior share
falsification: reject if traveling-wave propulsion or the demonstrated diagonal topology is lost, capture is delayed or missed, or effort and force/moment loads grow without improved arrival or distance integral

## Pre-evaluation verification

At saturated turn request, the always-on posterior share is `3.2 deg` and the
favored-half boost is bounded by `4 deg`; its approximate half-cycle mean adds
`2 deg`, recovering the sampled controller's `5.2 deg` cycle-average posterior
bias without increasing the anterior `8 deg` limit. The boost is exactly zero
at zero bearing, uses only joint state for phase, and every active constant is
returned by `target_policy_params()`.

The prescribed guidance semantic check, Julia policy-contract check, and solver
editable-boundary check pass. An additional state sweep across distance,
bearing, joint angle, and joint velocity returns finite actions and confirms a
zero-action equilibrium at zero bearing and zero joint state. No CFD rollout
was run; the mechanism and its performance claims remain hypotheses for the
post-worker evaluation.
