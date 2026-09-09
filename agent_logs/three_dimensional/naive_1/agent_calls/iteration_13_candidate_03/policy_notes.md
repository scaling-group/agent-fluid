# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled solver evaluations satisfy the frozen rollout contract:
direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders, no prewarm, finite moving-window dynamics, and `capture`. I
inspected the combined sheets for the assigned parent's best-scored result
(`solver_02eaf03fe1d2`) and the inherited phase-leading failure
(`solver_4b5a9b1731af`), including both the top-down vorticity and oblique
body/Lambda2 rows. I cross-checked those views against `wake_metrics.csv`,
`wake_diagnostics.json`, dense trajectories, executable policies, assigned
parent guidance, and inherited optimization notes.

The assigned parent's `15%` body-frame turn-amplitude relief is the strongest
current finite result. It remains self-propelled, follows the same shallow
target-directed arc as the displacement-only carrier, retains an alternating
top-down street and compact caudal Lambda2 structures, and captures at
`0.74981L` in `18.65050T` with mean scored distance `2.09340L`. The sampled
displacement-only carrier captures at `18.88149T` and `2.10234L`; the other
current captures span `19.00799--19.05201T` and `2.09874--2.09994L`. The
parent result is therefore positive route evidence, although it is one
rollout and still needs replication. It is not demand-relief evidence:
acceleration contact is `60.96%/73.19%` and rate contact is
`11.06%/15.10%`, overlapping the baseline and terminal-qualifier samples.

The inherited velocity-led phase failure is the informative counterexample.
Its street and caudal vortices remain coherent, but the fish turns through the
useful route into a near-vertical downward path, approaches only `3.56872L`,
and exits left at `28.64951T` and `9.19287L`. Thus continued translation and a
visually organized wake cannot validate a steering observation.

The remaining response mechanism in the successful carrier releases
geometry-owned curvature when measured yaw has the correcting sign. A
trajectory reconstruction over the same eight-row observation window shows
that correcting yaw and decreasing body-frame bearing disagree on only
`0.12%` of the parent capture; their positive mean rates are similarly scaled
at `1.603` and `1.632 rad/T`. In the phase-leading exit they disagree on
`35.62%` of rows. This supports a narrowly attributable substitution: keep
target geometry as sign authority, but qualify curvature release by actual
bearing improvement rather than body rotation alone. It does not support
adding bearing rate as a signed route residual.

## Single-candidate policy hypothesis

Preserve the parent's captured displacement-phase carrier, differential
anterior/posterior curvature shares, `15%` misalignment-conditioned amplitude
relief, and final acceleration projection. Replace only the yaw-based response
gate with a bounded gate from `bearing_window_rate`: release up to the same
fraction of existing curvature only while the signed body-frame bearing is
moving toward center. Both observations have the same units and evidenced
scale, so retain the `1 rad/T` normalization rather than tuning a new gain.

The current direct-still-water route should remain close to the parent because
the two response signs almost always agree there, while the controller no
longer treats body rotation that fails to improve target bearing as sufficient
progress. Falsify the mechanism if capture is lost; arrival or mean distance
leaves the sampled successful band; the downward/left exit topology appears;
acceleration or rate contact, planar loads, or switching worsens; or either
the alternating top-down street or compact oblique caudal structures loses
coherence. The new CFD outcome is unavailable to this worker and is not
claimed as evidence.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-feedback robotic-fish CPG direction tracking
source_mechanism: maintain bounded geometry-driven curvature during redirect and release it continuously only when the observed route error is responding
transferable_invariant: persistent normalized body-frame target geometry owns turn sign, while measured progress of that same geometry may reduce but never invert the existing curvature request
nontransferable_details: published gains, dimensional beat frequencies, burst timing, duty ratios, motor models, species-specific kinematics, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: preserve the captured two-joint traveling-bend carrier and misalignment amplitude schedule; replace yaw-only release with a bounded release proportional to signed eight-row body-frame bearing improvement
falsification: reject if capture or coherent wake is lost, the inherited downward/left exit returns, route quality leaves finite capture variability, load or saturation worsens, curvature sign changes, or returned acceleration exceeds the owned envelope
