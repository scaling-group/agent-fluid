# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting cylinder wakes. It is the common initial
condition, not candidate-specific evidence. All four sampled released sheets
show an immediate correct-sign redirect, a coherent posterior traveling bend,
and a compact upstream-left traverse into the `0.75L` target circle. Three
byte-identical unguarded carriers reproduce capture at `43.9505`, mean distance
`2.1391L`, and RMS relative crossflow/force/moment
`0.2111/49.44/701.26`. Their mean velocity `(-0.2471,-0.1020)` differs
materially from mean local flow `(-0.1342,-0.1556)`, especially upstream, so
the visible closure is active swimming rather than passive wake advection.
Both joint-rate and acceleration envelopes are nevertheless reached.

No sampled rollout has a failure keyframe. The available failure-class
boundary is the inherited target-blind seed, which left the lower domain after
`50.127` with no recovery turn and motion largely explained by local-flow
advection. That topology is absent from the current samples. The informative
sampled regression instead shifts the posterior half-cycle selector with
anterior rate. Its sheet retains the same direct route and capture at
`43.9780`, but RMS crossflow/force/moment rise to
`0.2136/53.18/736.58`, with no cap relief. This rules out another phase or
scalar retune of the half-cycle gate.

The inherited completed rollouts distinguish two alignment-conditioned
mechanisms. Reducing oscillator amplitude after alignment preserves visible
success but delays capture to `44.8525`, increases mean distance to `2.1708L`,
raises mean command to `1223.39`, and increases RMS
crossflow/force/moment to `0.2188/69.92/948.62`. By contrast, the smooth
alignment-gated projection of only near-envelope outward posterior acceleration
preserves the compact route and captures at `44.0220`, with mean distance
`2.1418L` and lower RMS crossflow/force/moment
`0.2102/44.86/663.89`. Terminal-only and nonfavored-half-cycle restrictions
were respectively inert and weaker, so aligned transit—not range, amplitude,
or oscillator phase—is the evidenced selector. Continued posterior rate-cap
contact bounds the benefit to distributed load shaping rather than peak-rate
avoidance.

## Policy hypothesis before the edit

Preserve the sampled anterior state-feedback oscillator, bounded normalized
body-frame bearing curvature, target-favored posterior half-cycle, posterior
lag, and smooth approach envelope. Add one direction-aware posterior
rate-envelope mechanism: keep full authority during large bearing error; once
aligned and only when posterior rate is near its normalized envelope, project
away the component of acceleration that reinforces the current rate. Preserve
every reversal acceleration.

Expected evidence is the same direct target capture near `44.02` released time
with force and moment below the unguarded carrier and phase-lead contrast.
Falsify the mechanism if capture is lost or materially delayed, the route
topology changes, reversal weakens, or the inherited RMS-load reduction does
not reproduce. Rate-cap contact alone is not a reason to tune thresholds.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and closed-loop robotic-fish burst-to-cruise direction control
source_mechanism: preserve a posterior traveling bend and full target-directed redirect authority, then relieve only redundant outward actuator drive after observed alignment
transferable_invariant: large normalized body-frame direction error retains bounded posterior propulsion and steering, while aligned state may remove only acceleration that reinforces an already near-envelope posterior rate without weakening reversal
nontransferable_details: published gains and actuator envelopes, dimensional timing, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, target coordinates, and task-specific routes
policy_translation: derive a smooth alignment gate from bounded body-frame bearing demand and a smooth actuator-state gate from posterior joint rate, then project only outward posterior acceleration within the two-joint state-feedback carrier
falsification: reject if direct capture is delayed or lost, route topology changes, reversal authority weakens, or RMS force and moment do not remain below the unguarded and phase-lead carriers

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass.
Static schema inspection found all `15` direct `params.FIELD` references among
the `15` fields returned by `target_policy_params()`, with no policy-owned `L`
or prohibited route/state constructs. An algebraic sweep of `405` combinations
spanning both bearing signs, rates below and beyond the envelope, and both raw
acceleration directions found finite actions, gates in `[0,1]`, exact
large-error inactivity, exact preservation of every reversal acceleration,
and no outward-acceleration sign reversal. The candidate is byte-identical to
the inherited alignment-gated rate-projection policy that completed formal CFD
with direct capture and lower RMS loads. The prescribed Julia include check
could not start because this runtime has no `julia` executable; this is an
environment limitation, not a passed runtime assertion. No formal CFD was run.
