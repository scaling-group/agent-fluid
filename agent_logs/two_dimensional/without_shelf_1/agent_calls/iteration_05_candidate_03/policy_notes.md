# Wake-policy candidate diagnosis

## Visual and metric diagnosis

- The shared prewarm sheet shows the fish held in the upper-right while four
  mature, interacting cylinder wakes fill the route to the second-row target.
  This is the common initial condition and is not credited to any controller.
- The positive-bearing, posterior-only anchor (`0.90` period, `28 deg`
  oscillator, `10 deg` bias) visibly self-propels diagonally toward the wake,
  reaches `6.34L`, and remains in-domain for `73.39` released units. Its mean
  head x velocity is more upstream than its mean local flow (`-0.0447` versus
  `-0.0293`), so the approach is not passive advection. It then makes a broad
  upper loop, reaches the `45 deg` posterior angle limit and both
  `260 deg/time` rate and `1650 deg/time^2` command limits, and exits with RMS
  force/moment `196/2014`.
- The assigned parent's direct body-turn-rate candidate preserves that anchor
  and subtracts a bounded `0.35` heading-rate term. Its sheet shows faster,
  longer upstream travel before the same upper-loop topology. Metrics confirm
  the useful part: head displacement improves from `-2.73L` to `-4.69L`,
  progress from `0.132` to `0.255`, mean distance from `10.65L` to `9.48L`,
  and score from `-12.76` to `-11.29`. It remains self-propelled relative to
  local flow (`-0.0878` mean head velocity versus `-0.0587` local flow).
  However, it exits sooner at `56.93`, misses the anchor's `6.34L` approach
  with a `7.30L` minimum, retains roughly `6.09L` maximum lateral target
  offset, and still reaches the posterior angle plus both rate/command caps;
  loads rise to `284/2797`. Thus direct turn-rate damping is promising for
  upstream authority but `0.35` does not arrest or desaturate the loop.
- The other sampled rate variants are negative boundaries. Subtracted
  `bearing_window_rate` exits at `53.53`, reaches only `7.90L`, and retains all
  saturations. The prefilled mixed `22 deg`/bearing-rate-lead controller exits
  with only `9.31L` closest approach and RMS loads `388/5262`; its nominal
  oscillator scale does not bound its observed anterior angle. Inherited logs
  add that a sign-preserving closing-bearing-rate brake, despite restoring the
  anchor gait, is swept `+2.28L` downstream, never improves on the initial
  `12.42L` distance, hits the same actuator limits, and exits after `19.10`.
  Target-bearing rate therefore must not be reused as a stronger brake.

## Candidate policy hypothesis

Restore the assigned parent's complete direct-heading-rate candidate and vary
only `turn_rate_damping` from `0.35` to `0.70`. The sampled gain can subtract
at most 35% of a saturated geometric bearing request, which explains why it
can improve upstream alignment while leaving a large persistent posterior
bend. Doubling that bounded coefficient lets actual body rotation reduce up to
70% of the request, but does not weaken the propulsion oscillator or react to
target-vector translation as the failed bearing-rate brakes did. Steering
remains posterior-only, and the heading-rate contribution remains smoothly
bounded before the existing steering and acceleration clamps.

This is a falsifiable next candidate, not a claimed CFD improvement. It should
retain negative upstream head velocity while lowering the lateral excursion
and posterior saturation enough to survive beyond `56.93` units, and ideally
beyond the anchor's `73.39`, while recovering a closest approach below
`7.30L`. If it instead loses upstream progress or repeats the inherited rapid
downstream escape, later workers should not increase turn damping again; they
should return to the `0.35` direct-heading-rate result and isolate static
posterior bias or the turn-rate sensitivity scale without bearing-rate input.
