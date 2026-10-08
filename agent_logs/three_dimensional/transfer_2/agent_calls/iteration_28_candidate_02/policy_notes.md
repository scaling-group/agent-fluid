# Replicated coupled terminal phase-allocation candidate

## Visual diagnosis before candidate selection

- All four sampled solver policies, trajectories, and combined keyframe sheets
  are byte-identical v41 evaluations.  They satisfy the frozen experiment:
  direct uniform still water (`U_infinity=[0,0,0]`), no cylinders or prewarm,
  and the L64 inertial moving window.  Every copy captures at `24.640015T`,
  minimum/final distance `0.748356L`, mean distance `2.347937L`, score
  `-0.448328283`, and 284 storage-window shifts.  Four copies establish exact
  nominal reproducibility, not four distinct mechanisms or held-out evidence.
- The sampled v41 combined sheet was inspected from release through capture in
  both views.  The top-down row begins wake-free, then shows self-propelled
  diagonal progress, a coherent alternating mid-plane vortex street, and a
  bounded transverse hook into the target disk.  The oblique row shows compact
  three-dimensional Lambda2 structures persisting through capture.  There is
  no passive advection, out-of-plane escape, numerical breakup, or terminal
  collision-like load spike.  The metrics agree: peak absolute planar
  body-force/yaw-moment coefficients are `0.0230/0.0317/0.0156`, posterior
  hard-stop occupancy is zero, and sampled exact-rate exposure remains in the
  inherited roughly `13%` class.
- No termination failure exists among the four current solver samples.  The
  most informative available performance-failure comparison is therefore the
  pair of completed v42 allocation variants in inherited optimizer logs; their
  top-down and oblique sheets were also inspected.  Both preserve v41's
  coherent route and wake rather than revealing a propulsion defect, but both
  weaken its terminal crossing.  Moving all terminal residual authority to the
  posterior captures later at `24.673016T`, with `0.748776L` final distance,
  `2.348364L` mean distance, and score `-0.448772903`.  Transferring the
  posterior share to the anterior according to predicted stroke headroom
  crosses one integration row earlier at `24.634514T`, yet worsens final/mean
  distance to `0.749001/2.348455L`, reduces capture margin to `0.000999L`, and
  scores `-0.448985838`.  Its smaller terminal projected miss (`0.630655L`
  versus v41's `0.631928L`) is specifically not an improvement in the scored
  capture outcome.
- The inherited posterior reference-velocity feedforward remains the relevant
  termination failure boundary: it changed the established far route by `8T`,
  missed at `0.993183L`, and exited left at `37.1470T` despite a coherent wake
  and lower rate-limit occupancy.  Together, the evidence rejects both a broad
  phase/rate correction and another terminal authority redistribution.  It
  does not reject v41's localized coupled phase allocation.

## Candidate hypothesis

Keep the existing v41 policy byte-identical as this workspace's exactly one
candidate.  It preserves the anterior observed-state phase anchor, posterior
lagged traveling wave, normalized body-frame predicted-miss corridor,
steering-priority envelope, posterior stopping-stroke reserve, and
steering-residual coast.  Its extra collision-course residual is bounded,
inactive outside the existing terminal neighborhood, and spent through both
joints only on the observed lagged-wave half-cycle aligned with the signed
target-derived request.

This is evidence selection of the only replicated positive mechanism, not a
scalar-only gain tune.  The v42 results show that the coupled anterior/posterior
split is part of the currently successful mechanism: neither posterior-only
delivery nor stroke-headroom transfer improves it.  The post-worker evaluator
should reproduce the v41 capture, coherent wake, far route, low-load class,
zero posterior hard-stop occupancy, and its small arrival/distance advantage
over v40.  Reject the selection if any nominal replication is lost.  Separately
falsify the phase gate and coupled split on reflected or perturbed poses if they
remove necessary corrective steering; fixed-case replication does not establish
that generalization.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: bounded half-cycle asymmetry embeds sensory steering in a stable anterior-to-posterior traveling bend instead of replacing the rhythm with static curvature
transferable_invariant: preserve the observed anterior phase anchor and posterior lag, infer phase from joint state, and spend an existing bounded target-derived residual only during the aligned half-cycle while retaining the empirically successful two-joint coupling
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant body-frame collision-course residual, observed lagged-wave gate, coupled joint shares, and safety layers; do not adopt a new scalar or the two contradicted v42 redistribution schemes
falsification: reject if nominal replication loses capture, v41's v40 arrival and distance advantage, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class, and reject on held-out poses if the gate or coupled split removes required route correction

## Pre-evaluation scope

- The selected policy is byte-identical to all four sampled v41 policies (LF
  SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  This is completed-evidence selection and does not claim a same-worker CFD
  result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this ChatGPT account.  Its three declared no-CFD commands
  were therefore run directly and separately: reusable-guidance semantics,
  the Julia public policy contract, and the solver editable-boundary audit all
  pass.  The contract probe returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
- Formal CFD is reserved for the post-worker evaluator.  No same-worker CFD
  result is claimed.
