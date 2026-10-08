# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes. It is common initial-condition
evidence, not a policy difference. The three byte-identical strongest sampled
policies immediately redirect toward the target, sustain a coherent posterior
traveling bend, and follow a compact upstream-left diagonal into the
second-row wake corridor. Each reaches the `0.75L` boundary after `43.9505`,
with `2.1391L` mean distance and score `-0.259248`. Mean fish velocity
`(-0.2471,-0.1020)` versus mean local flow `(-0.1342,-0.1556)` confirms a
material self-propelled upstream component rather than passive advection.

No current sampled solver is a semantic failure. The inherited right-domain
exit remains the available failure contrast: it never forms a coherent
targetward traveling bend, moves `(+2.175,-0.869)L`, and exits after `16.7914`
with negative progress and only `0.0154U` streamwise motion relative to local
flow. This bounds the edit away from larger static curvature or global carrier
relief. Among recent finite candidates, an anterior angle-plus-rate phase lead
keeps the direct topology but delays capture to `43.9780` and raises RMS
force/moment from `49.44/701.26` to `53.18/736.58`. Replacing the gate with
posterior rate alone is more negative: capture moves to `44.5885`, mean
distance to `2.1656L`, command mean to `1210.50`, and force/moment to
`58.31/808.59`, while all joint-rate and acceleration caps remain active.
The alignment-gated outward-rate projection lowers loads to `44.86/663.89`
but delays capture to `44.0220` and still touches every cap; adding a measured
moment residual then delays capture to `45.1935` and raises loads to
`71.51/957.29`. The images agree: the slower residual variant retains the
route but has a stronger late body and wake excursion. These completed
variants provide neither a new success nor a better termination class, so the
structured protocol calls for a different allocation mechanism rather than
another release, rate, moment, or scalar-gain threshold.

## Policy hypothesis before the edit

Preserve the incumbent anterior oscillator, bounded body-frame bearing
command, steering authority, posterior lag, and approach taper. Change one
mechanism: replace the head-position-only half-cycle phase measurement with a
bounded two-joint phase observer. First use the incumbent head gate only to
remove the known steering center from the measured posterior state. Then map
posterior angle and frequency-normalized rate back through the configured lag,
combine that estimate with anterior angle and rate, and use the resulting
realized collective phase to place the unchanged posterior half-cycle bias.
The mapping exactly recovers the incumbent phase for an ideal tracked harmonic
traveling bend, so it adds no fixed phase lead and no steering or propulsion
gain; it differs only when the posterior response falls out of the commanded
two-joint wave under wake loading or saturation.

Expected evidence is retention of the immediate redirect and direct target
capture with better mean distance or arrival than the position-only incumbent,
without the load increase seen for anterior phase lead or posterior-rate-only
allocation. Reject the mechanism if capture is delayed or lost, the route
develops a dogleg or boundary-exit topology, force/moment or command effort
rises without better progress, or the evaluated actions remain effectively
identical to the incumbent. If rejected, later workers should not tune the
observer normalization floor or blend weights; they should test a separately
evidenced actuator-allocation mechanism.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and elongated-body reactive propulsion
source_mechanism: allocate bounded asymmetric posterior steering by observed multi-joint oscillator phase while preserving a lagged traveling bend
transferable_invariant: phase-selective steering should follow the realized state-feedback traveling wave, retain cycle-average target curvature, and avoid a fixed clock or copied wake phase
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact duty ratios, vortex phases, cylinder coordinates, and task-specific routes
policy_translation: reconstruct a normalized collective phase from body-frame target demand and the two joint angles and rates, then use it only to time the incumbent bounded posterior half-cycle bias
falsification: reject if direct capture is delayed or lost, mean distance does not improve, or effort, saturation, force, or moment increase without better target progress

## Pre-evaluation verification

The required guidance-semantic and solver-boundary checks pass, and static
schema inspection resolves every direct `params.FIELD` reference to a field
returned by `target_policy_params()`. A no-CFD sweep over `15,625` combinations
of range, both bearing signs, both joint angles, and both joint rates returns
finite actions with a bounded phase gate; zero bearing is exactly
incumbent-equivalent, the zero equilibrium remains zero, and the new observer
changes posterior action in `12,500` deliberately distorted states while
leaving anterior action unchanged. On `1,440` ideal tracked-wave phase samples,
the reconstructed gate and posterior action recover the incumbent to
`1.42e-14` maximum error. The prescribed Julia include/assertion could not run
because no Julia executable is installed in this environment; this is a
runtime limitation rather than a detected policy failure. No formal CFD was
run, so performance remains a hypothesis for post-worker evaluation.
