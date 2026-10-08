# Signed terminal intercept mean-curvature correction

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the required direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics,
  and capture after `2,919` steps. I inspected the combined top-down
  mid-plane-vorticity and oblique body/Lambda2 sheets for the best distinct
  source, the prefilled regression, and the signed-wave variant; the fourth
  sheet is byte-identical to the best. In every distinct sheet the fish is
  self-propelled, establishes a strong alternating red/blue wake by about
  `4T`, retains the traveling posterior bend and compact three-dimensional
  shed structures, and reaches the target without collision, boundary exit,
  wake collapse, passive advection, or instability. The coarse sheets are
  visually near-identical, so the informative failure is a terminal
  control-role regression within the capture class.
- `solver_5187bb13ebc0` and `solver_d97cee67d951` are byte-identical policies
  and reproduce the same wake, milestones, `16.054512T` capture,
  `0.744345L` crossing, and `-0.055617` score. Their safe closing corridor
  releases only residual anterior damping; posterior approach settling and
  both mean-steering paths remain intact. This replication makes that policy
  the evidence-selected carrier rather than a scalar-score accident.
- The prefilled `solver_736250db9a8b` extends the same corridor release to
  posterior-wave settling. It preserves the `8/6/4/2/1.25L` milestones and
  capture time, but delays the `0.8L` crossing by one `0.0055T` control step,
  worsens final distance to `0.745354L` and score to `-0.056672`, and raises
  approach posterior acceleration-limit residence from `23.98%` to `29.24%`.
  The signed-intercept half-cycle attenuation in
  `solver_da1119fe4fc6` also preserves the earlier route and `0.8L` crossing,
  but worsens final distance to `0.744660L` and score to `-0.055945` while
  leaving approach posterior acceleration-limit residence at `23.98%`.
  Therefore neither generic posterior-wave release nor another pointwise
  opposing-lobe attenuation is supported here.
- At the best carrier's last sample, the fish is still closing at `0.887U`
  and moving at `1.178U`, but its speed-normalized signed straight-course miss
  is `+0.490L`; bearing is `-0.453 rad`, course angle is `+0.265 rad`, and raw
  target-versus-course error is `-0.706 rad`. The visible wake and early route
  are already useful, while the terminal translation crosses near the edge of
  the `0.75L` target. This supports testing course centering through feasible
  mean bend, not another propulsion rebuild, damping release, clamp wrapper,
  or posterior-wave attenuation.

## Policy hypothesis

Restore the replicated `solver_5187bb13ebc0` carrier: its state-feedback
oscillator, carrier-phase-residual redirect selector, raw-error turn direction,
one-sided steering relief, mean-first posterior allocator, response-subordinate
approach settling, intercept-conditioned anterior damping release, and exact
speed-boundary projection. Retain the sign of its normalized body-frame
target/velocity cross product. Only during a proximate, closing, speed-reliable
approach whose locally straight course lies inside the capture corridor, add a
small bounded posterior mean-curvature correction that points toward target
center. Apply the same correction to the raw and carrier-residual mean paths,
leaving redirect selection and all posterior-wave scaling unchanged. The term
is zero for a center-crossing course, reverses under lateral reflection, and
vanishes continuously when proximity, closing, reliability, or corridor
agreement is lost.

Expected result: preserve the coherent two-view wake and every far/middle
milestone while moving the final course deeper through the target neighborhood.
Falsify it if fixed-trace replay changes anterior or pre-approach action, the
correction points away from center, reflection/bounds fail, capture or an
earlier milestone regresses, wake coherence weakens, or added posterior mean
action increases limiting or loads without better late progress.

bookshelf_consulted: true
source_domain: robotic-fish turning and closed-loop path following
source_mechanism: target-feedback mean-curvature bias superposed on a rhythmic locomotor carrier
transferable_invariant: preserve the propulsive rhythm while a bounded signed course-error correction changes average posterior bend toward the measured target intercept
nontransferable_details: published gains, dimensional lookahead, species-specific kinematics, prescribed oscillator or vortex phase, exact source-task capture radii, and task-specific routes
policy_translation: form a reflection-odd signed miss from normalized body-frame target and velocity; gate a small posterior mean-curvature correction by measured proximity, closing, course reliability, and the existing capture corridor while leaving the two-joint carrier and wave-relief roles unchanged
falsification: reject if the correction acts outside the reliable closing approach, breaks lateral reflection equivariance, changes anterior or far-field action, weakens the coherent wake, loses capture, or adds limiting and load without improved late target progress

The candidate has no same-worker CFD evidence. Fixed-trace replay can establish
locality, sign, boundedness, and reflection symmetry; only the later EvE
evaluation can establish a trajectory, wake, or score improvement.

## Non-CFD verification after the policy edit

- Replay against all `2,919` states from the replicated best source leaves
  every anterior command and every action at or above the `1.75L` approach
  boundary exact. The centering mechanism changes 25 feasible posterior
  commands only between `1.626L` and `0.772L`; maximum and mean changed-command
  magnitudes are `4.602` and `2.065 rad/T^2`. On those inherited states,
  counterfactual approach posterior acceleration-limit residence falls from
  `23.98%` to `21.64%`. These are fixed-state command semantics, not a
  closed-loop trajectory or load claim.
- A deterministic `13,122`-state sweep over lateral reflection, joint angle,
  exact-limit joint velocity, target side and distance, and body-frame velocity
  returns finite bounded actions, zero outward action at either exact
  joint-speed boundary, and machine-exact zero lateral-reflection error.
  Static schema checking confirms that all 37 direct `params.FIELD` names are
  returned by `target_policy_params()`.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed checks were run directly and separately. The first guidance run
  exposed a duplicated rendering of the assigned parent in `README.md`;
  deleting only that duplicate repaired provenance. The rerun passes the
  material guidance/schema check, the lightweight Julia policy contract
  passes, and the solver editable-boundary check passes. No CFD was run.
