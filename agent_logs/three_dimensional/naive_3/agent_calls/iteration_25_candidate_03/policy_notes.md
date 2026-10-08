# Phase-local joint-speed governor candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All sampled rollouts used direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In the strongest finite
  soft-envelope capture and the slower unsoftened barrier contrast, the
  top-down rows show a coherent alternating vorticity street from release to
  capture. Their oblique rows show compact alternating three-dimensional
  Lambda2 structures convecting behind the caudal region. Peak swimming speed
  is `1.329--1.393U`, whereas peak local flow is only `0.0315--0.0325U`, so the
  approach is self-propelled rather than ambient advection.
- The high-knee soft envelope is the strongest sampled policy: it captures at
  `16.943T`, has mean distance `2.090L`, and keeps force/yaw-moment peaks at
  `0.03609/0.01766`. It also replaces the unsoftened policy's
  `3430/5066 deg/T^2` returned peaks with sub-limit peaks near
  `1710 deg/T^2`, while preserving the useful alternating wake. Its remaining
  defect is exact `260 deg/T` contact at both joints for about `3.73/3.54%` of
  the trace.
- Two inherited speed-feedback continuations establish a useful boundary.
  Both preserve capture and the visible alternating wake. A direct
  positive-power guard starting at `0.90` of the speed envelope reduces peaks
  to `257.1/257.7 deg/T` and captures at `17.330T`; a continuous velocity
  barrier reduces them further to `251.9/253.2 deg/T` but captures at
  `17.435T`. Thus speed-state feedback can remove hard-stop contact, but broad
  intervention gives up some of the soft-envelope policy's faster route.

## Policy hypothesis

Preserve the evaluated full-quadrant body-frame target/course feedback,
zero-centered anterior oscillator, posterior lag and steering reserve,
high-knee acceleration envelope, and posterior kinetic angle-margin
projection. Add one phase-local speed governor to both assembled commands.
Normalize each measured joint speed by the owned physical speed limit, open a
smooth guard only above `0.94` of that limit, and reduce only acceleration with
positive joint power (`phi_dot * phi_ddot > 0`). Natural or commanded braking
passes unchanged. This transfers a closed-loop rhythmic-envelope mechanism;
it is not a scalar retune of the carrier.

The narrower gate should avoid exact speed-limit occupancy while retaining
more of the `16.943T` route than the completed `0.90` guard. Falsify the
candidate if capture or alternating shedding is lost, either joint still
touches `260 deg/T`, arrival reaches or exceeds `17.330T`, mean distance
regresses materially from `2.090L`, posterior angle clearance worsens, or
force/moment exceed the `0.0361/0.0177` soft-envelope reference.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and classical reactive swimming
source_mechanism: sensor feedback modulates a bounded rhythmic actuation envelope while retaining the phase-coherent traveling bend
transferable_invariant: near an actuator speed boundary, suppress only cycle-resolved positive joint power and preserve opposing acceleration so the useful rhythm can brake and reverse naturally
nontransferable_details: published CPG gains, dimensional cadence and amplitude, species-specific body waves, source actuator ratings, exact vortex phases, and task-specific routes
policy_translation: use normalized phi_dot and the sign of phi_dot times the assembled phi_ddot as body-state phase; apply a smooth high-speed outward-work ceiling to both commands after the evidenced acceleration shoulder, while leaving target-course steering structure and posterior angle braking intact
falsification: reject if exact speed contact remains, capture or alternating three-dimensional shedding is lost, the route regresses to or beyond the 17.330T guard, angle clearance worsens, or load peaks exceed the soft-envelope reference
```
