# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The common prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes.  The released sheets for the
three byte-identical unguarded carriers show an immediate correct-sign redirect,
a coherent posterior traveling bend, and a compact upstream-left diagonal to
the `0.75L` target boundary in `43.9505`.  Mean fish velocity
`(-0.2471,-0.1020)` differs materially from mean local flow
`(-0.1342,-0.1556)`, especially upstream, so target closure is actively
propelled rather than passive advection.  The price is repeated contact with
both joint-rate and acceleration envelopes and RMS crossflow/force/moment of
`0.2111/49.44/701.26`.

No sampled solver in this workspace has a semantic-failure keyframe.  The
failure-class boundary therefore comes from the assigned parent and inherited
logs: the target-blind seed left the lower boundary without a recovery turn,
and excessive static curvature produced an advection-dominated right-domain
exit.  Those failures exclude global carrier weakening or a larger mean bend.

The sampled terminal-only posterior rate projection is the decisive new
negative result.  Despite a byte-distinct policy, its released sheet is
byte-identical to the unguarded carrier, and it exactly reproduces capture at
`43.9505`, mean distance `2.1391L`, RMS crossflow/force/moment
`0.2111/49.44/701.26`, and all four rate/acceleration maxima.  Mean command
changes by less than `0.0001`, so multiplying the projection by the complement
of the `2.5L` approach blend made the mechanism dynamically inert; threshold
tuning inside that terminal gate is not supported.

In contrast, the inherited alignment-gated projection that remains eligible
throughout the traverse visibly retains the direct target approach and reaches
in `44.0220`, only `0.0715` later with `0.0027L` more mean distance.  It lowers
RMS crossflow to `0.2102`, RMS force to `44.86`, RMS moment to `663.89`, and
mean command to `1206.57`.  Peak joint rates and accelerations still touch the
hard limits, so this is distributed load shaping rather than cap avoidance.

## Policy hypothesis before the edit

Preserve the successful anterior state-feedback oscillator, bounded body-frame
bearing curvature, joint-angle half-cycle steering, posterior phase lag, and
range-based amplitude envelope.  Add only the inherited direction-aware
posterior outward-rate projection, without the falsified terminal-distance
gate.  Large bearing leaves the redirect unchanged; after body-frame alignment,
the projection removes only acceleration that pushes an already near-envelope
posterior rate farther outward, while every reversal acceleration remains
available.

The expected evidence is the inherited direct `44.02`-class capture with lower
distributed force and moment than the unguarded and terminal-only samples.
Falsify the candidate if direct capture is lost or materially delayed, reversal
weakens, or the load reduction does not reproduce.  Continued peak-cap contact
does not justify scalar threshold tuning because both the positive global
projection and the inert terminal localization already bound that claim.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish CPG modulation
source_mechanism: preserve a posterior traveling bend for propulsion and steering while sensor feedback removes only redundant actuator drive
transferable_invariant: retain bounded posterior authority during large normalized body-frame direction error, then project only acceleration that reinforces an already near-envelope rate after alignment without weakening reversal
nontransferable_details: published gains and rate envelopes, dimensional timing, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, target coordinates, and task-specific routes
policy_translation: use bounded body-frame bearing demand as the alignment gate and normalized posterior joint rate as the actuator state, preserving the joint-state carrier while projecting only outward posterior acceleration
falsification: reject if direct capture is delayed or lost, reversal weakens, or RMS crossflow, force, and moment fail to remain below the unguarded carrier

## Pre-evaluation verification

The guidance/provenance check passes after removing a duplicated, byte-identical
assigned-parent marker from the rendered workspace `README.md`; the duplicate
had caused the checker to report two parents before examining the substantive
guidance change.  The solver editable-boundary check passes.  Static schema
inspection found all `15` direct `params.FIELD` references among the `15`
fields returned by `target_policy_params()`, with no policy-owned `L` and no
unused declarations.

The candidate SHA-256 is byte-identical to the inherited global rate-projection
implementation that completed evaluation with the `44.0220` direct capture and
lower distributed loads cited above.  This is prior evidence for selecting the
candidate, not a claim that this worker ran CFD.  The prescribed Julia
include/assertion could not start because this runtime has no `julia`
executable; no formal CFD was run.
