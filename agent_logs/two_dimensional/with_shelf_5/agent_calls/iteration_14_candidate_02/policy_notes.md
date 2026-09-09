# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The common prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes. It is shared initial-condition
evidence, not a policy comparison.

Three sampled policies are byte-identical to the prefill. Their released
sheets show an immediate correct-sign redirect, a coherent posterior traveling
bend, and a compact upstream-left diagonal to the `0.75L` target boundary.
They reproduce capture at `43.9505`, mean distance `2.1391L`, and RMS relative
crossflow/force/moment `0.2111/49.44/701.26`. Mean fish velocity
`(-0.2471,-0.1020)` differs materially from mean local flow
`(-0.1342,-0.1556)`, especially upstream, so the approach is actively
propelled rather than explained by advection. Both joint-rate and acceleration
envelopes are nevertheless reached.

No sampled solver is a semantic failure. The only distinct sampled policy adds
a velocity-derived lead to the half-cycle gate. It retains the same visible
route and target success, but arrives at `43.9780` and raises RMS
crossflow/force/moment to `0.2136/53.18/736.58`, command energy from
`53082.6` to `53191.1`, and power proxy from `3944.0` to `3966.3` without
removing cap contact. The available failure-class contrast is therefore the
inherited target-blind seed, which was largely advected through the lower
boundary without a recovery turn; that topology is absent from all current
samples.

The assigned parent's completed alignment-gated posterior rate projection is
the strongest physical contrast. Its released sheet preserves the compact
direct route and captures at `44.0220`, only `0.0715` later and `0.0027L`
worse in mean distance than the unguarded carrier, while lowering RMS
crossflow/force/moment to `0.2102/44.86/663.89`. Terminal-only localization
was inert, and restricting the projection to one oscillator half-cycle
captured at `44.0605` with weaker force/moment relief (`46.71/677.72`). A
sibling alignment-conditioned amplitude reduction is also negative evidence:
despite success it delayed capture to `44.8525` and raised command energy,
power, crossflow, force, and moment to `54872.1`, `4115.5`, `0.2188`, `69.92`,
and `948.62`. Thus the evidenced selector is actuator direction during aligned
transit, not range, oscillator phase, or a global gait-envelope reduction.

## Policy hypothesis before the edit

Preserve the sampled anterior state-feedback oscillator, bounded body-frame
bearing curvature, target-favored posterior half-cycle, posterior lag, and
smooth approach envelope. Add exactly one mechanism: the assigned parent's
direction-aware posterior rate projection. Large bearing demand leaves the
redirect unchanged. Once bearing demand is small and posterior rate is near
its envelope, remove only acceleration that reinforces the current posterior
rate; preserve every reversal acceleration.

The expected post-worker evaluation is the same compact direct capture near
`44.02` released time with force and moment below the unguarded carrier and
phase-lead contrast. Falsify the mechanism if target capture is lost or
materially delayed, route topology changes, reversal authority weakens, or
the inherited RMS load reduction fails to reproduce. Continued peak-rate
contact alone does not falsify distributed load relief and is not a reason for
another threshold-only edit.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish direction control
source_mechanism: preserve a posterior traveling bend during target-directed redirect, then relieve redundant outward actuator drive after alignment
transferable_invariant: retain bounded posterior propulsion and steering at large body-frame direction error while removing only acceleration that reinforces an already near-envelope posterior rate after alignment, without weakening reversal
nontransferable_details: published gains and actuator envelopes, dimensional timing, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: derive a smooth alignment gate from bounded normalized body-frame bearing demand and a smooth actuator-state gate from posterior joint rate, then project only outward posterior acceleration while retaining the two-joint carrier
falsification: reject if direct capture is delayed or lost, reversal authority weakens, route topology changes, or RMS force and moment do not remain below the unguarded carrier and phase-lead contrast

## Pre-evaluation verification

The guidance semantic check and solver editable-boundary check pass. Static
schema comparison found all `15` direct `params.FIELD` references among the
`15` fields returned by `target_policy_params()`, and the editable 2D case
contains exactly one target-policy candidate. The candidate is byte-identical
to the assigned parent's formally evaluated projection policy, whose completed
rollout supplies the stated capture and load evidence. The prescribed Julia
include/assertion could not start because this runtime has no `julia`
executable; this is an environment limitation, not a passed runtime check. No
formal CFD was run.
