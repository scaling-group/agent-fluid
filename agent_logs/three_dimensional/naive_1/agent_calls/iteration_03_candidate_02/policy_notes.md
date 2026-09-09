# Wake-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization in still water, `U_infinity=[0,0,0]`, no cylinders or prewarm,
  finite dynamics, and `left_domain` termination. The top-down and oblique rows
  show self-propelled alternating vorticity and Lambda2 chains, so the useful
  state-feedback carrier and posterior lag should be retained.
- The assigned parent's response-gated posterior candidate
  (`solver_4d290a0c05f4`) inherited the coherent wake but exited the upper
  boundary at `9.311T`; it only reached `11.789L`. Its bearing-trend/yaw-rate
  feedback did not improve the earlier posterior-only upper-exit topology.
- The prefilled shared-bias/slip policy (`solver_f0a5c173df3d`) visibly sustains
  a strong wake and approaches from `12.328L` to `8.174L`, but then follows a
  broad underdamped arc below the target and exits the lower boundary at
  `26.043T`, with final distance `12.336L`. Same-sign anterior and posterior
  offsets therefore provide route motion but the wrong joint allocation for
  stable error correction.
- The differential turn-rate servo (`solver_d282288428b4`) is the strongest
  finite sample: its coherent wake carries it left for `33.209T`, minimum
  distance reaches `4.977L`, and mean distance is `8.841L`. It nevertheless
  holds a nearly horizontal course around `y=14L`, passes above the target,
  and exits the upper-left boundary at final distance `9.249L`. Its recent-rate
  window spans only seven prior CFD steps, about `0.04T` versus the `0.55T`
  carrier period. The observed within-beat turn rate reaches the controller's
  `2 rad/T` clamp, both joint rates contact `260 deg/T` on about `16.8%/19.1%`
  of rows, and raw acceleration exceeds the envelope on about `70.5%/77.6%`.
  Thus the fast rate loop aliases propulsive yaw into steering and alternates
  the curvature request instead of regulating mean course.

## Policy hypothesis

Keep the best sample's opposite-sign anterior/posterior curvature allocation
and the seed carrier, but remove short-window bearing-rate and yaw-rate
feedback. Use the signed, full body-frame line-of-sight angle from
`target_body_L` as the sole slow route request. A smooth saturated mapping
should hold a correcting differential bend through carrier-scale yaw, release
it at alignment, and still choose a turn direction if the target passes behind.
This is a geometry-driven burst-redirect mechanism rather than a carrier gain
change or a memorized route.

Falsify the candidate if it does not establish sustained downward progress
toward `y=9.5L`, loses the alternating wake, repeats either early vertical exit,
passes above the target without improving the `4.977L` minimum, or retains the
differential servo's rate/acceleration contact despite removing its aliased
rate feedback.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and biological burst redirect
source_mechanism: bounded target-driven curvature asymmetry that releases on geometric alignment
transferable_invariant: preserve the propulsive rhythm while a persistent body-frame route error holds an asymmetric bend, then release or reverse it when alignment changes
nontransferable_details: published gains, clocked CPG phase, species-specific bend envelopes, exact vortex phases, and prescribed routes
policy_translation: map the normalized body-frame target vector to a bounded full line-of-sight request and distribute it as opposite-sign anterior/posterior mean offsets around the two-joint state oscillator
falsification: reject if the turn sign is wrong, vertical target progress is absent, wake coherence collapses, closest approach does not beat 4.977L, or actuator contact remains as persistent as the short-window rate servo
