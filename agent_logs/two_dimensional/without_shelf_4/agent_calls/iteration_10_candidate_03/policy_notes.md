# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held high and downstream/right while the same developed streets from
  the four staggered cylinders overlap through the target corridor. This is a
  common initial condition and cannot rank controllers.
- Three sampled released sheets and their diagnostics exactly reproduce the
  `20.25 deg`, `0.67`-period, `0.25` bearing-rate-lead anchor. The fish is not
  merely advected: mean upstream head velocity is `-0.04443` against mean
  local-flow x `-0.03649`, leaving `0.00793` controller-relative upstream
  transport. The sheet shows a broad initial loop and alternating bends on the
  right, then central-wake acquisition and an almost horizontal capture at
  `244.547`. Mean/final distance is `6.452/0.750L`, maximum lateral target
  offset is `4.293L`, and RMS relative crossflow, lateral force, and moment are
  `0.13437`, `18.263`, and `362.214`. There is no collision, exit, instability,
  or rebound.
- Propulsion has no supported tuning margin. The matched `20 deg` sample
  captures later at `266.255` with mean distance `7.218L`, while inherited
  `19 deg` evidence missed. At `20.25 deg`, maximum anterior acceleration is
  already `31.055 rad/time^2` against the `31.2` policy guard and `31.416` hard
  cap. The oscillator, posterior lag/damping, and all guards therefore remain
  fixed.
- The assigned parent's sign-asymmetric bearing-rate policy is the most
  informative failure. Reducing lead from `0.25` toward `0.20` only when
  `bearing * bearing_rate > 0` produces a visibly wider, jagged route that
  fails to retain the target corridor and misses at the horizon. Its minimum,
  final, and mean distances are `3.290/3.632/8.447L`, maximum lateral offset
  grows to `4.703L`, and absolute upstream velocity falls from `-0.04443` to
  `-0.02667`. It has the same `31.055` anterior acceleration maximum and no
  collision, exit, or instability, so the miss is a steering/route regression,
  not lost gait feasibility or a failure penalty. Its lower RMS force does not
  compensate for failed capture and higher mean command effort/power.
- A separately sampled global `0.05` heading-rate correction is a useful but
  negative component test. It retains capture and the `4.293L` excursion, and
  lowers RMS force/moment to `18.202/357.284`, but the sheet reaches the central
  corridor later: capture moves to `259.160`, mean distance rises to `6.502L`,
  relative crossflow rises to `0.13610`, and controller-relative upstream
  transport falls to `0.00359`. Thus body-rotation feedback can reduce loads,
  but applying it during every turn also damps useful targetward rotation.

## Candidate hypothesis

Preserve the demonstrated gait, posterior dynamics, steering limit, `0.30`
bearing scale, `0.25` bearing-rate lead, and acceleration guard. Retain the
evaluated `0.05` heading-rate lead and `0.30 rad/time` limit, but multiply that
correction by a smooth turn-away weight
`tanh(max(-bearing * heading_rate, 0) / (bearing_scale * heading_rate_limit))`.
The candidate is exactly the anchor when the body is stationary or rotating
toward the target (`bearing * heading_rate >= 0`), and adds rotational damping
only while the body rotates away. The extra pre-nonlinearity correction remains
bounded by `0.015 rad`; it introduces no clock, coordinate, route, wake probe,
or unnormalized observation.

This isolates the part of global heading damping supported by the visible
alternating reversals while avoiding its demonstrated cost during useful
targetward turns. Unlike the failed assigned-parent gate, it does not weaken
bearing-rate anticipation when total bearing error diverges; it strengthens
correction only when measured body rotation itself points away. Under the
certified prewarm, improvement requires retained central-wake capture with
arrival no later than `244.547` and mean distance below `6.452L`, or a material
load reduction without slower capture, while preserving upstream transport and
avoiding guard contact or switching artifacts. Falsify the mechanism on a
horizon miss, later capture, larger mean/lateral distance, reduced upstream
margin, higher crossflow/load, or visible chatter near zero alignment. If
falsified, restore the plain anchor and treat both bearing-divergence gating and
heading-rate decomposition as exhausted until time-resolved evidence supports
a different normalized corridor signal.
