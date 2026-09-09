# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled solver rollouts satisfy the frozen experiment contract:
direct uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
finite moving-window dynamics, and `termination=capture`. I inspected both the
top-down vorticity and oblique body/Lambda2 rows in the combined sheets for the
best current capture and the most informative inherited failure, then
cross-checked the visual claims against `wake_metrics.csv`,
`wake_diagnostics.json`, trajectories, executable policy diffs, the assigned
parent guidance, and inherited optimizer notes.

The sampled captures form one narrow useful route class. The prefilled
geometry-only schedule captures at `18.65050T`, score `-0.206060`, and mean
distance `2.09340L`; its executable repeat captures at `18.68350T` and
`2.09405L`. Coupling the same schedule to correcting-yaw response remains
inside that band at `18.66150T` and `2.09362L`. All show genuine
self-propulsion: from release to first crossing, the top-down sheets develop a
coherent body-attached alternating street along a broad target-directed turn,
and the oblique rows retain compact alternating caudal Lambda2 structures.

The half-cycle envelope-redistribution sample is the only current
architectural variant outside the core score/mean-distance band. It keeps the
same route and both wake structures, captures at `18.82649T`, and improves
score to `-0.200406` and mean distance to `2.08855L`. Relative to the prefill,
that is a `0.00565` score gain and `0.00485L` mean-distance gain at the cost of
`0.176T` later arrival. It is not demand relief: anterior/posterior
acceleration contact is `60.85%/73.27%` and rate contact is
`11.07%/14.93%`, overlapping the other captures. Peak planar force and yaw
moment are not worse (`0.03171` and `0.01632` in the recorded normalizations),
but one rollout cannot distinguish the mean-distance lead from finite CFD
variation.

The inherited posterior-only relief is the decisive failure boundary. Its
top-down row still carries an energetic alternating street and its oblique row
still shows caudal Lambda2 structures, yet the route bends downward after
roughly `16T`, reaches only `3.42595L`, and exits left at `27.50552T` with
final distance `7.25112L`. Together with the earlier posterior-enhancement
failure, this shows that wake coherence does not license joint-specific wave
allocation. Preserve target-signed differential mean curvature,
displacement-only phase, one-sided correcting-yaw release, posterior lag, and
the final acceleration projection.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric flapping
source_mechanism: sensor-modulated half-cycle amplitude or duty redistribution for turning while retaining a coupled traveling rhythm
transferable_invariant: bounded rhythmic effort may be redistributed between observed beat halves while preserving the common traveling-wave carrier and target-owned mean curvature
nontransferable_details: published gains, motor geometry, clock phase, species kinematics, duty ratios, exact vortex phases, dimensional cadence, and task-specific routes
policy_translation: use normalized body-frame target side and anterior joint displacement to redistribute only the existing common envelope relief between beat halves; keep both mean-curvature shares, oscillator cadence, and posterior lag unchanged
falsification: reject if capture or either coherent wake view is lost, score and mean distance return to the replicated geometry-only band, arrival degrades without an integral benefit, the downward exit reappears, or saturation and planar loads materially worsen

## Single-candidate policy hypothesis

Replay the completed half-cycle envelope-redistribution architecture exactly,
rather than stacking a new residual onto a one-run lead. Preserve the parent's
geometry-owned mean amplitude relief, but apply less relief when the observed
anterior displacement half-cycle is aligned with target-signed steering and
more relief during the opposed half-cycle. The bounded positive modulation
changes neither route sign nor the anterior/posterior curvature ratio and
introduces no clock, joint-velocity phase predictor, terminal velocity term,
posterior-only allocation, or scalar carrier retune.

This candidate tests repeatability of the only sampled architectural gain.
Accept the mechanism as reusable only if formal CFD again captures with both
wake rows intact and retains a mean-distance or score advantage beyond the
geometry-only repeat band without worse loads. If it instead falls back
inside that band, keep it classified as an unreplicated finite-variation
result; if capture is lost, restore the simpler geometry-only schedule. The
new CFD evaluation occurs only after this worker exits and is not claimed as
current evidence.
