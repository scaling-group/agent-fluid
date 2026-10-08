# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held above and downstream of the target while the four staggered cylinders
  establish overlapping vortex streets around the target corridor. The four
  released sheets remain well above/right of that corridor. They show a real
  leftward swimming leg followed by a sharp nose-up turn and upper-domain exit,
  so this candidate addresses far-field course recovery rather than claiming
  wake entry or capture.
- The strongest finite sampled result applies `-0.25` of the bearing gain after
  the normalized body-frame target projection becomes rearward, while retaining
  the evaluated `0.5L` fore/aft transition and the target-ahead controller.
  Against bearing shutoff, the opposite rearward term extends released life
  from `69.37` to `74.48`, improves head-x travel from `-4.36L` to `-4.44L`,
  progress from `0.235` to `0.241`, and mean/final range from `9.54/9.50L` to
  `9.45/9.43L`. Mean x velocity remains more upstream than local flow
  (`-0.0627` versus `-0.0454`), confirming self-propulsion rather than simple
  advection. Its anterior maximum also falls from `34.47 deg` and the
  `260 deg/time` cap to `34.31 deg` and `254.1 deg/time`.
- The improvement is limited. The best sheet still pitches almost vertically
  in its last two frames and exits above without entering the wake corridor;
  closest range changes slightly from `6.64L` to `6.63L`, while RMS
  force/moment increase from `68.8/947` to `76.8/1030`. Thus `-0.25` is
  evidence for late opposing bearing as an active straightening direction,
  not evidence of capture or a monotone unlimited gain response.
- The assigned rearward-damping prefill and the sampled factorial combination
  provide useful negative controls. Keeping aliased bearing active while
  adding `0.02` damping after the beam exits after `65.66` time with
  `-4.23L` head-x travel and `6.71L` minimum range. Removing bearing while
  adding the same damping still repeats the upper exit, shortens head-x travel
  to `-4.15L`, and worsens progress to `0.222` relative to bearing shutoff.
  Together with inherited logs for early-active motion and short-window range
  gates, this supports changing only rearward bearing authority rather than
  adding damping or modifying the demonstrated approach gait.

## Candidate hypothesis

Start from the best sampled `-0.25` fore/aft-gated policy and change only
`behind_bearing_fraction` to `-0.50`. While the target is ahead, the smooth gate
still recovers the same `0.60` bearing gain, fixed `0.04` recent-turn damping,
`12 deg` steering ceiling, `0.35/0.65` allocation, oscillator, guards, and
acceleration limiter. Once the target is rearward, the stronger bounded
opposite bearing contribution should continue the measured reduction in
terminal anterior angle/rate and delay or arrest the visible upper pitch. The
steering command remains bounded by the existing ceiling.

The test is supported only if it remains finite, retains roughly `-4.4L`
upstream head travel and a `6.7L` or better approach, and materially delays the
upper exit or returns toward the target without riding a joint cap or raising
loads beyond the sampled `77/1030` scale. It is falsified if the transition
damages the target-ahead leg, merely tightens the upper loop, creates a lower
full return, worsens closest range, or increases joint/load extrema. The policy
uses only normalized body-frame target geometry and existing joint/turn state;
it contains no coordinate, target identity, clock, route, prescribed inflow,
remote probe, target-station signal, or omitted-shelf dependency. No same-worker
CFD result is claimed.
