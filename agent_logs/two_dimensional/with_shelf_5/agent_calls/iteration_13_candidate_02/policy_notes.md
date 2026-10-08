# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes. The sheet is common across the
sampled solvers, so it anchors the initial disturbance field rather than
distinguishing policies.

The three strongest sampled policies are byte-identical. Their released sheets
show an immediate correct-sign redirect, a coherent posterior traveling bend,
and a compact upstream-left diagonal through the wake corridor to first
crossing of the `0.75L` target boundary. They reproduce capture at `43.9505`,
mean distance `2.1391L`, and RMS relative crossflow/force/moment
`0.2111/49.44/701.26`. Mean fish velocity `(-0.2471,-0.1020)` differs
materially from mean local flow `(-0.1342,-0.1556)`, especially upstream, so
the visible closure is active swimming rather than passive advection. Both
joint-rate and acceleration envelopes are nevertheless reached.

No sampled rollout is a semantic failure. The one distinct sampled policy
adds a velocity-derived lead to the target-favored half-cycle gate. It retains
the same direct topology and captures at `43.9780`, but increases RMS
crossflow/force/moment to `0.2136/53.18/736.58` and mean command to `1209.49`,
without eliminating cap contact. Joint-rate phase lead is therefore negative
load evidence, not a useful disturbance response. The available failure-class
contrast remains the inherited target-blind seed: it was largely advected out
the lower boundary without a recovery turn, a topology absent from every
current sample.

Inherited optimizer rollouts isolate a safer structural mechanism. A smooth
alignment-gated projection that removes only posterior acceleration directed
farther outward near the rate envelope repeated the same direct `44.0220`
capture with `2.1418L` mean distance, while lowering RMS crossflow/force/moment
to `0.2102/44.86/663.89`. Terminal-only localization was behaviorally inert,
and a non-target-favored-half-cycle selector captured at `44.0605` but recovered
only part of the load benefit (`46.71/677.72` force/moment). The visible route
remains compact in both inherited sheets. Thus alignment during transit, not
range or oscillator-phase retiming, is the evidenced selector. Continued rate
cap contact bounds the claim to distributed load shaping, not peak avoidance.

## Policy hypothesis before the edit

Preserve the sampled anterior state-feedback oscillator, bounded body-frame
bearing curvature, target-favored posterior half-cycle, posterior lag, and
smooth distance-conditioned amplitude envelope. Add only the repeatedly
evaluated direction-aware posterior rate projection. Large bearing demand
leaves the redirect unchanged; after alignment and only near the posterior
rate envelope, remove the component of acceleration that would reinforce the
current rate. Every reversal acceleration remains unchanged.

Expected evidence is the same compact direct capture near `44.02` released
time, with force and moment below both the unguarded carrier and the sampled
phase-lead variant. Falsify the mechanism if direct capture is lost or
materially delayed, route topology changes, reversal weakens, or the prior
load reduction does not reproduce. Rate-cap contact alone does not justify
threshold tuning because inherited repeats show it can coexist with lower RMS
loads.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish direction control
source_mechanism: preserve the posterior traveling bend during target-directed redirect, then relieve only redundant outward actuator drive after alignment
transferable_invariant: retain bounded posterior propulsion and steering at large body-frame direction error while removing only acceleration that reinforces an already near-envelope posterior rate after alignment, without weakening reversal
nontransferable_details: published gains and actuator envelopes, dimensional timing, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: derive a smooth alignment gate from bounded normalized body-frame bearing demand and a smooth actuator-state gate from posterior joint rate, then project only outward posterior acceleration while retaining the two-joint carrier
falsification: reject if direct capture is delayed or lost, reversal authority weakens, route topology changes, or RMS force and moment do not remain below the unguarded carrier and phase-lead contrast

## Pre-evaluation verification

The guidance semantic check and solver editable-boundary check pass. Static
schema inspection found all `15` direct `params.FIELD` references among the
`15` fields returned by `target_policy_params()`, with no policy-owned `L` or
prohibited route/state constructs. The candidate is byte-identical to the
inherited direction-aware rate-projection policy whose repeated formal
rollouts captured at `44.0220` with lower RMS loads. The prescribed Julia
include/assertion could not start because this runtime has no `julia`
executable; this is an environment limitation, not a passed runtime check. No
formal CFD was run.
