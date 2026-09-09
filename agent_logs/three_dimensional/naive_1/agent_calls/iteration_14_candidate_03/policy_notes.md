# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
prewarm, finite moving-window dynamics, and `capture`. I inspected both rows
of the combined keyframe sheets for the strongest current capture
(`solver_02eaf03fe1d2`), its response-coupled follow-up
(`solver_a1b6333c00d2`), and the assigned parent's inherited phase-leading
failure (`solver_4b5a9b1731af`), then cross-checked the views against metrics,
diagnostics, trajectories, executable policies, parent guidance, and inherited
worker notes.

The strongest capture is self-propelled rather than advected. Its head follows
a broad target-directed curve while the top-down row develops a coherent
alternating street and the oblique row retains compact caudal Lambda2 packets
through first crossing. Geometry-scheduled `15%` gait relief captures at
`18.65050T`, with mean distance `2.093400L` and score `-0.206060`. The clean
displacement-half-cycle prefill has the same useful wake class but captures at
`18.88149T`, with mean distance `2.102337L` and score `-0.213890`.

The response-coupled composition is visually indistinguishable from the
ungated geometry scheduler and captures at `18.66150T`, with mean distance
`2.093620L` and score `-0.206097`. The `0.011T`/`0.000220L` differences do not
support extra coupling between correcting yaw and gait relief, and inherited
diagnostics show neither variant is demand relief. In contrast, the inherited
joint-velocity phase lead preserves an active alternating wake and compact 3D
caudal structures but visibly rotates onto a long downward route, approaches
only `3.56872L`, and exits left at `28.64951T`. Wake coherence therefore does
not rehabilitate velocity-led phase or justify another compound response gate.

## Single-candidate policy hypothesis

Replay the strongest completed geometry-scheduled redirect/cruise policy
exactly. Preserve target-signed differential mean curvature, correcting-yaw
release of curvature, displacement-only half-cycle redistribution, the
traveling-bend carrier, posterior lag, and final acceleration projection. Use
the absolute normalized body-frame lateral target fraction to reduce only the
Van der Pol amplitude envelope by at most `15%`, without multiplying this
relief by measured yaw response. This keeps steering sign and absolute
curvature shares authoritative during redirect and restores the full rhythmic
envelope continuously as target misalignment falls.

The candidate is evidence-backed relative to the clean prefill, but its lead
has only one independent ungated rollout. Falsify it if replication loses
capture or either coherent wake view, leaves the sampled target-directed route
class, loses the arrival/mean-distance advantage beyond repeat variability, or
materially worsens rate/acceleration contact, force, or moment histories. Do
not interpret success as actuator-demand relief unless those load diagnostics
also improve.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG control
source_mechanism: preserve bounded steering curvature while temporarily reducing rhythmic drive under persistent directional error, then continuously restore cruise with alignment
transferable_invariant: normalized body-frame target misalignment may schedule the ratio of route-curvature authority to rhythmic gait amplitude without changing target-owned sign or observed joint phase
nontransferable_details: published gains, dimensional beat frequencies, C-start timing, duty ratios, motor models, species-specific envelopes, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: preserve the captured two-joint displacement-phase carrier and absolute differential-curvature shares; use absolute lateral target direction cosine to mildly reduce only the oscillator amplitude envelope during misalignment
falsification: reject if replication loses capture or either coherent wake view, returns a downward or left-exit topology, loses the sampled arrival and mean-distance advantage beyond repeat variability, changes steering sign or phase, or worsens saturation and planar loads
