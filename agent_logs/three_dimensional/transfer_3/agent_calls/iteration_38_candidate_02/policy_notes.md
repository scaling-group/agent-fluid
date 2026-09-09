# Replicated-route joint-rate anti-windup candidate

## Visual and metric diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct-uniform still
  water with `U_infinity=(0,0,0)`, no prewarm or cylinders, finite dynamics,
  and capture at `18.6725--18.7440T`. I inspected the combined top-down
  vorticity and oblique Lambda2 sheets for the best-score exact route and the
  assigned stress-gated-moment route from release through capture. Both form a
  body-led alternating caudal wake by `4T`, retain a shallow continuously
  corrected trajectory, and show no passive advection, wake breakup, boundary
  contact, or instability. Their `0.532--0.535U` body speed at `4T` and
  `0.01804--0.01816U` local-flow RMS confirm self-propulsion from the uniform
  zero-flow release.
- Three exact actuator-consistent samples capture at `18.6725--18.7330T`,
  score `-0.13362-- -0.13142`, and mean distance
  `2.01959--2.02129L`. Their posterior returned-action RMS is
  `28.72--28.85 rad/T^2`, acceleration-limit occupancy is
  `75.19--76.11%`, and force/moment RMS is
  `0.01331--0.01350 / 0.00693--0.00703`.
- The assigned stress-gated helpful-moment residual is not a separated
  improvement. It captures at `18.7440T`, scores `-0.13364`, and has mean
  distance `2.02198L`; posterior action RMS `28.77 rad/T^2`, acceleration-limit
  occupancy `75.44%`, and force/moment RMS `0.01343/0.00699` all overlap the
  exact route. The wake sheets are visually indistinguishable at their
  resolution. This completes another negative for instantaneous physical-yaw
  allocation: nesting moment relief behind phase recruitment, correction
  satisfaction, and predicted stress still does not produce route, effort, or
  load separation. Remove that residual rather than tuning its scale.
- The assigned optimizer log supplies the useful counterpoint. One-sided
  joint-rate anti-windup captured at `18.7000T`, inside the replicated route
  band, while reducing posterior returned-action RMS to `28.24 rad/T^2` and
  acceleration-limit occupancy to `73.97%`; its wake, `0.536U` speed at `4T`,
  and `0.01333/0.00694` force/moment RMS remained in the productive baseline
  envelope. The supported semantic is feasible-command cleanup without route
  loss, not faster capture or lower hydrodynamic load.

## Policy hypothesis recorded before the policy edit

Produce exactly one candidate by restoring the sampled actuator-consistent
posterior phase path and applying the inherited one-sided joint-rate
anti-windup projection. Preserve the normalized body-frame bearing-plus-LOS-
rate C-bend, traveling two-joint carrier, response-reversing half-cycle
steering, persistent same-side phase recruitment, coefficient rotation, and
componentwise acceleration clamp. Add the physical `260 deg/T` joint-speed
limit to `target_policy_params`. At that observed boundary, return zero only
when acceleration and joint velocity have the same sign; preserve the full
opposite-sign command for braking. When posterior outward demand is zeroed at
the boundary, use that continued raw same-side demand as the existing phase-
persistence witness, and release it immediately when demand reverses.

A later evaluation supports this candidate only if it captures within the
inherited `18.6725--19.0520T` route band with mean distance no greater than
`2.02129L`, coherent self-propelled wakes in both views, and force/moment RMS
no greater than `0.01350/0.00703`. The mechanism must also replicate posterior
returned-action RMS or acceleration-limit occupancy below the exact sample's
`28.72 rad/T^2 / 75.19%` lower bounds while retaining reverse braking and phase
reversal. Falsify it on route delay or loss, weakened propulsion, load growth,
or no repeated effort separation; then restore plain feasible-action
projection instead of tuning the speed threshold. The new CFD result occurs
only after this worker exits and is not claimed here.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and actuator-envelope gait design
source_mechanism: preserve a coordinated rhythmic carrier while joint-state feedback prevents commands from winding farther into an active actuator constraint
transferable_invariant: keep the directed posterior-lagged traveling bend primary; at a hard joint-speed boundary suppress only same-direction acceleration and preserve reverse braking authority
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, actuator hardware, and task-specific routes
policy_translation: retain the normalized body-frame LOS route and two-joint phase actuator, then project each feasible acceleration using observed joint velocity and a parameter-owned speed limit under a reflection-equivariant signed-product test
falsification: reject if capture leaves the replicated route band, either wake weakens, braking or phase reversal is impaired, force/moment loads exceed the baseline envelope, or posterior effort does not separate from the plain route
