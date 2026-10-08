# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four current samples are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three executable-identical
  descendants use the fixed one-cycle line-of-sight prediction to allocate the
  posterior recovery budget and reproduce exactly `22.307997T` capture,
  `2.107401L` scored mean distance, `0.748057L` crossing, and score
  `-0.212396`. The assigned prefill instead keeps instantaneous target-error
  recovery allocation and increases rudder prediction continuously from one
  to one-and-a-half cycles with proximity; it captures at `22.423492T`, with
  `2.117908L` mean distance, `0.748246L` crossing, and score `-0.222711`.
- Both visual rows were inspected before this proposal. All top-down sheets
  show self-propelled S-shaped approaches: alternating red/blue mid-plane
  structures develop behind the caudal region and remain attached and rhythmic
  through capture rather than indicating passive advection or wake collapse.
  One exact repeat of the stronger policy has a complete oblique row, where
  discrete three-dimensional Lambda2 structures appear behind the moving tail
  by `4T` and remain visible through capture. The other two repeat rows and the
  assigned prefill's oblique row are black render artifacts, so they are not
  independent three-dimensional-wake evidence.
- The predicted recovery allocator is a positive semantic result. Relative to
  the prefill, the repeated stronger trace is closer at `8/12/16/20/22T`
  (`8.629/6.147/3.993/1.884/0.876L` versus
  `8.646/6.202/4.077/1.986/0.946L`) and captures `0.115T` earlier. Mean
  action falls slightly from about `59.760` to `59.675`; anterior/posterior
  rate-cap occupancy remains about `12.0/6.6%`; peak normalized force/moment
  change only from `0.030527/0.015817` to `0.030897/0.015839`. The stronger
  policy crosses with larger full target error (`1.073` versus `0.761 rad`),
  so its gain is route progress rather than better terminal alignment.
- The inherited fixed-lead, instantaneous-allocation control captured at
  `22.500492T`, with `2.120233L` mean distance and score `-0.225086`.
  Against that common control, the assigned prefill's proximity-adaptive
  rudder lead is narrowly positive (`0.077T` earlier and `0.002325L` lower
  mean distance), while the siblings' fixed-lead predictive recovery
  allocation is more strongly positive (`0.192T` earlier and `0.012832L`
  lower mean distance). These are two matched observation-to-actuator changes,
  but their composition has not been tested. No current sample is a
  non-capture; the relevant inherited failure remains fitted beat-synchronous
  self-motion subtraction, which retained a coherent two-view wake but missed
  at `0.813329L` and later exited at `6.290125L`. That failure bounds this test
  away from another reconstructed-motion observation.

## One candidate hypothesis

Use the repeated stronger policy as the base. Preserve its through-water
course feedback, anterior speed recovery, full body-frame geometry, anterior
redirect, phase-selective carrier, fixed recovery budget, response-qualified
terminal relief, and fixed one-cycle `led_target_error` as the sole selector
of the whole-carrier versus velocity-quadrature recovery crossfade. Add a
second, separately named `rudder_led_target_error`: increase only its bounded
line-of-sight lead from one to one-and-a-half carrier cycles as the existing
normalized `8.0--5.5L` rudder proximity gate fills, then use it only in the
already bounded rudder error gate. Do not feed the adaptive lead into anterior
steering, carrier shaping, or recovery allocation.

The hypothesis is that the fixed one-cycle predictor preserves the siblings'
early and midcourse locomotor allocation, while the independently positive
proximity-adaptive predictor improves late rudder recruitment after the
distance gate activates. This is a factorial composition of two completed
state-feedback paths, not added authority: the carrier, `0.12` recovery share,
rudder sign, `16 deg` rudder ceiling, oscillator gains, terminal relief, and
all thresholds remain unchanged. It uses normalized body-frame target,
through-water velocity, observed short-window target-line response, distance,
and joint state; it adds no clock, coordinate, route memory, target identity,
modeled vortex phase, or mutable state.

Falsify the composition if capture is lost or not earlier than `22.307997T`,
scored mean distance is not below `2.107401L`, or score does not exceed
`-0.212396`. Also reject it if the base's `4/8T` distances exceed
`11.300/8.629L`, if its later pursuit advantage is lost, if mean action exceeds
the broader current `59.760` envelope, if anterior/posterior rate-cap occupancy
materially exceeds about `12.0/6.6%`, if peak normalized force/moment exceed
`0.030897/0.015839`, or if a valid two-view sheet does not retain the coherent
alternating three-dimensional wake. Fixed-pose still-water improvement would
show compatibility, not robustness to changed pose, inflow, hydrodynamics, or
external wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: retain a posterior-delayed traveling bend while bounded sensor feedback schedules locomotor quadrature allocation separately from steering recruitment
transferable_invariant: one normalized body-frame route observation may coordinate distinct fixed locomotor and steering budgets through separately bounded schedules without stacking authority or suppressing the traveling carrier
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source-task prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: use fixed one-cycle de-yawed target-line prediction only for the fixed posterior recovery crossfade, and proximity-adaptive prediction only for the existing bounded reactive-rudder gate
falsification: reject if capture is not earlier than 22.307997T, mean distance is not below 2.107401L, score does not exceed -0.212396, the early route changes, or valid two-view wake, action, saturation, force, or moment envelopes worsen
