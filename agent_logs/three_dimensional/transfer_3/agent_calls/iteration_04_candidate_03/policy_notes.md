# Candidate hypothesis: intercept-corridor carrier release

## Evidence read before the edit

- The four sampled rollouts are valid direct-uniform still-water evaluations:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and moving-window shift
  counts of 269--271. All capture from `12.3277L` at `25.2230--25.2670T`.
- I inspected the combined and view-specific sheets for the best-scoring
  captured policy (`solver_4731656a97d2`, score `-0.5306463`) and the
  lowest-scoring sampled capture (`solver_8945310ce86a`, score `-0.5317676`).
  The top-down rows show self-propulsion rather than advection: the fish moves
  through quiescent water while shedding a coherent alternating posterior
  wake through the far approach, then bends smoothly toward the target as the
  terminal carrier is reallocated. The oblique Lambda2 rows confirm finite 3D
  wake structures behind the body, a continuous target-directed trajectory,
  and no visible instability before capture. The two sheets are visually
  almost indistinguishable, consistent with their small metric spread.
- The inherited parent guidance describes the preceding `1.135L` fast miss and
  recommends near/closing drive relief or damping without sacrificing the
  geometry-gated redirect. The sampled child evidence establishes the next
  semantic step: damped carrier-to-curvature reallocation captures while
  preserving the far wake. In the sampled captures, distance first falls below
  `4L` at `19.624T`, below `2.4L` at about `22.737T`, and below `1L` at
  `24.860--24.899T`; terminal force and moment coefficient magnitudes remain
  below about `0.01593` and `0.00835`.
- The plain terminal-reallocation policies (`solver_a1253ad45bc8` and the
  closure-release `solver_4731656a97d2`, whose closure gate stays supported on
  this approach) tie for the best sampled score. Direct course-curvature
  residuals do not improve that result: `solver_53c22b6c3b9c` reaches `1L`
  `0.033T` sooner and captures `0.0385T` sooner but scores `0.000389` lower;
  the prefilled course-regulated policy reaches `1L` `0.0055T` later and is the
  lowest-scoring sample. Thus the evidence does not support adding or merely
  increasing a course-curvature gain.
- Reconstructed world-invariant target/velocity dot and cross products show
  why course is still useful as an allocation signal. From `4L` inward, the
  plain captured policy's radial closing speed rises from about `0.463U` to
  `0.586U` by `1L`, while its course error falls from `0.728` to `0.434` rad.
  The straight-line predicted miss therefore enters a conservative sub-radius
  corridor only late, after the curvature hold has done its job.

## Policy hypothesis

Preserve the sampled plain terminal curvature equilibrium and its geometry and
distance gates. Add one speed-qualified intercept-corridor gate computed from
normalized body-frame target and velocity vectors. When radial closing is
positive and the predicted straight-line miss is small, continuously restore
part of the posterior-lag carrier instead of adding another curvature residual.
When the course is unsafe, slow, or receding, retain the full evidenced
reallocation. This should preserve the identical far approach, keep terminal
joint/load relief, and reduce unnecessary late hold so capture occurs at least
as early with no score regression.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal fish-swimming approach control
source_mechanism: sensor feedback modulates a rhythmic carrier while near-target closing and course quality schedule propulsion versus damped hold authority
transferable_invariant: preserve the posterior-lag traveling bend until bounded target-relative state feedback shows that a near-target closing course needs hold authority or safely permits its release
nontransferable_details: published CPG gains, dimensional cadence and amplitude, species kinematics, exact vortex phase, world-frame routes, and task-specific open-loop timing
policy_translation: use body-frame target/velocity dot and cross products to estimate normalized radial closing and straight-line miss; restore only part of the carrier inside a conservative intercept corridor while leaving geometry-gated curvature in charge elsewhere
falsification: reject if the far trajectory changes before 4L, capture is lost or delayed, score falls, the release activates on a receding course, or terminal saturation/load rises relative to the sampled captured reallocation

The new CFD result is intentionally not claimed here; it is evidence for a
later worker.
