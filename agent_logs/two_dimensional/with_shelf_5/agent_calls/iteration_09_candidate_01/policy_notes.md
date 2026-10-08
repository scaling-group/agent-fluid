# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes.  Because this sheet is common to
every candidate, it anchors the disturbance field but does not distinguish
policy quality.

The three byte-identical strongest sampled policies immediately turn toward
the target, sustain a posterior traveling bend, and swim along a compact
upstream-left diagonal through the wake corridor.  They reproducibly reach the
`0.75L` boundary after `43.9505`, with `2.1391L` mean distance.  Mean fish
velocity `(-0.2471,-0.1020)` differs materially from mean local flow
`(-0.1342,-0.1556)`, so the target approach is self-propelled rather than
passive wake advection.  In contrast, the informative inherited domain-exit
sheet never develops a coherent targetward traveling bend and is carried
`(+2.175,-0.869)L` to the screen-right boundary after `16.7914`; its mean
streamwise motion differs from local flow by only `0.0154U`.  This excludes a
larger static bend or global weakening of the proven carrier.

The current prefill's small-bearing, response-conditioned withdrawal of the
target-favored half-cycle boost remains a direct success, but its late sheet
shows a larger body/wake excursion.  Against the strongest sampled carrier,
arrival improves by only `0.0550` while mean distance rises from `2.1391L` to
`2.1406L`, RMS crossflow from `0.2111` to `0.2166`, RMS force from `49.44` to
`55.12`, and RMS moment from `701.26` to `764.85`; both joint-rate and
acceleration caps remain active.  The mechanism therefore withdraws useful
steering rather than evidenced redundant drive.

The assigned parent's latest evaluated policy instead retains the
target-directed half-cycle boost and projects away only posterior acceleration
that pushes a near-envelope joint rate farther outward after body-frame
alignment.  Its keyframes preserve the same direct topology and capture after
`44.0220`.  Relative to the strongest sampled carrier, mean distance changes
by only `0.0027L`, while RMS crossflow falls to `0.2102`, RMS force to `44.86`,
and RMS moment to `663.89`.  Relative to the current prefill, those load
reductions are about `18.6%` and `13.2%`.  The posterior rate still touches
the hard cap, so this is evidence for load shaping, not for cap avoidance.

## Policy hypothesis before the edit

Replace the prefill's response-conditioned half-cycle-steering release with
the assigned parent's evaluated, direction-aware posterior rate envelope.
Keep the anterior state-feedback oscillator, body-frame bearing curvature,
target-favored half-cycle steering, posterior phase lag, and range-based
amplitude envelope unchanged.  Large bearing retains full redirect authority;
after alignment, only acceleration with the same sign as an already
near-envelope posterior rate is removed, while reversal acceleration remains
available.

The expected evidence is reproducible direct target capture in roughly
`44.02` released time with force/moment below both the current prefill and the
byte-identical carrier.  Falsify the candidate if the route ceases to be
direct, capture is lost or materially delayed, reversal authority weakens, or
the load reduction fails to reproduce.  Do not interpret continued rate-cap
contact as a reason for threshold tuning: the inherited evaluation already
shows that this guard's supported benefit is distributed load relief rather
than elimination of the peak.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish burst-to-cruise direction control
source_mechanism: preserve the posterior traveling wave during a large target-directed redirect, then relieve only redundant outward actuator drive after alignment
transferable_invariant: retain bounded target-directed posterior authority at large body-frame direction error and remove only acceleration that pushes an already near-envelope joint rate farther outward after alignment, without weakening reversal
nontransferable_details: published gains and actuator envelopes, dimensional timing, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: derive a smooth gate from bounded body-frame bearing demand and posterior joint rate, then project only the outward component of posterior acceleration while preserving the joint-state carrier and half-cycle steering
falsification: reject if direct capture is delayed or lost, reversal weakens, or RMS force and moment do not remain below the current prefill and unguarded carrier

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass.
Static schema inspection found all `15` direct `params.FIELD` references among
the `15` fields returned by `target_policy_params()`, with no policy-owned
`L`.  A deterministic sweep of `8,820` combinations spanning approach range,
both bearing signs, both joint-angle limits, both joint-rate limits, and rates
just inside the guard returned finite actions, gates in `[0,1]`, exact
large-error inactivity, and exact preservation of every reversal acceleration.
The prescribed Julia include/assertion could not start because this runtime has
no `julia` executable; this is an environment limitation, not a detected
policy failure.  No formal CFD was run.
