# Rapid-redirect C-bend candidate

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  `left_domain` termination. I inspected the combined sheets for the best
  finite posterior-phase case (`solver_0620d96874f3`, `2.326L` minimum), the
  weaker differential-S-bend failure (`solver_5140ef46529a`, `2.469L`), and
  the assigned solver parent (`solver_e0a3b33f1347`, `2.433L`). In both the
  top-down vorticity and oblique body/Lambda2 rows, each fish self-propels from
  rest, builds a long coherent alternating three-dimensional wake, passes
  laterally outside the target, and continues shedding a powered wake while
  rotating toward the lower boundary. Failure is controlled course loss, not
  advection, collision, weak propulsion, wake breakup, or instability.
- The fixed-proximity posterior phase-lag controller is the strongest sampled
  scaffold at `2.326/8.424L` minimum/scored-mean distance, ahead of the
  yaw-selected posterior brake (`2.385/8.436L`), anterior duty asymmetry
  (`2.433/8.434L`), and differential equilibrium S-bend (`2.469L`). At its
  `17.908T` minimum it still travels at `0.687U` with `1.088 rad`
  target-ray/course error; local flow is small and its coherent wake remains
  powered. Its acceleration clamps are already occupied for about
  `0.749/0.355` of anterior/posterior samples, so drive or command-limit
  increases are unsupported.
- The assigned optimizer parent's inherited forming-miss phase selector
  regressed to `2.684L`; its next yaw-moment-triggered posterior brake reached
  only `2.635L`. Other inherited completed logs show a posterior harmful-half-
  cycle notch at `2.619L`, posterior amplitude attenuation at `2.738L`, and a
  one-sided phase reset at `2.457L`; all retain the powered lower exit near
  `9.19--9.20L` final distance. These concrete negatives close another scalar
  phase envelope, moment brake, half-cycle authority cut, and one-sided timing
  edit. A new actuator-shape mechanism is warranted.

## Policy hypothesis

Start from the sampled `2.326L` phase-lag scaffold and preserve its bounded
cruise curvature, response-selected posterior brake, posterior phase action,
and command reserve. Add one nonsteady rapid-redirect mechanism. When
normalized lateral target geometry is large and translational course error
shows that a close lateral pass is forming, move both joint equilibria toward
the same signed C-bend, attenuate the traveling-wave component, and add
anterior damping. The request vanishes continuously as course alignment
returns, so the measured response releases the fish back into the propulsive
wave without time, memory, or a hidden stage counter. This differs from the
failed small persistent S-bends: it temporarily changes the body-wave shape
rather than reallocating a static equilibrium around an unchanged carrier.

Replay of the selector on the completed best trace (without integrating new
dynamics) is negligible at the first `3.6L` crossing, rises to about `0.30` at
the first `3.0L` crossing, and is about `0.54` at the sampled minimum. Thus it
targets the established terminal miss rather than release or cruise. These are
activation diagnostics only, not evidence of a new hydrodynamic trajectory.

The final `16 deg` rapid-curvature ceiling and low added damping return about
`27.28 rad/T^2` anterior acceleration when replayed at that exact sampled
minimum state, below the declared `28 rad/T^2` reserve; the uncalibrated
`18 deg` version would have clamped. This bounds the counterfactual activation
but does not predict new clamp residence after the trajectory changes.

Support requires the coherent inbound wake plus capture, a target-return leg,
a useful termination-class change, or a material improvement below `2.326L`
without worse scored mean distance or clamp/load residence. Reject the
mechanism if it changes far-field release, curls tightly, creates a one-sided
or collapsed wake, raises saturation/load residence, or again powers through
the lower boundary with only a small scalar shift.

```text
bookshelf_consulted: true
source_domain: biological rapid-start turning and sensor-modulated robotic-fish gait control
source_mechanism: a large directional error selects a bounded C-bend redirect, then measured directional response releases the swimmer into its propulsive rhythm
transferable_invariant: temporarily trade traveling-wave authority for a same-sign body bend when persistent relative geometry shows that cruise steering cannot avert a miss, and restore propulsion continuously as alignment returns
nontransferable_details: species-specific C-start kinematics, published gains, dimensional beat frequencies, full-body waveforms, fixed event timing, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target and velocity directions gate a bounded same-sign two-joint equilibrium shift and carrier attenuation; course-error reduction provides memoryless release under the two-joint acceleration contract
falsification: reject if cruise changes, wake coherence collapses, limit or load residence rises, a tight curl appears, or the result cannot beat 2.326L or change the powered lower-exit class
```
