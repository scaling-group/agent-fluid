# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, all four sampled evaluations, and inherited optimizer
  logs use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and finite
  dynamics. The observed translation and wakes are therefore self-propelled,
  not advection or an initialization artifact.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows in all
  four combined sheets. The best sampled parent (`2.443L` minimum at
  `17.869T`) and the informative distance-relief failure (`2.845L`) both keep
  coherent alternating vortex chains and long three-dimensional trails. They
  approach from the upper right, cross the target's height with substantial
  downward velocity, pass below the target, and remain powered until the lower
  boundary exit. This is a course-control failure rather than wake collapse,
  instability, or insufficient propulsion.
- The completed variants delimit the mechanism. Distance-only energy relief
  reached `2.845L`, full-direction posterior gating `2.494L`, slip-magnitude
  phase-lag relief `2.822L`, closing-gated stronger C-bending about `2.47L`,
  and direction-gated posterior half-cycle asymmetry `3.661L`; none changed
  the powered lower-exit topology. The inherited speed-qualified velocity-angle
  correction was worse still: it reversed the useful release route, reached
  only `12.150L`, and exited the upper boundary at `9.295T`. Thus neither
  another carrier gain nor unrestricted slip correction is supported.
- Recomputing normalized body-frame geometry from the parent's logged
  trajectory reveals an earlier, sign-specific omission. At the inbound `8L`
  and `6L` crossings, target direction is only `+0.113/+0.119 rad`, but course
  angle is `-0.616/-0.618 rad` with body-frame lateral velocity about
  `-0.528/-0.532 U`. The body points near the target while translating to the
  opposite lateral side. By `4L` the lateral velocity has changed to the target
  side, so a useful correction should release rather than become a persistent
  sideslip loop. The parent also leaves more posterior than anterior command
  reserve (about `35.4%` versus `74.6%` clamp residence in the inherited
  diagnostics).

## Policy hypothesis

Preserve the best sampled `7 deg` bearing/yaw-rate mean-curvature carrier,
alignment gate, oscillator, posterior lag, and command reserve. Add one
sign-safe actuator mechanism only: derive target side from normalized
body-frame target geometry, detect only lateral velocity that opposes that
side, and use the bounded residual as a posterior equilibrium bias. It cannot
subtract or reverse the parent's anterior steering, is zero at rest and for
same-side lateral motion, flips exactly under reflection, and releases once
the course becomes corrective. This translates course feedback into the less
saturated posterior joint without changing carrier amplitude, frequency,
phase lag, or acceleration limits.

Expected evidence is the parent's coherent far-field wake with a shallower
downward course by `8--16T`, closest approach below `2.443L`, and ideally
capture or a meaningfully different finite trajectory/termination. Falsify the
mechanism if the initial route turns upward, wake coherence or early closing is
lost, posterior clamp/rate residence grows materially, the fish curls tightly,
or the same powered lower exit remains without a better useful trajectory.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior-kinematics emphasis and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve the anterior propulsive rhythm while measured course error applies a bounded target-signed posterior steering bias
transferable_invariant: when normalized body-frame lateral velocity persistently opposes the target side, feedback may bias posterior mean curvature without changing the joint-state carrier phase
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot geometry, exact vortex phases, amplitude ratios, and task-specific routes
policy_translation: use normalized target lateral fraction and body-frame lateral velocity to add a reflection-equivariant, wrong-side-only posterior equilibrium residual around the existing two-joint carrier
falsification: reject if the useful release route or coherent wake is lost, the upper exit recurs, closest approach does not beat 2.443L, the powered lower exit persists unchanged, or posterior saturation and loads worsen
```
