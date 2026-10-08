# Phase-local joint-speed governor candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. All capture. In the
  strongest soft-envelope sample `solver_bb2a1c7cb2a0` and the informative
  speed-governed contrasts `solver_d08865019afc` and
  `solver_94d1c68ad200`, the top-down rows show the same target-directed arc
  and sustained alternating red/blue vorticity street from release through
  capture. The oblique rows show compact alternating three-dimensional
  Lambda2 structures convecting behind the caudal region. Peak body speed is
  `1.393--1.404U` while peak sampled local flow is only
  `0.0307--0.0325U`, so the route is self-propelled rather than moving-window
  or ambient-flow advection.
- The prefilled soft-envelope controller is the route baseline: it captures at
  `16.943T`, scores `-0.205386`, has mean distance `2.090L`, keeps
  acceleration peaks near `1710 deg/T^2`, and limits planar-force/yaw-moment
  peaks to `0.03609/0.01766`. Its unresolved mechanical defect is exact
  `260 deg/T` contact on both joints. The inherited optimizer notes locate
  those contacts throughout the broad route, not only near the target, so a
  terminal distance gate is the wrong protection.
- The sampled phase-local governor `solver_d08865019afc` suppresses only
  acceleration having the same sign as measured joint velocity above a
  normalized high-speed onset. It preserves the alternating wake and capture
  at `17.115T`, holds joint speeds to `258.92/259.19 deg/T`, and keeps
  force/moment peaks at `0.03564/0.01782`. This is a small route cost for a
  mechanical semantic improvement. The broader inherited `0.90` guard
  captures more slowly and scores `-0.217369`; the sampled cross-joint
  reallocation variant reaches only `17.275T` despite retained capture; and
  the identity-windowed class-K continuation scores `-0.221004`. Those
  completed results do not support relocating suppressed work or imposing a
  broader coupled envelope.

## Single-candidate policy hypothesis

Preserve the complete evaluated soft-envelope capture controller: wrapped
body-frame target/course error, zero-centered anterior state oscillator,
posterior traveling lag, target-steering acceleration reserve, continuous
acceleration shoulder, and posterior kinetic angle-margin projection. Add
only the sampled phase-local joint-speed governor to both assembled commands.
It reads normalized joint speed, opens smoothly near the speed boundary, and
caps only positive joint work; all lower-speed carrier work and every
opposing/braking acceleration pass unchanged. This is a joint-state feedback
mechanism that protects the physical speed envelope without changing carrier
gains, target geometry, route stages, or external phase.

Expected result: reproduce capture and coherent alternating three-dimensional
shedding while eliminating exact speed-limit occupancy and retaining the
stronger `17.115T` sampled tradeoff. Falsify the candidate if either joint
touches `260 deg/T`, capture or wake alternation is lost, arrival materially
exceeds `17.115T`, posterior angle clearance worsens, or force/moment exceeds
the soft-envelope reference `0.0361/0.0177`.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and classical reactive swimming
source_mechanism: sensor feedback modulates a bounded rhythmic actuation envelope while retaining a phase-coherent traveling bend
transferable_invariant: near a physical joint-speed boundary, suppress only cycle-resolved positive joint work and preserve opposing acceleration so the productive rhythm can brake and reverse naturally
nontransferable_details: published gains, dimensional cadence, species-specific body waves, source actuator ratings, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: use normalized phi_dot and the sign of phi_dot times assembled phi_ddot as joint-state phase; smoothly cap only speed-increasing work after the evidenced acceleration shoulder, leaving body-frame target/course steering and posterior angle braking intact
falsification: reject if speed contact remains, capture or alternating three-dimensional shedding is lost, route cost exceeds the sampled phase-local result, angle clearance worsens, or load peaks exceed the soft-envelope reference
```
