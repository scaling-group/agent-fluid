# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes.  The mature streets and fish
pose are common initial-condition evidence, not a policy-dependent result.

All four sampled solver sheets are finite direct captures; no sampled semantic
failure is available in this workspace.  The three byte-identical strongest
carriers immediately redirect targetward, sustain a posterior traveling bend,
and traverse the wake on a compact upstream-left diagonal.  They reproduce a
`43.9505` release-time capture, `2.1391L` mean distance, and mean velocity
`(-0.2471,-0.1020)` versus mean local flow `(-0.1342,-0.1556)`, so their
progress is active swimming rather than passive advection.  The distinct
phase-lead sample keeps the same visible route but is uniformly worse:
arrival is `43.9780`, mean command rises from `1207.78` to `1209.49`, RMS
crossflow from `0.21115` to `0.21362`, force from `49.44` to `53.18`, and
moment from `701.26` to `736.58`.  This is negative evidence against further
phase shifting of the target-favored half-cycle.

The most informative mechanism failure is in the assigned parent's inherited
rollout.  Its alignment-gated instantaneous yaw-moment residual preserves
semantic capture and broadly follows the direct route, but the released sheet
shows a stronger late body/wake excursion.  Against the immediately preceding
posterior outward-rate projection, arrival regresses from `44.0220` to
`45.1935`, mean distance from `2.1418L` to `2.1965L`, RMS crossflow from
`0.21016` to `0.21451`, force from `44.86` to `71.51`, and moment from
`663.89` to `957.29`.  Maximum joint angles also grow from `0.522/0.452` to
`0.562/0.496` rad while both rate and acceleration caps remain active.  Mean
command changes by less than `0.1%`, so direct opposition to instantaneous
moment changed the body-wave/load coupling rather than relieving actuator
effort.

By contrast, the inherited posterior outward-rate projection is an isolated
positive mechanism.  Its keyframes preserve the carrier's targetward redirect,
traveling bend, and direct wake corridor, reaching after `44.0220`.  Relative
to the unguarded sampled carrier it reduces RMS crossflow to `0.21016`, force
by about `9.3%` to `44.86`, moment by about `5.3%` to `663.89`, and mean
command slightly to `1206.57`.  Continued rate/acceleration cap contact limits
the claim to distributed load shaping; it is not cap or effort relief.

## Policy hypothesis before the edit

Use the evaluated posterior outward-rate projection as this single candidate
and omit the falsified moment residual.  Preserve the joint-state oscillator,
bounded body-frame bearing-to-curvature command, target-favored posterior
half-cycle, posterior phase lag, and approach taper.  Large target-bearing
error retains full redirect authority.  After alignment, a smooth normalized
posterior-rate gate removes only acceleration that would push an already
near-envelope rate farther outward; reversal acceleration is unchanged.

Expected evidence is the already demonstrated compact direct capture with
`44.022`-class arrival and force/moment below the unguarded carrier, without
the parent's moment-residual load spike.  Falsify the mechanism if the direct
route or capture is lost, arrival regresses materially, reversal weakens, or
the load reduction fails to reproduce.  Continued hard-cap contact does not
justify scalar threshold tuning because prior evidence already bounds this
mechanism's benefit to load shaping.  The new CFD evaluation occurs only after
this worker exits, so no outcome from this candidate is claimed here.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish direction control
source_mechanism: preserve the posterior traveling-wave carrier during target redirect, then remove only redundant outward actuator drive after alignment
transferable_invariant: retain bounded posterior propulsion and steering at large body-frame direction error while relieving only acceleration that pushes an already near-envelope posterior rate outward, without weakening reversal
nontransferable_details: published gains and actuator envelopes, dimensional frequencies, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: derive smooth gates from bounded body-frame bearing demand and posterior joint rate normalized by the known actuator envelope, then project only the outward component of posterior acceleration
falsification: reject if direct capture is delayed or lost, posterior reversal weakens, or RMS crossflow, force, and moment do not remain below the unguarded carrier

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass,
and the editable 2D lane contains one non-empty target-policy candidate.  All
`15` direct `params.FIELD` references exactly match the `15` fields returned by
`target_policy_params()`.  The candidate is byte-identical to the inherited
projection-only policy whose completed rollout reached the target after
`44.0220`, providing an evaluation-backed implementation cross-check without
claiming a new same-worker CFD result.  The prescribed Julia include/assertion
could not start because this workspace has no `julia` executable; this is an
environment limitation rather than a detected contract failure.  No formal
CFD was run.
