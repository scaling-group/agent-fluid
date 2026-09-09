# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four shared-prewarm sheets are byte-identical. They show the fish held
  high and downstream/right of the target while the four staggered cylinder
  streets develop and overlap through the target corridor. This establishes a
  common initial condition and cannot rank policies.
- All four current released sheets and physical metrics are also identical.
  The evaluated `20.25 deg`, `0.67`-period controller makes a pronounced
  right-side down/up loop, then enters the interacting central wake and closes
  almost horizontally on the target without collision, exit, rebound, or
  numerical breakup. It captures at `244.547`, with mean/final distance
  `6.452/0.750L`, head travel `(-10.916,-4.187)L`, and maximum lateral target
  offset `4.293L`. Thus the remaining visible inefficiency is the broad
  steering excursion before corridor retention, not failure to propel or
  acquire the wake.
- Flow and actuation diagnostics support that reading. Mean head velocity x is
  `-0.04443` against mean local-flow x `-0.03649`, so the route is wake-assisted
  but retains controller-produced upstream transport. Maximum anterior
  acceleration is `31.055 rad/time^2`, below the `31.2` policy guard and
  `31.416` episode cap; RMS lateral force/moment are finite at
  `18.263/362.214`. There is no supported amplitude margin for another shell
  increase.
- The assigned-parent and inherited optimizer notes supply the informative
  failure boundary absent from the current all-success sample: `14 deg` at
  `0.80` period was advected downstream and exited at `16.747`, while `19 deg`
  at `0.67` period self-propelled but missed at its `5.812L` minimum. The
  otherwise matched `20 deg` controller captured at `266.255` with mean
  distance `7.218L`; increasing only the shell to `20.25 deg` produced the
  current `244.547` capture and `6.452L` mean distance. This is a narrow
  corridor-acquisition threshold, not evidence that more drive is monotone.
- The clean inherited steering comparison is negative: changing only bearing
  scale from `0.30` to `0.28` at the successful `20 deg` gait made the visible
  down/up detour larger, worsened mean distance from `7.218L` to `8.112L`, and
  raised RMS lateral force from `18.262` to `18.583`, despite crossing only
  `3.36` time units earlier. Aggressive steering throughout the route is
  therefore not a supported way to shorten the initial loop.

## Candidate hypothesis

Keep the demonstrated `20.25 deg` propulsion shell, `0.67` period,
`0.65/0.80` posterior lag/damping, `10 deg` steering limit, `0.30` base bearing
scale, and `31.2 rad/time^2` guard. Add one bounded corridor-retention
mechanism using the normalized body-frame rolling-window closing speed already
provided by the task contract. When closing speed is nonpositive, preserve the
evaluated `0.30` response exactly. As positive closing rises to `0.05L/time`,
soften the effective bearing scale linearly to `0.32`; clamp the modulation at
both ends. The `0.05` normalization is the successful rollout's approximate
average closure, `(12.424-0.750)/244.547 = 0.0477L/time`, using the initial
distance recovered from its final-distance and progress metrics; `0.32` is the
symmetric local contrast to the harmful `0.28` sharpening.

This should retain strong recovery when stalled or receding and leave
large-error saturated steering nearly unchanged, while reducing moderate
bearing corrections once the wake is already carrying the fish toward the
target. The next fixed-prewarm CFD evaluation should preserve capture and
negative head-x travel while reducing the visible down/up excursion, mean
distance, RMS moment, or release time relative to the replicated `20.25 deg`
anchor. Falsify the mechanism if corridor acquisition is delayed or lost,
mean distance exceeds `6.452L`, capture is later than `244.547`, lateral
offset/load increases, or repeated closing-speed switching creates a new
zig-zag. In that case restore the fixed `0.30` scale and test a different
rolling-window corridor-retention signal; do not sharpen bearing gain or raise
amplitude at this period.
