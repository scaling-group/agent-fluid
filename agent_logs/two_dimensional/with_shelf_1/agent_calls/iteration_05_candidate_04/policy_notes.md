# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the edit

- The common held-fish prewarm sheet shows fully developed, interacting vortex
  streets crossing the target region before release. It is shared initial-state
  evidence, not a policy outcome.
- All four sampled solver examples are finite target reaches; the two prefill
  copies are identical. Their keyframes show self-propelled, not merely advected,
  motion: the fish redirects sharply from the upper-right release, establishes a
  coherent left/down traveling bend, enters the mixed wake, and reaches the
  `0.75L` circle without collision or an obvious late miss.
- The assigned-parent and inherited logs supply the informative failures absent
  from the sampled keyframe set: the target-blind seed exited downward after
  `50.127`, the opposite-sign curvature interpretation exited after `13.915`
  with negative progress, and a slower/smaller wholesale carrier became unstable
  after `121.517` with RMS force/moment `16749.8/290421`. These results rule out
  revisiting steering sign, static curvature, or scalar gait reduction.
- Relative to the reproduced fixed-reserve parent (`49.142` arrival,
  `2.15598L` mean distance, command energy `62521.6`, RMS force/moment
  `39.05/617.13`), the course-slip branch reached in `48.032` with `2.10028L`
  mean distance and slightly lower load `37.92/605.38`, while retaining the same
  `30.0` acceleration and `4.5379` joint-speed maxima. Its total energy was
  slightly lower (`62426.9`), although its per-time mean was higher (`1299.7`).
- The bearing-scheduled-reserve branch is the strongest finite sample by arrival
  (`46.035`), mean distance (`2.06953L`), total/mean command energy
  (`56948.0/1237.1`), and score (`-0.188341`). Its visible route remains coherent,
  but the improvement trades against higher RMS force/moment (`51.40/761.46`),
  larger joint-1 excursion (`0.60595` rad), and continued acceleration/speed-cap
  contact. The compact diagnostics do not establish saturation duty cycle.

## Candidate hypothesis

Preserve the evaluated oscillator, posterior lag, steering sign, acceleration
residual, and `30.0` envelope. Combine only the two independently positive
body-frame mechanisms: subtract the bounded course-slip proxy from bearing, then
use that same slip-corrected error for both the steering residual and continuous
redirect-reserve scheduling. This should retain the scheduled branch's strong
initial redirect while backing off extra directional allocation whenever measured
lateral motion already carries the fish toward the target. The candidate is not
claimed to be evaluated here.

Expected evidence: retain `target_reached`; beat the fixed-reserve parent's
`49.142` arrival and `2.15598L` mean distance; approach the scheduled-reserve
branch's arrival/effort without retaining its `51.40/761.46` load increase.
Reject the combination if it loses capture, makes the visible path loop or yaw
reverse, fails to improve arrival/mean distance over the parent, or leaves the
scheduled-reserve load rise without a compensating progress benefit.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG control and adaptive swimming in organized wakes
source_mechanism: separate persistent route error from measured lateral response, then modulate bounded directional authority without replacing the propulsive rhythm
transferable_invariant: target geometry should set the mean turn while observed body-frame motion prevents redundant correction; large residual error may continuously receive more bounded redirect authority
nontransferable_details: published CPG gains, duty ratios, species kinematics, dimensional frequencies, exact vortex phases, and wake-specific routes
policy_translation: preserve the two-joint state-feedback carrier; form course_slip from normalized body velocity, subtract a small bounded share from bearing, and schedule the existing in-envelope steering reserve from that corrected error
falsification: reject on lost target reach, repeated yaw reversal, no arrival or mean-distance gain over the fixed-reserve parent, or RMS force and moment near the scheduled-reserve branch without a compensating progress or effort benefit
