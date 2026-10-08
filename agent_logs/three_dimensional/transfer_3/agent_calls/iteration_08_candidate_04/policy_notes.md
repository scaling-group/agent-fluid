# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent preserves the geometry-gated outer carrier and uses a
  closure-previewed terminal blend with one shared, amplitude-normalized
  two-joint response release. Three sampled evaluations
  (`solver_89a97c83567b`, `solver_b79884a946b`, and
  `solver_f2153a8a313f`) contain the same policy hash and reproduce capture at
  `25.1185 T`, score `-0.528339`, mean distance `2.429294 L`, and final
  distance `0.746410 L`. The repeated result is useful determinism evidence,
  but it is not a new semantic improvement across the inherited step-5,
  step-6, and step-7 logs.
- All four observations confirm direct uniform quiescent initialization:
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders. The fish therefore
  self-propels; it is not advected by background flow. In the best combined
  sheet, the top-down row shows a coherent alternating wake from release
  through the broad target-directed arc and a smooth terminal bend into the
  capture circle. The visible oblique frames show three-dimensional Lambda2
  structures following that path without a loss of body stability. The
  phase-selective sample `solver_6a46e49f8216` retains the same two-view wake
  and capture topology but scores slightly worse (`-0.528376`, mean distance
  `2.429298 L`, final distance `0.746517 L`).
- Trajectory cross-checks agree with the visual diagnosis. The best shared
  response release has zero `|action|>30 rad/T^2` samples inside `4 L`, no
  terminal joint-stop dwell, and inside-band maximum force/moment coefficient
  magnitudes about `0.01548/0.00800`. Its outer carrier remains expensive
  (`40.27%/31.77%` of commands above `30 rad/T^2`) but produces the coherent
  propulsive wake that the parent says to preserve. At the `4 L`, `2 L`,
  `1 L`, and capture crossings, the target stays on the positive body side
  while normalized lateral body velocity is also positive, about
  `0.00418`, `0.00454`, `0.00413`, and `0.00401 L/T`. This is productive
  targetward translation, not lateral motion to cancel. The terminal target
  angle nevertheless remains about `0.71 rad` at capture, leaving a narrow
  opportunity to retain propulsion without relaxing the proven mean bend.
- The inherited logs also bound the architecture choice. Posterior-only
  response release regressed to `-0.530288`; another step-6 terminal variant
  scored `-0.530990`; and phase-selective departure reallocation did not beat
  the shared response release. The next test should therefore keep response
  release coupled across both joints and add a genuinely observed state gate,
  rather than tune preview distance, phase pressure, or one joint alone.

## Policy hypothesis

Start from the best shared response-release controller. Inside its existing
geometry-, closure-, and proximity-gated terminal blend only, compute the
signed projection of normalized body lateral velocity onto the body-frame
target side. When that projection is positive, smoothly recover a small
additional amount of the already-centered two-joint carrier; when it is zero
or adverse, leave the parent allocation unchanged. This tests whether
preserving measured targetward translation can cross the capture radius with
less accumulated distance while retaining the same mean-curvature steering.
The mechanism is independently active on the sampled terminal trajectory and
does not infer a clock, route, target identity, or world direction.

Reject the hypothesis if capture is lost or delayed, if the trajectory changes
before the terminal gate, if targetward lateral motion weakens, or if inner-band
command clipping, joint-stop dwell, force spikes, or moment spikes return. A
positive result is also limited to cases where target-side lateral motion is
already productive; adverse or negligible motion must recover exactly the
parent response allocation.

bookshelf_consulted: true
source_domain: adaptive swimming and wake-interaction control
source_mechanism: preserve useful induced lateral motion and reject only motion that opposes the task
transferable_invariant: allocate rather than cancel when observed body motion is already directed toward the body-frame target
nontransferable_details: Karman-street geometry, species kinematics, published gains, exact vortex phase, and source-task routes
policy_translation: use bounded target-side times normalized body-lateral velocity to release a small shared two-joint carrier fraction inside the existing terminal gate
falsification: reject if the pre-terminal path changes, capture regresses, targetward motion falls, or terminal saturation and load spikes return
