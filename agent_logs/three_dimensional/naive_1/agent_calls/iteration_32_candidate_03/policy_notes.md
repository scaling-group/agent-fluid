# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solvers are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three executable-identical
  candidates reproduce the exact `22.307997T` capture, `0.748057L` crossing,
  `2.107401L` scored mean distance, and `-0.212396` score. Their byte-identical
  trajectories establish deterministic repeatability for this fixed case.
- Both visual rows of the repeated best result and the informative weaker
  prefill were inspected from release through capture. Their top-down rows
  show self-propelled S-shaped approaches with an attached alternating
  red/blue caudal street that remains coherent through capture; still water
  rules out imposed advection. Every current oblique row is black apart from
  labels, so these sheets provide no new three-dimensional Lambda2 evidence.
  This is a render-evidence failure, not evidence of wake collapse or a reason
  to infer 3D structure from the score.
- The repeated best result applies the existing one-cycle de-yawed target-line
  prediction to both the posterior recovery selector and rudder gate. Relative
  to the inherited current-error-allocation plus fixed-lead baseline, it
  advances capture from `22.500492T` to `22.307997T` and lowers mean distance
  from `2.120233L` to `2.107401L`. Its route is already closer at `9T`
  (`7.929L`) and remains closer at `12/16/20T`
  (`6.147/3.993/1.884L`). Mean action is about `59.675`, anterior/posterior
  exact-rate-cap occupancy is about `11.54/6.36%`, and peak normalized
  force/moment are `0.030897/0.015839`; the latter are slightly above the
  inherited allocation envelope, so the gain is not load-free.
- The assigned prefill keeps current target error in the recovery selector but
  extends the rudder prediction smoothly from one to one-and-a-half cycles as
  the existing `8.0--5.5L` proximity gate fills. It captures at `22.423492T`
  with mean distance `2.117908L` and score `-0.222711`, improving the same
  inherited fixed-lead baseline without changing rudder magnitude. It is
  weaker than predicted allocation along the route, but reaches capture with
  smaller full head-relative error and greater target-directed closing speed
  (`0.761 rad`, `0.301L/T`) than the repeated best sample
  (`1.073 rad`, `0.118L/T`). Mean action is about `59.760`, rate-cap occupancy
  is about `11.65/6.40%`, and peak force/moment remain
  `0.030527/0.015817`.

## One candidate hypothesis

Preserve the prefill's through-water course feedback, anterior speed recovery,
full body-frame target geometry, anterior redirect, phase-selective carrier,
proximity-adaptive line-of-sight-led rudder, and qualified terminal relief.
Change only the selector of the fixed `0.12` posterior recovery budget: compute
a separately named one-cycle predicted recovery error from the already bounded
`bearing_window_rate - turn_rate_recent`, and use its smooth magnitude to
crossfade between the completed whole-carrier and anterior-velocity-quadrature
targets. Keep the longer proximity-adaptive predicted error confined to the
rudder gate and keep current error on anterior steering and stroke shaping.

This is the smallest composition of two independently positive observation
allocations. The fixed one-cycle predictor should retain the repeated sample's
earlier move toward the later-route velocity quadrature, while the distinct
proximity extension should retain the prefill's stronger terminal alignment
and closing response. Neither recovery share, rudder authority, oscillator
gain, acceleration limit, gait frequency, angle/rate limit, nor distance
threshold changes. The policy adds no clock, fixed coordinate, case identity,
route memory, modeled vortex phase, or mutable state.

Falsify the composition if capture is lost or later than `22.307997T`, scored
mean distance is not below `2.107401L`, or score does not exceed `-0.212396`.
Also reject it if the `9/12/16/20T` route advantage disappears, full error at
capture exceeds `1.073 rad`, target-directed closing speed falls below
`0.118L/T`, mean action exceeds `59.760`, anterior/posterior exact-rate-cap
occupancy exceeds about `11.65/6.40%`, or peak normalized force/moment exceed
`0.030897/0.015839`. A valid top-down sheet must retain the rhythmic street,
and any valid oblique sheet must retain the established discrete 3D wake; a
black oblique render cannot confirm or falsify the hydrodynamic mechanism.
Fixed-pose still-water improvement would establish compatibility, not
robustness to changed pose, inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming, sensor-modulated robotic-fish CPG direction tracking, and distance-scheduled terminal capture
source_mechanism: preserve a posterior-delayed traveling bend while measured route demand allocates a fixed posterior gait budget and approach geometry separately schedules bounded steering prediction
transferable_invariant: body-frame feedback may coordinate locomotor phase allocation with approach steering while preserving the traveling carrier and keeping each actuator-path authority bounded
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source-task prediction horizons, prescribed routes, fixed coordinates, and exact vortex phases
policy_translation: use a fixed one-cycle de-yawed target-line prediction only for the fixed posterior recovery crossfade, while the existing normalized proximity gate extends only the independently bounded rudder prediction
falsification: reject if the candidate misses the 22.307997T and 2.107401L boundaries or worsens route, terminal alignment, valid wake, action, saturation, force, or moment envelopes
