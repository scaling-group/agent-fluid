# Joint-speed headroom projection candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct-uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture at `18.6560--18.7330T`. I inspected every combined
  sheet from release through capture in both the top-down vorticity and
  oblique Lambda2 rows. Each fish forms a body-led alternating wake by `4T`,
  retains a shallow continuously corrected route, and reaches the target
  without wake breakup, boundary contact, or passive advection. The assigned
  parent's wake and route are visually indistinguishable at sheet resolution
  from the two plain actuator-consistent references.
- The assigned-parent one-sided anti-windup is now a completed positive
  feasibility result, but not a route-speed improvement. It captures at
  `18.7000T`, scores `-0.13320`, and has mean distance `2.02103L`, all inside
  the plain exact-policy range (`18.6725--18.7330T`, `-0.13362-- -0.13142`,
  `2.01959--2.02129L`). Its posterior action RMS falls to `28.237 rad/T^2`
  from `28.715--28.769`, and posterior acceleration-limit occupancy falls to
  `73.91%` from `75.19--75.46%`; anterior RMS/occupancy remain within plain
  spread. Force/moment RMS (`0.01333/0.00694`) and local-flow RMS (`0.01809U`)
  also overlap the plain route, so the useful semantic is feasible action
  without propulsion or route loss, not lower hydrodynamic load.
- Trace alignment matters: each logged action is computed from the preceding
  logged joint state and the logged joint is post-integration. With that
  alignment, the plain references command outward from an already active
  speed boundary during `2.23--2.36% / 6.11--6.39%` of anterior/posterior
  samples. The parent's anti-windup reduces both to exactly zero while keeping
  reverse braking at `0.62% / 0.94%`. Apparent outward action paired with a
  same-row limited velocity is therefore entry into the boundary, not leakage
  through the parent's exact-boundary gate.
- The remaining actuator mismatch occurs on boundary entry: a finite outward
  acceleration can exceed the velocity headroom left for the next solver
  update, after which the episode clips the resulting joint speed. A frozen
  replay using the documented maximum update `0.0055T` changes only
  `0.62% / 0.94%` of the assigned parent's anterior/posterior actions, lowers
  posterior replay RMS from `28.237` to `28.147 rad/T^2`, and lowers replay
  posterior acceleration-limit occupancy from `73.91%` to `73.26%`. This is
  a narrow prospective feasibility opportunity, not support for weakening
  the carrier globally.
- The inherited closing-speed carrier-envelope sibling is a relevant negative
  control. Its wake remains coherent in both views and it still captures, but
  arrival slows to `18.8705T`, mean distance worsens to `2.04281L`, and score
  falls to `-0.15464`. Do not combine near-range carrier contraction with the
  headroom test or scalar-tune that envelope; it changes useful propulsion
  without solving a route failure.

## Policy hypothesis recorded before the policy edit

Preserve the normalized bearing-plus-LOS-rate C-bend, state-feedback traveling
carrier, response-reversing half-cycle path, persistent same-side posterior
phase recruitment, and componentwise acceleration clamp exactly. Replace the
reactive exact-boundary gate with one prospective, reflection-equivariant
velocity-headroom projection: for outward acceleration only, cap magnitude by
`(joint_velocity_limit - abs(phi_dot)) / projection_horizon`, using the
parameter-owned `0.0055T` maximum update horizon; leave all reverse braking
untouched. At the posterior speed boundary, treat either zero or same-side
headroom-limited previous action as the persistence witness while raw demand
continues, and release immediately when demand reverses. This is a one-step
control-barrier mechanism, not a carrier-gain change.

Support requires capture inside `18.6725--19.0520T`, mean distance no greater
than `2.02129L`, coherent wakes in both views, and force/moment RMS no greater
than `0.01350/0.00703`. The feasibility mechanism must preserve reverse
braking and remove next-update speed overshoot while reducing posterior action
or clipping beyond the parent's `28.237 rad/T^2 / 73.91%`; falsify it if
prospective limiting changes the traveling-wave phase, delays the route,
weakens propulsion, or merely moves effort into the anterior joint. On
falsification restore the completed exact-boundary anti-windup rather than
tuning the projection horizon.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and actuator-envelope gait design
source_mechanism: preserve a coordinated rhythmic carrier while a joint-state feasibility layer prevents commands from demanding motion beyond an active actuator envelope
transferable_invariant: keep the posterior-lagged traveling bend primary and project only outward acceleration into normalized one-update joint-speed headroom while preserving reverse braking
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, actuator hardware, and task-specific routes
policy_translation: retain the body-frame LOS C-bend and persistent two-joint phase path; cap same-direction acceleration by parameter-owned joint-speed headroom over the solver's maximum update horizon and retain raw same-side demand only as the causal phase-persistence witness at the boundary
falsification: reject if capture leaves 18.6725--19.0520T, mean distance exceeds 2.02129L, either wake weakens, force/moment RMS exceeds 0.01350/0.00703, reverse braking is reduced, or effort shifts upstream instead of eliminating next-update speed overshoot

The current candidate's CFD evaluation occurs only after this worker exits and
is not used as evidence here.
