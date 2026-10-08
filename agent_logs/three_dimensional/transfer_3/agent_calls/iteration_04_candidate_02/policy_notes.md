# Phase 2 candidate diagnosis and policy hypothesis

## Evidence diagnosis

- All four sampled solver rollouts use the required direct-uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The
  combined sheets were inspected from release to capture in both the top-down
  vorticity and oblique body/Lambda2 rows. Each shows self-propulsion, an
  organized alternating wake, and essentially the same compact target path.
- The prefilled shared-curvature reallocation (`solver_a1253ad45bc8`) and the
  assigned parent's recession-release variant (`solver_4731656a97d2`) are
  trajectory-identical in this episode: both capture at `25.2615T`, score
  `-0.530646`, and have mean distance `2.43180L`. The inherited replay explains
  why: all `1026` samples inside `4L` close at more than the release gate's
  `0.16L/T` threshold. The release branch is a bounded robustness provision,
  but this nominal rollout supplies no coupled evidence for recession recovery.
- The two sampled velocity-course residuals do not improve this established
  result. `solver_53c22b6c3b9c` captures `0.0385T` sooner and reduces final
  velocity-course error from about `23.5` to `18.9 deg`, but its mean/final
  distances are slightly worse and its score falls to `-0.531035`.
  `solver_8945310ce86a` captures at `25.2670T`, raises mean distance to
  `2.43271L`, and scores `-0.531768`. Their top-down and oblique paths remain
  visually indistinguishable from the parent. This is insufficient evidence
  to stack another velocity-course term on the terminal hold.
- The inherited cadence-relief controller (`solver_e7a7bd0d3fe2`) is the
  informative weak trajectory: both visual rows show a large loop before its
  late `51.645T` capture and `-1.19739` score. By contrast, reallocation keeps
  the useful far-field wake, captures directly, and inside `4L` holds
  acceleration-cap incidence near `0.10%/0%`, maximum force/moment magnitudes
  near `0.01597/0.00834`, and neither joint at its angle stop. The policy edit
  must preserve that actuator allocation rather than revive cadence relief.
- A distinct terminal mismatch remains after the joints settle. From about
  `2.7L` to capture, joint rates fall below roughly `0.37 rad/T` and then tend
  to zero while the body-frame target angle stays large (`1.00` to `0.84 rad`).
  Geometry requests a yaw rate near `-0.74 rad/T`, but measured yaw remains
  near `-0.25 rad/T` over the final `2L`. Thus the held curvature is calm and
  low-load but does not track its own observable redirect response. This
  motivates target-rate feedback, not stronger open-loop curvature.

## Policy hypothesis

Start from the assigned parent's recession-release policy. Preserve its exact
far-field carrier, target-geometry redirect, terminal actuator reallocation,
and closure-conditioned escape. Once proximity indicates that most of the
carrier has already been replaced, add one bounded residual from the difference
between the existing geometry-requested yaw rate and measured body yaw rate to
the total two-joint curvature equilibrium. The residual is attenuated through
the same proximity gate during entry, so tail-beat-scale yaw does not dominate
while the propulsive carrier is still active. It changes the equilibrium rather
than adding raw acceleration and cannot choose redirect sign independently of
body-frame target geometry.

Expected evidence is the same coherent far approach and low-saturation terminal
hold, with faster reduction of target misalignment and no large loop. Support
requires capture with a meaningfully better distance integral, arrival, or
terminal alignment while retaining the parent's low inside-`4L` loads and
saturation. Reject the mechanism if capture is delayed or lost, if the path is
visually unchanged without a useful metric improvement, if terminal joint/load
peaks return, or if short-window yaw noise reintroduces oscillation as the hold
engages.

bookshelf_consulted: true
source_domain: biological burst-redirect turning and sensor-modulated robotic-fish direction tracking
source_mechanism: release or reinforce a strong curvature maneuver according to the observed heading response while rhythmic propulsion is reallocated
transferable_invariant: when steering and propulsion share limited joints, compare target-requested turning with measured body turning and apply a bounded correction to the curvature equilibrium only after gait suppression makes the response signal meaningful
nontransferable_details: species-specific C-start shapes, published feedback gains, dimensional cadence, full-body CPG phases, exact vortex phases, and prescribed routes
policy_translation: existing normalized body-frame target geometry supplies the desired yaw rate, `turn_rate_recent` supplies observed response, and their bounded error shifts the two-joint terminal curvature target under the distance and closure gates
falsification: reject if direct capture, distance integral, terminal alignment, saturation, or load history worsens, or if residual tail-beat yaw contaminates the transition into the terminal hold

## Non-CFD implementation audit

Reconstructing the new gates on the completed shared-curvature trajectory gives
exactly zero terminal weight at every sample at or beyond `4L`. All samples
inside `4L` have closing speed between `0.384` and `0.685L/T`, so the inherited
recession release remains fully supported on the nominal path. The new
rate-error curvature is bounded between `-3.98` and `+1.36 deg`; after the
terminal blend its effective equilibrium contribution is only `-3.10` to
`+0.36 deg`. It is about `-2.56 deg` by `2.70L` and `-3.10 deg` once the hold is
full at `2.4L`. This confirms far-field invariance and bounded activation on
recorded states, but it is not coupled-CFD evidence of improved motion.
