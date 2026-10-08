# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no numerical
  instability. The top-down rows show self-propelled translation and a
  persistent alternating red/blue caudal wake from release through capture.
  The oblique rows in all supplied combined and view-specific sheets are black,
  however, so this generation does not visually establish the inherited claim
  of resolved three-dimensional Lambda2 structures. That is an evidence
  artifact boundary, not evidence of wake collapse.
- Three independent samples of the target-gated opposite-sign posterior rudder
  are bitwise-consistent in their policy and trajectory outcomes: each captures
  at `24.337509T`, reaches `0.749625L`, and scores `-0.325566`, with mean
  distance `2.224316L`. This reproducibly replaces the assigned parent's
  `3.692L` lower miss and validates the inherited reactive-load sign
  calibration as actual yaw authority rather than geometric bend appearance.
- The captured baseline retains target progress after entering `5L`: mean
  closing speed is about `0.471L/T`; anterior/posterior rate-cap occupancy is
  about `11.1/5.9%`; and peak planar force/yaw-moment coefficients remain
  `0.03165/0.01638`. Capture is nevertheless threshold-grazing: the final
  margin is only `0.000375L`, full head-relative target error is `1.324 rad`,
  and closing speed falls to `0.109L/T` during the last fraction of a body
  length.
- The sole distinct sample adds up to 20% rudder authority when instantaneous
  closure falls from `0.35` toward `0.10L/T`. It still captures, but later at
  `24.414513T`, with a worse `-0.325802` score, slightly worse mean distance
  (`2.224632L`), lower mean closure inside `5L` (`0.467L/T`), and a larger
  terminal error (`1.366 rad`). Its peak force/moment and overall rate-cap
  occupancy are effectively unchanged. Thus deficient terminal closure is not
  evidence for adding more mean-rudder load; the finite difference points in
  the opposite direction.

## One candidate hypothesis

Preserve the replicated capture controller, including its autonomous
joint-state carrier, anterior slip-aware center, full target geometry, and
opposite-sign posterior rudder. Add one continuous terminal response mechanism:
inside `1.5L`, if windowed closing speed falls below `0.35L/T`, release at most
20% of the mean posterior rudder, reaching full release only near `0.9L` and
`0.10L/T`. The carrier and its posterior phase lag are not unloaded. This
translates the burst-redirect invariant "release steering after the useful
response" into observed proximity and closure, and directly tests the sign
suggested by the completed authority-boost regression without globally
retuning the successful rudder.

Expected result: reproduce capture while preserving the top-down wake and
established load/saturation envelope, but avoid the sampled terminal
over-loading and cross the radius no later than `24.3375T`. Falsify the
mechanism if capture is lost or delayed, if mean distance exceeds `2.224316L`,
if terminal error grows beyond `1.324 rad`, or if planar wake coherence, rate
occupancy, force, or moment materially worsen. No conclusion about 3D wake
coherence is valid until a later evaluation supplies non-black oblique frames.

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish direction tracking
source_mechanism: a bounded steering load redirects the swimmer, then releases when observed task response shows that continued steering competes with approach
transferable_invariant: preserve the rhythmic propulsive carrier and schedule only the mean steering residual from normalized geometry and measured response
nontransferable_details: species-specific burst duration, published CPG gains, robot linkage geometry, dimensional speeds, exact beat or vortex phase, and task-specific routes
policy_translation: normalized distance and windowed closing speed smoothly release at most one fifth of the already validated posterior mean rudder while joint state continues the inherited two-joint traveling carrier
falsification: reject if capture is lost or later than 24.3375T, mean distance exceeds 2.224316L, terminal alignment worsens, or the established planar wake, saturation, force, or moment envelope degrades
