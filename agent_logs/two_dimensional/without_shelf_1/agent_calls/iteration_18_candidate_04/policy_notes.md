# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet establishes the common initial condition: the held
fish begins above and downstream of the target while four developed,
interacting wakes fill the route. The inherited close-gated `0.50` to `0.55`
opposition continuation is the informative failure. Its released sheet shows
active upstream swimming into the wake followed by a sharp upper hook and
domain exit rather than collision or instability. The metrics agree: head
travel is `(-12.66,+1.72)L`, closest approach is `2.21L`, mean head velocity x
is more upstream than mean local flow x (`-0.179` versus `-0.127`), and RMS
force/moment rise to `566/5660`.

All four current sampled candidates contain the same controller apart from
comments and reproduce the same finite result bit-for-bit. Their released
sheets show an early downward turn, entry into the interacting wake, and a
diagonal target crossing instead of the inherited upper exit. This is active
propulsion, not advection: the head moves `(-10.92,-4.44)L`, mean head velocity
x is `-0.124` while mean local flow x is `-0.092`, and the fish reaches
`0.747L` after `88.13` release units. The route also reduces RMS relative
crossflow and force/moment to `0.289` and `445/4597`. Therefore the complete
`0.18*tanh(target_body_L[2]/2L)` cross-track term, `0.50` phase allocation,
and bearing/body-rate controller are the deterministic arrival anchor; the
duplicates add reproduction evidence, not a gain bracket.

Capture does not establish actuator economy. The success sheet retains a
pronounced terminal loop before first crossing, and diagnostics show the
posterior joint at exactly `45 deg`, both rates at exactly `260 deg/time`, and
both acceleration commands at exactly the policy's `1650 deg/time^2` cap.
Command energy is `76355`, with RMS force/moment still `445/4597`. Inherited
results rule out changing body-rate damping, static bias, phase allocation,
late bearing/lateral blending, desired-angle clipping, or cross-track gain as
a justified companion change. A clean command-ceiling bracket is not isolated
in the sampled evidence and is the narrow remaining actuator test.

## Single candidate hypothesis

Keep every demonstrated navigation and propulsion parameter unchanged and
reduce only the policy-owned acceleration command ceiling from `1650` to
`1550 deg/time^2` (about `6%`). This does not weaken the posterior target,
alter cross-track geometry, add a recovery signal, or use global coordinates,
elapsed time, prescribed inflow, remote probes, or target-station flow. It is
one conservative test of whether the exact command-cap contact is unnecessary
headroom now that the route has four identical sampled captures.

The hypothesis is supported only if target capture and the diagonal topology
survive with no material arrival delay while command energy and/or RMS loads
fall. It is falsified by loss of capture, return of the upper exit, materially
worse mean distance, or continued angle/rate saturation without an effort or
load benefit. A negative result should restore `1650` and close simple ceiling
reduction as desaturation; later work would need a separately evidenced
within-cycle shaping mechanism while preserving the exact arrival controller.
