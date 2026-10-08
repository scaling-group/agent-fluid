# Bearing-gated redirection-reserve candidate

## Visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the Phase 2 evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm,
  no cylinders, finite dynamics, and `left_domain` termination. Motion is
  therefore self-generated rather than imposed advection.
- I inspected both rows of the combined sheets for the strongest finite
  rollout and the informative prefilled failure, with the unrelieved
  course-feedback rollout as the controlled comparison. Their top-down rows
  show leftward translation and alternating red/blue vorticity; the oblique
  rows show coherent three-dimensional caudal structures. The prefilled
  controller bends upward into the boundary by `13.178T` at `8.515L`, whereas
  one-sided posterior wave relief preserves the wake through `18.975T`,
  reaches `5.144L`, and only then arcs upward to the same boundary topology.
- Metrics and trajectory reconstruction agree with the images. Relative to
  the otherwise matching unrelieved course controller, one-sided relief
  improves minimum distance from `6.218L` to `5.144L`, survival from
  `16.879T` to `18.975T`, and posterior acceleration-limit residence from
  about `60.8%` to `35.9%`. This is positive evidence for preserving the
  anterior oscillator and relieving only the posterior wave lobe opposed to
  the requested mean bend.
- The remaining failure is not weak propulsion. At the relieved rollout's
  `15.312T` closest approach, body bearing is about `-1.30 rad` while
  body-frame course is still about `+0.34 rad`; the fish is already off-axis
  and laterally overshooting. At termination those signs still disagree, and
  joint-1 acceleration has occupied its hard limit in about `51.9%` of
  samples. More continuous curvature would compete with saturated propulsion
  rather than create steering reserve.

## Policy hypothesis

Start from the evidenced target-versus-course controller with one-sided
posterior wave relief. Add one continuous redirection mode: when the slowly
varying absolute body bearing grows beyond a modest off-axis band, reduce the
anterior Van der Pol limit-cycle envelope while leaving its zero-mean
equilibrium intact. Because the posterior wave is reconstructed from anterior
joint state, it should shrink with the carrier and expose more of the fixed
posterior target/action envelope to mean curvature. As bearing returns toward
the body axis, full propulsion returns without time, route, or phase memory.

This is a response-gated redirect rather than a scalar-only carrier retune.
The candidate should preserve early coherent self-propulsion, keep posterior
opposition relief, reduce late joint-1 limit residence, and turn the inertial
course downward before the positive-y boundary. Falsify it if wake coherence
or the `5.144L` closest-approach benchmark is lost, if the carrier remains
saturated despite envelope relief, or if it repeats the upper exit without an
earlier course correction or better termination class.

bookshelf_consulted: true
source_domain: biological burst-redirect turning and sensor-modulated robotic-fish CPG control
source_mechanism: large observed directional error temporarily reallocates a rhythmic gait from propulsion toward bounded curvature, then releases back to cruise as alignment returns
transferable_invariant: preserve a state-feedback traveling bend when aligned, but reduce oscillatory propulsion to expose turning authority during a large observed off-axis error
nontransferable_details: species-specific C-start shapes, published gains and duty ratios, clocked CPG phase, exact vortex phase, dimensional kinematics, and task-specific routes
policy_translation: use bounded body-frame bearing magnitude to shrink the joint-1 oscillator envelope continuously; retain target-versus-course sign feedback and one-sided posterior wave relief within the two-joint limits
falsification: reject if early thrust or coherent wake is lost, minimum distance regresses from 5.144L, acceleration-limit residence does not fall, or the same upper exit occurs without earlier inertial-course redirection

The new candidate has no same-worker CFD result; downstream evaluation is its
first valid test.

## Non-CFD verification

- The guidance-parent comparison, lightweight Julia policy-contract check,
  deterministic parameter-schema exercise, and solver boundary check pass.
- A nonzero mock-state reflection reverses bearing, lateral velocity, both
  joint angles, and both joint rates; both returned accelerations reverse to
  numerical precision and remain finite inside the configured envelope.
- No formal CFD rollout was run in this worker workspace.
