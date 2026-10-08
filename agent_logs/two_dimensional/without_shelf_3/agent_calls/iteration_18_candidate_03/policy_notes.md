# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The identical shared-prewarm sheets show the fish held above and downstream
  of the target while four developed staggered-cylinder streets overlap around
  the target corridor. The released sheets for the strongest sampled partial
  unload, the current full-unload prefill, and the inherited posterior-unload
  test all remain above and to the right of that corridor. Each fish makes a
  useful diagonal upstream leg, then curls sharply nose-up and exits the upper
  boundary; none enters the developed wake region or the `0.75L` capture disk.
- The approach is partly self-propelled rather than passive advection. With
  terminal anterior allocation `0.10`, mean velocity is
  `(-0.07075,+0.01712)L/time` versus mean local flow
  `(-0.04945,-0.00064)L/time`. Its tailbeat-driven leftward motion exceeds the
  local stream, while the visible terminal rise occurs against near-zero mean
  crossflow. The large body bend in the last two keyframes is therefore
  wasteful course reversal, not useful vortex-assisted lateral oscillation.
- The strict more-than-`1L`-rearward, simultaneous instantaneous-and-windowed
  opening selector with anterior allocation `0.10` is the strongest measured
  finite policy: score `-11.1487`, head travel `(-4.676,+1.798)L`,
  minimum/mean/final range `6.609/9.342/9.266L`, progress `0.2542`, and RMS
  force/moment `75.55/984.76`. Its anterior angle/speed reach
  `33.23 deg`/`251.35 deg/time`; posterior extrema remain near
  `25.93 deg`/`191.21 deg/time`.
- Two sampled full-anterior-unload evaluations (`0.0`) are numerically
  equivalent, including the current prefill. They retain the same keyframe
  topology and `6.609L` minimum, slightly reduce anterior speed and RMS moment
  to `249.86 deg/time` and `982.10`, but worsen score to `-11.1649`, upstream
  head travel to `-4.653L`, mean/final range to `9.355/9.283L`, and progress
  to `0.2528`. The extra unload is a small load/navigation trade, not recovery.
- The inherited gated posterior-allocation test is a second negative endpoint.
  Keeping anterior allocation `0.10` while reducing posterior allocation from
  `0.65` to `0.55` again produces the same upper exit and unchanged `6.609L`
  minimum. It worsens score to `-11.2126`, upstream travel to `-4.593L`,
  mean/final range to `9.393/9.332L`, and progress to `0.2489`, without a
  meaningful load benefit (`75.53/982.44`). Together these brackets support
  the sampled `0.10/0.65` terminal allocation, not interpolation toward either
  attenuated endpoint.

## Candidate hypothesis

Restore exactly the strongest sampled terminal allocation: set
`terminal_anterior_steering_fraction=0.10` and retain the fixed posterior
fraction `0.65`, the strict deep-rearward dual-opening selector, oscillator,
`-0.125` rearward bearing authority, `0.60` bearing gain, `12 deg` steering
ceiling, `0.04` recent-turn damping, joint guards, and smooth acceleration
limit. This changes one owned parameter from the inferior full-unload prefill
and avoids combining the evidence-backed rollback with another unmeasured
mechanism.

The candidate is supported if reevaluation reproduces approximately
`-4.68L` upstream travel, `6.61L` minimum range, `9.342/9.266L` mean/final
range, `0.254` progress, and RMS force/moment near `76/985`, outperforming the
current `0.0` parent in navigation. The existing evidence already falsifies it
as a complete recovery policy: the expected upper-domain exit, lack of useful
wake entry, and lack of capture bound any replicated benefit to terminal
allocation shaping. Later workers should seek a structurally distinct,
bounded recovery observation rather than attenuating either joint farther.
The controller uses only normalized body-frame target projection and range
rates, measured recent turn, and joint state; it contains no coordinate, clock,
route, prescribed inflow, remote probe, target-station signal, or omitted-shelf
dependency. Formal CFD remains deferred to EvE.
