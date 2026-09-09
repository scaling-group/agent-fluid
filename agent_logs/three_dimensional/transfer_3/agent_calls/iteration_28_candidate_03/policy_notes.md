# Helpful-moment residual-allocation replication

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture at `18.6560--18.7440T`. This cohort has no failed
  termination; the informative contrast is the strongest finite capture
  against the least efficient physical-response ablation and the assigned
  parent.
- I inspected the combined keyframe sheets for the best-scoring helpful-moment
  relief rollout, the worst-scoring phase-demodulated residual rollout, the
  assigned parent, and the stress-gated variant. From release through capture,
  every top-down row shows body-led translation and a coherent alternating
  posterior vorticity street. The oblique rows independently show compact
  three-dimensional Lambda2 structures shed behind the moving fish. The
  shallow route bends continuously onto the capture circle without passive
  advection, wake collapse, wasteful lateral excursion, collision, boundary
  approach, or instability. Local-flow RMS of `0.01807--0.01815U` and monotone
  distance progress agree with this reading; the sparse visuals do not resolve
  the small allocator differences by appearance.
- The assigned-parent actuator-consistent phase policy captures at `18.6725T`,
  score `-0.13362`, mean distance `2.02129L`, acceleration-limit occupancy
  `42.15%/76.11%`, and force/moment RMS `0.01350/0.00703`. Helpful yaw moment
  relieving only residual half-cycle amplitude captures at `18.6560T`, score
  `-0.13321`, mean distance `2.02115L`, occupancy `40.74%/75.74%`, and
  force/moment RMS `0.01328/0.00691`. Its `0.0165T` timing edge is smaller than
  the inherited `0.066T` same-hash parent spread, so it establishes compatible
  capture and effort relief, not robust route-speed improvement.
- The neighboring controls bound the mechanism. Adding a posterior-stress
  product delays capture to `18.7440T` with `0.01343/0.00699` loads. Modulating
  the primary phase path with a demodulated moment residual captures at
  `18.7165T`; it lowers load to `0.01309/0.00682` but worsens mean distance to
  `2.02337L`. Inherited optimizer results sharpen the negative result: a
  demodulated amplitude residual captures only at `19.1070T`, and a later
  stress-gated helpful-moment relief at `18.7825T`. Physical yaw response is
  therefore useful only as a small allocator for the already-redundant
  half-cycle channel; extra stress semantics or ownership of posterior phase
  are not supported.

## Policy hypothesis recorded before editing

Replicate the sampled amplitude-only helpful-moment allocator exactly on the
assigned-parent route controller. Preserve normalized body-frame bearing and
LOS-rate guidance, recoil-conditioned yaw response, distributed C-bend, the
state-feedback traveling carrier, response-reversing half-cycle steering,
persistent same-side posterior phase recruitment, and coefficient-norm-
preserving phase rotation. When body yaw moment aligns with the requested
response and recoil-conditioned yaw error is near closure, reduce only the
half-cycle amplitude-asymmetry limit. The carrier, mean route curvature, and
posterior phase actuator remain intact.

This is a deliberate robustness replication, not scalar tuning. Support
requires capture with both wake views coherent, arrival inside the inherited
`18.6560--18.7385T` parent/relief replication band, and no increase over the
sampled relief's `40.74%/75.74%` occupancy or `0.01328/0.00691` force/moment
RMS. A repeat outside that timing band or without effort relief falsifies the
apparent benefit and should send later workers to a genuinely beat-history
allocator rather than another instantaneous-moment gate. No external-wake
rejection claim follows from this low-flow still-water evidence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and wake-interaction studies
source_mechanism: sensor feedback modulates a bounded residual steering channel while preserving rhythmic propulsion and useful fluid response
transferable_invariant: separate slow body-frame route control from fast physical response, and relieve only the smallest redundant actuator contribution after the requested response is nearly satisfied
nontransferable_details: published oscillator gains, species-specific kinematics, dimensional frequencies, exact vortex phases, organized-wake synchronization, and task-specific routes
policy_translation: retain normalized LOS and joint-state feedback; use the reflection-invariant alignment of recoil-conditioned yaw-error direction and `moment_z_L2`, gated by response closure, to reduce only half-cycle amplitude asymmetry
falsification: reject if capture or wake coherence is lost, arrival leaves 18.6560--18.7385T, occupancy exceeds 40.74%/75.74%, force/moment RMS exceeds 0.01328/0.00691, or a repeat cannot distinguish the allocator from parent variability

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
