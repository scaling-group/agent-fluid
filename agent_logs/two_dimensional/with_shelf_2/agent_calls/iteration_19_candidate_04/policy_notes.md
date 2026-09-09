# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheets are byte-identical and show the common held-fish
  release condition: four developed, interacting vortex streets fill the
  diagonal target corridor while the fish is held near the upper-right
  boundary. This is initial-condition evidence, not a candidate-specific wake
  phase or route.
- All four sampled policies, candidate files, and released keyframe sheets are
  byte-identical. They reproduce `target_reached` at `44.121`, mean/final
  distance `1.70618/0.74893L`, score `0.173450`, and force/moment RMS
  `389/3909`. The keyframes show an immediate traveling body wave and active
  down-left swimming through the merged wakes without cylinder contact. Head
  displacement is `-10.910/-4.263L`, and mean body-x speed inferred from that
  displacement and release time is about `-0.247`, stronger upstream than the
  `-0.1848` mean local flow; the route is self-propelled rather than passive
  advection. The last frames retain visible downward course/yaw motion as the
  fish crosses the capture ring.
- No sampled solver is a failure, so there is no honest sampled failure
  keyframe comparison. The inherited semantic failure boundary is the broader
  posterior-propulsion allocator that passed below capture and collided after
  only a `1.872L` closest approach with `537/4995` force/moment RMS. The policy
  therefore keeps the base oscillator and posterior propulsion allocator
  unchanged.
- The assigned parent's sine-bounded lateral-course representation is a new
  concrete negative result. It retained capture but regressed from the sampled
  angular course residual's `44.121/1.70618L/0.173450` arrival, mean distance,
  and score to `46.074/1.73655L/0.144279`. Mean command energy fell only from
  `1036.49` to `1028.72`, while force/moment RMS rose from `389/3909` to
  `407/4002`. Together with inherited regressions from closure amplification,
  shared route-response clamping, and opposing-cue arbitration, this supports
  preserving the raw angular course residual and its independent authority.
- Inherited notes report that both joints reach the `4.538` rate cap in the
  successful reference and in the recent degraded variants, while commands
  approach the candidate soft acceleration limit. This is the remaining
  repeated actuator symptom. Aggregate diagnostics do not establish the sign
  of force, moment, or relative crossflow at route events, so this candidate
  does not add a signed hydrodynamic disturbance residual.

## Policy hypothesis

Add one state-feedback allocation mechanism around the proven rhythmic gait:
apply a smooth oscillator-normalized joint-rate headroom gate only to each
half-cycle steering residual when that residual would accelerate the joint
farther in its current velocity direction. Leave the residual unattenuated
when it opposes joint velocity, so steering can still brake and reverse the
joint. Preserve the zero-centered oscillator, posterior lag and progress
allocator, raw independently distance-gated course-angle damper,
time-to-go-capped heading forecast, yaw-magnitude gate, and final acceleration
soft limiter.

The expected later evidence is preserved first-crossing capture and diagonal
wake-entry topology with less joint-rate cap contact and lower load or effort,
without delaying arrival or worsening mean distance materially. Reject the
mechanism if capture is lost, the fish again passes below the target, arrival
or mean distance regresses without a material cap/load/effort benefit, or
attenuating outward steering creates a deeper terminal excursion. A fixed
prewarm result cannot establish robustness to changed wake phase, inflow,
geometry, or target.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual path-following control
source_mechanism: preserve a low-dimensional propulsive rhythm while allocating bounded sensor-feedback steering through current actuator state instead of replacing the gait with raw high-frequency commands
transferable_invariant: retain the traveling bend and use normalized joint-rate headroom to withhold only steering that compounds current joint motion while preserving restorative steering
nontransferable_details: published gains, dimensional frequencies or actuator limits, robot and species kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: gate each two-joint half-cycle steering acceleration by oscillator-normalized `phi_dot` only when steering acceleration and joint velocity have the same sign; leave the base wave and opposite-sign steering unchanged
falsification: reject if capture or diagonal topology is lost, terminal excursion deepens, arrival or mean distance regresses without material cap/load/effort relief, or hydrodynamic loads increase
