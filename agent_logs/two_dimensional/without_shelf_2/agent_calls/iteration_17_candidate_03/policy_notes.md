# Multi-Wake Candidate Diagnosis

## Current visual and metric evidence

- The shared prewarm sheets are byte-identical. They show the fish held in the
  upper-right while four staggered cylinder streets develop and merge around
  the target, so the released-policy comparisons start from the same wake.
- Three executable `tail_steering_gain=0.70` samples have byte-identical
  released sheets and exactly matching diagnostics. From release they turn
  toward the body-frame target, traverse a compact diagonal path through the
  developed wake, and enter the capture circle without collision, domain exit,
  or visible coiling. Mean x velocity is `-0.15005` versus local flow
  `-0.08386`, giving `0.06620` upstream-relative separation; the motion is
  therefore materially self-propelled rather than passive advection. Their
  `72.457` arrival, `2.4541L` mean distance, `0.13063` relative crossflow, and
  `23.85/408.89` RMS force/moment confirm the compact finite behavior.
- The sampled `0.60` share has the same broad visual topology but closes more
  slowly (`73.859`) with worse mean distance (`2.4800L`), slightly less
  upstream-relative x speed (`0.06565`), and higher force/moment
  (`24.94/410.68`). The inherited `0.65` result is the complementary Pareto
  point: faster arrival (`72.160`), higher relative x speed (`0.06732`), and
  lower total command energy (`51284`), but higher crossflow and force/moment
  (`0.13603`, `25.32/420.32`) than `0.70`.
- No current sampled rollout is a failure. The inherited downstream exits from
  under-driven steering and the unstable negative-sign high-amplitude trial
  remain the applicable failure boundary: preserve the positive bearing sign,
  the evaluated propulsive orbit, and the `28/28` command guard.

## Policy hypothesis

Replace only the static posterior steering share with a bounded body-frame
bearing schedule. Use the reproduced `0.70` share when the bounded steering
center is large, where compact turning and lower loads matter, and taper to the
evaluated `0.65` share as the steering center approaches zero, where the
faster/lower-effort endpoint may retain propulsion. Normalize the blend by the
existing steering limit, so it is independent of coordinates, target identity,
elapsed time, and resolution and never extrapolates beyond evaluated shares.

The falsifiable expectation is target capture on the same compact route with
arrival no slower than the `0.70` anchor and without exceeding its crossflow,
force/moment, or effort materially. Reject the schedule if it changes route
branch, loses upstream-relative propulsion, increases guard contact/load, or
misses capture; later evaluation, not this worker, determines that outcome.
