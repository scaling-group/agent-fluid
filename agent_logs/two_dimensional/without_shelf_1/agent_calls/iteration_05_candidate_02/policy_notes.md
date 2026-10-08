# Multi-wake candidate diagnosis

## Evidence read before policy editing

- The common prewarm sheet shows the fish held above and downstream of four
  mature, interacting cylinder wakes. The target is in the merged corridor
  behind the second row. Because this sheet is shared by every rollout, it
  establishes the difficult initial wake but no candidate-specific gain.
- The undamped positive posterior-steering anchor (`0.90` period, `28 deg`
  anterior oscillator, `10 deg` steering limit) visibly self-propels toward
  the wake before making a broad upward loop. It survives `73.39` release
  units and reaches `6.34L`, but exits through the upper boundary with the
  posterior angle at `45 deg`, both rates at `260 deg/time`, both commands at
  `1650 deg/time^2`, and RMS force/moment `196/2014`.
- Direct normalized heading-rate damping is the strongest finite sampled
  repair. Its sheet shows faster diagonal upstream motion before the same
  upward curl; the diagnostics confirm mean upstream velocity `-0.0878`
  versus `-0.0447` for the undamped anchor, progress `0.255` versus `0.132`,
  and score `-11.29` versus `-12.76`. This motion is self-propelled rather than
  passive advection because mean local x-flow is only `-0.0587`. It is not a
  desaturation result: minimum distance worsens to `7.30L`, release survival
  falls to `56.93`, the same posterior/rate/command caps are reached, and RMS
  force/moment rise to `284/2797`. Its `+1.80L` final head-y displacement and
  upper-boundary curl leave lateral motion as an unresolved control channel.
- Additive bearing-window-rate variants do not provide that missing channel.
  The `8 deg` variant still saturates and exits after `53.53` units at `7.90L`,
  while the prefilled lower-drive rate-lead variant reaches only `9.31L` and
  raises RMS force/moment to `388/5262`. An inherited longer look-ahead loses
  upstream motion entirely (`+0.083L` head x, negative progress).
- The inherited sign-preserving closing-bearing brake is a stronger negative
  boundary: despite restoring the anchor gait, its up-to-`65%` multiplicative
  brake is swept downstream/right (`+2.28L` x), never improves on the initial
  distance, and exits after `19.10` units. Low loads `22/620` in that rollout
  reflect lost swimming authority, not useful stabilization.

## Single candidate hypothesis

Restore the complete direct-heading-rate candidate because it is the only
sampled rate mechanism that improves upstream speed and continuous progress.
Keep propulsion, posterior servo, positive bearing sign, heading-rate scale,
steering ceiling, and command cap unchanged. Add one small bounded correction
from `state.velocity_body_U[2]`, the task contract's normalized body-lateral
velocity: subtract at most `0.20` normalized steering units, with a `0.50`
velocity scale, before the existing final clamp. Unlike bearing-window rate,
this signal does not mix target-vector translation with yaw; unlike the failed
closing brake, it cannot remove more than one fifth of the saturated geometric
request by itself. Steering stays entirely in the posterior mean tangent.

The falsifiable expectation is to preserve roughly the heading-damped
rollout's upstream motion while reducing its upper-loop lateral drift, with
survival beyond `56.93` units and either minimum distance below `7.30L` or
reduced posterior/rate saturation and RMS load. If upstream displacement falls
back toward zero, the lateral correction is too strong or has the wrong sign
and should be removed before changing the proven gait. If `+y` exit and the
same caps persist while upstream speed remains, body-lateral damping is not
the missing loop repair; later workers should isolate posterior-servo
bandwidth or static steering strength rather than revive bearing-rate lead or
the closing-bearing brake.
