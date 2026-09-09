# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled solver rollouts satisfy the direct-uniform experiment
contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
dynamics, and `termination=capture`. I inspected both the top-down vorticity
and oblique body/Lambda2 rows for all four combined sheets, and compared the
strongest current capture with the inherited velocity-predicted phase failure.
The visual claims below were cross-checked against `wake_metrics.csv`,
`wake_diagnostics.json`, controller sources, the assigned parent guidance, and
inherited optimizer notes.

The strongest current sample (`solver_02eaf03fe1d2`) is visibly self-propelled:
it follows a broad monotonic target-directed curve, forms a coherent
alternating top-down street, and retains compact caudal Lambda2 structures
through first crossing. Its body-frame misalignment schedule reduces only the
anterior oscillator envelope by at most `15%`; it captures at `18.65050T`,
with mean scored distance `2.09340L` and score `-0.206060`. The assigned
parent's executable policy is identical and independently captures at
`18.79899T`, with mean distance `2.10189L`. The clean displacement-half-cycle
carrier captures at `18.88149T` and `2.10234L`. The response-coupled schedule
also retains the same wake/route class and captures at `18.66150T` and
`2.09362L`. These results establish capture preservation and a sometimes-useful
route lead for misalignment scheduling, but not demand relief: the current
geometry schedule still contacts the acceleration envelope on about
`61.0%/73.2%` and the joint-rate envelope on about `11.0%/15.1%` of
anterior/posterior rows.

The informative inherited failure separates wake production from route
control. Adding normalized anterior joint velocity to the displacement phase
keeps an energetic top-down street and compact three-dimensional caudal
structures, yet bends downward past the target, approaches only `3.56872L`,
and exits left at `28.64951T` with final distance `9.19287L`. The candidate
must therefore preserve displacement-only phase, target-owned curvature sign,
and one-sided response release. Terminal velocity residuals, range-only relief,
bearing-release compounds, and pointwise rate barriers are also excluded by
the inherited evidence because they either remain inside repeat variation or
lose capture.

## Single-candidate policy hypothesis

Keep normalized target geometry, differential mean curvature, displacement-only
half-cycle steering, correcting-yaw response release, the state-feedback
oscillator, posterior lag, and final acceleration projection unchanged. Add
one gait-allocation mechanism: when misalignment reduces the anterior rhythmic
envelope, scale the observed centered anterior displacement and lag term in the
posterior target by the inverse envelope ratio. This preserves their normalized
posterior traveling-wave component while the anterior sweep is relieved; the
scale returns continuously to one at alignment and is bounded by the existing
`15%` relief. Mean-curvature shares and target-owned sign are not scaled.

The hypothesis is that separating anterior redirect relief from posterior
propulsion will retain the captured route and both coherent wake views while
avoiding the speed cost of reducing the whole two-joint wave. This is not a
claim of lower demand. Falsify it if capture is lost, arrival or mean distance
leaves the sampled `18.650--19.052T` and `2.0934--2.1024L` capture band, the
downward/left topology returns, posterior angle/rate contact or planar loads
materially worsen, or either wake view loses its coherent traveling structure.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and closed-loop robotic-fish CPG gait modulation
source_mechanism: use anterior body motion to sustain and steer a traveling bend while retaining posteriorly emphasized motion for reactive thrust
transferable_invariant: a geometry-scheduled redirect may reduce anterior rhythmic sweep without proportionally removing the normalized posterior traveling-wave component, provided target-owned curvature sign and observed phase remain unchanged
nontransferable_details: published amplitudes, dimensional frequencies, CPG gains, species-specific envelopes, full-body waveforms, motor models, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: retain the captured body-frame displacement-phase carrier; during the existing bounded misalignment relief, compensate only the centered displacement-plus-lag component of the posterior target by the inverse anterior envelope ratio while leaving both mean-curvature shares unchanged
falsification: reject if capture or either coherent wake view is lost, the route leaves the sampled capture band, target-owned sign or displacement phase changes, posterior saturation or planar loads worsen materially, or returned acceleration exceeds the owned envelope
