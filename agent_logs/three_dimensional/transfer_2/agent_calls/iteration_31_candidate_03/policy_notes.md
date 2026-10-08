# Evidence-selected replicated terminal phase-allocation candidate

## Visual diagnosis before candidate selection

- The four assigned solver examples are byte-identical copies of the same v41
  policy, trajectory, diagnostics, and combined keyframe sheet.  Each satisfies
  the frozen contract: direct uniform still water (`U_infinity=[0,0,0]`), no
  cylinders or prewarm, and the L64 inertial moving window.  Each captures at
  `24.640015T` with minimum/final distance `0.748356L`, mean distance
  `2.347937L`, score `-0.448328283`, and 284 moving-window shifts.  These are
  deterministic nominal replications, not four mechanisms or held-out tests.
- I inspected both rows of the combined v41 keyframe sheet from release through
  capture and compared them with the distinct inherited posterior-only v42
  sheet.  The top-down views begin wake-free, show self-propelled diagonal
  progress with an alternating mid-plane vortex street, and finish with the
  same compact transverse hook into the capture disk.  The oblique views retain
  compact three-dimensional Lambda2 structures through capture, without
  passive advection, out-of-plane escape, or wake breakup.  V42 has no visibly
  different route or wake class; its regression is measurable only in the
  histories and terminal crossing.
- The diagnostics support the visual reading.  V41 retains zero sampled
  posterior hard-stop occupancy, `73.594%` raw acceleration-envelope exposure,
  and peak absolute body-frame planar force/yaw-moment coefficients
  `0.0254/0.0319/0.0156`.  V42 moves the same phase-selected terminal residual
  off the anterior anchor and into the posterior follower, but captures later
  at `24.673016T`, worsens final/mean distance to `0.748776/2.348364L`, and
  scores `-0.448772903`.  The sampled optimizer guidance adds two compatible
  negatives: transferring safety-rejected posterior effort into anterior
  headroom consumes capture margin and raises raw acceleration exposure, while
  scaling anterior effort down to match the posterior safety filter delays
  capture, reduces the crossing margin to `0.000397L`, and worsens score to
  `-0.449516`.
- No current sampled rollout has a failed termination.  The informative
  negative comparator is therefore the visually inspected, distinct v42
  regressive capture plus inherited failure boundaries: posterior
  reference-velocity feedforward and broad dual-joint rate barriers lower
  saturation statistics but change the established far route and lose capture.
  Carrier holds, course-gain variants, corridor-threshold variants, and the
  two opposite joint-coupling responses have likewise failed to improve the
  captured trajectory class.

## Candidate hypothesis

Keep exactly one candidate: the current v41 terminal phase-allocation policy,
byte-identical to the four assigned evaluated solvers.  It preserves the
observed-state anterior phase anchor, posterior lagged traveling bend,
normalized body-frame course and predicted-miss feedback, bounded
steering-priority allocation, posterior stopping-stroke reserve and rate coast,
and the terminal target residual spent only on its compatible lagged-wave
half-cycle.

This is evidence selection after three completed nominal iterations without a
new mechanism or semantic improvement.  It is not scalar tuning and does not
claim a result for the unevaluated child.  A shelf-inspired wake residual is
not identifiable because the current experiment has no imposed wake and the
rollout supplies no calibrated disturbance sign or scale.  A terminal
yaw/slip hold is also rejected for this candidate: yaw reverses within the beat,
lateral slip remains positive throughout the final approach, and the completed
carrier-hold and joint-redistribution controls do not establish which bounded
two-joint action would reduce slip without consuming the narrow capture margin.
The post-worker evaluation should reproduce capture, the coherent route, zero
posterior hard-stop occupancy, and the low-load class.  Reject nominal
selection if those fail to repeat; separately, do not infer robustness until a
reflected pose, perturbed release, or actual wake disturbance is evaluated.

bookshelf_consulted: true
source_domain: terminal approach control together with sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve a stable anterior-to-posterior traveling bend and admit bounded sensory correction only when an observed approach error has an identified actuator response
transferable_invariant: keep joint-state phase, posterior lag, and normalized body-frame target feedback; require a measured sign and scale before adding yaw, slip, force, flow, or moment feedback
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant predicted-miss residual, lagged-wave half-cycle gate, coupled joint shares, and posterior safety filters; do not add an uncalibrated disturbance or approach-hold residual after three nominal repetitions
falsification: reject if nominal capture, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class fails to repeat; reopen yaw/slip or wake residuals only when held-out evidence identifies a persistent error and actuator-response sign

## Validation scope

- Formal CFD is reserved for the post-worker evaluator.  This worker uses only
  completed evidence, source-level checks, and the configured no-CFD policy
  validator.
- The active candidate is byte-identical to all four assigned v41 policies (LF
  SHA-256 `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  No sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three commands were then run separately:
  the guidance-semantic check, public policy contract check, and solver
  editable-boundary check all pass.  The contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`; no
  field is missing.  The static dependency scan finds no direct elapsed-time,
  step, random, or file-I/O dependency, and the active candidate remains
  non-empty.
