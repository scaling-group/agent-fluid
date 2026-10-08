# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. The assigned parent and
  two semantic replicas reproduce exactly `22.307997T` capture,
  `2.107401L` scored mean distance, `0.748057L` crossing, and score
  `-0.212396`. The informative weaker sample captures at `22.423492T`, with
  `2.117908L` mean distance, `0.748246L` crossing, and score `-0.222711`.
- Both rows of the best and weaker combined keyframe sheets were inspected
  from release to capture. Their top-down rows show self-propulsion rather
  than advection: an alternating red/blue street grows from the caudal region,
  remains coherent along the S-shaped approach, and is still attached at
  capture. Every current oblique row is black after its frame labels, so the
  sample supplies no new three-dimensional Lambda2 evidence. The inherited
  complete two-view parent sheet remains the applicable 3D-wake bound; a
  future positive result requires a valid oblique render rather than treating
  the current blank rows as physical wake evidence.
- The assigned parent's predicted recovery allocation is a reproduced semantic
  improvement over the inherited common controller: applying the bounded
  one-cycle de-yawed target-line lead to only the fixed posterior recovery
  crossfade advances capture from `22.500492T` to `22.307997T`, lowers mean
  distance from `2.120233L` to `2.107401L`, and improves score from
  `-0.225086` to `-0.212396`. The current top-down trace retains the inherited
  route and is at `11.297/8.629/6.147/3.991/1.881/0.876L` at
  `4/8/12/16/20/22T`.
- The weaker sample isolates a second positive mechanism against that same
  inherited common controller: it keeps instantaneous target error for the
  recovery crossfade but extends the rudder's target-line prediction smoothly
  by up to one half-cycle as the existing `8.0--5.5L` proximity gate fills.
  It captures at `22.423492T`, earlier than the `22.500492T` common result and
  with lower mean distance (`2.117908L` versus `2.120233L`). It does not beat
  the assigned parent because it gives up predicted recovery allocation. This
  is evidence for testing isolated composition, not for increasing rudder
  magnitude, recovery share, or carrier energy.
- The parent preserves finite actuator and load use: mean action is about
  `59.675`, anterior/posterior exact rate-cap occupancy is about
  `12.08/6.66%`, and peak normalized force/moment are
  `0.030897/0.015839`. The proximity sample has mean action about `59.760`,
  occupancy `12.12/6.65%`, and peak force/moment
  `0.030527/0.015817`. The composition must remain within the union of these
  completed envelopes rather than claim that earlier capture alone is enough.

## One candidate hypothesis

Preserve the assigned parent's through-water course feedback, anterior speed
recovery, full body-frame target geometry, anterior redirect, phase-selective
carrier, terminal stroke-qualified relief, and fixed one-cycle predicted
posterior recovery allocation. Add the sampled proximity scheduling only to
the independently bounded reactive-rudder predictor: compute the existing
distance gate before prediction, keep a `recovery_led_target_error` with the
validated one-cycle horizon, and compute a separate `rudder_led_target_error`
whose horizon gains at most another half-cycle as proximity fills. The
recovery crossfade must continue to read only the first signal, while the
rudder error gate reads only the second.

The hypothesis is that the assigned parent can retain its whole-carrier to
velocity-quadrature allocation advantage while the separately positive
proximity predictor supplies earlier target-line compensation during the
middle and terminal approach. This is one bounded observation-to-allocation
composition. It does not change oscillator energy, recovery share, posterior
rudder sign or angle limit, steering thresholds, carrier phase, terminal
relief, or any actuator limit; it adds no clock, route memory, fixed coordinate,
case identity, external phase, or mutable state.

Falsify the composition if capture is lost or later than `22.307997T`, scored
mean distance is not below `2.107401L`, or score does not exceed `-0.212396`.
Also reject it if the route changes before proximity recruitment, the inherited
`16/20/22T` distances are not improved, mean action exceeds about `59.760`,
anterior/posterior exact rate-cap occupancy exceeds about `12.12/6.66%`, peak
normalized force/moment exceed `0.030897/0.015839`, or a valid top-down and
oblique sheet does not preserve the coherent alternating three-dimensional
wake. A positive fixed-pose still-water result would establish compatibility,
not robustness to changed pose, inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: retain a posterior-delayed traveling carrier while separate bounded body-frame predictions coordinate gait allocation and steering recruitment
transferable_invariant: slow measured route demand may schedule a fixed locomotor budget and an independently capped steering path on different continuous horizons without stacking gait authority or replacing the carrier
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: keep the validated one-cycle target-line lead only on the fixed posterior recovery crossfade while the sampled normalized proximity gate extends only the independently bounded rudder lead by at most one half-cycle
falsification: reject if capture is later than 22.307997T or lost, mean distance is not below 2.107401L, the pre-proximity route changes, or valid two-view wake, action, saturation, force, or moment envelopes worsen
