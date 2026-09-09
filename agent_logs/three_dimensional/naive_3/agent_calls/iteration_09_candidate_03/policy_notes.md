# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations used direct uniform still water
  (`U_infinity=(0,0,0)`), no cylinders, and no prewarm snapshot. They remained
  finite until `left_domain`, so the visible translation and wakes are
  self-propelled rather than advection or an initialization artifact.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows in all
  four combined keyframe sheets. Every policy sustains a coherent alternating
  mid-plane street and compact three-dimensional structures while approaching
  from the upper right. None fails through wake collapse. Every trajectory
  passes below the target with substantial speed, rotates into a powered
  downward track, and leaves through the lower boundary.
- The plain alignment-gated carrier reaches `2.443L` and has anterior/posterior
  acceleration-clamp residence of about `0.746/0.354`. Full-direction thrust
  gating is nearly neutral (`2.494L`) and raises peak planar force/moment from
  about `0.0287/0.0148` to `0.0453/0.0223`. Slip-gated posterior phase rotation
  is negative (`2.822L`). Those completed results do not support another
  course-angle replacement, phase rotation, or scalar drive schedule.
- The sampled posterior counter-bend is the one useful new mechanism. It keeps
  the coherent wake and similar mean distance (`8.446L` versus `8.443L`),
  improves closest approach from `2.443L` to `2.187L`, and changes yaw rate at
  minimum distance from the carrier's wrong-side `+2.04 rad/T` to a corrective
  `-0.33 rad/T`. Peak force/moment remains close (`0.0304/0.0153`), although
  posterior clamp residence rises to `0.381`. This is not success: the policy
  still exits below at `32.126T` and finishes `9.281L` from the target.
- At the counter-bend minimum, full normalized body-frame target direction is
  about `1.49 rad`, center-velocity projection onto the target ray is about
  `0.001 U`, and lateral velocity still weakly opposes the target side. The
  slip-only counter-bend weight has nevertheless fallen to `0.041`, so the
  useful actuator shape nearly releases while severe misalignment and lost
  closure agree that the pass is unresolved.

## Policy hypothesis

Preserve the completed counter-bend carrier, including its target-side slip
gate, anterior oscillator, bearing/yaw mean curvature, posterior lag and
alignment authority. Add one compatible terminal-retention mechanism to the
same bounded posterior counter-bend: full body-frame direction error and a
deficit in velocity projected onto the normalized target ray form a second
continuous gate. Combine the slip and terminal weights by bounded union, so
the residual never exceeds the already tested `7 deg` posterior equilibrium
cap. Either corrective closure or restored alignment releases the terminal
term; there is no clock, distance threshold, route, or world coordinate.

Replay on completed traces is only a contract check, not new CFD evidence. On
the counter-bend trajectory the terminal weight averages `0.000` from `6--8L`
and `4--6L`, `0.142` from `2.2--3L`, and `0.496` inside `2.2L`; it is `0.836`
at the `2.187L` minimum. Thus the new term leaves the evidenced cruise intact
and retains the useful S-shaped posterior action specifically during the late
stalled pass.

Falsification: reject terminal retention if it damages early distance progress
or the long alternating wake, drives a tight curl, materially raises posterior
clamp residence or force/moment peaks, fails to beat `2.187L`, or preserves the
same powered lower-boundary exit without a meaningfully different useful
trajectory. A scalar-score change alone is insufficient.

```text
bookshelf_consulted: true
source_domain: elongated-body posterior-kinematics theory, sensor-modulated robotic-fish direction tracking, and terminal capture control
source_mechanism: preserve a propulsive traveling wave while normalized geometry and inadequate target-directed motion retain a bounded posterior steering shape until the approach recovers
transferable_invariant: release a useful posterior redirect on restored target alignment or measured target-directed closure, not merely on small instantaneous lateral slip
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, open-loop burst durations, and task-specific routes
policy_translation: full direction from target_body_L and center velocity projected on its normalized ray form a reflection-equivariant terminal gate that shares the existing bounded two-joint posterior counter-bend
falsification: early-progress loss, wake shortening or curling, higher posterior limit/load residence, no improvement beyond 2.187L, or the same powered lower exit
```

## Implemented candidate and pre-CFD checks

The implementation adds only the terminal-retention weight and combines it
with the sampled slip weight under the same posterior counter-bend cap. The
required guidance-semantic, lightweight policy-contract, and repository
boundary checks pass. All `324` non-CFD repository assertions also pass.
Synthetic reflection of target side, lateral velocity, yaw, and joint state
produces exactly sign-mirrored finite commands; strong target-directed closure
releases the added posterior action; and extreme finite observations remain
inside the configured command bounds. Formal CFD remains deferred to the EvE
evaluator.
