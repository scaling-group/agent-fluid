# Evidence-selected localized terminal phase-allocation candidate

## Visual diagnosis before candidate selection

- All four assigned solver examples are exact v41 replications: their policy,
  `4480`-row trajectory, and combined keyframe sheet hashes match.  Each uses
  direct uniform still-water initialization (`U_infinity=[0,0,0]`), no
  cylinders or prewarm snapshot, and captures at `24.640015T` and
  `0.748356L` with score `-0.448328283`.  The repetition demonstrates
  deterministic nominal behavior, not four mechanisms or held-out
  generalization.
- I inspected the combined v41 sheet from release through capture in both
  views.  The top-down row begins wake-free, then shows self-propelled diagonal
  progress, a coherent alternating mid-plane vortex street, and a compact
  transverse hook into the target disk.  The oblique row shows compact
  three-dimensional Lambda2 structures persisting through the hook.  There is
  no passive advection, out-of-plane escape, collision, or numerical breakup.
  The trace agrees: peak absolute body-frame planar force/yaw-moment
  coefficients are `0.02303/0.03169/0.01559`, neither joint reaches its hard
  stop, and total exact-rate exposure is `13.839%`.
- No termination failure is present among the assigned examples.  The most
  informative sampled regression is the inherited v43 coupled terminal
  anti-windup child.  Its combined top-down and oblique sheet stays in the same
  coherent route/wake class, but capture moves to `24.656513T`, final distance
  worsens to `0.749603L`, and score falls to `-0.449516228`.  It does not buy a
  constraint-class improvement: total exact-rate exposure is `13.897%`, both
  joint hard-stop occupancies remain zero, and peak coefficients remain in the
  same low `0.0231/0.0297/0.0156` class.  Scaling the anterior terminal share
  by the safety-filtered posterior realization therefore spends capture
  margin without a new physical benefit.
- The assigned parent and inherited logs provide consistent boundaries.
  Posterior-only and stroke-headroom redistributions also regress the narrow
  terminal crossing, while reference-velocity feedforward and dual-joint rate
  barriers alter the far route and lose capture despite better saturation
  statistics.  The current evidence supports locality and phase-compatible
  coupling, and supplies neither a measured disturbance nor a calibrated sign
  for adding wake-flow, force, or moment feedback.

## Candidate hypothesis

Select the current v41 policy as this workspace's exactly one candidate,
byte-identical in dynamics and parameter schema to the four replicated solver
examples.  Preserve its observed-state anterior phase anchor, lagged posterior
traveling bend, normalized body-frame projected-miss corridor, bounded steering
priority, posterior stopping-stroke reserve and coast guard, and the terminal
course residual spent through both joints only on the compatible lagged-wave
half-cycle.

This is completed-evidence selection after a semantically stalled sequence,
not scalar-only tuning and not a same-worker CFD claim.  The bookshelf's
disturbance-rejection and approach-hold options are not adopted: the wake is
already coherent and low-load, prior terminal holds and allocation changes
regressed, and no sampled wake event establishes a new feedback sign or scale.
Post-exit CFD should reproduce capture, the coherent route, zero hard-stop
occupancy, and the low-load class.  Reject the selection on nominal
non-replication; separately test the phase gate on reflected or perturbed poses
before treating it as robust beyond this fixed rollout.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: embed bounded sensory steering in a stable anterior-to-posterior traveling bend while preserving the phase anchor and posterior lag
transferable_invariant: infer beat phase from joint state and spend an existing normalized body-frame target residual only on the compatible half-cycle without reclaiming safety-filtered effort or independently winding one joint down
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave phase gate, coupled joint shares, anterior phase anchor, and posterior safety filters; add no new scalar, residual, route, or disturbance term
falsification: reject if nominal replication loses capture, coherent wake, zero hard-stop occupancy, low-load class, or the measured advantage over the coupled anti-windup child; reject on held-out poses if phase selection removes necessary correction

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The completed rollouts
support selection of the existing mechanism but do not establish robustness to
reflections, changed release poses, or actual external wake disturbances.

## Pre-evaluation validation

- The selected candidate and all four assigned solver policies have LF
  SHA-256 `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`;
  the four completed trajectories and combined keyframe sheets are likewise
  byte-identical.  This workspace retains exactly one materializable candidate.
- The configured check-runner agent was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account.  Its three declared
  no-CFD commands were therefore run directly and separately: reusable-guidance
  semantics, the Julia public contract, and the solver editable-boundary audit
  all pass.  The contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
