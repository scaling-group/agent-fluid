# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled solver rollouts satisfy the direct-uniform still-water
contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
dynamics, and `termination=capture`. I inspected both rows of the combined
keyframe sheet for the strongest sampled capture (`solver_02eaf03fe1d2`) and
the inherited velocity-predicted phase failure (`solver_4b5a9b1731af`), then
cross-checked the images against their metrics, diagnostics, trajectories,
controller sources, the assigned parent guidance, and inherited notes.

The strongest sample is visibly self-propelled: it follows a broad monotonic
target-directed curve, builds a coherent alternating top-down street, and
retains compact caudal Lambda2 structures through capture. It adds only
body-frame misalignment scheduling of the oscillator envelope to the clean
displacement-half-cycle carrier and captures at `18.65050T`, with mean scored
distance `2.09340L` and score `-0.206060`. The matched clean prefill
(`solver_2e35da543303`) has the same useful wake and route class but captures
at `18.88149T`, with mean distance `2.10234L` and score `-0.213890`. Thus the
misalignment-scheduled policy leads every sampled result in arrival, distance
integral, and score while preserving the two visual wake views.

The comparison also bounds what should not be composed into this candidate.
Terminal velocity/range variants capture but remain inside repeat variation,
so they do not explain the stronger result. More importantly, adding
normalized joint velocity to predict the half-cycle retained coherent
propulsion but rotated the route downward, reached only `3.56872L`, and exited
at `28.64951T`. The assigned parent's restored clean controller captured at
`18.82099T` with mean distance `2.10522L`, confirming that displacement-only
phase plus non-inverting response release is the safe architecture boundary
while leaving the redirect/cruise sample's arrival and distance-integral lead
intact. This candidate therefore replays the single strongest completed
mechanism without terminal residuals, velocity-led phase, rate barriers, or
another untested compound.

## Single-candidate policy hypothesis

Preserve target-signed differential mean curvature, displacement-only
half-cycle redistribution, correcting-yaw response release, the traveling
bend, posterior lag, and final acceleration projection. Add the sampled
redirect/cruise mechanism: use the absolute normalized body-frame lateral
target fraction to reduce only the Van der Pol amplitude envelope by at most
`15%` during misalignment, while leaving absolute curvature shares unchanged
and restoring full cruise continuously as the target returns ahead. This
raises steering authority relative to rhythmic drive without changing route
sign, beat phase, frequency, posterior lag, or the action envelope.

The completed sampled rollout supports capture and a useful wake for this
exact executable policy, but one run does not establish repeatability or
demand relief. Falsify the reusable mechanism if replication loses capture or
the coherent wake, leaves the successful route class, fails to retain the
arrival/mean-distance lead beyond repeat variability, or materially worsens
joint saturation, force, or moment histories.

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish CPG gait modulation
source_mechanism: preserve bounded steering curvature while temporarily reducing rhythmic drive during large directional error, then restore cruise as alignment responds
transferable_invariant: persistent normalized body-frame target misalignment may schedule the ratio of route-curvature authority to rhythmic gait amplitude without changing target-owned sign or observed joint phase
nontransferable_details: published gains, dimensional beat frequencies, C-start timing, duty ratios, motor models, species-specific kinematics, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: retain the captured two-joint displacement-phase carrier and absolute differential-curvature shares; use absolute lateral target direction cosine to mildly reduce only the oscillator amplitude envelope during misalignment
falsification: reject if replication loses capture or either coherent wake view, returns the downward exit topology, loses the sampled arrival and mean-distance advantage beyond repeat variability, changes steering sign or phase, or worsens saturation and planar loads
