# Candidate diagnosis and hypothesis

## Prior evidence

- All four sampled rollouts report direct uniform still-water initialization,
  no cylinders, finite dynamics, and capture. The two executable-identical
  half-cycle redistribution runs (`solver_649d7e789a5a` and the assigned
  prefill `solver_d2a3f8408b10`) capture at `18.8265T` and `18.8815T` with
  mean distances `2.088545L` and `2.088964L`. Their top-down sheets show an
  alternating, target-bending vortex street from release through capture, and
  their oblique sheets show compact caudal Lambda2 structures rather than
  passive advection or wake breakup.
- The broadside-reserve sample (`solver_de4c121e5685`) is the informative
  mechanism-control comparison. Both visual rows retain the same coherent,
  self-propelled wake and target-directed trajectory, and it captures sooner
  at `18.7055T`, but its mean distance is worse at `2.093857L`. Its anterior /
  posterior acceleration contact (`60.84% / 73.04%`), rate contact
  (`10.85% / 14.67%`), peak planar force coefficient (`0.03275`), and peak
  yaw-moment coefficient (`0.01704`) overlap or sit at the edge of the
  redistribution samples. This establishes bounded non-interference, not an
  attributable performance improvement.
- The rearward-route multiplier sample (`solver_bae498322681`) also captures,
  at `18.9640T` and mean distance `2.090724L`, but inherited reconstruction
  shows its new branch never activated. It therefore supplies no recovery
  evidence. The inherited optimizer logs include two current left-domain
  failures (scores `-10.3753` and `-10.5028`), while the parent guidance
  localizes the relevant earlier near miss to a forward-broadside target when
  the ordinary lateral route tanh was already saturated. Waiting for the
  target to pass behind, or multiplying that saturated argument, is too late.

## Candidate policy hypothesis

Keep the assigned half-cycle redistribution carrier and all of its gains
unchanged. Add the already exercised smooth broadside gate as one separate,
bounded mean-curvature reserve outside the saturated route argument, while the
target remains forward. Lateral body-frame target geometry owns its sign, and
the inherited correcting-yaw response gate can reduce but never reverse it.
This is one small composition: the common anterior/posterior traveling wave
and displacement-only half-cycle allocation remain intact; there is no
distance schedule, velocity residual, rearward branch, clock, or new
posterior-specific allocation.

Expected test: ordinary capture and the two coherent wake views should survive,
while the reserve becomes available before the inherited broadside near-miss
topology. Falsify the composition if capture is lost, the route bends into the
known downward/left exit, wake coherence degrades, peak load or joint-limit
contact materially exceeds the sampled capture band, or independent results
continue to show only ordinary-capture variation without closing a near miss.

bookshelf_consulted: true
source_domain: biological and robotic-fish closed-loop turning
source_mechanism: bounded target-driven mean-curvature redirect superimposed on a rhythmic propulsive gait
transferable_invariant: persistent large body-frame target error can receive bounded mean curvature without replacing the posterior-lag traveling wave
nontransferable_details: published gains, species kinematics, dimensional frequencies, prescribed turn routes, and exact vortex phase
policy_translation: use normalized forward and lateral target components to gate a small differential joint-bias reserve before overshoot, retaining displacement-only beat feedback and the existing non-inverting yaw-response release
falsification: reject on lost capture, damaged top-down or oblique wake coherence, repeated left-exit topology, or materially higher saturation and load than sampled captures
