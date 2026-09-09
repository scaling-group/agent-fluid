# Candidate diagnosis and hypothesis

## Prior evidence

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, remain finite, form a sustained alternating
  top-down wake with compact three-dimensional Lambda2 structures, and travel
  under their own actuation. The combined sheets therefore diagnose a
  navigation failure rather than advection or loss of propulsion.
- The strongest sampled response-gated posterior brake reaches `2.385L`
  (mean `8.436L`), versus `2.443L` (mean `8.443L`) for the alignment-gated
  carrier. The joint-phase counterbend reaches only `2.512L`, while the
  assigned parent's response-released equilibrium S-bend reaches `2.536L`.
  Every sample then continues on the visible near-vertical downward leg and
  leaves the lower boundary near `31T`; none changes the termination class.
- At closest approach the brake still has about `1.38 rad` full target
  direction error, near-zero closure, roughly `0.705U` translational speed,
  and large wrong-way instantaneous yaw. Inherited completed results at
  `2.484L`, `2.429L`, `2.385L`, and then `2.444L` retain the same lower-exit
  topology. This supports the measured response gate as a useful half-cycle
  selector but rejects braking, persistent equilibrium redirects, and
  scalar-only threshold edits as completed recovery mechanisms.

## Policy hypothesis

Start from the sampled response-gated brake and preserve its anterior
oscillator, mean-curvature steering, alignment envelope, approach/direction
gates, and all far-field behavior. On the selected wrong-way posterior
half-cycle, reallocate the measured amount removed from the traveling wave
into an opposite-side posterior target instead of discarding it. The resulting
bounded asymmetry should create corrective yaw while retaining the evidenced
cruise wake and using no time, world route, or hidden phase. The hypothesis is
falsified by loss of wake coherence or far-field progress, greater actuator
residence, a minimum no better than `2.385L`, or the same powered lower exit
without a meaningfully different terminal trajectory.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop CPG turning
source_mechanism: sensor-selected half-cycle amplitude asymmetry
transferable_invariant: redirect bounded oscillatory authority on only the beat half-cycle whose measured body response grows target error
nontransferable_details: published gains, clocked CPG phase, robot-specific kinematics, dimensional frequency, and prescribed routes
policy_translation: use normalized body-frame target direction, distance, measured yaw response, and joint-state traveling-wave amplitude to move removed posterior authority to the corrective side
falsification: reject if the coherent cruise wake or far-field progress degrades, actuator saturation rises, or closest approach and lower-exit topology do not improve over the response-gated brake
