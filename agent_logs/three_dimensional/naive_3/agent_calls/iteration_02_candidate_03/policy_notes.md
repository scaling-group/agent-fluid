# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase-2 evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm,
  no cylinders, finite dynamics, and complete combined top-down/oblique
  keyframe sheets. The assigned parent's inherited note proposed bounded
  bearing-to-mean-curvature steering with yaw/slip damping and command reserve.
- The common joint-only carrier (`solver_35fea652543a`) is self-propelled: both
  visual rows show an alternating three-dimensional posterior wake, but the
  path curls upward and exits at `8.602T`. Distance changes only from
  `12.3277L` to `12.0701L` before finishing at `12.3677L`; raw acceleration
  exceeds the `31.42 rad/T^2` envelope in about one third of rows on each
  joint. This supports retaining the traveling-bend carrier, not increasing
  its scalar drive.
- The strongest finite example, `solver_6f1e6108928b`, adds a bounded `7 deg`
  target-relative mean bend to that carrier. Its sheets show a coherent,
  alternating wake and sustained diagonal self-propulsion from the release
  toward and then below the target. It survives to `24.893T`, lowers mean
  distance to `8.7447L`, and reaches `4.0671L` at `14.911T`; it then continues
  downward and exits the bottom boundary at final distance `9.1287L`. At the
  closest approach, reconstructed body-frame bearing is still about
  `+1.02 rad`, so this is inadequate corrective turn authority after a useful
  approach, rather than a loss of thrust or a false visual improvement.
- Stronger persistent-bend variants do not justify simply increasing mean
  curvature. `solver_b8ee16f26af1` (`14 deg`) damps into a broad upper
  U-turn and reaches only `12.2908L`; the assigned-parent child
  `solver_b0180f8d5568` (`10 deg`, slower/smaller carrier plus yaw/slip terms)
  substantially damps the alternating carrier, turns through roughly three radians, and
  exits the right boundary after reaching only `12.3238L`. Their mean
  distances, `13.3147L` and `15.0926L`, are both worse than the naive seed.
  The keyframes and trajectory metrics therefore reject persistent stronger
  curvature and the parent's combined slower-carrier translation in this
  topology.

## Policy hypothesis

Inherit the evidenced `7 deg` mean-curvature controller and add one
phase-selective turning mechanism. From the normalized body-frame bearing and
measured heading rate, form the same bounded turn request. Use the sign of
anterior joint velocity relative to that request as a state-only half-cycle
gate: inject a bounded acceleration boost only while the anterior bend is
moving toward the requested side. The boost scales quadratically toward zero
with small turn error, so the established traveling wave is nearly unchanged
on centerline, while a large post-approach bearing receives more authority
without imposing the failed whole-cycle static bend. Explicit final command
bounds preserve a small reserve below the episode acceleration envelope.

Expected evaluation signature: retain the alternating posterior wake and the
strong example's sustained distance reduction, then produce a larger
corrective turn once bearing grows after passing below the target. Accept only
semantic improvement: capture, a closer approach than `4.0671L`, or a
meaningfully better non-bottom-exit trajectory with preserved propulsion.
Reject the transfer if oscillation collapses, the initial path becomes one of
the sampled U-turns, the same bottom exit remains without a closer approach,
or joint-limit residence and load spikes materially worsen.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG turning
source_mechanism: half-cycle amplitude asymmetry superposed on a propulsive rhythm
transferable_invariant: strengthen only the beat half-cycle aligned with a body-frame turn request while preserving the opposite recovery stroke and posterior lag
nontransferable_details: published gains, clocked phase, duty ratios, robot or species kinematics, exact vortex phase, and any task-specific route
policy_translation: a reflection-equivariant product of bounded bearing-based turn request and observed anterior joint velocity gates a small same-sign acceleration boost inside the two-joint state-feedback controller
falsification: reject if the alternating wake collapses, the approach no longer beats the seed, closest distance is not below 4.0671L or the bottom-exit topology is unchanged, or actuator/load diagnostics worsen
