# Multi-wake candidate diagnosis

## Evidence read before policy editing

- The common prewarm sheet shows the held fish above and downstream of four
  mature, interacting vortex streets.  The target sits inside the merged wake
  corridor behind the second row.  This is identical initial-condition
  evidence for every candidate, not evidence for a controller gain.
- The target-blind `0.55`-period seed never enters that useful corridor.  Its
  released sheet shows a nearly monotone lower-boundary escape; the metrics
  agree with `-3.55L` upstream but `-13.30L` lateral head displacement, only
  `0.024` progress, and both joint rates and accelerations at their hard caps.
- The strongest finite sampled mechanism is the `0.90`-period, `28 deg`
  anterior oscillator with positive, posterior-only bearing feedback.  Its
  keyframes show genuine upstream swimming toward the wake followed by a broad
  upper loop.  Near-zero mean local x-flow (`-0.029`) versus upstream mean
  velocity (`-0.045`) supports self-propulsion.  It survives `73.39` released
  units and reaches `6.34L`, but the posterior angle reaches `45 deg`, both
  rates reach `260 deg/time`, both commands reach the `1650 deg/time^2` policy
  cap, and RMS force/moment rise to `196/2014` before domain exit.
- The sampled additive rate-damping variant is a concrete negative result, not
  a desaturation result.  With the anchor gait, an `8 deg` bias, and a
  subtracted `bearing_window_rate` term, it still reaches the same posterior,
  rate, and command limits, exits sooner (`53.53`), and worsens minimum distance
  from `6.34L` to `7.90L`; its slightly higher endpoint progress (`0.145`) does
  not offset the shorter saturated loop.  The prefilled `22 deg` drive with a
  small additive look-ahead also reaches only `9.31L` and raises RMS loads to
  `388/5262`.  Inherited optimizer logs further show that a much longer
  `0.35` bearing-rate look-ahead loses upstream authority, moving `+2.24L`
  downstream and exiting after `22.61` units.  Thus rate feedback that can add
  to or reverse the geometric command is not supported by current evidence.

## Single candidate hypothesis

Restore the strongest finite sample's entire propulsion oscillator, posterior
servo, `10 deg` steering ceiling, and command cap.  Keep the proportional
positive-bearing command, but multiply it by a bounded brake only while the
bearing is already closing (`bearing * bearing_window_rate < 0`).  The brake
can reduce the existing geometric steering magnitude but can neither reinforce
an opening-bearing turn nor reverse the sign before bearing crosses zero.  This
isolates the failure suggested by the additive-rate samples while leaving the
only demonstrated upstream gait unchanged; steering remains posterior-only
and all gains remain in `target_policy_params`.

The next CFD rollout supports this hypothesis only if upstream displacement is
retained while the broad loop, posterior/rate saturation, or load signature is
reduced, with survival beyond `73.39` units or minimum distance below `6.34L`.
It is falsified if closing-only braking still reaches the same limits and exits
on the same upper-loop topology, or if it weakens target approach before the
first bearing crossing.  In that case later workers should test static bias
strength without any rate term, rather than trying another additive look-ahead
or weakening the propulsion gait at the same time.
