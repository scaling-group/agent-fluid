# Posterior-only joint-rate anti-windup candidate

## Visual and metric diagnosis recorded before the policy edit

- All four current examples satisfy the frozen contract: direct-uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture at `18.6725--18.7440T`. The two plain
  actuator-consistent replications capture at `18.6725T` and `18.7330T`, with
  mean distance `2.02018L` and `2.01959L`; their same-hash timing and score
  spread is the route baseline, so the moment-residual run's nearby result is
  not evidence for another fluid-response allocator.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the best current plain route, the current exact-boundary anti-windup route,
  and the current moment-residual route, then compared them with the inherited
  prospective-headroom underperformer and exact anti-windup repeat. Each wake
  forms from the quiescent release, becomes a coherent alternating body-led
  street by `4T`, and persists along a shallow corrected target approach. No
  passive advection, wake breakup, boundary contact, or instability precedes
  capture. The headroom underperformer instead shows a slightly longer late
  closure at `19.124T`; its wake remains coherent, so it is an actuator/route
  tradeoff rather than a propulsion failure. Current local-flow RMS remains
  only `0.01804--0.01816U`, consistent with self-propulsion.
- Exact-boundary anti-windup now has two same-policy evaluations. It captures
  at `18.7000T` and `18.7825T`, scores `-0.13320` and `-0.14324`, and has mean
  distance `2.02103L` and `2.03157L`. Thus it is not a replicated route-speed
  improvement. It does replicate a posterior feasibility improvement:
  returned-action RMS is `28.24` and `27.99 rad/T^2`, and acceleration-limit
  occupancy is `73.97%` and `72.24%`, versus `28.72--28.77 rad/T^2` and
  `75.22--75.46%` for the two plain current references. In contrast, anterior
  RMS (`24.61--24.71`) overlaps the plain `24.70--24.73` range and anterior
  occupancy (`40.68--41.96%`) does not improve on the plain
  `40.37--40.82%` range. Projecting both joints is therefore broader than the
  supported benefit.
- The inherited prospective velocity-headroom mechanism is a concrete
  negative. Two executions capture at `18.7330T` and `19.1235T`, score
  `-0.13620` and `-0.16366`, and raise mean distance to `2.02411L` and
  `2.05212L`. Although posterior RMS/occupancy fall slightly further to
  `28.05--28.21 rad/T^2` / `72.56--73.69%`, the route cost is unresolved and
  one run leaves the established arrival band. Do not scalar-tune its
  projection horizon or elaborate a soft pre-limit taper.

## Policy hypothesis recorded before the policy edit

Preserve the normalized body-frame bearing-plus-LOS-rate C-bend, traveling
two-joint carrier, response-reversing half-cycle steering, persistent
same-side posterior phase recruitment, and componentwise acceleration clamp.
Apply the completed exact-boundary anti-windup only to the posterior joint,
where two runs show separated returned-effort reduction: when observed
posterior velocity is at the parameter-owned hard limit, return zero only for
same-direction acceleration and preserve full reverse braking. Keep anterior
acceleration unchanged after its ordinary clamp. When the posterior projected
return is zero, continued same-side raw posterior demand remains the causal
persistence witness for the established phase gate and releases immediately
when demand reverses.

This single allocation change should retain the baseline anterior route
response while preserving the replicated posterior effort cleanup. Support
requires capture inside `18.6725--19.0520T`, coherent wakes in both views,
posterior RMS below `28.72 rad/T^2` or occupancy below `75.22%`, and
force/moment RMS no higher than `0.01350/0.00703`. Falsify it if capture is
lost or delayed beyond that band, mean distance exceeds `2.03157L`, braking or
phase reversal changes, posterior effort returns to baseline, or load rises;
then the exact-boundary projection should be retained only as an optional
whole-controller feasibility cleanup, not treated as a route improvement.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and actuator-envelope gait design
source_mechanism: preserve a coordinated traveling rhythm while observed joint state gates only the actuator-infeasible command component
transferable_invariant: keep the directed posterior-lagged carrier primary, localize constraint feedback to the actuator with evidenced redundant effort, and preserve reverse response
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, actuator hardware, and task-specific routes
policy_translation: retain normalized body-frame LOS route feedback and the two-joint state-feedback carrier; compare posterior joint rate with its parameter-owned hard limit and suppress only same-direction acceleration there while leaving anterior steering and posterior braking unchanged
falsification: reject if capture leaves the replicated route band, either wake weakens, braking or phase reversal changes, posterior effort does not remain below the plain route, or force/moment loads exceed the inherited envelope

The current candidate's CFD evaluation occurs only after this worker exits and
is not used as evidence here.
