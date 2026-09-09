# Replicated-route joint-rate anti-windup candidate

## Visual and metric diagnosis recorded before the policy edit

- All four sampled solver rollouts satisfy the frozen contract: direct-uniform
  still water with `U_infinity=(0,0,0)`, no prewarm or cylinders, finite
  dynamics, and capture at `18.6560--18.7330T`. I inspected the combined
  top-down/oblique sheets for the best-score exact route and the joint-rate
  anti-windup route, and compared them with the inherited closing-speed
  carrier-contraction negative. Each fish generates its wake from release; by
  `4T`, the top-down row shows a coherent alternating caudal-vorticity street
  and the oblique row shows compact Lambda2 structures shed behind the tail.
  The exact and anti-windup trajectories retain the same shallow corrected
  approach with no growing lateral excursion, wake breakup, collision,
  boundary contact, or instability. Local-flow RMS remains only
  `0.01804--0.01822U`, so the target approach is self-propelled rather than
  passive advection.
- The plain actuator-consistent policy has two current same-hash captures at
  `18.6725T` and `18.7330T`, scores `-0.13219` and `-0.13142`, mean distance
  `2.02018L` and `2.01959L`, posterior returned-action RMS `28.77` and
  `28.72 rad/T^2`, posterior acceleration-limit occupancy `75.46%` and
  `75.22%`, and force/moment RMS within
  `0.01331--0.01335 / 0.00693--0.00695`. This same-policy spread is the route
  baseline; the helpful-moment sample's `0.0165T` timing edge is smaller than
  inherited repeat variability and does not support another moment allocator.
- The sampled joint-rate anti-windup policy captures at `18.7000T` with score
  `-0.13320` and mean distance `2.02103L`, inside the replicated route
  envelope. Its `0.536U` body speed at `4T` and both wake rows are
  indistinguishable from the productive baseline. Posterior returned-action
  RMS falls to `28.24 rad/T^2` and acceleration-limit occupancy to `73.97%`;
  the controller returns zero on `6.38%` of posterior samples at the hard
  speed boundary while retaining reverse braking. Force/moment RMS
  `0.01333/0.00694` and rate-limit residence still overlap baseline, so the
  supported result is feasible-command cleanup without a route penalty, not
  faster capture or lower hydrodynamic load.
- The inherited closing-speed carrier contraction is the informative
  mechanism failure. It retains a coherent wake but delays capture to
  `18.8705T`, raises mean distance to `2.04281L`, leaves range `2.8599L` at
  `16T` and `1.3862L` at `18T`, and scores `-0.15464`. Its lower posterior
  occupancy/load (`74.06%`, `0.01312/0.00683`) comes with anterior occupancy
  rising to `42.32%`: it trades terminal progress for load relief and shifts
  effort upstream. Do not retune or combine that range gate with anti-windup.

## Policy hypothesis recorded before the policy edit

Produce exactly one candidate by applying the sampled one-sided joint-rate
anti-windup projection to the prefilled actuator-consistent route. Preserve
the normalized body-frame bearing-plus-LOS-rate C-bend, traveling two-joint
carrier, response-reversing half-cycle steering, persistent same-side
posterior phase recruitment, coefficient rotation, and componentwise
acceleration clamp. Add the `260 deg/T` speed limit to the parameter object.
At that observed boundary, return zero only when acceleration and joint
velocity have the same sign; retain the full opposite-sign command for
braking. When the posterior return is zero for this reason, continuing raw
outward demand remains the persistence witness for the already established
phase gate, and disappears immediately when demand reverses.

A later evaluation supports the candidate only if it again captures within
the inherited `18.6725--19.0520T` route band with mean distance no greater
than `2.02129L`, coherent self-propelled wakes in both views, and force/moment
RMS no greater than `0.01350/0.00703`. The anti-windup mechanism must also
replicate posterior returned-action RMS or acceleration-limit occupancy below
the exact sample's `28.72 rad/T^2` / `75.22%` lower bounds without impairing
reverse braking or phase reversal. Falsify it on route delay/loss, weakened
propulsion, load growth, or no repeated effort separation; in that case
restore the plain feasible-action projection instead of tuning the speed
threshold. The new CFD result occurs only after this worker exits and is not
claimed here.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and actuator-envelope gait design
source_mechanism: preserve a coordinated rhythmic carrier while joint-state feedback prevents commands from winding farther into an active actuator constraint
transferable_invariant: keep the directed posterior-lagged traveling bend primary; at a hard joint-speed boundary suppress only same-direction acceleration and preserve reverse braking authority
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, actuator hardware, and task-specific routes
policy_translation: retain the normalized body-frame LOS route and two-joint phase actuator, then project each feasible acceleration using observed joint velocity and a parameter-owned speed limit under a reflection-equivariant signed-product test
falsification: reject if capture leaves the replicated route band, either wake weakens, braking or phase reversal is impaired, force/moment loads exceed the baseline envelope, or posterior effort no longer separates from the plain route
