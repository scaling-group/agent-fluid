# One-step speed-feasibility projection candidate

## Visual and metric diagnosis before the edit

- The four assigned solver examples are exact repeats: their policy,
  trajectory, and combined keyframe hashes match. Each satisfies the released
  direct-uniform still-water contract (`U_infinity=[0,0,0]`, no cylinders, no
  prewarm), captures at `16.609995T` and `0.745621L`, and scores `-0.115560`.
  Exact replication supports fixed-case determinism, not held-out robustness.
- I inspected both rows of the combined keyframe sheet for an assigned
  speed-guard capture and the distinct inherited mean-preserving capture at
  `16.631994T`. The top-down views show self-propelled targetward translation
  and an alternating red/blue wake that stays connected to the caudal region;
  the oblique views show finite, compact three-dimensional Lambda2 structures
  behind the tail through capture. Their shallow approach arcs and wake class
  are nearly identical. There is no sampled semantic failure, so the weaker
  completed capture is the informative controlled comparator rather than a
  fabricated failure case.
- The replicated speed guard retains the inherited mechanism's small matched
  advantage: relative to the mean-preserving carrier, it arrives about
  `0.022T` earlier, lowers scored distance integral from `2.001992L` to
  `1.999656L`, lowers mean requested acceleration from `22.77/25.43` to
  `21.74/22.69 rad/T^2`, reduces maximum joint excursions from
  `0.548/0.556` to `0.541/0.549 rad`, and lowers peak planar force/moment from
  about `0.03678/0.01827` to `0.03583/0.01776`.
- A direct replay of the released joint update exposes a smaller remaining
  command/actuator mismatch. With `dt=0.0055T` and the declared
  `260 deg/T` speed limit, the returned post-guard acceleration would still
  step outside the speed envelope on 30 of 3020 joint-1 updates (`0.993%`)
  and 34 joint-2 updates (`1.126%`). The runtime clips those predicted speeds.
  Capping only the excess would reduce all-sample mean requested acceleration
  by about `0.069/0.137 rad/T^2`, with maximum removed excess
  `13.58/21.63 rad/T^2`. This replay establishes redundancy and scale only;
  it is not counterfactual CFD evidence.
- Inherited optimizer logs bound the intervention. Waiting until exact speed
  equality was behaviorally inert, while broad wave relief, startup
  recruitment, and added terminal mean curvature damaged a useful route or
  its effort/load envelope. The full carrier, body-frame route response,
  phase-selective posterior steering, yaw demodulation, and existing smooth
  guard should therefore remain unchanged.

## Single policy hypothesis

After the completed smooth guard, add one parameter-owned, one-step
feasibility projection. For an acceleration pointing in the same direction as
measured joint velocity, retain at most the acceleration that reaches the
declared speed boundary on the next released integration step. Pass inward
reversal commands and all requests whose predicted speed remains feasible
unchanged. This is a symmetric two-joint constraint mechanism; it uses no
world direction, target identity, elapsed time, route memory, or external
phase.

Because the released integrator already clips precisely the removed excess,
the candidate should retain the replicated capture arc, reversal timing, and
connected wake while reporting only realizable requested effort. Falsify it
if capture, arrival, distance integral, joint history, wake topology, force,
or moment changes materially, or if mean action and predicted overshoot
residence do not fall. The mechanism is valid only while the policy's
parameter-owned prediction step matches the actuator update; a changed step
or integration order requires disabling or recalibrating the projection.

bookshelf_consulted: true
source_domain: bounded robotic-fish CPG control and reactive traveling-wave propulsion
source_mechanism: preserve a useful rhythmic carrier while applying a separate state-feedback correction compatible with actuator feasibility
transferable_invariant: preserve feasible traveling-wave and reversal motion while removing only the command component that lies outside the actuator's next-step tangent cone
nontransferable_details: published gains, dimensional beat frequencies, species or robot kinematics, waveform envelopes, exact vortex phases, task-specific routes, and simulator step size
policy_translation: retain the normalized body-frame two-joint carrier and smooth speed guard, then cap only outward acceleration above the remaining normalized joint-speed margin divided by the parameter-owned actuator step
falsification: reject if capture, targetward arc, connected three-dimensional wake, reversal timing, joint clearance, force, moment, or feasible effort worsens, or if the runtime actuator step differs from the policy prediction

## Evaluation boundary

No CFD result is claimed for this child. Its later evaluation should first
require capture and preservation of both wake views, then compare arrival,
scored and observed distance integral, exact target-relative trajectory,
joint histories, predicted speed overshoot count, outward command at the speed
boundary, mean/RMS action, reversal timing, joint contact, and peak planar
force/moment against the four exact completed speed-guard captures.
