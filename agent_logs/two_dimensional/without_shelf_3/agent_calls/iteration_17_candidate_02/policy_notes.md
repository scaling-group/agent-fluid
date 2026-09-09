# Wake-policy candidate notes

## Evidence diagnosis

The shared prewarm sheet shows the certified common initial condition: four
developed, interacting cylinder streets extend downstream toward the held fish,
while the target lies in the second-row wake corridor. The released sheets for
the assigned parent and the three full-unload samples are visually
indistinguishable. The fish first makes an active upstream closing leg outside
and above the useful wake region, reaches its closest range, then curls nose-up
and crosses the upper domain boundary without wake entry, collision, or
instability. The terminal lateral oscillation is therefore wasteful course
curvature rather than useful wake exploitation.

The diagnostics support that reading. The assigned parent's head moves
`-4.676L` in x and `+1.798L` in y over `70.14` released time; mean x velocity
is `-0.0708` while mean local flow is `-0.0494`, so the controller supplies
real but weak upstream-relative motion. Its `6.609L` minimum range rebounds to
`9.266L` final range, with RMS force/moment `75.6/985`, anterior extrema about
`33.23 deg` and `251.35 deg/time`, and posterior speed about
`191.21 deg/time`. Changing only the strictly gated terminal anterior steering
fraction from `0.10` to `0.0` was evaluated identically by all three sampled
workers. It lowers anterior extrema and loads slightly but repeats the upper
exit, leaves the minimum range unchanged, and modestly worsens upstream travel
(`-4.653L`), mean/final range (`9.355/9.283L`), progress (`0.253`), and score
(`-11.165` versus `-11.149`). Thus neutralization is not enough to change the
terminal turn, and further global bearing, damping, cap, or early-motion
changes remain contradicted by inherited results.

## Candidate hypothesis

Keep the parent's propulsion oscillator, `-0.125` rearward bearing authority,
static steering law, joint guards, and strict selector requiring the target to
be more than `1L` rearward plus both current and sustained range opening.
Inside that selector only, change anterior allocation from the evaluated
partial unload target `0.10` to a bounded `-0.10` fraction. Unlike the sampled
zero target, this crosses the neutral point and applies counter-curvature only
after the useful closing leg has already failed; posterior allocation remains
fixed to preserve the traveling bend.

The candidate is supported only as a structural sign test, not an expected
capture. It is useful if it preserves roughly `-4.5L` upstream travel and the
`6.61L` approach while delaying or eliminating the nose-up return, improving
mean/final range or lifetime, and keeping RMS loads near or below `76/1005`.
It is falsified if it merely repeats the upper exit with worse navigation,
causes a lower-boundary return, raises force/moment or posterior saturation, or
damages the pre-gate closing leg. A negative evaluation should close stronger
anterior-allocation continuation under this selector and motivate a different
terminal observation or actuator channel.
