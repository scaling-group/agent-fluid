# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- All four assigned rollouts report the required direct uniform still-water
  initialization, `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their
  top-down and oblique sheets show self-propelled motion: an organized
  alternating mid-plane wake and coherent three-dimensional Lambda2 structures
  accompany target progress, with no imposed flow available to advect the fish.
- The prefilled distance-only terminal reallocation is represented by
  `solver_02855629f46e` and `solver_a1253ad45bc8`. Both capture at `25.2615T`,
  score `-0.530646`, traverse about `13.7781L`, and preserve the same compact
  outer approach. Inside `4L`, the head command still occupies the acceleration
  envelope for about `1.17%` of recorded samples, although neither terminal
  joint dwells at the angle stop and terminal force/moment remain bounded.
- A closure-only release branch (`solver_4731656a97d2`) is exactly inactive on
  that strongly closing trajectory and reproduces the baseline trace and score.
  This is useful recovery semantics but cannot improve a nominal rollout unless
  closure first weakens.
- The closure-previewed variant (`solver_d5c9dea468e1`) is the strongest assigned
  finite result. It retains the visually indistinguishable coherent outer wake,
  captures at `25.1130T`, scores `-0.530060`, shortens the recorded center path
  to about `13.7105L`, removes inside-`4L` command-cap incidence on both joints,
  and slightly lowers the terminal peak force and yaw moment. The improvement is
  small but agrees across arrival, distance integral, path length, saturation,
  and load evidence rather than relying on the scalar score alone.
- The inherited slow approach-hold capture (`solver_e7a7bd0d3fe2`) is the
  informative failure comparison. Both visual rows show a broad orbit before
  capture at `51.6450T`; its path is about `31.6455L`, and inside-`4L` loads and
  clipping are much larger. It falsifies broad carrier relief and supports
  limiting the preview to the terminal transition while restoring the
  posterior-lag carrier when measured closure is absent.

## Policy hypothesis

Promote the evaluated closure-previewed reallocation as the one candidate.
Keep the prefilled target-relative geometry gate, turn sign, two-joint damped
curvature equilibrium, carrier floor, and every far-field command unchanged.
Positive normalized closing speed previews range by at most `0.75` of the
declared control period so fast approaches begin reallocating just before the
physical `4L` crossing. A smooth closure-support factor suppresses the terminal
hold at nonpositive closure and restores the posterior-lag carrier. Closing
speed schedules allocation only; it never creates a steering direction.

Expected evidence is reproduction of the sampled compact capture near
`25.113T`, unchanged outer wake topology, no inside-`4L` command clipping, and
terminal loads no larger than the distance-only parent. Reject the mechanism if
the coupled rollout delays or loses capture, changes the far-field carrier,
creates a low-drive loop, increases terminal loads, or fails to restore rhythmic
propulsion when range stops decreasing. The sampled nominal rollout validates
entry during sustained positive closure; recession recovery remains a held-out
falsification boundary.

## Bookshelf transfer record

- `bookshelf_consulted: true`
- `source_domain:` biological burst-redirect turning and sensor-modulated
  robotic-fish rhythmic control
- `mechanism_borrowed:` when two joints share propulsion and steering, persistent
  target error should own the bend while observed task response schedules the
  transfer of joint authority between rhythmic carrier and mean curvature
- `policy_translation:` bounded body-frame target geometry continues to set the
  two-joint curvature equilibrium; normalized range and measured closure only
  schedule entry and release over less than one state-feedback period
- `nontransferable:` published gains, dimensional cadence, species-specific
  kinematics, exact vortex phase, full-body waveforms, target coordinates, and
  task-specific routes
