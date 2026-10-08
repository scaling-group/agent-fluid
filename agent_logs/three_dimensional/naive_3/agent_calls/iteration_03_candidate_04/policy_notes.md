# Wake-policy candidate notes

## Inherited evidence and visual diagnosis

- The assigned parent (`solver_f222e3379ba1`) retains the common joint-state
  oscillator and posterior lag, then adds a bounded posterior mean curvature
  from body-frame bearing and instantaneous heading rate. Its rollout is a
  valid direct-uniform still-water trial: `U_infinity=(0,0,0)`, no cylinders,
  no prewarm, and therefore no ambient advection that can explain the motion.
- Both rows of the parent's combined keyframe sheet show self-propulsion. The
  top-down row develops alternating signed vorticity behind the tail, and the
  oblique row resolves the same activity as a three-dimensional Lambda2 trail.
  The wake stays energetic while the body turns into a broad upward arc, so
  the terminal failure is guidance/yaw control rather than absent thrust.
- The parent reduces distance from `12.328L` to `11.824L`, then loses progress
  and exits the upper boundary at `9.191T`, center `y=15.200L`, with final
  distance `11.876L`. Its heading spans `+0.567` to `-0.973 rad`; the visual
  upward hook and the large negative final heading agree. Raw acceleration
  exceeds the `1800 deg/T^2` envelope in about `35%/47%` of anterior/posterior
  samples, so more carrier gain is unsupported.
- The strongest sampled finite result (`solver_7afa3aa3b5d0`) uses sharper
  bearing-plus-trend posterior curvature. Its top-down and oblique views retain
  a longer coherent alternating wake, its speed reaches `0.753U`, and it moves
  from `x=21.000L` to `16.396L`, monotonically improving late distance to
  `9.141L`. It nevertheless follows the same upward-turning topology and exits
  at `y=15.201L` after `13.129T`; bearing is already negative near `7T` while
  away-from-target body lateral velocity recurs through the remaining beats.
  Its raw posterior request is above the acceleration envelope in about `62%`
  of samples, showing that the existing tail channel has little clean reserve.
- Instantaneous body yaw is dominated by the propulsive beat rather than the
  slow course change: across the four sampled posterior-curvature traces, a
  common linear proxy built from anterior angle, anterior rate, and posterior
  rate explains more than `98%` of heading-rate variance, while raw yaw rate
  repeatedly reaches roughly `+/-2 rad/T`. The parent's direct use of that raw
  signal therefore mixes carrier phase into route feedback. A rate controller
  should first remove this observed joint-state-correlated component and gate
  that subtraction off at release, when body speed and hydrodynamic response
  are still zero.
- The other sampled static-offset policy and both inherited phase-aware tests
  do not change termination class. Posterior half-cycle asymmetry without a
  mean offset reaches only `11.655L` before an upper exit at `9.086T`; adding
  opposing-half-cycle relief to the strongest offset reaches `9.855L` before
  the same exit at `12.551T`. Moving both joint centers is worse still: the
  anterior excursion collapses to about `8 deg`, closest distance is
  `12.292L`, and final distance grows to `13.403L`. Thus neither another
  posterior asymmetry adjustment nor recentering the anterior oscillator is
  supported by the completed evidence.

## Policy hypothesis

Preserve the zero-centered anterior oscillator and its posterior traveling-wave
carrier, but replace the parent's direct bearing-plus-yaw sum with a bounded,
phase-referenced target-yaw-rate servo. Body-frame bearing and its measured
short-window trend define a desired turn rate. Before comparison, subtract the
cross-sample joint-state proxy for fast carrier-induced yaw from
`turn_rate_recent`, smoothly enabling that subtraction with measured body
speed. Posterior mean curvature can then change sign when the slow yaw response
has met or exceeded the target-directed request instead of reacting to each
propulsive half-cycle or waiting for a large bearing overshoot. Clamp the
combined posterior target inside the joint-angle envelope so the new feedback
does not demand still more unavailable tail authority.

This should preserve the visible propulsive wake and the best sampled policy's
leftward carrier while braking the beat-averaged upward turn earlier. The next
evaluation should show a smaller negative-bearing excursion, lower upward
drift after the first alignment sweep, and either a better termination class
or a later/closer useful trajectory. Falsify the mechanism if it destroys the
alternating wake, loses material x progress, keeps the same upper-boundary
exit without beating `9.141L`, chatters between curvature limits with the
beat-scale yaw signal, or increases joint-limit occupancy.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual control around rhythmic locomotion
source_mechanism: close a bounded slow turn-rate loop around a preserved propulsive rhythm after separating the observed beat-synchronous body response
transferable_invariant: target geometry should request a turn response while phase-referenced body rotation decides whether further curvature or braking is needed; the fast propulsive carrier remains separate from slow guidance
nontransferable_details: published controller gains, clock phase, species-specific bend envelopes, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: map normalized body-frame bearing plus its bounded observed trend to a desired yaw rate; subtract a speed-gated joint-state carrier-yaw proxy from bounded recent body yaw, then track the residual error with a bounded posterior mean-tangent request without moving the anterior oscillator center
falsification: reject if bearing still diverges after the first alignment sweep, the same upper exit persists without a closer or longer trajectory, yaw feedback chatters destructively, wake coherence or leftward propulsion collapses, or actuator-limit occupancy worsens
