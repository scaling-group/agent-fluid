# Evidence-selected multi-wake policy after the nominal semantic stall

## Visual diagnosis before candidate selection

- The four current solver samples have identical policy, `4480`-row
  trajectory, and combined-keyframe hashes.  All satisfy direct uniform
  still-water initialization (`U_infinity=[0,0,0]`) with no cylinders or
  prewarm, and all capture at `24.640015T` with minimum/final distance
  `0.748356L`, mean distance `2.347937L`, score `-0.448328283`, and 284
  moving-window shifts.  This is deterministic nominal replication, not four
  distinct controller tests.
- I inspected the combined sheet from release through capture in both views.
  The top-down vorticity row begins wake-free, then shows self-propelled
  diagonal progress, a coherent alternating street, and a bounded late hook
  through the target disk.  The oblique Lambda2 row shows compact
  three-dimensional structures persisting through the hook.  Zero background
  velocity rules out passive advection, and there is no visible wake breakup,
  out-of-plane escape, collision, or numerical instability.
- The trace cross-check agrees with the images: peak absolute body-frame
  planar force/yaw-moment coefficients are
  `0.02303/0.03169/0.01559`; neither joint reaches its position hard stop,
  although both touch the rate limit.  The terminal head is inside the capture
  disk at `0.748356L`, while measured yaw rate remains high
  (`1.88723 rad/T`), so success is a narrow dynamic crossing rather than a
  settled hold.
- No termination failure or distinct trajectory is available among the
  current samples, so there is no failed current sheet to compare.  The most
  informative inherited controls are the posterior-only redistribution
  (`24.673016T`, `0.748776L`, `-0.448773`) and coupled anti-windup
  (`24.656513T`, `0.749603L`, `-0.449516`): both retain the coherent route and
  low-load class while consuming capture margin without improving the
  constraint class.  The stronger inherited failures—dual-joint rate barriers
  and posterior reference-velocity feedforward—lower saturation statistics
  but alter the far route and lose capture.  These results reject another
  terminal authority redistribution or widespread phase correction.
- The assigned parent contains three consecutive completed v41 selections,
  and the other sampled optimizer logs select the same byte-identical policy.
  Their later CFD outcomes add reproducibility only; they do not expose a new
  body-frame disturbance, trajectory topology, termination class, or
  robustness axis.

## Candidate hypothesis

Keep exactly one candidate: the current v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to the four successful sampled
solvers.  Preserve the state-feedback anterior phase anchor, lagged posterior
traveling bend, normalized body-frame projected-miss corridor, bounded coupled
half-cycle steering, posterior stopping-stroke reserve, and posterior rate
coast.

This is an evidence-selected negative result after a semantic stall, not a
same-worker CFD claim and not scalar tuning.  The bookshelf offers no supported
new active mechanism: the observed wake is already coherent and low-load;
approach holds and terminal reallocations have regressed; and direct-uniform
still water supplies no diagnosed external wake disturbance from which to
calibrate the sign, scale, or gate of force/flow feedback.  Adding a dormant
residual would change code without testing a mechanism, while activating one
on the self-wake would violate the evidence boundary.  The post-worker rollout
should reproduce capture, the coherent two-view wake, zero joint hard-stop
occupancy, and the low-load class.  Reject this selection on nominal
non-replication.  A later policy change should instead wait for reflected,
perturbed-pose, or actually disturbed evidence and must remain null before its
new normalized body-frame trigger appears.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, asymmetric robotic-fish turning, and sensor-modulated terminal approach control
source_mechanism: preserve an anterior phase anchor and posterior lag, allocate bounded steering by observed joint phase, and add disturbance or approach feedback only for a diagnosed measured error
transferable_invariant: stable propulsion comes from an observed-state traveling bend, while any additional correction must be localized by a normalized body-frame error and must not reclaim safety-filtered effort through another joint
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, fixed capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, compatible lagged-wave half-cycle gate, anterior phase anchor, and posterior safety filters; add no uncalibrated flow residual, approach hold, scalar gain, or terminal allocator
falsification: reject if nominal evaluation loses capture, coherent wake, zero hard-stop occupancy, or the low-load class; reject the retained phase gate on held-out evidence if it suppresses necessary correction, and reject any future residual that activates before a divergent normalized body-frame signal

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The present evidence
supports the single retained nominal candidate but does not establish
robustness to reflections, changed release poses, imposed inflow, or external
wake disturbances.

## Pre-evaluation validation

- The single materializable candidate retains LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  matching all four current successful samples.  No sibling candidate was
  created.
- The reusable-guidance semantic check passes after removing the duplicate
  assigned-parent marker from the rendered workspace README.  The Julia public
  contract returns finite accelerations
  `(-14.3858335, 0.0005062)`, and the solver editable-boundary check passes.
- The deterministic schema audit resolves every one of the `87` direct
  `params.FIELD` references among the `89` fields returned by
  `target_policy_params()`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD commands were run
  directly and separately and pass.  Formal CFD remains reserved for the
  post-worker evaluator.
