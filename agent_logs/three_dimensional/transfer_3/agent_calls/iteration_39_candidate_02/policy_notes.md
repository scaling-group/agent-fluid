# Joint-speed headroom candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct-uniform still
  water with `U_infinity=(0,0,0)`, no prewarm or cylinders, finite dynamics,
  and capture at `18.6560--18.7330T`. The two plain actuator-consistent
  replications capture at `18.6725T` and `18.7330T`, score `-0.13219` and
  `-0.13142`, and have mean distance `2.02018L` and `2.01959L`. Helpful-moment
  relief arrives at `18.6560T`, but its `0.0165T` edge is smaller than the
  same-policy timing spread and its score `-0.13321` does not separate.
- I inspected the combined sheets for the best-score plain route, the helpful-
  moment non-improvement, and the one-sided anti-windup result. The top-down
  row shows a coherent alternating caudal-vorticity street forming from the
  quiescent release and persisting through a shallow target-closing route. The
  oblique row independently shows compact body-led Lambda2 structures shed
  behind the tail without wake breakup, boundary contact, or instability.
  Together with zero imposed flow, these views establish active propulsion,
  not advection. No current sampled rollout is a terminating failure, so the
  anti-windup rollout is the most informative semantic non-improvement.
- Exact-boundary anti-windup captures at `18.7000T`, scores `-0.13320`, and has
  mean distance `2.02103L`, inside but not better than the replicated plain
  route. Inherited logs show that it nevertheless removes outward-at-boundary
  commands and reduces posterior returned-action RMS/acceleration occupancy to
  about `28.24 rad/T^2 / 73.9%` from the plain route's
  `28.72--28.77 rad/T^2 / 75.2--75.5%`, while force/moment loads and wake
  topology overlap. The supported lesson is feasibility cleanup without a
  route or load benefit; repeating the boundary gate, another moment
  allocator, or scalar gain tuning is not supported.
- The inherited headroom analysis isolates the remaining distinction: a
  finite outward command can consume more joint-speed headroom than remains
  for the next maximum `0.0055T` update before the episode clamps velocity.
  Its frozen replay affects only about `0.62% / 0.94%` of anterior/posterior
  actions, so this is a narrow prospective feasibility test rather than a
  carrier contraction. Inherited closing-speed carrier contraction is the
  relevant negative control: it keeps a coherent wake but delays capture to
  `18.8705T`, worsens mean distance to `2.04281L`, and shifts effort upstream.

## Policy hypothesis recorded before the policy edit

Preserve the normalized body-frame bearing-plus-LOS-rate C-bend, joint-state
traveling carrier, response-reversing half-cycle steering, persistent same-
side posterior phase recruitment, and componentwise acceleration clamp.
Replace reactive exact-boundary blocking with one prospective velocity-
headroom projection: only when acceleration points with joint motion, cap its
magnitude by the remaining normalized joint-speed headroom divided by the
parameter-owned maximum update horizon; leave opposite-sign braking entirely
unchanged. At the posterior boundary, continued same-side raw demand remains
the causal persistence witness for the existing phase actuator and releases
immediately when demand reverses. This changes one feasibility mechanism, not
the established route, carrier gains, or approach envelope.

Support requires capture inside the inherited `18.6725--19.0520T` band, mean
distance no greater than `2.02129L`, coherent wakes in both views, force/moment
RMS no greater than `0.01350/0.00703`, and reverse braking preserved. The
headroom projection must eliminate next-update velocity overshoot and reduce
posterior returned effort or clipping beyond the exact-boundary result without
moving effort anteriorly. Falsify it if it delays or loses capture, weakens the
traveling wake, changes phase reversal, increases load, or merely reproduces
the exact-boundary result; then retain exact-boundary anti-windup only as an
effort cleanup and stop elaborating velocity-feasibility projections.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded gait actuation
source_mechanism: preserve a coordinated rhythmic carrier while observed joint state gates only the actuator-infeasible command component
transferable_invariant: keep the directed posterior-lagged traveling bend primary and preserve reverse response while preventing outward commands from exceeding available joint-speed headroom
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, actuator hardware, and task-specific routes
policy_translation: retain the normalized body-frame LOS C-bend and two-joint phase path; normalize observed joint speed by the parameter-owned hard limit and project only same-direction acceleration into one-update headroom using the lane's maximum update bound
falsification: reject if capture leaves the replicated route band, either wake weakens, braking or phase reversal changes, load exceeds the baseline envelope, or effort does not separate from exact-boundary anti-windup

The current candidate's CFD evaluation occurs only after this worker exits and
is not claimed as evidence here.
