# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled policies are byte-identical copies of the assigned parent
  and reproduce the same finite direct-uniform still-water rollout: capture at
  `24.310009T` in 4,420 steps, crossing at `0.749162L`, score-metric mean
  distance `2.223959L`, and score `-0.325172`. There are no cylinders, imposed
  flow, prewarm snapshot, or reported numerical instability. This is strong
  fixed-pose determinism, not evidence of robustness to changed flow or pose.
- `solver_43e27134a723` supplies the complete two-view sheet. Its top-down row
  shows continuous curved self-propelled translation toward the target behind
  an alternating red/blue caudal street; its oblique row retains discrete
  three-dimensional Lambda2 structures from release through capture. The
  other three sampled combined sheets have complete matching top-down rows
  but blank oblique rows, which are render artifacts rather than independent
  three-dimensional wake confirmation.
- The most informative available matched regression is the inherited
  near-field anterior-redirect response release. Its complete sheet preserves
  the same S-route and coherent wake class, but its normalized
  bearing-window-rate mechanism captures two steps later at `24.321011T`,
  crosses at `0.749193L`, and raises mean distance to `2.223987L`. Together
  with earlier weaker translation/bearing response replacements, this rules
  against another terminal gate, derivative response, or scalar relief edit.
- The assigned parent's trace exposes one unused physical distinction. Its
  head-local lateral flow is small but nonzero in direct still water (mean/RMS
  about `-0.00308/0.00424 U` overall and `-0.00890/0.00907 U` inside `1.5L`).
  Body-lateral speed has RMS about `0.229 U` overall and `0.195 U` inside
  `1.5L`; measured relative crossflow remains comparably scaled at about
  `0.229/0.196 U`. Thus changing from inertial lateral speed to actual
  water-relative sideslip preserves the evidenced feedback scale in this
  rollout while admitting local fluid motion. The relative signal is strongly
  carrier-phased (correlation about `0.91` with anterior joint rate), so it is
  used only in the existing bounded slow route request rather than as a new
  raw acceleration or posterior phase trigger.

## One candidate hypothesis

Keep the assigned parent's complete response-plus-anterior-stroke controller,
including the joint-state traveling carrier, anterior redirect, target-gated
opposite-sign posterior reactive rudder, closing-deficit response, `20%`
relief ceiling, and target-side anterior half-cycle qualification. Change only
the slip term in the anterior curvature request from inertial body-lateral
velocity to body velocity relative to the measured local water,
`-state.relative_flow_velocity_body_U[2]`. This is an observation/mechanism
change: target geometry continues to set the slow turn, while locally advected
water no longer masquerades as body sideslip. It remains normalized, bounded,
reflection equivariant, and free of time, coordinates, route memory, or mutable
state.

The current still-water evaluation can establish only whether the physical
translation preserves or improves the parent capture. Falsify it if capture is
lost or later than `24.310009T`, mean distance exceeds `2.223959L`, behavior
changes before the existing route feedback can account for it, or the coherent
wake, saturation, action, peak force, or peak moment envelope worsens. Even a
better fixed-pose result would not establish multi-wake or inflow robustness;
that requires a later held-out evaluation.

bookshelf_consulted: true
source_domain: wake interaction and closed-loop robotic-fish steering
source_mechanism: preserve a rhythmic propulsive carrier while separating persistent target geometry from locally measured fluid-relative crossflow
transferable_invariant: route feedback should respond to body sideslip relative to the surrounding water rather than inertial lateral speed alone, without rewriting carrier phase or amplitude
nontransferable_details: published gains, dimensional flow speeds, species-specific kinematics, cylinder geometry, prescribed vortex phase, task routes, and fixed-pose performance
policy_translation: replace only the existing normalized body-lateral velocity term with the sign-equivalent body-minus-local-water velocity obtained from `relative_flow_velocity_body_U`; preserve every evidenced actuator allocation and gain
falsification: reject if capture is lost or later than 24.310009T, mean distance exceeds 2.223959L, the preterminal route changes adversely, or wake, saturation, effort, force, or moment envelopes worsen
