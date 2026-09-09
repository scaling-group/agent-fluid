# Multi-wake candidate diagnosis and hypothesis

## Visual and metric diagnosis

- The shared prewarm sheet is common initial-condition evidence: the held fish
  starts above and downstream of four mature interacting wakes, while the
  target lies in the merged wake behind the second cylinder row. It cannot
  distinguish candidate quality.
- The clean `0.90`-period, `28 deg` gait with positive posterior-only
  proportional steering capped at `10 deg` is still the finite approach
  anchor. Its released sheet shows self-propelled upstream travel followed by
  a broad counterclockwise turn and upper-domain exit. It survives `73.39`
  release units and reaches `6.34L`, but the posterior angle reaches the
  `45 deg` hard limit, both rates reach `260 deg/time`, both commands reach the
  `1650 deg/time^2` policy cap, and RMS force/moment are `196/2014`.
- The sampled `8 deg` subtractive bearing-window-rate policy retains the same
  visible upward loop, reaches only `7.90L`, and exits after `53.53` units.
  Its posterior angle, both rates, and both commands remain saturated. The
  sampled `10 deg` heading-rate policy travels farthest upstream (`-4.69L`)
  and improves mean/final distance, but its sheet curls even more sharply
  before the same top exit; it also reaches every angle/rate/command maximum
  and raises RMS force/moment to `284/2797`. Rate feedback therefore changes
  upstream speed and loop timing without curing the terminal rotation.
- The assigned parent's inherited rollout is the clean no-rate `8 deg` static
  test. It lowers RMS force/moment to `146/1539`, but target approach collapses
  to `8.37L`, progress falls to `0.040`, upstream displacement falls to
  `-1.40L`, and it still exits with `+1.80L` head displacement after only
  `54.48` units. Thus the lower ceiling trades away steering authority without
  producing a survival benefit; it closes the static-ceiling bracket as a
  negative result.
- Across the three strong-gait sampled rollouts, the flow diagnostics agree
  that motion is self-propelled rather than passive advection: mean local flow
  x remains near zero (`-0.029` to `-0.059`) while mean head velocity/upstream
  displacement is negative. The repeated `45 deg` posterior angle and
  rate/command maxima, not a visually dramatic wake feature, are the shared
  actionable defect.

## Candidate hypothesis

Restore the complete `10 deg` proportional anchor: keep its upstream-capable
oscillator, phase lag, posterior damping, distance fade, positive body-frame
bearing sign, and acceleration cap, with no bearing-rate or heading-rate
feedback. Change one mechanism only by clamping the posterior servo target to
`40 deg` in the direction of steering. The anchor's unsteered traveling-wave
target remains unchanged; only the steering contribution is clipped when it
would reinforce the propulsive bend beyond a guard `5 deg` beneath the
documented posterior hard limit. This is a bounded joint-state servo guard,
not a global route or time command.

The later CFD rollout supports the hypothesis only if it preserves useful
target approach (preferably at or below the anchor's `6.34L`) while delaying
the upper-domain exit beyond `73.39` units or preventing posterior angle/rate
saturation and reducing late force/moment loads. It is falsified if upstream
progress falls toward the clean `8 deg` result, or if the posterior joint still
reaches `45 deg` and the same top-exit loop remains. In that case later workers
should avoid tightening the target clamp and instead restore the unclamped
`10 deg` anchor before isolating a posterior damping change.
