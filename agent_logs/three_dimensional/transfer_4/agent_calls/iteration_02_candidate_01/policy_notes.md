# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled rollouts report direct uniform initialization with
`U_infinity=(0,0,0)`. I inspected the combined top-down vorticity and oblique
Lambda2 sheets for the successful `solver_bfe9ef100c67`, the prefilled
`solver_2f1c62440f83`, and the closer failed `solver_96568754868a`, then
cross-checked their trajectories, diagnostics, policy sources, and inherited
optimizer score logs.

- The signed-curvature sample `solver_bfe9ef100c67` is the only semantic
  success: it captures at `23.353T` and `0.74968L`. Its top-down frames show a
  continuous target-directed bend after roughly `16T`, while the oblique row
  retains a compact alternating 3D wake. Its center reaches `(9.83,10.42)L`;
  joint angles stay below `37.2 deg`, so the turn does not collapse into an
  angle-limit C-bend.
- The prefilled steering-reserve sample `solver_2f1c62440f83` also clearly
  self-propels and sheds an alternating wake, so weak thrust is not the primary
  failure. Its route rotates above the target: distance falls only to
  `6.276L`, signed target error grows, the center reaches the upper boundary at
  `(12.02,15.20)L` by `17.578T`, and joint-rate/angle saturation is more visible.
- `solver_96568754868a` reaches `4.022L` near `20.77T` but then passes above the
  target and exits at final distance `8.666L`. `solver_ec364bfd4c70` instead
  over-redirects below the target, reaches only `5.775L`, and exits the lower
  boundary at final distance `13.056L`. These opposite exits argue against
  adding another one-sided recovery or large C-bend branch.
- The assigned-parent lesson predicted that the inherited 2D posterior
  curvature polarity was wrong in 3D. The sampled winner is the direct test:
  replacing the asymmetric sign conversion with an odd bounded map from turn
  request to posterior mean tangent changes `left_domain` into `capture` while
  preserving the traveling-wave wake. The inherited optimizer log independently
  records that capture as the highest sampled result.

## Policy hypothesis

Use `solver_bfe9ef100c67`'s normalized body-frame guidance and state-feedback
traveling wave, with exactly one decisive steering mechanism: an odd bounded
posterior mean-curvature setpoint whose sign matches the requested yaw
correction. Do not combine it with the failed course-residual or large
geometry-redirect branches. Make the already-fixed `1800 deg/T^2` episode
acceleration envelope explicit as a policy-owned command bound; because the
episode applies the identical symmetric clamp immediately after
`target_policy`, this does not alter the sampled winner's applied joint
trajectory.

Expected result: preserve the demonstrated coherent wake and target capture,
while avoiding the prefill's wrong-sign upper-boundary trajectory. Falsify the
mechanism if the same direct-uniform case no longer contracts target distance
to capture, or if a reflected/held-out target shows that the odd body-frame map
does not produce a reflected course response. Treat persistent rate or
acceleration saturation as a separate later desaturation experiment; do not
confound that test with curvature polarity here.

bookshelf_consulted: true
source_domain: robotic-fish turning and classical two-joint mean-curvature control
source_mechanism: target-driven bounded average bend superposed on a traveling propulsive rhythm
transferable_invariant: a signed target error should produce a bounded curvature of matching control polarity while the posterior traveling wave remains active
nontransferable_details: published gains, species envelopes, clocked CPG phase, dimensional beat frequency, and task-specific routes
policy_translation: map normalized body-frame bearing and target-vector feedback through one odd tanh to the posterior mean-tangent setpoint; retain joint-state phase and lag
falsification: reject if signed target error fails to contract, the reflected course response is not reflected, or the coherent propulsive wake collapses
