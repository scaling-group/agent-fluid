# Evidence-selected v41 multi-wake target-policy candidate

## Visual diagnosis before candidate selection

- The four current solver examples are byte-identical v41 rollouts: candidate,
  trajectory, and combined keyframe sheet all match.  Each satisfies the
  frozen direct-uniform still-water contract (`U_infinity=[0,0,0]`, no
  cylinders or prewarm) and captures at `24.640015T`, with minimum/final
  distance `0.748356L`, mean distance `2.347937L`, score `-0.448328283`, and
  284 moving-window shifts.
- I inspected the combined sheet from release through termination in both
  rows.  The top-down row begins wake-free, then shows self-propelled diagonal
  progress with a coherent alternating vortex street and a bounded transverse
  hook through the target disk.  The oblique row shows compact, persistent
  three-dimensional Lambda2 structures rather than passive advection,
  out-of-plane escape, or numerical breakup.  The metrics and diagnostics
  agree: capture is stable, planar body-force/yaw-moment peaks remain in the
  low `0.023/0.032/0.0156` class, and sampled posterior hard-stop occupancy is
  zero.
- No failed rollout or failed keyframe sheet is present in the current
  `solver_examples`; all four are exact successful replicas.  The most
  informative available visual comparator is the sampled v42 posterior-only
  terminal allocation.  It remains in the same coherent route/wake class but
  regresses to `24.673016T`, `0.748776L`, mean distance `2.348364L`, and score
  `-0.448772903`.  The inherited v42 headroom-redistribution result supplies
  the same control boundary more sharply: moving safety-filtered posterior
  effort to the anterior phase anchor consumed capture margin and raised raw
  acceleration-envelope exposure without improving rate or load class.
- The informative termination failures are therefore inherited audited
  negatives rather than available visual samples: posterior
  reference-velocity feedforward changed the established route by `8T`,
  missed at `0.993183L`, and exited left, while two broad dual-joint rate
  barriers also converted capture into pass-and-turn exits despite lower rate
  occupancy and coherent wakes.  These results rule out another widespread
  phase correction, dual-joint brake, or saturation-statistic optimization.

## Candidate hypothesis

Keep exactly one candidate: the current v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to the four replicated solver
examples.  Preserve the anterior state-feedback phase anchor, lagged posterior
traveling bend, normalized body-frame predicted-miss corridor, bounded
steering priority, posterior stopping-stroke reserve and coast guard, and the
existing terminal residual applied only on its compatible state-inferred
half-cycle.

This is evidence selection after a stalled semantic sequence, not scalar gain
tuning and not a claim about the unevaluated child.  The shelf's approach-hold
and wake-residual primitives do not survive the present evidence: the visible
wake is already coherent and low-load, carrier holds have regressed, and no
measured wake disturbance or failed current route establishes a sign and scale
for new flow/force feedback.  Repeating v41 is preferable to adding an
unidentified disturbance term or another terminal allocator.  Post-exit CFD
should reproduce capture, the coherent route, zero posterior hard-stop
occupancy, and the low-load class.  Reject the selection on nominal
non-replication, and do not infer held-out robustness until reflected,
perturbed-pose, or actual wake-disturbance rollouts test it.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: allocate bounded sensory steering within a stable traveling bend while preserving its anterior phase anchor and posterior lag
transferable_invariant: infer beat phase from joint state and spend an existing body-frame target residual only on the compatible half-cycle without reclaiming safety-filtered effort through the other joint
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant lagged-wave phase gate, anterior phase anchor, posterior safety filters, and normalized body-frame predicted-miss residual without adding a new gain or route signal
falsification: reject if nominal replication loses capture, the coherent wake, the v42 distance and score advantage, zero posterior hard-stop occupancy, or the low-load class; separately reject on held-out poses or wakes if phase selection removes necessary correction

## Pre-evaluation validation

- The selected candidate remains byte-identical to all four current v41
  samples (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  This workspace contains one selected candidate; no sibling was created.
- The reusable-guidance semantic check passes after removing the duplicate
  assigned-parent marker from the rendered workspace README.  The public
  policy contract returns two finite accelerations (`-14.3858335`,
  `0.0005062`), and the solver editable-boundary check passes.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
- The configured check-runner agent was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account.  Its three specified
  no-CFD commands were therefore run directly and separately, and all pass.
  Formal CFD remains reserved for the post-worker evaluator.
