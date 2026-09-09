# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the common held fish above and downstream of
four mature, interacting cylinder wakes; this is fixed initial-condition
evidence rather than a policy difference. The three byte-identical incumbent
samples all show an immediate targetward redirect, a coherent posterior
traveling bend, and a compact upstream-left diagonal through the developed
wake corridor. They reproducibly reach the `0.75L` target boundary after
`43.9505`, with `2.1391L` mean distance. Mean fish velocity
`(-0.2471,-0.1020)` differs materially from local flow
`(-0.1342,-0.1556)`, so upstream closure is active swimming rather than
passive advection.

No current sampled solver is a semantic failure, so the required visual
contrast uses that best finite success and the inherited right-domain exit.
The failure never develops a traveling targetward bend, moves
`(+2.175,-0.869)L`, and exits after `16.7914` with negative progress
`-0.1471`; its mean streamwise motion differs from local flow by only
`0.0154U`. Together with inherited reports of lower-boundary seed advection,
this rules out increasing static curvature or weakening the carrier globally.

The sampled posterior rate guard is the informative physical tradeoff. Its
released sheet preserves the incumbent's direct trajectory topology and
target success, but arrival moves to `44.2420` and mean distance to `2.1450L`.
In exchange, mean command falls from `1207.8` to `1197.1`, RMS lateral
force/moment fall from `49.44/701.26` to `43.46/649.26`, and posterior peak
rate falls just below the `260 deg/time` cap while reversal authority is
preserved. The inherited clean no-taper ablation had unchanged arrival and
nearly identical `49.45/701.31` loads, so the guard, not taper removal,
explains the useful load change.

The assigned parent's small-bearing, response-conditioned release of the
posterior steering boost is a concrete negative result. It arrives only
`0.055` earlier than the incumbent, yet raises mean command to `1216.2`, RMS
crossflow from `0.2111` to `0.2166`, and RMS force/moment to
`55.12/764.85`; both joint rate and acceleration still hit their caps. Its
sheet remains direct but shows a visibly stronger late body/wake excursion.
Thus alignment-gated relief is not sufficient by itself: the relief must act
on the evidenced redundant outward rate drive rather than on target-directed
half-cycle steering.

## Policy hypothesis before the edit

Preserve the incumbent anterior oscillator, bearing-to-curvature command,
target-favored posterior half-cycle boost, posterior lag, and approach taper.
Add one direction-aware posterior rate-envelope mechanism. The existing
bounded `turn_request` provides a continuous normalized alignment gate:
steering demand above a parameter-owned fraction leaves the evaluated redirect
exactly unchanged, while small bearing activates the sampled guard. The guard
removes only the part of posterior acceleration that would push an already
near-envelope joint rate farther outward; acceleration that reverses the joint
remains untouched.

This is a structural test rather than a carrier-gain retune. Expected evidence
is preservation of the incumbent's early redirect and `43.9505`-class direct
capture, with posterior peak rate below the cap and force/moment between the
incumbent and the globally guarded sample. Falsify the mechanism if arrival
regresses toward or beyond `44.2420`, the direct path changes, target capture
is lost, posterior rate still reaches the cap, or load/effort remain
indistinguishable from the incumbent. If it is inert, later workers should not
tune the alignment exponent or rate threshold; they should test a separately
evidenced feedback primitive.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish burst-to-cruise direction control
source_mechanism: preserve posterior traveling-wave authority during a large target-directed redirect, then return toward cruise by relieving only redundant outward actuator drive after alignment
transferable_invariant: large body-frame direction error retains full bounded posterior propulsion and steering, while small observed direction error can gate removal of acceleration that pushes an already near-limit rate farther outward without weakening reversal
nontransferable_details: published gains and rate envelopes, dimensional timing, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: derive a smooth alignment gate from bounded body-frame bearing demand and apply it only to the sampled posterior outward-rate projection; retain the joint-state oscillator, half-cycle steering, and reversal acceleration
falsification: reject if the early direct redirect weakens, capture is delayed or lost, posterior cap contact remains, or force/moment and command evidence do not improve relative to the incumbent

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass.
Static schema inspection found all `15` direct `params.FIELD` references among
the `15` fields returned by `target_policy_params()`, and exactly one candidate
policy file exists. A deterministic sweep of `30,375` combinations spanning
approach distance, both bearing signs, both joint angle limits, both joint-rate
limits, and rates just inside and outside the guard returned finite actions,
alignment/rate gates in `[0,1]`, zero change at large steering demand, zero
change to every reversal acceleration, and zero action at the zero state. The
prescribed Julia include/assertion could not start because this runtime has no
`julia` executable; this is an environment limitation, not a detected policy
failure. No formal CFD was run.
