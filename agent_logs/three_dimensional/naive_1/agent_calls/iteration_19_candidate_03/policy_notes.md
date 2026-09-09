# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled rollouts satisfy the frozen direct-uniform still-water
contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
dynamics, and `termination=capture`. There is therefore no sampled termination
failure to relabel as a comparison. I inspected the release-to-capture
top-down vorticity and oblique body/Lambda2 rows for all four, emphasizing the
fastest geometry-scheduled capture and the only distinct lower-route capture,
then cross-checked the sheets against `wake_metrics.csv`, diagnostics,
trajectories, executable policy diffs, the assigned parent guidance, and
inherited optimizer notes.

The geometry-scheduled policy and its comment-only executable repeat capture
at `18.6505T` and `18.6835T`, with mean distance `2.09340L` and `2.09405L`.
The prefilled response-coupled relief composition also lies inside that band
at `18.6615T` and `2.09362L`; it is not a semantic gain and does not support
stacking another yaw gate. In both visual rows these policies are genuinely
self-propelled rather than advected: a coherent alternating top-down street
grows behind the caudal region, compact alternating Lambda2 structures remain
attached to the active tail, and the fish follows a broad target-directed
turn without collision, wake breakup, or instability before capture.

The half-cycle envelope-redistribution sample is the sole executable variant
outside that narrow comparison band. It preserves capture and both coherent
wake views, improves score from the replicated geometry range
`[-0.20606, -0.20578]` to `-0.20041` and mean distance to `2.08855L`, but
arrives later at `18.8265T`. Its center follows a meaningfully lower route
(`min y=9.6129L` rather than `9.9819--10.1669L`). Its anterior/posterior
rate contact (`11.07%/14.93%`) and projected-action contact
(`60.85%/73.27%`) overlap the capture band, so the evidence supports a route
allocation hypothesis, not demand relief. Peak planar force and yaw moment
remain within the captured comparison envelope.

Inherited completed failures constrain the replay: joint-velocity phase,
removing correcting-yaw release, cadence scheduling, and either increasing or
decreasing posterior-only wave authority retained energetic wakes but produced
wrong-route exits. Pointwise rate barriers removed rate contact while losing
capture. The candidate therefore preserves displacement-only phase, target-
owned differential mean curvature, non-inverting response release, common
two-joint scheduling, posterior lag, cadence, and final acceleration
projection.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: sensor-modulated half-cycle amplitude redistribution within a coupled traveling rhythm
transferable_invariant: bounded rhythmic effort can be redistributed between observed beat halves while preserving the common propulsive carrier and target-owned mean curvature
nontransferable_details: published gains, duty ratios, clock phase, robot or species kinematics, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target side and centered anterior joint displacement to redistribute only the existing common amplitude-relief envelope; keep both curvature shares, cadence, and posterior lag unchanged
falsification: reject if capture or either coherent wake view is lost, the lower route and mean-distance separation fail to repeat beyond finite variation, arrival cost dominates the integral gain, or saturation and planar loads materially worsen

## Single-candidate hypothesis

Replace only the prefill's response-coupled amplitude relief with the completed
half-cycle redistribution policy. Geometry retains ownership of mean relief;
the target-aligned displacement half receives less relief and the opposed half
more, through a bounded positive factor with `0.50` redistribution already
evaluated in the sampled solver. This is an exact architectural replication,
not scalar tuning and not a claim about the new post-exit CFD result.

Accept the mechanism as reusable only if a second evaluation captures with
both wake rows intact and again separates in lower-route topology, mean
distance, or score without materially worse loads. If the result falls back
inside the geometry-only repeat band, retain the simpler geometry schedule and
classify the apparent lead as finite variation; if capture is lost, reject the
redistribution around this carrier.
