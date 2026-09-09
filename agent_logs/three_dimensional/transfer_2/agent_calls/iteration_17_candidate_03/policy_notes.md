# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled episodes satisfy the direct uniform still-water contract
  (`U_infinity=[0,0,0]`, no prewarm) and capture from the common pose. The
  response-gated posterior-curvature sample is the strongest scalar result at
  `19.360T`, distance integral `2.08911L`, and score `-0.19989`; the other
  posterior lag/amplitude variants span `19.409--19.552T`,
  `2.09001--2.09701L`, and `-0.20065-- -0.20789`.
- The best and worst-score combined sheets both show self-propelled motion, a
  coherent alternating wake from release through approach, productive lateral
  body motion rather than passive advection, and the same smooth late hook into
  capture. Their oblique Lambda2 rows retain discrete alternating structures
  without a visible instability or collision precursor. The scalar spread is
  therefore a within-class performance difference, not a new trajectory or
  termination class.
- The diagnostics expose a common actuator boundary that the images cannot:
  every sampled policy reaches exactly the `260 deg/T` rate ceiling on both
  joints. The best sample has mean absolute commands `19.25/17.71 rad/T^2` and
  spends `37.1%/33.3%` of samples above 90% of the smooth `31 rad/T^2` command
  bound. Across the four traces, posterior rate is above 80% of its ceiling for
  `21.8--22.1%` of samples, but posterior acceleration pushes farther into that
  band for only `9.7--10.3%`; peak planar force/yaw-moment coefficients remain
  inside about `0.0230/0.0135`. Additional same-direction acceleration at a
  clipped joint rate is therefore a localized plausible source of wasted
  command rather than missing steering authority.
- The inherited optimizer evidence rules out two nearby ideas. An
  approach-weighted wrong-sign-yaw lag gate fell inside exact-policy repeat
  variation, and previous-command feasibility feedback reduced anterior mean
  command only `18.20 -> 18.09 rad/T^2` while slowing capture to `19.949T` and
  worsening the distance integral/score. This candidate will neither tune a
  terminal gate nor reuse command-history feedback.

## Policy hypothesis

Use the clean captured posterior-lag scaffold and add one posterior joint-rate
governor. Normalize measured `phi_dot[2]` by the known actuator rate envelope;
as the posterior joint enters the near-limit band, smoothly attenuate only a
tail acceleration whose sign would push the rate farther toward saturation.
Leave opposite-sign braking, the anterior oscillator/steering path, target
geometry, distance/closing relief, half-cycle asymmetry, and LOS-led terminal
redirect unchanged. This is state feedback with no clock, route memory, or
world-frame cue.

The mechanism is supported only if formal evaluation preserves capture and
the coherent wake while producing a material posterior command/rate-headroom
benefit at comparable or better arrival and distance integral, with non-worse
joint-angle margin and force/moment loads. Falsify it if propulsion weakens,
the late hook becomes a pass-and-exit trajectory, capture time/integral moves
beyond repeat variation in the wrong direction, or rate/command residence does
not materially improve.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control
source_mechanism: sensor feedback modulates a low-dimensional rhythmic command while preserving its oscillator scaffold
transferable_invariant: use normalized measured actuator state to remove locally infeasible rhythm-driving effort without erasing the traveling posterior bend or braking response
nontransferable_details: published robot gains, hardware rate limits, clock-driven phases, species kinematics, and task routes
policy_translation: gate only same-direction posterior acceleration by normalized posterior joint-rate margin; retain body-frame target feedback and the two-joint state-feedback oscillator
falsification: reject if command/rate headroom is not materially better at preserved capture, timing, distance integral, loads, joint margin, and wake coherence
