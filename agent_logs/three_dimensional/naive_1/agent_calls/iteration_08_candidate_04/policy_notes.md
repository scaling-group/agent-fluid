# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization in still water with `U_infinity=[0,0,0]`, no cylinders, no
  prewarm snapshot, and no numerical instability. Motion is therefore
  self-propelled rather than advection. Across the combined sheets, the
  top-down row shows a persistent alternating red/blue posterior wake and the
  oblique row shows discrete three-dimensional caudal Lambda2 structures from
  release through the approach. None of the failures is caused by wake or
  joint-motion collapse.
- The visible failure topology is common: each fish follows a long lower-going
  path, passes below the target, and exits through the lower virtual boundary.
  The assigned prefill (`solver_5f29dca2aca2`) reaches `4.018L` at `19.77T`
  with folded and full target errors both `1.333 rad`. It passes the target
  abeam at `20.52T`, then its folded-error gate starts releasing by `24.71T`
  when distance has risen to `5.306L` even though the true head-relative error
  is `2.245 rad`. It exits at `31.94T` and `9.179L`.
- Whole-body half-cycle redistribution (`solver_24724bc7bb0b`) is the strongest
  finite sampled trajectory. It preserves the coherent wake and improves the
  closest approach to `3.691L` at `20.46T`, compared with `4.233L` for
  symmetric posterior relief and `4.018L` for the assigned anterior-only
  redirect. Its posterior rate-cap occupancy remains about `5.5%`, but it does
  not establish route recovery: after passing abeam at `21.19T`, its folded
  gate begins releasing at `24.71T` with distance `4.697L` and true error
  `2.243 rad`, and it exits low at `33.27T`.
- The full-angle posterior-only descendant (`solver_dac1edc233b4`) is an
  informative negative result. Keeping posterior relief/asymmetry active for a
  rearward target reaches `3.909L` and survives to `33.23T`, but without the
  anterior redirect its true error still grows to `2.721 rad` by `32T` and the
  lower exit remains. Full target geometry fixes a semantic observation bug;
  it is not yaw authority by itself. Conversely, the best whole-body redirect
  has yaw authority before the miss but discards it on false folded alignment.
- Sampled joint-rate histories remain bounded by the common hard cap. The
  whole-body redirect's approximately `13.7/5.5%` anterior/posterior cap
  occupancy and `0.00596` RMS normalized yaw moment are comparable to the
  full-angle descendant's `13.3/5.1%` and `0.00623`; the evidence supports a
  gate-semantic test but not more oscillator, curvature, or relief gain.

## One candidate hypothesis

Use the sampled whole-body half-cycle redirect unchanged in magnitude and gait
structure, but compute its activation magnitude from the full signed
head-relative target angle
`atan(state.target_body_L[2], -state.target_body_L[1])`. Before the target
passes abeam this is the same error used by the sampled redirect, so the early
alternating wake and `3.691L` approach have a controlled basis. After abeam,
the absolute full angle keeps the redirect and posterior redistribution active
until genuine alignment. Retain folded `state.bearing` only for the
reflection-equivariant turn direction and slip-aware anterior center; this
makes an exactly rearward target reduce signed steering continuously to zero
rather than exposing the full-angle branch as a command-sign jump.

This is one rear-aware burst-release mechanism, not scalar gain tuning. It is
falsified if the early wake or approach degrades materially, closest approach
does not retain the sampled `3.691L` level, full target error does not decrease
after the first pass, the same lower exit occurs without a meaningful delay or
recovery turn, either joint's rate-cap occupancy or yaw load materially rises,
or the sign/gate separation produces indecision near a rearward target.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking, asymmetric flapping, and biological burst redirection
source_mechanism: persistent target error sustains turn-producing half-cycle authority and releases it continuously only after observed realignment
transferable_invariant: a target-gated redirect must distinguish true alignment from a target passed abeam or behind while retaining joint-state phase and a bounded propulsive wave
nontransferable_details: published gains, dimensional beat frequency, clock-driven CPG phase, robot linkage geometry, species-specific kinematics, prescribed burst timing, exact vortex phase, and task-specific routes
policy_translation: the full normalized body-frame target angle sets the shared redirect gate magnitude; folded body-frame bearing and anterior joint rate provide continuous turn sign and observed half-cycle phase for the two joints
falsification: reject if early wake or 3.691L approach is lost, rear-target error does not fall, the lower exit persists without delayed or recovered motion, saturation or yaw load worsens, or rear-axis sign ambiguity causes indecision
