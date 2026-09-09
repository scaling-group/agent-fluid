# Acceleration-feasible response-gated C-bend candidate

## Visual diagnosis recorded before the policy edit

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Both the top-down
  mid-plane and oblique Lambda2 rows were inspected. The motion and alternating
  three-dimensional wakes are self-generated; no imposed flow or moving-window
  transport explains the route differences.
- The two response-conditioned distributed-C-bend policies retain compact
  oblique vortex structures and long coherent top-down streets through capture
  at `19.585T` and `19.784T`. The stronger response-demand form reaches the
  `0.75L` circle first, with local-flow RMS `(0.01758,0.00490)U`, force-magnitude
  RMS `0.01261`, moment RMS `0.00661`, and raw acceleration-limit exceedance in
  `39.5%/71.6%` of anterior/posterior rows.
- The sampled terminal safe-intercept release preserves a strong alternating
  wake but does not preserve the route. It changes the `19.585T` capture into a
  `1.712L` closest pass, crosses the target x station at head `y=11.255L`, and
  exits left at `28.897T` with final range `8.659L`. Its force/moment RMS rises
  to `0.01580/0.00812`, while raw acceleration-limit exceedance rises to
  `60.6%/76.4%` overall and `67.9%/75.7%` inside `3L`. Thus instantaneous
  closing speed plus constant-velocity predicted miss is not a reliable
  beat-resolved arrival response, and erasing both mean-steering branches is a
  concrete negative result rather than a terminal improvement.
- The phase-conditioned yaw residual itself still oscillates within a beat;
  replay of the winning trace does not support a new memoryless achieved-yaw
  gate without risking fast anterior-center modulation. The prior evidence
  therefore supports preserving the completed response-demand route, not a
  replacement terminal architecture or another scalar threshold edit.

## Policy hypothesis recorded before editing

Preserve the completed LOS-rate, phase-conditioned posterior response, bounded
distributed anterior C-bend, and propulsive traveling-wave equations exactly.
Add one feasibility mechanism at the policy boundary: componentwise project
the two returned accelerations into an owned `1800 deg/T^2` limit. The episode
already applies exactly this fixed physical limiter after every policy call,
so this projection is expected to leave joint evolution, wake, route, and
capture unchanged while preventing the controller from requesting impossible
accelerations and making its reported action contract explicit. This is not a
claim of reduced applied saturation or hydrodynamic load; those require a later
mechanism with completed evidence.

Falsify the preservation claim if reevaluation loses capture, changes arrival
or route beyond numerical reproducibility, weakens the coherent wake, or
changes applied joint histories. Treat zero *raw exceedance* as contract
compliance only, not as evidence that saturation occupancy or energetic effort
has improved.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: retain a propulsive rhythm while bounded observed route demand recruits reversible distributed mean curvature
transferable_invariant: preserve the evidenced traveling bend and response-conditioned curvature; do not erase steering until an observed response is reliable
nontransferable_details: published gains, species kinematics, dimensional frequencies, source actuator models, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame bearing and rotation-invariant LOS-rate feedback in the two-joint controller, and add only a parameter-owned componentwise acceleration projection matching the physical contract
falsification: reject if the projected policy fails to reproduce capture or changes applied actions; do not count lower raw-command exceedance alone as lower load or effort
