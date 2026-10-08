# Evidence-selected v41 candidate after the nominal-replication stall

## Visual diagnosis before candidate selection

- The four sampled solver policies, `4480`-row trajectories, and combined
  keyframe sheets are byte-identical. Each rollout uses direct uniform
  still-water initialization (`U_infinity=[0,0,0]`), no cylinders, and no
  prewarm; each captures at `24.640015T` with minimum/final distance
  `0.748356L`, score `-0.448328283`, and 284 moving-window shifts. These are
  deterministic nominal replications, not four distinct mechanisms or
  evidence of wake robustness.
- I inspected the combined sheet from release through termination in both
  views. The top-down row begins wake-free, then shows self-propelled diagonal
  progress, a coherent alternating mid-plane vortex street, and a compact
  transverse hook through the target disk. The oblique row retains compact
  three-dimensional Lambda2 structures through that hook. Zero background
  flow rules out passive advection, and there is no visible wake breakup,
  out-of-plane escape, collision, or numerical instability.
- The trace corroborates the visual diagnosis: peak absolute planar
  body-force/yaw-moment coefficients are `0.02303/0.03169/0.01559`, neither
  joint occupies a hard stop, total exact-rate exposure is `13.839%`, and the
  capture-radius crossing margin is `0.001644L`. Local body-frame crossflow
  begins at zero and remains in the fish's endogenous still-water wake class
  (peak absolute value `0.01134U`); it is not evidence of an imposed wake
  disturbance.
- No termination failure or failed keyframe sheet is present in the sampled
  examples, so the failure-side comparison is limited to inherited audited
  results. Posterior reference-velocity feedforward changed the far route and
  missed at `0.993183L`, while two dual-joint rate barriers missed at
  `0.848--0.933L`; all retained coherent wakes despite better rate statistics.
  Nearby posterior-only allocation, headroom redistribution, and coupled
  anti-windup also consumed capture margin without creating a new trajectory,
  load, or constraint class. Those negatives rule out another widespread
  phase correction, rate brake, terminal allocator, or scalar tune.

## Candidate hypothesis

Keep the current v41 terminal phase-allocation policy as this workspace's
exactly one candidate, byte-identical in dynamics and parameter schema to the
four sampled policies. Preserve its observed-state anterior phase anchor,
lagged posterior traveling bend, normalized body-frame predicted-miss
corridor, coupled phase-compatible terminal residual, posterior stopping-
stroke reserve, and posterior rate coast.

The bookshelf's wake-disturbance residual is not adopted. A direct-uniform
still-water trace can calibrate the nominal self-wake envelope, but it cannot
identify the sign or scale of an external-disturbance correction. Adding such
a residual now would contradict the inherited locality boundary and would
turn an unevidenced flow signature into a route command. Post-exit evaluation
should reproduce capture, the coherent route, zero hard-stop occupancy, and
the low-load class. Reject the selection on nominal non-replication. A later
disturbance residual requires matched nominal/disturbed evidence and must be
null before a divergent normalized body-frame wake signal appears.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: separate slow target-route steering from bounded fast disturbance rejection while preserving the state-inferred traveling-bend phase anchor
transferable_invariant: treat disturbance rejection as a residual driven by a measured body-frame signature distinct from nominal self-generated wake motion, and preserve the propulsive oscillator when that signature is absent
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, cylinder layouts, capture geometry, and task-specific routes
policy_translation: retain v41 unchanged because the normalized still-water observations establish only the endogenous wake envelope; require a future matched disturbed rollout before adding any flow, force, moment, or yaw residual
falsification: reject the retained candidate if nominal capture, coherent wake, zero hard stops, or the low-load class fails to repeat; reject any future wake residual if it activates on this nominal route, changes the far trajectory before an evidenced disturbance, or fails to improve a matched disturbed comparator

## Evaluation boundary

Formal CFD is reserved for the post-worker evaluator. The current evidence
supports selecting the existing mechanism but does not establish robustness
to reflected poses, perturbed releases, or external wakes.

## Static validation

- The single materializable candidate remains byte-identical to all four
  sampled v41 policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`);
  no sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account. Its three specified no-CFD checks
  were therefore run directly and separately: reusable-guidance semantics,
  the Julia public contract, and the solver editable-boundary audit all pass.
  The contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves every one of the 87 direct
  `params.FIELD` references among the 89 fields returned by
  `target_policy_params()`.
