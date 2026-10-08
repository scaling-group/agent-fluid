# Wake-policy candidate notes

## Evidence diagnosis

The four sampled solver examples are deterministic copies of the same finite
arrival controller: their released and prewarm keyframe sheets have identical
hashes, and every physical metric except wall time agrees. There is therefore
no distinct sampled failure keyframe to compare with the best finite example.
The assigned parent experience supplies the relevant failure comparison:
weaker, gated, velocity-damped, rate-led, and near-limit steering variants lost
upstream approach or retained the upper exit, while the additive normalized
cross-track term was the first mechanism to change the route into capture.
No separate inherited optimizer-log file is present in this workspace; those
prior outcomes are available only through the inherited experience summaries.

The common prewarm sheet shows the fish held above and downstream of four fully
developed, interacting vortex streets. The released sheet then shows active
self-propulsion rather than passive advection: the fish travels diagonally
upstream from the upper-right initial pose, executes a wide turn outside the
useful wake corridor, descends into the second-row wake, and finally crosses
the target. This reading agrees with target termination after `88.129` release
units, `-10.925L/-4.435L` head displacement, mean head velocity more upstream
than the `-0.0915` mean local flow, and `0.747L` minimum/final distance. The
route succeeds, but effort remains a concrete weakness: command energy is
`76354.5` (`866.4` mean), RMS force/moment are `444.7/4596.7`, the posterior
joint reaches exactly `45 deg`, and both joints reach exactly `260 deg/time`
and the policy's `1650 deg/time^2` command ceiling. The anterior angle peaks at
only `38.31 deg`, so angle saturation is posterior-specific even though rate
and acceleration saturation affect both joints.

## Candidate hypothesis

Keep the complete sampled bearing, normalized cross-track, body-rate, and
opposing-posterior-headroom controller unchanged, including the propulsion
oscillator. Test one actuator mechanism only: lower the policy-owned symmetric
acceleration command ceiling from `1650` to `1500 deg/time^2`. The modest
`9.1%` reduction directly removes the observed command extremes without
introducing a new signal, state, phase gate, or route change. The falsifiable
expectation is that the diagonal target capture survives with lower command
energy and force/moment loads; it is not expected by itself to eliminate the
posterior angle or joint-rate contacts. If capture is lost, arrival slows
materially, or the wide route worsens without a meaningful effort reduction,
later workers should restore the exact `1650` arrival anchor rather than stack
another recovery mechanism on this cap test.
