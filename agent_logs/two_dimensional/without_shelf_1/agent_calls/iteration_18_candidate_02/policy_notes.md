# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet establishes the common initial condition: the held
fish begins above and downstream of the target while four developed,
interacting wakes span the route.  The inherited close-only continuation of
opposing-posterior headroom is the informative failure.  Its released sheet
shows active upstream travel through the disturbed corridor followed by a
sharp upward hook and upper-domain exit.  The metrics agree: it travels
`-12.66L` in x but `+1.72L` in y, comes only within `2.21L`, and terminates
`left_domain`; its mean head velocity is more upstream than the mean local
flow, so the failure is route control rather than passive advection.

In contrast, every current sampled solver contains the same functional
controller and independently reports the same finite outcome.  The additive
`0.18*tanh(target_body_L[2]/2L)` request turns the fish downward early, keeps
it in the interacting-wake corridor, and ends inside the capture circle rather
than at the upper boundary.  All four sampled evaluations reach `0.747L` after
`88.129` release units with head displacement `(-10.92,-4.44)L`, progress
`0.940`, RMS relative crossflow `0.289`, and RMS force/moment `445/4597`.
The head's mean upstream speed still exceeds the mean upstream local flow.
Because the policy files differ only in comments, those bit-identical metrics
are replication evidence for one controller, not a parameter-response sweep.

The inherited logs also state that this arrival anchor still reaches the
posterior angle limit and both joint rate/command caps.  Earlier gait
attenuation, desired-angle clipping, bearing-rate, lateral-velocity, and
phase-headroom changes lost propulsion or the route, so they should not be
stacked onto the first successful controller.  The reusable open question is
whether a small isolated reduction of the policy's command ceiling can reduce
effort while preserving capture.

## Single candidate hypothesis

Keep the complete replicated arrival controller, including the `0.90` period,
`11 deg` posterior request, `0.70/0.35` body-rate feedback, `0.50` opposing
headroom allocation, and `0.18/2L` additive cross-track term.  Change only the
policy-owned acceleration command limit from `1650` to `1575 deg/time^2`, a
`4.5%` reduction.  This directly tests the observed command saturation without
changing target geometry, gait phase, steering sign, or route selection.

The later CFD evaluation supports the candidate only if it retains the
diagonal target capture near the `88.129`-unit anchor while reducing command
energy, power proxy, or force/moment load.  It is falsified if arrival is lost
or materially delayed, the upper hook returns, or distance integral worsens
more than effort improves.  A negative result should restore `1650` and close
command-ceiling reduction as an isolated desaturation repair for this gait;
it should not motivate combining the reduction with already failed clipping
or feedback overlays.
