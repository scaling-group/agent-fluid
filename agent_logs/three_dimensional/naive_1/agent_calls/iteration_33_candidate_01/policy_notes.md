# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. Three semantically
  equivalent proximity-lead compositions have byte-identical trajectories and
  reproduce exactly `22.187000T` capture, `0.748118L` crossing,
  `2.106255L` scored mean distance, and score `-0.211504`. The informative
  weaker assigned-parent sample captures at `22.307997T`, with `0.748057L`
  crossing, `2.107401L` mean distance, and score `-0.212396`.
- Both rows of the best and weaker sampled combined sheets were inspected from
  release through capture. Their top-down rows show self-propulsion rather than
  advection: alternating red/blue structures grow from the caudal region,
  remain attached along the S-shaped route, and persist through capture. Every
  sampled oblique row is black after its frame labels, so the current samples
  provide no new three-dimensional Lambda2 evidence. The inherited complete
  two-view common-controller sheet was also inspected; its discrete oblique
  caudal structures persist from `4T` through capture and remain the applicable
  3D-wake bound. A black render is an evidence failure, not wake collapse.
- The current composition changes only the rudder predictor: the existing
  normalized `8.0--5.5L` proximity gate extends its line-of-sight lead from one
  to one-and-a-half carrier cycles while the fixed one-cycle prediction still
  selects posterior recovery quadrature. Relative to the assigned parent it
  leaves the trajectory unchanged before proximity recruitment, then is closer
  at `16/20/22T` (`3.983/1.872/0.830L` versus
  `3.993/1.884/0.876L`) and captures `0.121T` earlier. This establishes
  compatibility of separate locomotor and steering prediction horizons, not
  support for more rudder magnitude or a still longer scalar horizon.
- The improvement has a bounded cost. Trace-derived mean action rises from
  about `59.675` to `59.850`, while anterior/posterior exact-rate-cap occupancy
  remains about `11.55/6.45%` and peak normalized force/moment remain exactly
  `0.030897/0.015839`. During the established approach the full body-frame
  target error and bounded target-line residual have the same sign at every
  sample below `8L`; the residual grows from roughly `0.05 rad/T` near `9T`
  to `0.26 rad/T` on average after `20T`. The remaining error is therefore a
  persistent, measured pursuit demand rather than an isolated wake impulse.
- Inherited evidence rules out another scalar terminal gate, fitted beat-motion
  subtraction, tail-rate unloading, posterior half-cycle recovery
  redistribution, angle-quadrature stacking, and an unqualified yaw-moment
  residual. The new test keeps those paths unchanged and moves the already
  bounded target-line prediction onto one unsampled actuator gate.

## One candidate hypothesis

Preserve the current through-water course feedback, anterior oscillator-energy
recovery, full body-frame geometry, phase-selective posterior carrier, fixed
posterior recovery budget, proximity-adaptive reactive rudder, and
response-plus-stroke terminal relief. Change only anterior redirect
recruitment: apply the existing redirect thresholds to the fixed one-cycle
predicted full target error already used by the posterior recovery allocator,
and use that separate smooth gate only on the existing `16.0` anterior
acceleration residual. Keep instantaneous full target error on posterior
carrier relief and stroke shaping, and keep the longer proximity prediction
confined to the rudder.

This is a sensor-triggered burst-redirect translation, not scalar gain tuning.
When the observed body-frame target line predicts growing error, the anterior
joint should recruit its already capped target-side redirect before current
geometry catches up; as predicted error falls, the same continuous gate
releases back to the joint-state traveling carrier. No oscillator, recovery,
rudder, angle, rate, acceleration, distance, or prediction limit changes, and
the policy adds no clock, fixed coordinate, route memory, case identity,
modeled vortex phase, force/moment residual, or mutable state.

Falsify the mechanism if capture is lost or not earlier than `22.187000T`,
scored mean distance is not below `2.106255L`, or score does not exceed
`-0.211504`. Also reject it if the inherited `4/8T` launch distances exceed
`11.300/8.629L`, the `12/16/20/22T` route does not improve, mean action
materially exceeds `59.850`, anterior/posterior exact-rate-cap occupancy
materially exceeds about `11.55/6.45%`, peak normalized force/moment exceed
`0.030897/0.015839`, or a valid two-view sheet fails to retain the coherent
alternating three-dimensional wake. A positive fixed-pose still-water result
would show actuator-path compatibility, not robustness to changed pose,
inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: recruit a bounded anterior redirect when measured target geometry predicts growing heading error, then release continuously into the posterior-delayed carrier as the predicted error falls
transferable_invariant: a slow body-frame route prediction can advance an already capped steering gate without increasing carrier or steering authority, while joint-state feedback preserves the traveling bend
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific C-start kinematics, distributed-body envelopes, robot calibration, source-task prediction horizons, prescribed routes, fixed coordinates, and exact vortex phases
policy_translation: replace current-error recruitment only on the existing anterior redirect with the separately bounded one-cycle predicted-error gate; retain current error on tail shaping and the proximity-adaptive prediction only on the rudder
falsification: reject if capture is not earlier than 22.187000T, mean distance is not below 2.106255L, or the established launch, route, valid two-view wake, action, saturation, force, or moment envelopes worsen
