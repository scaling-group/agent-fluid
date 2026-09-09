# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes. Because the sheet is byte-identical
across all four sampled solvers, it is common initial-condition evidence rather
than a policy comparison.

Three byte-identical sampled carriers immediately redirect toward the target,
maintain a coherent posterior traveling bend, and swim a compact upstream-left
diagonal through the developed wake corridor. They reproducibly reach the
`0.75L` boundary after `43.9505`, with `2.1391L` mean distance. Mean fish
velocity `(-0.2471,-0.1020)` differs materially from mean local flow
`(-0.1342,-0.1556)`, especially upstream, so closure is active swimming rather
than passive advection. Their joint rates and accelerations nevertheless touch
both hard envelopes, and RMS relative crossflow, lateral force, and yaw moment
remain `0.2111`, `49.44`, and `701.26`.

No sampled solver is a semantic failure. The most informative sampled contrast
adds anterior-rate phase lead to the target-favored posterior half-cycle gate.
Its keyframes retain essentially the same direct topology and it still captures
at `43.9780`, but RMS crossflow rises to `0.2136`, force to `53.18`, moment to
`736.58`, and mean command to `1209.49`; all joint-rate and acceleration caps
remain active. Thus a rate-shifted half-cycle is not evidenced load relief, even
when the route and scalar score change only slightly.

Inherited optimizer logs provide the stronger structural comparison. A bounded
yaw-moment residual added after alignment still captured, but delayed arrival to
`45.1935`, increased mean distance to `2.1965L`, and raised RMS force/moment to
`71.51/957.29`; instantaneous normalized moment is therefore not a calibrated
disturbance sign for this carrier. In contrast, a direction-aware posterior
outward-rate projection preserved the direct topology and captured at `44.0220`
with only `0.0027L` more mean distance than the carrier, while reducing RMS
crossflow to `0.2102`, force to `44.86`, and moment to `663.89`. Its posterior
rate still touched the cap, so the supported interpretation is distributed load
shaping rather than peak-rate avoidance.

## Policy hypothesis before the edit

Preserve the sampled anterior oscillator, bounded body-frame bearing curvature,
target-favored posterior half-cycle, posterior lag, and distance-conditioned
amplitude envelope. Add only the inherited direction-aware posterior rate
projection. Large bearing demand leaves the evaluated redirect exactly
unchanged. After alignment, the projection removes only acceleration that
pushes an already near-envelope posterior rate farther outward; every reversal
acceleration remains available.

Expected evidence is the same compact direct capture near `44.02` released time
with RMS force and moment below the unguarded carrier and phase-lead variant.
Falsify the mechanism if capture is lost or materially delayed, the direct route
weakens, reversal authority is reduced, or the prior load reduction does not
reproduce. Continued rate-cap contact alone does not falsify the evidenced load
benefit and should not trigger scalar threshold tuning.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish burst-to-cruise direction control
source_mechanism: preserve a posterior traveling wave during a large target-directed redirect, then return toward cruise by relieving only redundant outward actuator drive after alignment
transferable_invariant: retain bounded target-directed posterior authority at large body-frame direction error and remove only acceleration that pushes an already near-envelope posterior rate farther outward after alignment without weakening reversal
nontransferable_details: published gains and actuator envelopes, dimensional timing, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: derive a smooth alignment gate from bounded body-frame bearing demand and a smooth envelope gate from normalized posterior rate, then project only the outward component of posterior acceleration while preserving the joint-state carrier and half-cycle steering
falsification: reject if direct capture is delayed or lost, reversal weakens, or RMS force and moment do not remain below the unguarded carrier and phase-lead variant

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass.
Static schema inspection found all `15` direct `params.FIELD` references among
the `15` fields returned by `target_policy_params()`, with no policy-owned `L`
or prohibited route/state constructs. A deterministic sweep of `8,820` states
spanning approach range, both bearing signs, both joint-angle limits, both
joint-rate limits, and rates just inside and outside the guard returned finite
actions, exact inactivity at large bearing error, exact preservation of every
reversal acceleration, bounded outward projection, and zero action at the zero
state. The candidate is byte-identical to the inherited rate-projection policy
that completed formal evaluation. The prescribed Julia include/assertion could
not start because this runtime has no `julia` executable; this is an environment
limitation, not a detected policy failure. No formal CFD was run.
