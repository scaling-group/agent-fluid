# Signed terminal intercept centering

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct, uniform still-water contract:
  `initialization_mode=uniform_direct`, `U_infinity=(0,0,0)`, no cylinders,
  no prewarm, and finite capture. I inspected both the top-down vorticity and
  oblique body/Lambda2 rows of every combined keyframe sheet. In each rollout
  the fish is self-propelled, establishes a coherent alternating red/blue wake
  by about `4T`, retains a strong posterior traveling bend, and turns through
  the capture circle without collision, boundary interaction, wake collapse,
  passive advection, or numerical instability. The sheets are visually
  indistinguishable at their coarse sampling times, so the informative
  failures are mechanism regressions within the same successful termination
  class rather than a visually distinct failure-class rollout.
- The assigned parent `solver_5187bb13ebc0` is the strongest supplied finite
  result: it crosses `8/6/4/2L` at `9.202/11.154/13.013/14.905T`, captures at
  `16.0545T`, has mean/held distance `1.938857L`, final distance `0.744345L`,
  and scores `-0.055617`. It preserves the carrier-phase-residual redirect and
  all posterior steering while a measured safe closing corridor releases only
  residual anterior damping.
- The same corridor is not interchangeable across control roles.
  `solver_736250db9a8b` releases posterior-wave relief together with anterior
  damping; it reaches the same `16.0545T` capture but delays the `0.8L`
  crossing from `16.0105T` to `16.0160T`, worsens final distance to
  `0.745354L`, and scores `-0.056672`. `solver_3b5e36735c7f` instead
  attenuates high-authority mean steering in the corridor; it captures at
  `16.0490T`, but changes only six inherited posterior commands, worsens final
  distance to `0.745652L`, and scores `-0.056973`. Thus a locally safe miss is
  evidence for removing residual anterior braking, not for weakening the
  established posterior wave or mean route command.
- The terminal parent trace identifies a remaining geometric error rather
  than a propulsion failure. At capture the fish still closes at `0.887U` but
  its locally straight course passes about `0.490L` from target center. The
  body-frame target-versus-course error is `-0.706 rad`, the measured course
  angle is `+0.265 rad`, and the fish carries positive carrier-scale yaw while
  the target lies on the opposite side. The inherited logs show that removing
  mean bend in this regime worsens the endpoint, while exact-clamp wrappers
  and pre-limit wave guards do not create useful route diversity. A new test
  should therefore alter feasible terminal mean action without modifying the
  proven far/middle carrier or treating raw beat-scale yaw as navigation
  error.

## Policy hypothesis

Preserve the assigned parent's state-feedback oscillator, carrier-phase
residual authority selector, raw-error redirect direction, one-sided
opposing-wave relief, mean-first posterior allocator, intercept-conditioned
anterior damping release, posterior approach relief, and exact speed-limit
projection. Add one compact terminal mechanism: retain the sign of the
speed-normalized body-frame target/velocity cross product instead of using
only its magnitude. During a proximate, closing, speed-reliable approach, add
a small bounded posterior mean-curvature correction toward target center. The
correction is zero for a center-crossing course, reverses with the measured
miss side, and vanishes continuously outside approach; it does not change the
redirect selector, anterior carrier, posterior wave amplitude, or any
far/middle action.

This tests a meaningfully different feasible trajectory rather than another
clamp-equivalent wrapper or scalar-only gain edit. Expect the existing
coherent wake, early milestones, and capture class with a course that crosses
deeper into the target neighborhood. Falsify the mechanism if fixed-trace
replay changes pre-approach/anterior action, the correction points away from
target center, bounds or lateral reflection fail, the alternating wake or
early progress weakens, capture is delayed or lost, or extra mean curvature
raises limiting/loads without improving the late milestones, distance
integral, or final distance.

bookshelf_consulted: true
source_domain: robotic-fish path following and terminal biological capture
source_mechanism: retain rhythmic propulsion while closed-loop course geometry applies a bounded final intercept correction
transferable_invariant: separate a persistent signed translational miss from beat-scale body yaw, and add only the curvature needed to drive the measured course toward target center while preserving the locomotor carrier
nontransferable_details: published gains, dimensional lookahead, species-specific capture kinematics, prescribed oscillator or vortex phase, exact source-task capture radii, and task-specific routes
policy_translation: form a reflection-odd signed miss from normalized body-frame target and velocity; gate a small posterior mean-curvature correction by measured proximity, closing, and speed reliability while leaving carrier, wave relief, and raw target-feedback roles unchanged
falsification: reject if the correction acts before the closing approach, breaks lateral reflection equivariance, changes anterior or far-field action, weakens the coherent wake, loses capture, or adds limiting and load without better late target progress

The candidate has no same-worker CFD evidence. Fixed-trace replay can establish
signal sign, locality, action semantics, bounds, and reflection symmetry; only
the later EvE evaluation can establish a new wake or trajectory result.

## Non-CFD verification after the policy edit

- The required dedicated check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. I therefore
  ran its three prescribed commands separately. The guidance check first
  exposed a duplicated rendering of the same assigned parent in `README.md`;
  removing only that duplicate restored unique provenance. The material
  guidance check, lightweight Julia policy contract, and solver editable-
  boundary check all pass.
- Static schema inspection finds `36` direct `params.FIELD` references and all
  `36` fields are returned by `target_policy_params()`. A deterministic
  `19,683`-state sweep over joint state, exact speed boundaries, target side,
  bearing, body velocity, and target geometry returns finite bounded actions,
  rejects outward acceleration at either exact joint-speed boundary, and has
  exactly zero lateral-reflection error.
- Replay against all `2,919` assigned-parent states leaves every anterior
  command and every action at or above the `1.75L` approach boundary exact.
  The signed-centering term changes 44 feasible posterior commands between
  `1.626113L` and `0.764785L`; the maximum and mean changed-command deltas are
  `5.963053` and `1.840620 rad/T^2`. These are fixed-state counterfactual
  action semantics, not a closed-loop trajectory, score, or wake claim. No CFD
  was run.
