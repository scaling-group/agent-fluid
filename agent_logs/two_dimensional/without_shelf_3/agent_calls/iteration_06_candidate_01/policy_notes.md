# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The assigned parent guidance identifies the guarded `0.75`-period,
  `22 deg` angle-only oscillator with bounded positive-bearing steering as the
  finite propulsion anchor, while requiring derivative/load additions to be
  judged against upstream progress, joint demand, and the visible exit route.
  The common prewarm sheet confirms that the four developed interacting wakes,
  upper-right release pose, and target are shared initial-condition evidence,
  not candidate effects. No sampled release enters the useful second-row wake
  corridor, so this decision remains a far-field course/stability test rather
  than a wake-capture claim.
- The strongest finite sample uses bearing gain `0.60`, a `12 deg` steering
  limit, and opposing recent-turn damping `0.04`. Its keyframes show active,
  nearly horizontal upstream travel before a broad upward U-turn and upper
  exit. Metrics corroborate both segments: head displacement
  `(-4.08,+1.80)L`, minimum range `6.71L`, progress `0.217`, and mean x
  velocity `-0.0673` versus local flow `-0.0457`, with finite RMS force/moment
  `66.5/958` over `65.47` released time. It is self-propelled but neither
  target-reaching nor yet inside the useful wake region.
- The current prefill added `0.02` damping only as distance fell through `8L`,
  leaving the far-field value at `0.04`. Its rollout is a direct negative
  result for that schedule: the released sheet turns upward sooner and exits
  without useful wake entry; upstream displacement falls to `-2.48L`, minimum
  range worsens to `8.59L`, progress falls to `0.114`, and duration falls to
  `53.97`. RMS force/moment `78.2/1119` and maximum joint demands remain close
  to the finite anchor, so the loss is course behavior rather than numerical
  instability or a new load event.
- The inherited uniform-`0.06` rollout supplies the complementary boundary.
  It initially descends toward the target and reaches the best available
  transient range, `5.41L`, but later sweeps through a large lower loop,
  reverses downstream, and exits after `81.91` time with head displacement
  `(+2.62,-7.92)L`, progress `-0.185`, and RMS force/moment `99.1/1356`.
  Thus `0.06` is not a globally valid cure, although its early approach is more
  useful than the current near-field boost. The inherited bearing-gain `0.45`
  variant is also negative: it retains the early upward turn while reducing
  upstream displacement to `-0.73L` and progress to `-0.007`, so proportional
  gain reduction should not be mixed into this yaw-schedule test.
- The target-blind seed remains the informative opposite failure: it moves
  left but is swept `-13.30L` laterally, with mean y velocity `-0.263` nearly
  matching local flow `-0.241` and both rate/action caps touched. Full-orbit
  radial regulation and bearing-window-rate feedback likewise lost propulsion
  or became unstable in inherited logs. Those mechanisms are excluded here.

## One candidate hypothesis

Keep every gait, bearing, guard, and smooth-action parameter of the strongest
finite sample. Reverse only the failed distance schedule: use opposing
recent-turn damping `0.06` while farther than roughly `8L`, then smoothly
relieve it to the demonstrated `0.04` as normalized target distance decreases.
This combines the uniform-`0.06` rollout's closer initial diagonal approach
with the lower damping that remained finite and self-propelled, while directly
testing the sign of the current prefill's harmful near-field increment. The
gate uses only `state.distance_L`; it encodes neither coordinates, target
identity, a route, a clock, prescribed inflow, remote probes, nor the omitted
research shelf. Every threshold and gain is policy-owned.

The next CFD rollout supports the hypothesis only if it preserves negative
head and relative-flow x, passes inside the `6.71L` prior minimum, retains a
moderate negative-y approach, and avoids both the anchor's upper U-turn and the
uniform-`0.06` lower loop without hard-cap or load growth. It is falsified if
far-field `0.06` already suppresses propulsion, if reducing damping near `8L`
still triggers either lateral exit, or if the response remains too sensitive
for distance scheduling to be trustworthy. No outcome for this unevaluated
candidate is claimed here.
