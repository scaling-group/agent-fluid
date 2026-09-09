# Stress-gated physical-response residual candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite dynamics,
  and capture at `18.6560--18.7715T`. The combined keyframe sheets were
  inspected for the best finite sample and the most informative slower
  physical-response control, as well as both identical-hash parent runs. From
  release through capture, the top-down rows show body-led translation and a
  coherent alternating posterior vortex street; the oblique rows independently
  show paired three-dimensional Lambda2 structures following the swimmer.
  None shows passive advection, wake collapse, collision, boundary exit, or
  instability. Direct `wake_metrics.csv` termination/progress values and the
  full diagnostics agree with this visual reading.
- The current cohort separates allocator semantics more clearly than wake
  topology. Preserving persistent same-side phase recruitment captures at
  `18.6725T` and `18.7385T` for the identical policy hash; inherited logs add a
  slower `19.0080T` repeat, so differences inside that band are not by
  themselves resolved route improvements. The current two sampled repeats have
  posterior acceleration-limit occupancy `76.41%` and `75.81%`, force RMS
  `0.01350` and `0.01327`, and moment RMS `0.00703` and `0.00691`.
- Helpful-moment relief of only half-cycle amplitude is the best current
  finite sample at `18.6560T`, score `-0.13321`, mean distance `2.02115L`,
  occupancy `41.19%/75.97%`, and force/moment RMS `0.01328/0.00691`. The timing
  gain over the fastest identical-hash parent is only `0.0165T`, so it is
  evidence that residual allocation is compatible with capture, not yet a
  robust speed claim. In contrast, using the same response to suppress the
  primary phase actuator even after yaw-error conditioning captures later at
  `18.7715T`, with `41.25%/75.53%` occupancy and `0.01335/0.00695` loads.
  Instantaneous moment can therefore inform a redundant allocator but should
  not own the slow LOS route or remove the phase correction.
- Local-flow RMS is only `0.01806--0.01816U` across the cohort. The measured
  moment is a self-generated physical-response cue in this evidence, not proof
  of external-wake rejection. No disturbance benefit is claimed.

## Policy hypothesis recorded before editing

Preserve normalized body-frame bearing and LOS-rate guidance, recoil-conditioned
yaw response, continuous distributed C-bend, the state-feedback traveling
carrier, response-reversing half-cycle authority, persistent same-side
demand/previous-action phase recruitment, fixed-coefficient-norm posterior
phase rotation, and componentwise physical projection.

Add one bounded allocation condition to the sampled amplitude-only release.
Helpful hydrodynamic yaw moment may reduce half-cycle asymmetry only when the
requested yaw correction is closing, the existing phase actuator is already
recruited by persistent posterior stress, and the asymmetry correction points
into that predicted stress. The final sign-coherence condition avoids
increasing the weak half-cycle when doing so would worsen clipping. This stress
gate confines the physical-response signal to the redundant channel identified
by the evidence; it cannot suppress the carrier, mean route curvature, or
posterior phase. The product is reflection invariant because yaw error, moment,
demand, previous action, and predicted acceleration reverse together, while all
allocation weights remain even. It introduces no clock, mutable memory, range
switch, world coordinate, or task route.

Support requires capture no later than the established `18.931T` half-cycle
bound with both wake views coherent, posterior occupancy no greater than
`76.41%`, and force/moment RMS no greater than `0.01350/0.00703`. A result in
the identical-hash timing spread is useful only if it materially lowers load or
limit occupancy. Falsify the mechanism if capture is lost, arrival exceeds the
bound, the coherent alternating wake weakens, or effort exceeds those limits;
also reject the stress condition if it is behaviorally indistinguishable from
the parent across repeated outcomes.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: preserve the propulsive rhythm while measured physical response modulates only a small redundant steering residual
transferable_invariant: separate slow body-frame route guidance from fast response and relieve the smallest residual only when another bounded actuator channel is observably recruited and the requested response is closing
nontransferable_details: organized-vortex phase, published gains, dimensional frequency, species or robot kinematics, exact wake timing, and task-specific routes
policy_translation: retain normalized LOS and joint-state feedback; use phase recruitment, yaw-error closure, and reflection-invariant moment/response and asymmetry/stress alignments to reduce only sign-coherent half-cycle asymmetry
falsification: reject if capture is lost or later than 18.931T, wake coherence degrades, posterior occupancy exceeds 76.41%, force/moment RMS exceeds 0.01350/0.00703, or repeated results cannot distinguish the allocator from the parent

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
