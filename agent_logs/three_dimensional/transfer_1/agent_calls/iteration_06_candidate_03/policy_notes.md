# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled episodes are finite, self-propelled `left_domain` failures
  from direct uniform still water with `U_infinity=[0,0,0]`, no cylinders, and
  no prewarm snapshot. The motion is not ambient advection or a numerical
  instability.
- Both rows of the combined sheets were inspected. Every sample forms an
  alternating top-down vortex street and compact oblique Lambda2 structures,
  so the `0.55T`, `28 deg` traveling-bend carrier remains useful. The
  phase-compensated and rate-cascade samples keep swimming almost horizontally
  above the target and reach only `3.0031L` and `3.1135L` before left exits.
- The prefilled opposing-half reallocation produces the strongest sampled
  target-directed route and reaches `1.2669L` at `18.6945T`. It then turns
  nearly vertical and leaves through the lower boundary. This is a propulsive
  reserve failure rather than a missing route request: mean normalized
  head/tail phase-plane energy falls from about `0.87/0.84` during `16--17T`
  to `0.41/0.32` during `18T` and below `0.2` after `19T`; joint excursion
  concurrently falls from about `52 deg` to `25 deg`, then below `9 deg`.
  The visual wake fades while inertial speed remains `0.777L/T` at closest
  approach, so the fish coasts past the target without enough new wake to
  realize the saturated course correction.
- The sampled terminal mean-curvature alternative preserves roughly
  `0.83--0.89` carrier energy and `50--51 deg` joint excursion through the
  approach, but worsens closest approach to `1.5454L` and returns an
  acceleration at the physical envelope on about `70.5%/72.5%` of rows. Pure
  mean curvature therefore protects propulsion but discards some of the
  useful close-pass topology; it is not evidence for replacing the half-cycle
  turn or increasing a scalar steering gain.
- The assigned-parent lesson preserves target-versus-achieved-course sensing
  but calls for a bounded response-released actuator. Its inherited
  `solver_9ddd873113a3` notes proposed an energy guard around half-cycle
  attenuation; no sampled CFD result here establishes that proposal. The
  present hypothesis retains that guard and adds a bounded phase-aligned
  carrier recovery path so merely releasing attenuation at low energy does not
  depend on the weak base oscillator rebuilding before the fast terminal pass.

## Candidate mechanism and falsification

Estimate a reflection-even locomotor reserve from the minimum normalized
phase-plane amplitude of the two observed joints. Preserve the prefilled
far-field policy exactly. Inside the existing terminal distance gate, allow
opposing-half attenuation only while reserve is healthy. As reserve falls,
smoothly release the attenuation and apply a small bounded acceleration along
each joint's observed velocity; this injects oscillatory energy without adding
a mean bend, choosing a world direction, or changing carrier phase. Both
operations share one state-dependent amplitude-homeostasis mechanism.

Expected test: retain the prefilled redirect and first close approach, arrest
the `17--19T` energy collapse, restore substantial joint excursion and an
alternating terminal wake, and give the already-correct course request enough
authority to cross the `0.75L` disk or at least change the lower-exit topology.
Returned accelerations remain hard bounded and the recovery path is identically
inactive outside the evidenced terminal regime.

Falsification: reject the mechanism if early closure changes, either joint's
normalized energy still remains below about `0.6` after relief engages, the
first approach worsens materially from `1.2669L`, acceleration/rate saturation
grows, the wake loses its alternating structure, or the same fast lower exit
survives. If energy recovers but the route still overshoots, test a separate
bounded yaw/slip-response release rather than more carrier recovery or course
gain.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological burst-redirect behavior
source_mechanism: release strong curvature into a recovered propulsive rhythm when observed gait response approaches a locomotor reserve boundary
transferable_invariant: target-directed steering must yield to normalized locomotor-state feedback before it quenches the traveling carrier, and recovery should add oscillatory energy without adding mean turn
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, prescribed duty ratios, exact vortex phases, CPG clocks, and task-specific routes
policy_translation: use normalized two-joint phase-plane amplitude to release terminal opposing-half attenuation and gate bounded velocity-aligned carrier recovery inside the existing body-frame course servo
falsification: reject if far-field closure changes, carrier energy or the alternating wake does not recover, saturation grows, closest approach worsens from 1.2669L, or the lower-exit topology remains
