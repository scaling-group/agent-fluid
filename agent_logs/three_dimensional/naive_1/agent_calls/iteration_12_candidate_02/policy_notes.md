# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled evaluations satisfy the frozen evidence contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders
or prewarm, finite moving-window dynamics, and `capture`. I inspected the
combined sheets for the best-scored sampled capture (`solver_072da2f3a45e`)
and the assigned parent's inherited phase-leading failure
(`solver_4b5a9b1731af`), including both the top-down vorticity and oblique
body/Lambda2 rows, and cross-checked them against `wake_metrics.csv`,
`wake_diagnostics.json`, trajectory histories, executable policies, assigned
parent guidance, and inherited optimization notes.

The best sample is self-propelled rather than advected. From release to first
crossing it follows a broad target-directed curve, builds an alternating
top-down street, and retains compact caudal Lambda2 structures. It captures at
`0.74966L` in `19.05201T`, with mean scored distance `2.09874L` and score
`-0.210566`. The other three current samples remain in the same useful
route/wake class and capture in `18.88149--19.01899T` with mean distances
`2.09994--2.11536L`. The best sample's range-only `20%` amplitude relief is
not established as demand relief: its `60.1%/72.8%` far-regime acceleration
contact becomes `65.6%/78.0%` below `1.5L`, overlapping the no-relief family.
Its small score margin is inside finite repeat variability.

The inherited phase-leading controller demonstrates that coherent propulsion
does not guarantee route control. Its top-down street and compact caudal 3D
structures persist while the body turns onto a long downward path, approaches
only `3.56872L`, and exits left at `28.64951T` and `9.19287L`. Adding
`0.35*phi1_dot/omega` to the displacement-based half-cycle coordinate was the
only policy mechanism change from the captured geometry-authoritative family.
Across that failure the target-forward alignment averages only `0.305`, versus
`0.953--0.965` in current captures; nevertheless speed remains `0.699L/T` and
acceleration contact `64.6%/71.6%`. Later workers should therefore avoid any
velocity-led phase anticipation around this carrier unless it first restores
capture; wake coherence, action projection, or continued translation cannot
rescue a wrong route.

The sampled carrier already has enough bounded curvature to capture, but it
keeps nearly full rhythmic authority even when the target leaves the forward
body axis. A safer distinct experiment is to let persistent target geometry
change the ratio of steering authority to gait amplitude, without changing
curvature sign, phase, lag, frequency, or the final action projection.

## Single-candidate policy hypothesis

Use the sampled projected displacement-only half-cycle carrier without the
unestablished instantaneous lateral-velocity route residual. Compute the
bounded lateral target direction cosine `abs(target_body_L[2])/distance_L` and
continuously reduce only the Van der Pol amplitude envelope by at most `15%`
as lateral error grows. The absolute anterior/posterior curvature shares stay
unchanged, so a misaligned fish has greater steering-to-gait authority; as the
target returns ahead, the full traveling-bend envelope returns. The maximum
relief is deliberately below the sampled safe `20%` range-only relief, and no
world heading, clock, route, flow phase, or case identity is used.

Expect the coherent captured wake class to survive, with less propulsive
commitment during large target-angle excursions and no velocity-led phase
anticipation. Falsify the mechanism if capture is lost; the high/downward exit
topology appears; arrival or mean distance leaves the sampled successful band;
rate or acceleration contact, force, or moment worsens; or the top-down street
or oblique caudal structures lose coherence. The new CFD outcome is unavailable
to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish CPG gait modulation
source_mechanism: prioritize bounded mean curvature while target alignment is poor, then continuously restore the propulsive rhythm as alignment responds
transferable_invariant: persistent normalized body-frame target geometry may schedule the ratio of route-curvature authority to rhythmic gait amplitude without changing target-owned sign or introducing a clocked phase
nontransferable_details: published gains, dimensional beat frequencies, C-start timing, duty ratios, motor models, species-specific kinematics, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: preserve the captured two-joint displacement-phase carrier and absolute differential-curvature shares; use bounded lateral target direction cosine to mildly reduce only its oscillator amplitude envelope during misalignment
falsification: reject if capture or coherent wake is lost, the inherited downward/left exit returns, distance integral or arrival leaves finite capture variability, saturation or planar loads worsen, steering sign changes, or returned acceleration exceeds the owned envelope
