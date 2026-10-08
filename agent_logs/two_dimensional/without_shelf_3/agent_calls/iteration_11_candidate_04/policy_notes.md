# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The common prewarm sheet shows the held fish at the upper-right release pose
  while four developed cylinder streets overlap around the target. It is shared
  initial-condition evidence, not a controller effect. Every released sheet
  remains above and to the right of the target-centered wake corridor, so the
  present failure is far-field course retention rather than wake capture.
- The strongest finite sample is the guarded angle-only oscillator with
  bearing gain `0.60`, steering ceiling `12 deg`, and opposing recent-turn gain
  `0.04`. Its released sheet shows a sustained, nearly horizontal upstream leg
  followed by a sharp upper pitch and return. The diagnostics establish active
  propulsion: mean x velocity `-0.0673` is more upstream than mean local flow
  `-0.0457`, head travel is `(-4.08,+1.80)L`, minimum range is `6.71L`, and
  progress is `0.217`. RMS force/moment remain finite at `66.5/958`, although
  anterior speed reaches `4.36 rad/time`; retain its guards and smooth action
  bound.
- The prefilled always-active body-lateral-velocity subtraction, gain `0.35`
  capped at `2 deg`, repeats the upper exit and leaves head-y travel unchanged
  (`+1.803L` versus `+1.804L`). It cuts upstream travel to `-2.72L`, worsens
  closest range to `8.20L`, and raises RMS force/moment to `78.6/1084`. Lateral
  velocity therefore does not isolate the terminal turn, despite the anchor's
  near-zero mean local crossflow.
- The assigned parent's evaluated posterior allocation shift is a stronger
  negative result. Moving the anterior steering fraction from `0.35` to `0.30`
  leaves joint/action extrema and low loads broadly comparable, yet head-x
  travel becomes `+0.07L`, minimum range worsens to `9.82L`, and progress falls
  to `-0.063`. The sheet pitches upward before a useful leg. Total bounded
  curvature alone does not preserve propulsion or course when its joint
  allocation changes.
- Inherited opening-speed-only steering attenuation also fails to isolate a
  recoverable terminal phase. Scaling steering toward `0.35` whenever smoothed
  range opens still repeats the upper return, shortens head-x travel to
  `-2.27L`, reaches only `7.99L`, and raises RMS force/moment to `117/1568`.
  Together with evaluated `0.0375`, `0.0425`, `0.045`, `0.05`, range-gated
  damping increases, `10/14 deg` ceilings, and static bearing rolloff, this
  rules out another always-active scalar steering change and an opening gate
  without a late-range condition.

## One candidate hypothesis

Restore the strongest finite controller exactly during its demonstrated
closing leg. Add a smooth turn-damping boost of at most `0.02` only when two
target-relative observations agree that the terminal regime has begun: the
history-smoothed range is opening and distance is inside `7.25L`, just outside
the anchor's `6.71L` closest approach. The conjunction keeps the `0.04` anchor
law unchanged during the useful upstream approach, unlike the failed
opening-only attenuation and distance-only damping increase. Once the fish has
entered the late band and begun moving away, total recent-turn damping rises
toward `0.06` without changing bearing authority, curvature allocation, gait,
or joint protection.

The hypothesis is supported only if the rollout remains finite, preserves
approximately `-4.08L` upstream travel and the `6.71L` approach, then delays or
softens the visible upper return without materially increasing loads. It is
falsified if the gate disturbs the closing leg, the same upper or lower return
persists, minimum range worsens, hard joint/action caps are touched, or RMS
force/moment rise materially. The distance and opening gates are bounded and
body/target-relative. The policy adds no coordinate, clock, route, prescribed
inflow, remote wake probe, target-station flow, or omitted-shelf dependency.
Its CFD evaluation occurs after this worker exits, so no result for this
candidate is claimed here.
