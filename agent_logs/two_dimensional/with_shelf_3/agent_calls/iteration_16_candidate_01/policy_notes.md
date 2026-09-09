# Multi-Wake Policy Candidate Notes

## Evidence diagnosis

The common prewarm sheet shows a developed, interacting four-cylinder wake
around the held fish; it is common initial-condition evidence rather than a
policy result.  The released sheets for the assigned prefill
(`solver_d30b14ced2df`) and sampled best (`solver_9d2afbdabdbe`) both show a
compact self-propelled diagonal transit.  A coherent body-generated traveling
wake persists from release to capture, the fish enters the developed cylinder
wake, and neither sheet shows a detour, collision precursor, or collapse into
passive advection.  The sampled set contains no failure sheet: the other two
examples are code- and metric-identical repeats of the prefill, so no failure
topology can be inferred from these images.

The numerical comparison is correspondingly narrow.  Relative to the prefill,
the sampled response-supervised policy reaches the target at `32.31796` rather
than `32.33997`, lowers mean distance from `1.637732L` to `1.637411L`, command
energy from `46033.42` to `45988.36`, power proxy from `3517.99` to `3513.69`,
and RMS moment from `888.56` to `881.45`.  It raises RMS lateral force from
`65.12` to `65.52` and finishes slightly farther from the target center
(`0.74715L` versus `0.74583L`), while both runs terminate by first capture.
RMS relative crossflow is essentially unchanged (`0.24372` versus `0.24339`),
so the small improvement is not evidence of wake avoidance.  Three independent
prefill evaluations reproduce the same metrics exactly, making the changed
fixed-snapshot outcome meaningful but not evidence of held-out wake robustness.

Inherited logs provide the broader boundary.  The earlier direction-selective
headroom gate captured at `32.73048` with lower force/moment loads
(`56.29/800.58`); supervising that gate with coherent target closure produced
the prefill's faster `32.33997` capture but spent some load relief
(`65.12/888.56`).  The sampled best adds response supervision without altering
the base curvature or traveling wave and moves only slightly farther along that
same speed/load tradeoff.  This is evidence for a guarded mechanism replay, not
for another scalar increase or a wake-cancellation residual.

## Policy hypothesis

Materialize the sampled best's compact architectural change on the assigned
prefill: infer a developed gait from normalized anterior joint phase-space
activity, then require both target-signed recent heading response and shrinking
body-frame bearing before yielding the optional posterior half-cycle residual.
Combine that response confidence with coherent target-closure confidence.  Do
not yield the target-signed mean curvature or unit-gain lagged traveling wave.
This should preserve the proven direct capture and propulsion topology while
testing whether the small arrival, distance-integral, effort, and yaw-moment
improvements reproduce.  Falsify the candidate if it loses target capture or
the compact route, arrives no earlier than the prefill, raises load or
saturation without a navigation benefit, or fails under a later held-out wake.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG and response-gated burst/redirect turning
source_mechanism: modulate a rhythmic steering residual only after joint activity and observed targetward response confirm that redirection is working
transferable_invariant: gate the transition between redirecting and yielding by normalized gait state plus body-frame target-response feedback
nontransferable_details: published CPG gains, robot morphology, dimensional timing, species kinematics, exact wake phase, and task-specific routes
policy_translation: preserve bounded bearing-to-curvature steering and the lagged two-joint wave; use normalized joint activity, target-signed heading rate, and shrinking bearing only to supervise the optional posterior half-cycle residual
falsification: reject if direct capture or the traveling wake is lost, if the fixed-snapshot arrival and distance integral do not improve, or if force, moment, effort, or saturation rise without a compensating navigation benefit
