# Multi-wake candidate after a replicated nominal semantic stall

## Visual diagnosis before candidate selection

- I inspected the successful prefill's combined keyframe sheet from release
  through termination, including both the top-down mid-plane vorticity row and
  the oblique body/Lambda2 row.  The four sampled sheets, policies, and full
  trajectories are byte-identical.  Each evaluation starts directly from
  uniform still water (`U_infinity=[0,0,0]`) with no cylinders or prewarm and
  captures at `24.640015T`, minimum/final distance `0.748356L`, mean distance
  `2.347937L`, score `-0.448328283`, and 284 moving-window shifts.
- The release frame is wake-free.  Subsequent top-down frames show the fish
  self-propelling diagonally toward the target while shedding a coherent
  alternating street, then executing a bounded terminal hook through the
  capture disk.  The oblique row shows compact three-dimensional wake
  structures that persist through the hook.  Zero imposed flow rules out
  passive advection, and neither view shows collision, wake breakup,
  out-of-plane escape, or numerical instability.
- The trace supports the visual reading: peak absolute body-frame planar
  force/yaw-moment coefficients remain in the low
  `0.02303/0.03169/0.01559` class and neither joint reaches its position hard
  stop.  Both joints still touch their rate limits, raw acceleration-envelope
  exposure remains about `73.6%`, and terminal yaw rate is
  `1.88723 rad/T`.  Capture is therefore a narrow dynamic crossing, not a
  settled hold, but the inherited approach-hold and terminal redistribution
  controls already regressed score or consumed crossing margin.
- There is no distinct failure sheet among the current solver samples or the
  assigned parent's inherited log.  The most informative failure comparison
  available inside this workspace is the inherited route-changing controls:
  posterior reference-velocity feedforward missed at `0.993183L` and exited
  left, while two sign-symmetric velocity barriers missed at `0.933L` and
  `0.848L` and exited left.  All reduced saturation statistics yet destroyed
  the captured route.  The nearer posterior-only and headroom redistributions
  retained a coherent wake but consumed capture margin.  Together they rule
  out another widespread phase/rate correction, terminal authority transfer,
  or scalar tune.
- The assigned parent records three consecutive completed unchanged v41
  selections; all four current solver samples and all available sibling
  optimizer outcomes repeat the same policy, trajectory, and two-view wake.
  These evaluations establish deterministic nominal reproducibility, not a
  new controller mechanism, termination class, useful trajectory, or
  robustness axis.

## Candidate hypothesis

Keep exactly one materializable candidate: the prefilled v41 terminal
phase-allocation policy, byte-identical in dynamics and parameter schema to the
four sampled successful solvers.  Preserve its observed-state anterior phase
anchor, lagged posterior traveling bend, normalized body-frame projected-miss
corridor, phase-compatible coupled terminal residual, posterior stopping-stroke
reserve, and posterior rate coast.

This is an evidence-selected negative result after a semantic stall, not a
same-worker CFD claim and not scalar-only gain tuning.  The bookshelf does not
supply an identifiable new active mechanism for this fixed nominal rollout:
the self-generated wake is already coherent and low-load, the route captures,
and the available evidence contains no reflected pose, release perturbation,
or external-wake event that gives a new residual a calibrated sign, scale, or
activation boundary.  A mechanism designed to be null before such a divergent
body-frame trigger cannot be falsified here; activating it on the nominal
self-wake would contradict the inherited route-consistency boundary.  The
post-worker evaluator should reproduce capture and the established low-load
trajectory.  Reject this selection on nominal non-replication.  Future work
should first supply a genuinely divergent held-out trace, then test one
bounded mechanism that is null before its measured trigger appears.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated robotic-fish control, and wake-disturbance rejection
source_mechanism: preserve a state-inferred anterior-to-posterior traveling bend and add a bounded residual only when a measured disturbance is distinguishable from target error and the swimmer's own coherent wake
transferable_invariant: stable propulsion retains an observed-state phase anchor and posterior lag, while any added correction must be localized by a divergent normalized body-frame signal and must not reclaim safety-filtered effort through the other joint
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, fixed capture geometry, task-specific routes, and assumed wake timing
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave half-cycle allocation, anterior phase anchor, and posterior safety filters; add no unidentifiable flow, force, yaw, hold, scalar, or authority-redistribution term on the replicated nominal trace
falsification: reject if nominal evaluation loses capture, the coherent two-view wake, zero joint hard-stop occupancy, or the low-load class; reject any later residual if it activates before a divergent normalized body-frame trigger, changes the established far route, or fails to improve the held-out termination or useful trajectory

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The current evidence
does not establish robustness to reflection, release-pose perturbation, imposed
inflow, or external wake disturbance, and another nominal rollout cannot test
those properties.

## Pre-evaluation validation

- The single candidate remains byte-identical to all four current successful
  samples (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`);
  no sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account.  Its three declared no-CFD commands
  were then run directly and separately: reusable-guidance semantics, the
  Julia public contract, and the solver editable-boundary audit all pass.  The
  contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves every one of the `87` direct
  `params.FIELD` references among the `89` fields returned by
  `target_policy_params()`.
