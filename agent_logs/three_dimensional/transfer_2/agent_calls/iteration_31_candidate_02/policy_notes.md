# Evidence-selected v41 candidate after coupled anti-windup falsification

## Visual diagnosis before candidate selection

- All four assigned solver examples are exact v41 replications: their policy,
  `4480`-row trajectory, and combined keyframe-sheet hashes match.  Each uses
  direct uniform still-water initialization (`U_infinity=[0,0,0]`), no
  cylinders or prewarm snapshot, and captures at `24.640015T` and
  `0.748356L`, with mean distance `2.347937L`, score `-0.448328283`, and 284
  inertial moving-window shifts.  The repetition establishes deterministic
  nominal behavior, not four different mechanisms or held-out robustness.
- I inspected the combined v41 sheet from release through capture in both
  views.  The top-down row starts wake-free, then shows self-propelled diagonal
  progress, an orderly alternating mid-plane vortex street, and a compact
  transverse hook through the target disk.  The oblique row retains paired,
  compact three-dimensional Lambda2 structures through that hook.  There is
  no background current that could passively advect the fish, and no visible
  wake breakup, out-of-plane escape, or collision-like terminal event.  The
  trajectory agrees: peak absolute planar body-force/yaw-moment coefficients
  are `0.02303/0.03169/0.01559`, neither joint occupies a hard stop, and the
  terminal head crossing occurs with a `0.001644L` capture margin.
- No termination failure is present among the assigned visual examples.  The
  most informative distinct failure is therefore inherited rather than a
  current keyframe sheet.  The completed v43 coupled anti-windup test first
  diverges only at `22.044T` and `2.052L`, but captures three integration rows
  later at `24.656513T`, reduces crossing margin to `0.000397L`, worsens mean
  distance to `2.348909L`, and lowers score to `-0.449516`.  It creates no new
  load or command class: peak coefficients remain
  `0.02313/0.02974/0.01559`, while raw acceleration-envelope exposure is
  essentially unchanged (`73.55%` versus v41's `73.59%`).
- That result complements the assigned parent's v42 negative.  Reclaiming
  safety-filtered posterior effort through the anterior phase anchor crosses
  one row earlier but worsens final/mean distance to `0.749001/2.348455L`,
  raises raw acceleration-envelope exposure to `74.124%`, and supplies no rate
  or load-class improvement.  V43 instead vetoes the anterior residual when
  the posterior filter rejects its share and also regresses.  Posterior
  stroke/rate safety is therefore a joint-local allocation decision on this
  established hook, not an instantaneous coupling signal for modifying the
  anterior oscillator in either direction.

## Candidate hypothesis

Select the existing v41 terminal phase-allocation policy as this workspace's
exactly one candidate, byte-identical in dynamics and parameter schema to all
four current successful samples.  Preserve its observed-state anterior phase
anchor, lagged posterior traveling bend, normalized body-frame projected-miss
corridor, coupled phase-compatible terminal residual, posterior stopping-stroke
reserve, and posterior rate coast.  Do not adopt either v42's inverse headroom
transfer or v43's realized-follower anti-windup.

This is completed-evidence selection rather than a scalar edit or a claim
about the unevaluated child.  Post-exit evaluation should reproduce capture,
the coherent route and three-dimensional wake, zero hard-stop occupancy, and
the low-load class.  Reject the selection if nominal replication fails.
Separately test reflection or release-pose perturbations before treating the
coupled phase allocation as generally robust; the fixed nominal rollout
cannot reveal whether asynchronous joint safety becomes harmful on a truly
different route.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish control and asymmetric fish turning
source_mechanism: place bounded sensory steering within an observed anterior-to-posterior traveling bend while retaining its phase anchor and posterior lag
transferable_invariant: infer beat phase from joint state and spend an existing target-derived residual on the compatible half-cycle without treating independently constrained joints as interchangeable instantaneous authority
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, robot or species kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant body-frame projected-miss residual and lagged-wave half-cycle gate, with the anterior phase anchor and posterior joint-local safety filters left independent
falsification: reject if capture, far-route locality, coherent wake, zero hard-stop occupancy, or the low-load class fails to repeat, or if reflected or perturbed evidence shows that the retained phase allocation removes necessary route correction

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The current candidate's
outcome is not evidence available to this worker.

## Pre-evaluation validation

- The selected candidate has LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  matching all four assigned v41 samples.  This workspace contains one
  materializable candidate and no sibling candidate was created.
- The configured check-runner agent was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account.  Its three declared
  no-CFD commands were therefore run directly and separately after removing
  the duplicate assigned-parent marker from the rendered workspace README.
  Reusable-guidance semantics, the Julia policy contract, and the solver
  editable-boundary audit all pass; the contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
