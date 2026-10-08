# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes.  It is common initial-condition
evidence, not evidence for a controller.  In the released sheets, the three
byte-identical highest-scoring carriers immediately redirect toward the target,
sustain a posterior traveling bend, and swim the same compact upstream-left
diagonal to capture at `43.9505` with `2.1391L` mean distance.  Mean fish
velocity `(-0.2471,-0.1020)` differs materially from mean local flow
`(-0.1342,-0.1556)`, especially upstream, so this is active propulsion rather
than wake advection.  The `0.2111/49.44/701.26` RMS relative-crossflow,
lateral-force, and yaw-moment values and contact with both joint-rate and
acceleration envelopes identify load, not route discovery, as the useful
remaining control problem.

No sampled solver has a semantic-failure keyframe.  The assigned-parent seed
exit therefore remains the termination-class boundary: it was carried through
the lower domain without a recovery turn.  The visually available
response-conditioned steering-withdrawal rollout is the most informative
mechanism failure.  It retains capture at `43.8955`, but its late sheet shows a
larger body/wake excursion and its RMS crossflow/force/moment rise to
`0.2166/55.12/764.85`; withdrawing the target-favored half-cycle is not load
relief.

The assigned parent's direction-aware posterior rate projection is the
repeatable positive contrast.  Its keyframes retain the compact direct route
and coherent traveling bend, reaching at `44.0220` with only `0.0027L` more
mean distance, while RMS crossflow falls to `0.2102`, force to `44.86`, moment
to `663.89`, and mean command to `1206.57`.  The posterior rate still touches
the hard envelope, so the supported claim is distributed load shaping, not
peak-cap avoidance.

Most importantly for this candidate, the sampled terminal-localized version
of that projection is dynamically inert: despite a distinct policy file, its
arrival, mean/final distance, displacement, crossflow, force, moment, command,
and power match the unguarded carrier to reported precision.  Multiplying the
guard by the complement of the existing `2.5L` approach blend therefore
removes the only evidenced benefit.  This locates the useful intervention in
the earlier aligned traverse (or shows that the terminal gate never overlaps
the rate/alignment gates), and rules out another terminal-threshold edit.

## Policy hypothesis before the edit

Preserve the incumbent state-feedback oscillator, bounded body-frame bearing
curvature, target-favored joint-state half-cycle, posterior phase lag, and
smooth range-based amplitude envelope.  Add only the assigned parent's smooth
posterior rate-envelope projection across the aligned traverse: full posterior
authority remains during large bearing error; after alignment, remove only
acceleration that pushes an already near-envelope posterior rate farther
outward.  Every reversal acceleration remains unchanged.

Expected evidence is the already repeated `44.02`-class direct capture with
lower force and moment than the unguarded prefill.  Falsify the mechanism if a
new distinct rollout loses or materially delays direct capture, weakens a
reversal, or fails to reproduce lower RMS force and moment.  Continued peak
rate or acceleration contact does not justify tuning the threshold, and the
exactly inert terminal-localized result says not to re-confine this mechanism
to the final `2.5L` neighborhood.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish CPG direction control
source_mechanism: preserve a posterior-emphasized traveling bend during redirect, then use observed state to relieve redundant outward actuator drive after alignment
transferable_invariant: retain bounded target-directed posterior authority at large body-frame direction error and remove only acceleration that reinforces an already near-envelope rate after alignment, without weakening reversal
nontransferable_details: published gains and actuator limits, dimensional frequencies, species or robot kinematics, clock or exact vortex phase, cylinder coordinates, and source-task routes
policy_translation: use bounded body-frame bearing as an alignment gate and normalized posterior joint rate as the envelope state, then project only the outward component of posterior acceleration while preserving the joint-state carrier
falsification: reject if direct capture is lost or materially delayed, reversal weakens, or RMS force and moment do not remain below the unguarded carrier in a distinct rollout

## Pre-evaluation verification

The required guidance semantic/provenance check and solver editable-boundary
check pass.  Static schema inspection found all `15` direct `params.FIELD`
references among the `15` fields returned by `target_policy_params()`, with no
missing or unused declaration.  The candidate SHA-256
`1edf13974ccf694f26683c51d8bcdf6df1ff054af65d4063525fc57b4b4eab74`
is byte-identical to the assigned parent's evaluated global-projection policy;
that inherited rollout is evidence for selecting this candidate, not a claim
that this worker ran CFD.  The configured Julia include/assertion could not
start because this environment has no `julia` executable, so runtime contract
execution remains an environment limitation.  No formal CFD was run.
