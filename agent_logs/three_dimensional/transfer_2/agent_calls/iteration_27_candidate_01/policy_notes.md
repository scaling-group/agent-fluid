# Evidence-selected replicated terminal phase-allocation candidate

## Visual diagnosis before policy selection

- All four sampled solver results are byte-identical evaluations of the v41
  terminal phase-allocation policy.  Each uses direct uniform still water
  (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the L64 inertial moving
  window; each captures at `24.640015T`, minimum/final distance `0.748356L`,
  mean distance `2.347937L`, and score `-0.448328283`.
- The combined keyframe sheet was inspected from release through capture in
  both views.  The top-down row starts wake-free, then shows self-propelled
  diagonal progress, a coherent alternating mid-plane vortex street, and a
  bounded terminal left hook into the target disk.  The oblique row shows
  compact three-dimensional Lambda2 structures persisting through capture.
  There is no evidence of passive advection, out-of-plane escape, instability,
  or a collision-like terminal load event; the trace agrees, with peak planar
  body-force/yaw-moment coefficients about `0.0230/0.0317/0.0156`.
- No sampled failure keyframe exists: all four images, policies, and
  trajectories have identical hashes.  The informative failure comparison is
  therefore restricted to inherited audited logs.  Posterior reference-rate
  feedforward changed the established far route by `8T`, missed at `0.993183L`,
  and exited left at `37.1470T`; dual-joint rate barriers also converted
  capture into a pass-and-exit topology.  Those results rule out another broad
  phase/rate correction, not the terminal-local allocation retained here.
- Relative to the replicated v40 corridor parent recorded in inherited logs,
  v41 advances capture by `0.021999T`, lowers mean distance by `0.000236L`,
  improves score by `0.000242448`, and reduces final projected miss from
  `0.637713L` to `0.631928L`, while preserving the coherent route, zero
  posterior hard-stop occupancy, and the low load/rate classes.  The four
  current samples establish deterministic nominal replication, but no new
  trajectory class or held-out-pose evidence.

## Candidate hypothesis

Select the existing v41 policy as this workspace's exactly one candidate,
without changing its dynamics or parameter schema.  It preserves the anterior
state-feedback phase anchor, lagged posterior traveling wave, body-frame
predicted-miss corridor, steering-priority envelope, posterior stroke braking,
and steering-residual coast.  Its terminal collision-course residual remains
separate from mean curvature and is spent only on the observed lagged-wave
half-cycle aligned with the signed target-derived request.  This is evidence
selection of a replicated controller mechanism, not scalar-only gain tuning.

The post-exit evaluation should reproduce the v41-family capture and retain
the same coherent wake, far route, zero posterior hard-stop occupancy, and low
load/rate classes.  Reject this selection if capture, the measured arrival and
distance advantage over v40, or route locality fails to repeat.  Reflected or
perturbed tests must separately falsify the phase gate if it withdraws
necessary route-corrective steering; four deterministic copies of one nominal
rollout do not establish that generalization.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: bounded half-cycle asymmetry allocates sensory steering within a stable traveling bend instead of imposing continuous static curvature
transferable_invariant: preserve the observed anterior phase anchor and posterior lag, infer phase from joint state, and spend an existing bounded target-derived residual only on the half-cycle aligned with the requested turn
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant lagged-wave phase gate on the normalized body-frame predicted-miss residual while leaving the carrier and safety layers unchanged
falsification: reject if nominal replication loses capture, the v40 arrival/distance advantage, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class, and separately reject on held-out poses if the gate removes necessary corrective steering

## Pre-evaluation scope

- The candidate was intentionally left byte-identical to all four sampled v41
  policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD commands were
  therefore run directly and separately: the material reusable-guidance
  update, Julia public-policy contract, and solver editable-boundary checks all
  pass.  The policy probe returns two finite accelerations
  (`-14.3858335`, `0.0005062`).
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD is reserved for the post-worker evaluator.
