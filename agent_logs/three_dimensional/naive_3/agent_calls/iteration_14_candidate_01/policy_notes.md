# Velocity-course terminal-curvature candidate

## Visual diagnosis and inherited evidence

- All sampled diagnostics and the inherited optimizer rollouts use direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. The sampled response-released parent is self-propelled: its
  top-down row shows an alternating vorticity street, its oblique row shows
  persistent three-dimensional Lambda2 structures, speed reaches `1.032U`,
  and local-flow speed stays below `0.033U`.
- The assigned solver parent reaches `2.989L` at `17.661T` with speed about
  `0.77U`, then passes high and hooks into the upper boundary. The visible wake
  weakens as its joints approach the response-released equilibrium. This is
  loss of course authority after a propulsive approach, not ambient advection.
- The best scalar sampled rollout is also the clearest phase-aware failure.
  Anterior half-cycle stiffness preserves an alternating wake, but closest
  approach worsens to `4.859L`, peak speed falls to `0.947U`, and raw
  acceleration-envelope exceedance rises from the parent's roughly `34/45%`
  to `53/64%` for joints 1/2. Its higher score does not represent a more useful
  target trajectory.
- The assigned optimizer's later posterior phase-lag, posterior counterstroke,
  receding-coil, moment-gated posterior allocation, and receding anterior-brake
  tests reach `3.532L`, `2.978L`, `2.959L`, `2.979L`, and `2.960L`; every one
  retains the upper-boundary exit. The last brake also worsens final distance
  to `6.853L`. More beat-side selection on the bearing/slip carrier is not
  supported.
- Sampled optimizer evidence supplies a distinct observation mechanism.
  Speed-gated full-quadrant target-ray versus body-frame velocity-course error
  was independently reproduced at about `0.857L` and changed the upper hook to
  a later left-boundary exit. A terminal-only curvature schedule then reached
  `0.832L` at `19.074T`; both visual rows retain coherent, controller-generated
  shedding through approach, and peak speed/local-flow speed are
  `1.052U/0.030U`. At closest approach the fish is still moving about `0.847U`
  with a saturated course correction. The tested `18 deg` terminal ceiling
  therefore moved the near miss in the right direction but did not cross the
  `0.75L` capture radius; raw acceleration exceedance was already about
  `58/68%`, so the increment must remain localized and modest.

## Policy hypothesis

Replace the assigned parent's folded-bearing-minus-slip steering and
instantaneous-yaw redirect with the evidenced body-frame course-error
observation. Below reliable translation speed, blend continuously to the
full-quadrant target ray; above it, steer from the wrapped difference between
that ray and measured velocity course. Preserve the zero-centered anterior Van
der Pol oscillator and the complete posterior lagged carrier.

Retain the sampled terminal-only curvature allocation, but raise its maximum
posterior mean-curvature ceiling from `18 deg` to `21 deg` inside `1L`; the
far-field ceiling remains `12 deg`, and the schedule remains exactly inactive
outside `3L`. The expected result is the demonstrated sub-`1L` course-controlled
approach plus enough final yaw impulse to cross `0.75L`. Reject the candidate
if it changes the pre-`3L` trajectory, loses the alternating wake, fails to
retain a sub-`1L` closest point, materially raises angle/rate/acceleration limit
occupancy, or does not capture.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical posterior traveling-wave propulsion
source_mechanism: preserve a state-feedback propulsive rhythm while a bounded target-relative course error modulates mean curvature, with extra authority confined to terminal capture
transferable_invariant: compare observed travel direction with target direction and correct their wrapped body-frame mismatch without suppressing the traveling carrier
nontransferable_details: published gains, dimensional cadence, linkage and species kinematics, clock phase, exact vortex phase, world-frame target coordinates, and prescribed routes
policy_translation: derive a full-quadrant ray from normalized target_body_L, derive velocity course from bounded velocity_body_U, blend by observed speed, and drive only the posterior mean-curvature channel while joint state supplies carrier phase
falsification: reject if the sub-1L approach is not retained, the pre-3L path changes, capture remains absent, the wake loses coherence, or actuator-limit occupancy rises materially
```
