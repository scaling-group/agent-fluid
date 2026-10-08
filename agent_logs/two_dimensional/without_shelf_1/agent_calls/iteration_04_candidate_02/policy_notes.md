# Multi-wake candidate diagnosis and hypothesis

## Visual and metric diagnosis

- The shared prewarm sheet shows the held fish at the upper-right while the
  four asymmetric cylinder streets develop and merge around the target. This
  is the certified common initial condition, not evidence for any controller.
- The target-blind `0.55`-period seed is self-propelled upstream by `3.55L`,
  but its released sheet shows a nearly monotone dive out of the lower domain
  after `50.13` units. It never enters the useful target/wake corridor; both
  joint rates and commands reach their hard limits and progress is only
  `0.024`.
- The proportional posterior-only anchor (`0.90` period, `28 deg` drive,
  `10 deg` positive bearing bias) is the strongest finite mechanism. Its
  released sheet shows upstream travel into the developed wake and a closest
  approach of `6.34L`, followed by a broad upward loop and exit after `73.39`
  units. Near-zero mean local flow versus `-0.0447` mean head velocity in x
  supports active propulsion. The loop coincides with the posterior angle
  reaching `45 deg`, both rates reaching `260 deg/time`, both commands
  reaching `1650 deg/time^2`, and RMS force/moment of `196/2014`.
- The sampled subtractive rate variant (`8 deg` bias plus bounded negative
  `bearing_window_rate` feedback) does not damp that loop. Its keyframes turn
  vertical earlier; it exits after `53.53` units and never gets closer than
  `7.90L`. Posterior angle, both rates, and both commands still hit the same
  limits, while RMS force/moment rise slightly to `201/2115`. Its slightly
  better endpoint progress (`0.145`) is therefore not a better approach.
- The inherited opposite-sign `0.35`-time bearing prediction is a stronger
  negative boundary: with the anchor gait otherwise retained it moves
  `2.24L` downstream, reaches only `12.42L`, and exits after `22.61` units.
  A broader reduced-gait/rate alteration also removes upstream authority
  (`+0.08L` x displacement, `-0.062` progress) while raising loads to
  `329/5141`. Together these results do not support another bearing-rate or
  wholesale gait change before isolating the persistent posterior saturation.

## Candidate hypothesis

Restore the strongest anchor's proportional positive bearing feedback and its
entire upstream-capable gait. Keep target steering exclusively in the
posterior mean tangent, but clamp the requested posterior joint target to
`36 deg`, safely inside the physical `45 deg` stop, before the existing servo.
Use separate parameter-owned command caps: preserve the anchor's `1650
deg/time^2` anterior propulsion authority and reduce only the posterior cap to
`1500 deg/time^2`. This directly addresses the repeated posterior angle/rate/
command saturation without weakening the anterior oscillator or introducing
an unscaled temporal observation.

The hypothesis is supported only if the next rollout retains upstream head
motion, keeps the posterior angle below its hard stop, lowers posterior rate
saturation and force/moment loads, and improves on the anchor's late loop by
surviving beyond `73.39` units or approaching closer than `6.34L`. It is
falsified if the bounded tail target removes upstream authority or merely
delays the same loop; later workers should then relax the posterior target
limit independently before revisiting bearing-rate feedback.
