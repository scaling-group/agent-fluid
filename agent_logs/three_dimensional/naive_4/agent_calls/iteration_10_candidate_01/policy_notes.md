# Velocity-limit anti-windup on the carrier-phase-residual redirect

## Pre-edit visual and quantitative diagnosis

- All four sampled rollouts are finite captures from the required direct,
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. I inspected both rows of all four combined keyframe sheets.
  The top-down rows show self-propelled target approach with a coherent
  alternating red/blue wake established by `4T`; the oblique rows retain
  compact three-dimensional Lambda2 structures behind the traveling bend
  through capture. None shows advection, wake collapse, boundary exit, or
  numerical instability. The view-level differences among these late
  variants are subtle, so trajectory and joint histories decide between them.
- `solver_a0cc85d2f5b2`, the carrier-phase-residual redirect, is the strongest
  finite sample: it advances the `8/6/4/2L` crossings to
  `9.202/11.154/13.013/14.905T`, captures at `16.044T`, and scores
  `-0.058311`. The otherwise matching closing-conditioned redirect
  `solver_4c0e1314ad61` reaches those crossings at
  `9.246/11.209/13.140/15.026T`, captures at `16.225T`, and scores
  `-0.063208`. Thus partial normalized joint-phase removal from only the
  high-authority gate is now positive closed-loop evidence, not just a
  fixed-trace hypothesis.
- The assigned phase-lead parent `solver_bffa3def5d62` is the informative
  mechanism failure. Its visuals preserve the coherent wake and its path is
  identical to the closing-redirect baseline through the `0.8L` crossing,
  but it still captures at `16.225T` and regresses to `-0.065510` rather than
  anticipating arrival. A bounded short-window bearing extrapolation should
  not displace the evaluated phase residual.
- The faster phase-residual rollout carries a modest actuation cost: posterior
  exact acceleration-limit residence is `22.7%` versus `21.3%` for the
  closing-redirect baseline, although mean absolute posterior acceleration is
  slightly lower (`25.514` versus `25.677 rad/T^2`) and peak force/moment are
  comparable (`0.0393 L^2` and `0.0194 L^3`). Its joint-speed history exposes
  a separable inefficiency: on the command-aligned trace, `2.8%` of anterior
  and `4.9%` of posterior actions push outward while the corresponding joint
  is already at the `260 deg/T` speed limit. Projecting only those infeasible
  components to zero lowers fixed-trace mean absolute action from
  `23.452/25.514` to `23.294/24.871 rad/T^2`. Because the episode integrator
  already clamps the same outward speed increment, this projection leaves the
  next joint angle and velocity exactly unchanged at every activated sample.
- Inherited logs rule out shared anterior bias, two-sided lobe amplification,
  short-window yaw-rate steering, full zero-bend holds, and indiscriminate
  carrier shrink. The proposed projection retains the successful carrier,
  residual gate, raw redirect direction, opposing-lobe relief, closing
  schedule, and mean-first posterior allocator.

## Policy hypothesis

Start from the evaluated carrier-phase-residual controller and add one compact
constraint-aware anti-windup mechanism. Normalize each measured joint velocity
by the owned physical velocity limit; when a joint is already at that limit,
project only acceleration with the same sign as its velocity to zero. Inward
acceleration, every command below the speed limit, posterior mean curvature,
and the traveling-wave state feedback remain untouched. This is a
reflection-equivariant state projection rather than a gain change.

The expected result is the same coherent wake, milestone times, and capture as
`solver_a0cc85d2f5b2`, with fewer commands that cannot affect the clipped
joint state and lower mean command effort. Falsify the implementation if it
changes any below-limit command, breaks lateral reflection symmetry, produces
nonfinite/unbounded actions, or materially changes the sampled-best route or
arrival; falsify the reusable physical benefit if later actuator models assign
meaningful work to an outward command despite an exactly clamped joint speed.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control under bounded actuators
source_mechanism: preserve the rhythmic locomotion carrier while feedback removes actuator requests that cannot change an already constrained joint state
transferable_invariant: keep the established traveling bend and target residual intact, but project only outward acceleration at an observed joint-speed boundary
nontransferable_details: published CPG gains, species-specific wave envelopes, dimensional frequencies, motor models, prescribed phases, exact vortex phases, and task-specific routes
policy_translation: normalize each two-joint velocity by the owned speed limit and zero only same-sign acceleration at or beyond unit magnitude; all body-frame navigation feedback and feasible joint commands pass through unchanged
falsification: reject if below-limit commands change, reflection equivariance fails, coherent propulsion or capture is lost, arrival differs materially from the sampled best, or a richer actuator model shows that the projected command was not physically redundant

The new candidate has no same-worker CFD evidence. Only deterministic contract,
symmetry, boundedness, trace-equivalence, and command-projection checks are
claimed before downstream evaluation.

## Non-CFD verification

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. I then ran its
  three prescribed commands directly. The guidance check initially exposed a
  duplicated rendering of the same assigned parent in `README.md`; removing
  only that duplicate restored the unique-parent contract. Guidance
  provenance, the lightweight Julia policy contract, and the solver editable-
  boundary check all pass.
- A deterministic `18,225`-state sweep spanning joint angles, below-limit and
  exact-limit joint velocities, bearing, forward/lateral body velocity, and
  target distance returned finite bounded actions with lateral-reflection
  equivariance. Every state with both joints below the velocity limit matches
  `solver_a0cc85d2f5b2` exactly, and every exact-limit component has a
  non-outward command. All `33` direct `params.FIELD` references are present in
  `target_policy_params()`.
- Replaying the projection on the sampled-best action-aligned trace changes
  `82/2917` anterior and `143/2917` posterior commands. For every changed
  sample, the episode's clamped next joint velocity and angle are exactly equal
  to the evaluated update; mean absolute action falls from `23.452/25.514` to
  `23.294/24.871 rad/T^2`. This is deterministic integrator evidence, not a
  same-worker wake or trajectory claim.
