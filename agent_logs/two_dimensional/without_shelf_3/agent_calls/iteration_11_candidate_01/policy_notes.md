# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The byte-identical shared prewarm sheets show the held fish above and
  downstream of the target while four developed cylinder streets convect
  through the target region. This is common initial-condition evidence, not a
  policy effect. Every released sheet inspected remains above and to the right
  of the target-centered wake corridor, so this candidate addresses far-field
  course retention rather than wake capture.
- The strongest finite sampled controller remains the guarded angle-only
  oscillator with bearing gain `0.60`, steering ceiling `12 deg`, and fixed
  opposing recent-turn gain `0.04`. Its sheet shows a genuinely propelled
  leftward leg followed by a sharp nose-up turn and upper exit: mean x
  velocity/local flow are `-0.0673/-0.0457`, head travel is
  `(-4.08,+1.80)L`, minimum range is `6.71L`, progress is `0.217`, and finite
  RMS force/moment are `66.5/958`. It does not enter the useful second-row wake
  corridor, but it is the only current low-load anchor that combines material
  upstream travel with a substantially closer approach.
- The sampled always-active body-lateral-velocity correction repeats the same
  upper-loop topology while cutting head-x travel to `-2.72L`, worsening
  minimum range to `8.20L`, and raising RMS force/moment to `78.6/1084`.
  Likewise, the high-authority `16 deg`/gain-`0.75` sample pitches upward
  earlier, reaches only `10.35L`, and raises loads to `350/5007`. These results
  reject another correction that modifies the demonstrated target-ahead leg
  from release.
- The assigned parent's now-evaluated range-opening attenuation is also a
  concrete negative result. Although intended to preserve the closing leg, its
  released sheet begins the familiar upper pitch and return, then exits with
  `(-2.27,+1.80)L` head travel. Minimum range worsens to `7.99L`, progress falls
  to `0.099`, and RMS force/moment rise to `117/1568` versus the anchor's
  `66.5/958`. Range opening alone therefore did not identify a safe terminal
  regime; the bounded attenuation altered the useful course without arresting
  the exit.
- Other inherited logs close nearby scalar alternatives. Fixed recent-turn
  gains `0.0375`, `0.0425`, `0.045`, and `0.05`, range-gated damping, `10/14
  deg` steering ceilings, lower bearing gain, and absolute-bearing rolloff all
  lose the anchor's approach or change only the return topology. A static
  anterior steering-allocation shift from `0.35` to `0.30` is negative too:
  it moves the head only `+0.07L` in x, reaches `9.82L`, has negative progress,
  and exits upward despite finite `64.8/1039` RMS force/moment. Thus neither
  another steering scalar nor static curvature reallocation is supported.

## Candidate hypothesis

Restore the strongest finite controller's gait, guards, curvature allocation,
`12 deg` ceiling, `0.60` bearing gain, and `0.04` recent-turn damping. Add one
bounded structural gate using the target's normalized body-frame forward
projection divided by range. While that cosine-like projection is positive,
the target-bearing term remains essentially identical to the anchor. As the
target crosses the fish's beam, smoothly reduce only bearing authority to zero
over a dimensionless width of `0.15`; retain the opposing `0.04` turn damping.
The released sheets show that the destructive event is a nose-up reorientation,
whereas range opening and lateral velocity can occur too early and failed as
regime selectors. Target-ahead versus target-behind geometry is a sharper,
coordinate-free test of whether the controller should keep accumulating mean
curvature or let measured turn damping straighten the course.

This is supported only if the rollout remains finite, retains approximately
the anchor's `-4.08L` upstream leg and `6.71L` closest approach, and delays or
removes the upper exit without materially raising joint extrema or loads. It is
falsified if the gate damages the target-ahead leg, the target never crosses
the beam before the upper turn, zero bearing authority merely freezes an
upward heading, either return persists, or closest range and loads worsen. The
gate is based only on normalized target-relative body geometry; it contains no
coordinate, route, clock, prescribed inflow, remote wake probe, target-station
signal, or omitted-shelf dependency. Its CFD result will be evaluated only
after this worker exits and is not claimed here.
