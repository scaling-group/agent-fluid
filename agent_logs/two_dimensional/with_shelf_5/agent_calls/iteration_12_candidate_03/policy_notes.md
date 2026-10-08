# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes.  It is common initial-condition
evidence and does not distinguish policies.

All four sampled released sheets show the same useful topology: an immediate
correct-sign redirect, a coherent posterior traveling bend, and a compact
upstream-left diagonal to first crossing of the `0.75L` target boundary.  The
three unguarded samples reproduce release time `43.9505`, mean distance
`2.1391L`, and RMS crossflow/force/moment `0.2111/49.44/701.26`.  Mean fish
velocity `(-0.2471,-0.1020)` differs materially from mean local flow
`(-0.1342,-0.1556)`, so upstream closure is active swimming rather than the
advection-dominated motion of the inherited seed failure.

The fourth sample is the exact prefilled terminal-localized posterior
rate-projection policy.  Its keyframes and all trajectory/load summaries are
indistinguishable from the unguarded carrier: the same `43.9505` release time,
`2.1391L` mean distance, `0.2111` crossflow, and `49.44/701.26` force/moment.
Only about `0.0044` of `53082.6` integrated command differs.  The approach gate
therefore made the previously useful projection effectively inactive; tuning
its distance or rate thresholds would be a scalar search with no supported
mechanism.

No current sampled solver has a failure keyframe.  The inherited failure-class
comparison is the target-blind seed, which left the lower boundary after
`50.127` with advection explaining most of its motion and no recovery turn.
That topology is absent here.  More informative successful contrasts are the
globally alignment-gated projection, which retained direct capture at
`44.0220` while lowering force/moment to `44.86/663.89`, and the small-bearing
response release, which reached at `43.8955` but raised force/moment to
`55.12/764.85`.  Together they show that load relief must act during aligned
transit, but indiscriminately changing the steering burst can amplify loads.

## Policy hypothesis before the edit

Preserve the evaluated anterior oscillator, normalized body-frame bearing
curvature, target-favored joint-state half-cycle, posterior lag, and smooth
approach amplitude envelope.  Replace the ineffective distance localization
with a phase-selective version of the positive alignment-gated rate
projection.  After bearing demand becomes small and posterior rate approaches
its envelope, remove only outward posterior acceleration, weighted toward the
non-target-favored joint-state half-cycle.  Large-error redirect, every
reversal acceleration, and the full target-favored steering stroke remain
available.

This is a new phase-selective load-allocation mechanism rather than a guard
threshold change.  Expected evidence is the existing direct route and
`43.95`-class capture with a measurable force/moment reduction but less arrival
penalty than the phase-indiscriminate global projection.  Falsify it if the
route changes, capture is lost or materially delayed, reversal weakens, or
loads remain indistinguishable from the unguarded carrier.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and robotic-fish asymmetric CPG turning
source_mechanism: preserve posterior traveling-wave authority on the target-favored stroke while relieving redundant actuator drive on the complementary stroke after alignment
transferable_invariant: a bounded rhythmic carrier should retain the posterior stroke that supplies target-directed propulsion and steering, while state feedback may remove only outward near-envelope drive on the nonfavored half-cycle
nontransferable_details: published gains, dimensional frequency and actuator limits, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: use normalized body-frame bearing for the alignment gate, posterior joint rate for the envelope and outward-direction test, and the already demonstrated joint-angle half-cycle gate for phase-selective projection
falsification: reject if direct capture is delayed or lost, reversal authority weakens, or RMS force and moment fail to fall below the unguarded carrier without the global projection's full arrival penalty

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass.
Static schema inspection found all `15` direct `params.FIELD` references among
the `15` fields returned by `target_policy_params()`, with no policy-owned `L`.
An algebraic sweep of `16,875` combinations spanning distance, both bearing
signs, both joint-angle limits, both joint-rate limits, and rates on either side
of the guard found finite actions, a projection multiplier in `[0,1]`, exact
large-error inactivity, exact preservation of reversal acceleration, and no
sign reversal of outward acceleration.  The prescribed Julia include check
could not execute because this workspace has no `julia` binary; this is a
verification limitation, not a passed runtime assertion.  No formal CFD was
run.
