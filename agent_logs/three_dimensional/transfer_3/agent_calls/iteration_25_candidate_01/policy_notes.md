# Saturation-separated target-residual promotion

## Evidence and visual diagnosis before the policy edit

- The assigned parent is the triply reproduced `v34` direction-conditioned
  common limiter. Its inherited logs establish exact captures at
  `21.912008 T`, score `-0.3246592933`, mean distance `2.218947189 L`, and
  final distance `0.747680604 L`. Two current samples reproduce that rollout
  again exactly under direct uniform still-water initialization, with a
  compact target-directed arc, coherent alternating top-down shedding, finite
  localized oblique Lambda2 structures, and a quiet held-bend capture. The
  assigned result is therefore the informative slower comparison rather than
  a failed termination.
- I inspected the combined keyframe sheets from release through capture for
  the strongest finite sample, the saturation-separated sample, and the
  reproduced parent, including both the top-down mid-plane vorticity row and
  the oblique body/Lambda2 row. All are self-propelled; none shows passive
  advection, a loop, collision, boundary-exit precursor, wake collapse, or
  out-of-plane instability. The saturation-separated sample preserves the
  parent's visible trajectory class and quiet final glide while advancing the
  `8/6/4 L` crossings from about `10.703/13.222/16.110 T` to
  `10.456/12.986/15.835 T`.
- The sampled `v36` saturation-separated allocator constrains the coordinated
  rhythmic drive first and then places the existing target-feedback residual
  into remaining componentwise headroom only under observed overload and
  clipping-angle distortion. It captures at `21.735992 T`, improves score to
  `-0.3012661700` and mean distance to `2.194857233 L`, and has no command
  above `30 rad/T^2` below `2 L`; its below-`2 L` peak planar force and yaw
  moment are about `0.003175` and `0.000719`.
- The raw-score winner is not the safest policy to promote. Its extra common
  scaling is supported by posterior lag error in the same outer saturation
  locus and reaches capture at `20.096998 T`, score `-0.2975685868`, and mean
  distance `2.188311614 L`, but the changed outer state bypasses the quiet
  terminal topology: below `4 L`, anterior/posterior commands exceed
  `30 rad/T^2` on about `50.3%/63.2%` of stored states, with peak planar force
  and yaw moment about `0.02667/0.01348`. Its final course is useful and no
  joint dwells at the angle stop, but this persistent terminal clipping
  violates the inherited rejection boundary; a slightly better scalar does
  not establish reusable control quality.

## Policy hypothesis

Promote the sampled `v36_saturation_separated_target_residual` policy unchanged
as this workspace's single candidate. Preserve the normalized body-frame
guidance, state-feedback oscillator, anterior-to-posterior lag, target-angle
redirect, closure preview, shared terminal mean bend, center-intercept support,
paired terminal release, and reproduced direction-conditioned common limiter.
Outside `4 L` only, keep the rhythmic carrier and body-frame target residual
separately observable at saturation: limit the carrier, add the already bounded
turn residual into remaining joint headroom, and interpolate toward that
allocation only when overload rotates the combined command. Do not add the
posterior-lag common-scaling increment or stack another terminal mechanism.

This is an independent reproduction candidate for one actuator-allocation
mechanism, not scalar-only tuning and not a same-regime stack. Its formal CFD
result occurs only after this worker exits. Falsify the promotion if it does
not reproduce capture and the outer crossing improvement, if it changes the
compact coherent two-view wake or quiet below-`2 L` glide, or if terminal
clipping, joint-stop dwell, load growth, instability, or lost capture appears.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish control and residual control over rhythmic locomotion commands
source_mechanism: preserve a coordinated low-dimensional propulsive rhythm while applying bounded sensor-derived route corrections as a separable residual
transferable_invariant: when an actuator envelope engages, preserve the productive inter-joint carrier structure and allocate the independently observed target residual only through available headroom rather than amplifying all joint commands together
nontransferable_details: published CPG gains, dimensional cadence, robot or species kinematics, full-body waveforms, clock phase, exact vortex phases, capture geometry, and task-specific routes
policy_translation: retain normalized body-frame target feedback and the reproduced outer common limiter, constrain the two-joint drive first, then add its existing turn residual into componentwise headroom under normalized overload and clipping-angle support, with exact dormancy inside the terminal band
falsification: reject on failed reproduction, delayed or lost capture, worse distance integral, changed outer trajectory, terminal command growth, joint-stop dwell, material force or moment growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD audit

- The candidate is byte-identical to the evaluated saturation-separated
  sample, with SHA-256
  `b9336ecaa402c04717760d32c42c8b0b0b12c56de57045beff08c4723434aa81`.
  This establishes exact promotion, not a new CFD result.
- The prescribed checker agent was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account and failed before running a command.
  Its three declared checks were then run directly and separately: the
  material guidance/notes check, finite two-acceleration Julia contract, and
  solver edit-boundary check all pass.
- A separate deterministic schema audit resolves all 81 direct
  `params.FIELD` references to fields in the 82-field object returned by
  `target_policy_params()`; only the version label is intentionally unused.
  No formal CFD was run in this workspace.
