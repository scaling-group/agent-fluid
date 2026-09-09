# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed interacting wakes.  Because that sheet is common to every
candidate, it anchors the release disturbance but does not distinguish policy
quality.

The three byte-identical strongest sampled policies immediately redirect
toward the target, preserve a coherent posterior traveling bend, and traverse
a compact upstream-left diagonal to the `0.75L` capture boundary in `43.9505`.
Their mean fish velocity `(-0.2471,-0.1020)` differs materially from mean local
flow `(-0.1342,-0.1556)`, so the approach is actively propelled rather than
passive advection.  The sampled half-cycle phase-lead variant keeps the same
visible route and still captures at `43.9780`, but raises RMS crossflow from
`0.2111` to `0.2136`, RMS force from `49.44` to `53.18`, and RMS moment from
`701.26` to `736.58`; advancing the state-defined gate is therefore not an
evidenced improvement.

The assigned parent's evaluated posterior rate-envelope projection is the
stronger physical tradeoff.  Its keyframes retain the compact direct route
and coherent traveling bend, capture at `44.0220`, and show a calmer late wake
excursion.  Relative to the byte-identical carrier, mean distance changes by
only `0.0027L`, while RMS crossflow falls to `0.2102`, RMS force to `44.86`,
and RMS moment to `663.89`; mean command also falls slightly from `1207.78` to
`1206.57`.  The posterior rate still reaches the hard envelope, so the
supported interpretation is distributed load shaping rather than peak-rate
avoidance.

The inherited alignment-gated instantaneous yaw-moment residual is the
informative mechanism failure.  Its final sheet shows a larger tail-generated
vortex and disturbed late wake, while capture slips to `45.1935`, mean
distance to `2.1965L`, and RMS force/moment to `71.51/957.29`.  This rejects
adding an unfiltered moment residual or another phase tweak when the compact
evidence does not calibrate disturbance sign relative to carrier phase.

## Policy hypothesis before the edit

Materialize the assigned parent's evaluated direction-aware posterior rate
projection on the current sampled carrier.  Preserve the anterior
state-feedback oscillator, bounded body-frame bearing curvature, joint-angle
half-cycle gate, posterior phase lag, and range-based amplitude envelope.
Large bearing retains the complete redirect; after alignment, remove only the
component of posterior acceleration that pushes an already near-envelope
joint rate farther outward, while every reversal acceleration remains intact.

Expected evidence is the already observed direct `44.02`-class capture with
lower force and moment than the current unguarded prefill.  Falsify the
candidate if the route ceases to be direct, capture is lost or materially
delayed, reversal weakens, or the inherited load reduction does not reproduce.
Continued rate-cap contact is not evidence for threshold tuning; a future
disturbance residual should wait for sign-resolved or history-resolved evidence.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish CPG direction tracking
source_mechanism: preserve posterior traveling-wave authority through a target-directed redirect, then relieve redundant outward actuator drive after alignment
transferable_invariant: retain bounded posterior propulsion and steering at large normalized body-frame direction error while removing only acceleration that pushes an already near-envelope rate farther outward after alignment, without weakening reversal
nontransferable_details: published gains and actuator envelopes, dimensional timing, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: use bounded body-frame bearing demand as a smooth alignment gate and posterior joint rate as the envelope state, preserving the joint-state carrier and projecting only outward posterior acceleration
falsification: reject if direct capture is delayed or lost, reversal weakens, or RMS force and moment fail to remain below the unguarded carrier

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass.
Static schema inspection found all `15` direct `params.FIELD` references among
the `15` fields returned by `target_policy_params()`.  The candidate is
byte-identical to the assigned parent's evaluated policy, so its inherited
direct-capture/load result is the evidence for selecting it, not a claim that
this worker ran CFD.  The prescribed Julia include/assertion could not start
because this runtime has no `julia` executable; this is an environment
limitation rather than a detected policy failure.  No formal CFD was run.
