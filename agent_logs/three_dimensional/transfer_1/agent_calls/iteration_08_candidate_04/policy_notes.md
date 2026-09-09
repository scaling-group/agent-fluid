# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled solver episodes and both inherited parent episodes are
  finite, self-propelled `left_domain` failures from direct-uniform still
  water with `U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot.
  Their motion is neither ambient advection nor numerical instability.
- Both rows of the combined sheets were inspected. The sampled
  phase-compensated bearing and course-rate policies keep a coherent
  alternating top-down vortex street and compact oblique Lambda2 structures,
  but travel above the target and reach only `3.0031L` and `3.1135L`. The
  terminal curvature and reserve-guarded policies turn down toward the target
  and reach `1.5454L` and `1.7708L`, yet retain a fast target-normal pass and
  exit through the lower boundary.
- In the assigned parent, bounded phase-aligned carrier recovery improves the
  close pass to `1.1444L` while preserving a strong terminal wake, but does
  not change the lower-exit topology. The next inherited candidate adds a
  slip-driven posterior mean tangent to the `0.9532L` carrier-aligned
  baseline; it regresses to `1.0561L` with the same lower exit. At its closest
  point the speed and target-normal velocity are both about `0.786L/T`, while
  the two returned actions occupy the acceleration envelope on about
  `71.0%/70.8%` of rows. More carrier recovery, additive curvature, or scalar
  route gain is therefore not supported.
- A separately sampled response-release controller reaches `0.9312L`, but at
  closest approach still carries `0.839L/T` almost entirely normal to the
  target line and remains in the same lower-exit class. This corroborates the
  assigned-parent diagnosis: the remaining miss is excess terminal
  cross-track inertia during an otherwise coherent, strongly actuated gait.

## Candidate mechanism and falsification

Restore the assigned parent's carrier-aligned achieved-course controller
without the failed additive posterior tangent. Add one approach-hold
mechanism: inside `3L`, smoothly reduce carrier cadence only while the measured
windowed closing speed is substantially positive, with a hard frequency
floor. The relief grows during the fast inbound segment, then releases as
closing speed approaches zero so the full alternating carrier and
carrier-aligned steering return for the cross-track correction. This does not
attenuate a selected half-cycle, add mean curvature, increase steering gain,
or prescribe a route.

Replay of the new observation-to-cadence gate on the inherited slip-response
trace is zero at `3L`, about `8%` at `2L`, peaks near `17%` around `1.2L`, and
falls to about `4%` by `1.06L` as closure vanishes. This is a bounded mechanism
check, not a claim about the unevaluated candidate's CFD behavior.

Expected test: retain the carrier-aligned route outside `3L`, reduce inbound
target-normal speed before the closest pass, recover the full carrier as
closure ends, and cross the `0.75L` capture disk or at least improve on the
`0.9532L` baseline and change the lower-exit topology without increasing
saturation.

Falsification: reject if far-field closure changes, closest approach does not
beat `0.9532L`, joint excursion or the alternating wake collapses, acceleration
saturation grows, or the same fast lower exit remains. In that case avoid
further cadence or additive-curvature edits and test a target-relative
line-of-sight-response allocation of the existing shared steering term.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish gait control
source_mechanism: approach hold that relieves propulsion during fast closure and restores the rhythmic carrier for terminal steering
transferable_invariant: near a target, measured closing behavior may reduce excess drive continuously, but locomotor rhythm must return before loss of closure removes steering authority
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, prescribed CPG phase, exact vortex phases, capture route, and duty ratios
policy_translation: gate a bounded carrier-frequency relief with normalized body-frame distance and windowed closing speed while preserving achieved-course steering, carrier phase, and a frequency floor
falsification: reject if early closure changes, the coherent carrier weakens, the sub-0.9532L pass or saturation does not improve, or the lower-exit topology survives
