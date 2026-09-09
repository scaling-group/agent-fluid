# Response-gated predicted-miss replication candidate

## Evidence and visual diagnosis before editing

All sampled and inherited evaluations report direct uniform still-water
initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I
inspected the combined top-down vorticity and oblique body/Lambda2 rows for
both captures and both sampled failures. Every rollout is self-propelled: a
body-connected alternating wake develops from rest and remains coherent
through the useful translation. The differentiator is target interception,
not passive advection, absent thrust, or numerical instability.

The best finite sample `solver_d32fb3a02de7` follows a narrow down-left
intercept with compact three-dimensional shedding and captures at `15.983T`
with score `-0.02444`. It slightly improves the earlier predicted-miss capture
`solver_aa2570fe3d2e` at `16.011T` and score `-0.02805`. The posterior-pulse
sample preserves the traveling carrier while using body-frame predicted miss,
carrier-separated yaw response, and anterior-joint phase to retain rhythmic
steering and briefly reshape the posterior wave near the intercept.

The failures retain strong wakes but develop broad late curls. Continuous
drive relief in `solver_1fbf1e40b119` reaches `2.703L`, then exits left at
`7.056L`; the prefilled full-circle/drive-relief policy
`solver_ec81137f627b` reaches only `4.650L` and exits left at `5.706L`.
Neither supports further symmetric carrier braking. More importantly, the
assigned parent's inherited rollout and `solver_aa2570fe3d2e` have identical
policy, configuration, body, and geometry hashes, yet one captures at
`0.748L` and the other misses at `1.034L` before a left exit. Thus a single
threshold crossing is evidence for the interception architecture, but not yet
evidence of repeatable capture margin.

## Single candidate hypothesis

Replace the prefilled failed drive-relief architecture with the exact sampled
best response-gated predicted-miss controller. Preserve its joint-state
traveling bend, body-frame target/velocity interception geometry, bounded
terminal mean curvature, yaw-confirmed half-cycle handoff, and closing,
mid-stroke posterior pulse. This is a clean replication of the only sampled
mechanism combination that improved both semantic outcome and arrival/score;
adding another untested terminal mechanism now would confound whether the
posterior phase-gated actuator survives the inherited repeat sensitivity.

Support requires another capture while retaining the narrow approach, compact
alternating wake, low load history, and joint reserve reported by its parent.
Falsify on a repeat miss outside `0.75L`, the broad post-pass curl of either
drive-relief failure, loss of pre-approach translation, posterior pinning,
limit/load growth, or degraded wake coherence. Formal CFD remains downstream;
this worker performs only contract and algebraic checks.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish capture maneuvers
source_mechanism: preserve rhythmic propulsion while target feedback briefly reshapes posterior motion during the force-producing portion of a beat
transferable_invariant: bounded terminal steering should use measured target-relative miss and joint phase, retain the propulsive rhythm, and release authority when the target stops closing or the measured yaw response is corrective
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species-specific curvature and timing, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target and velocity for predicted miss, subtract joint-rate-correlated carrier yaw before the steering handoff, and gate a target-signed posterior offset by normalized anterior-joint speed under the two-joint state-feedback contract
falsification: reject if repeated capture and termination fail to improve together or if wake coherence, joint reserve, load scale, reflection symmetry, or far-field translation degrades
```

## Dry validation only

The mandated guidance-materiality, Julia policy-contract, parameter-schema,
and editable-boundary checks pass. All `28` direct `params.FIELD` references
are returned by `target_policy_params()`. A deterministic `19,683`-state grid
spanning target geometry, body velocity, both joint angles/rates, and yaw
response produced finite commands inside the smooth `30 rad/T^2` envelope and
exact left/right reflection (maximum error `0.0`). Disabling only the posterior
pulse changed a constructed closing-terminal action by `0.3400 rad/T^2`, so
the selected mechanism is semantically active. These checks establish schema,
boundedness, symmetry, and gating only; no CFD was run in this workspace.
