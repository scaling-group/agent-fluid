# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the common held fish above four mature,
interacting cylinder wakes.  It is initial-condition evidence, not a policy
comparison.  The three byte-identical sampled incumbent sheets then show an
immediate correct-sign redirect, a coherent posterior traveling bend, and the
same compact upstream-left diagonal capture at `43.9505` with `2.1391L` mean
distance.  Mean fish velocity `(-0.2471,-0.1020)` differs materially from mean
local flow `(-0.1342,-0.1556)`, especially in the upstream component, so the
route is actively propelled rather than explained by passive wake advection.
The remaining weakness is load: RMS relative crossflow, force, and moment are
`0.2111/49.44/701.26`, and both joint-rate and acceleration envelopes are
reached.

The sampled velocity-led half-cycle gate is the closest released-sheet
comparison.  It preserves capture at `43.9780` and essentially the same route,
but its stronger late tail-wake excursion agrees with worse RMS crossflow,
force, and moment of `0.2136/53.18/736.58`; phase lead is therefore not an
evidenced load-relief mechanism.  No sampled solver example has a semantic
failure sheet.  The assigned-parent seed exit remains the available failure
boundary: advection through the lower domain without a recovery turn.  The
successful direct carrier has removed that topology, so a stronger route
redirect is not indicated.

The inherited response-conditioned release supplies a further negative
mechanism result.  Releasing the target-favored posterior half-cycle only in a
`10`--`20` degree alignment window retained fast capture at `43.8955` and
`2.1406L` mean distance, but increased RMS crossflow/force/moment to
`0.2166/55.12/764.85`, raised mean command to `1216.18`, and still touched both
actuator envelopes.  A small-bearing gate fixes the earlier arrival delay but
does not turn steering withdrawal into load relief; its thresholds should not
be tuned again.

In contrast, the assigned parent's direction-aware posterior rate projection
has repeated the same compact direct route at `44.0220` and `2.1418L` mean
distance while lowering RMS crossflow/force/moment to
`0.2102/44.86/663.89`.  Two assigned-parent rollouts are byte-identical and
agree with distinct inherited branch artifacts.  Peak rates still reach the
hard envelope, so this supports distributed load shaping, not cap avoidance.

## Policy hypothesis before editing

Preserve the incumbent oscillator, smooth range-based amplitude envelope,
bounded body-frame bearing curvature, target-favored joint-state half-cycle,
and posterior phase lag.  Add only the assigned parent's smooth posterior
rate-envelope projection across the aligned traverse: retain full posterior
authority at large bearing error, and after alignment remove only the
acceleration component that pushes an already near-envelope posterior rate
farther outward.  Reversal acceleration remains unchanged.

This is one state-feedback mechanism rather than a gain sweep.  Expected
evidence is the already repeated `44.02`-class direct capture with lower force
and moment than the unguarded prefill.  Reject it if a distinct rollout loses
or materially delays direct capture, weakens reversal, or fails to reproduce
the load reduction.  Continued peak-cap contact is not evidence for further
threshold tuning.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish CPG direction control
source_mechanism: preserve a posterior-emphasized traveling bend during redirect, then use sensed actuator state to remove redundant outward drive after alignment
transferable_invariant: retain bounded target-directed posterior authority at large body-frame error and remove only actuation that reinforces an already near-envelope rate, without weakening reversal
nontransferable_details: published gains, actuator limits, species or robot kinematics, dimensional frequencies, exact vortex phase, cylinder coordinates, and source-task routes
policy_translation: gate on bounded body-frame bearing demand and normalized posterior joint rate, then project only the outward component of posterior acceleration while preserving the joint-state carrier
falsification: reject if direct capture is lost or materially delayed, reversal weakens, or RMS force and moment fail to remain below the unguarded carrier in a distinct rollout

## Pre-evaluation verification

The required guidance semantic/provenance check and solver editable-boundary
check pass.  Static schema inspection found all `15` direct `params.FIELD`
references among the `15` fields returned by `target_policy_params()`, with no
missing or unused declarations.  The candidate SHA-256 is
`1edf13974ccf694f26683c51d8bcdf6df1ff054af65d4063525fc57b4b4eab74` and is
byte-identical to the assigned parent's evaluated rate-projection policy.  The
configured Julia include/assertion could not start because this environment
has no `julia` executable; runtime contract execution is therefore an
environment limitation, not a passed check.  No formal CFD was run.
