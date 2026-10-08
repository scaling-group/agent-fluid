# Candidate diagnosis and hypothesis

## Inherited evidence

- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  `solver_ecbe2be01c45` (best sampled scalar result) and
  `solver_31b486aa171c` (weakest distinct finite result), anchored by each
  rollout's observation, metrics, diagnostics, trajectory, and policy source.
  Both evaluations report direct uniform still-water initialization,
  `U_infinity=[0,0,0]`, no cylinders, and capture at `16.0544T` after `239`
  window shifts.
- In both views the fish self-propels toward the target rather than being
  advected: a compact alternating wake develops behind a translating body in
  zero background flow, grows into a coherent three-dimensional chain, and
  remains organized through capture. The body turns toward the target without
  collision, exit, or visible wake collapse. Lateral oscillation is productive
  enough to sustain forward translation, though the terminal body and wake
  still show a strong beat-scale yaw excursion at crossing.
- The four sampled policies have identical `8/6/4/2/1.25/0.9/0.8L`
  milestones, capture time, anterior/posterior angle extrema, acceleration-
  limit residence, and peak body-force/yaw-moment diagnostics. Their only
  measurable separation is terminal-scale: final distance spans
  `0.7460507-0.7462119L` and distance integral spans
  `1.9300118-1.9301471L`. The assigned-parent redirect-to-cruise handoff is
  `1.9300279L`; the sampled terminal yaw damper is `1.9300118L`. Neither is a
  meaningfully different trajectory or wake mechanism.

## Policy hypothesis

The next useful test should change feasible action during target-directed
translation instead of adding another terminal release or damping threshold.
Retain the evidenced posterior mean-curvature, wave-relief, yaw-residual, and
approach scaffold. Add one reflection-equivariant half-cycle primitive to the
anterior carrier: once measured forward motion makes the raw redirect request
reliable, smoothly attenuate only anterior acceleration pointing against that
redirect. The aiding acceleration half-cycle is unchanged, and the mechanism
is off when raw redirect authority is absent. This should create bounded
turning asymmetry without a shared static joint bias or amplified action.

Expected evidence is a reproducibly earlier distance milestone or lower
distance integral, with capture and the coherent two-view wake retained. A
reduction in anterior limiting is supportive but is not sufficient by itself.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning
source_mechanism: target-conditioned half-cycle amplitude asymmetry superposed on a propulsive rhythm
transferable_invariant: steer by redistributing bounded action between beat halves while preserving the traveling-wave carrier
nontransferable_details: published gains, clock-driven CPG phase, robot linkage geometry, species kinematics, and task-specific routes
policy_translation: use normalized anterior acceleration phase, raw body-frame target-versus-course redirect, and measured speed reliability to attenuate only the opposing anterior acceleration half-cycle under the existing two-joint state-feedback contract
falsification: reject if capture or coherent wake is lost, any established milestone is delayed, distance integral fails to improve materially, or reduced limiting is bought with posterior excursion or load growth
