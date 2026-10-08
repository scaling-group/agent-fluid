# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of the
  target while the four staggered cylinders develop overlapping streets. It is
  the common initial condition, not a policy effect. Every released sheet
  inspected remains outside the target-centered second-row wake corridor, so
  the immediate control problem is still far-field course recovery.
- The best sampled finite policy is the guarded angle-only oscillator that
  preserves the anchor while the target is ahead and releases bearing authority
  over a `0.5L` fore/aft transition. Its sheet shows genuine upstream swimming,
  then a sharp nose-up turn and upper-domain exit. Metrics agree: mean x
  velocity/local flow are `-0.0678/-0.0477`, head travel is
  `(-4.36,+1.80)L`, minimum range is `6.64L`, progress is `0.235`, and finite
  RMS force/moment are `68.8/947`. It reaches `34.5 deg` anterior angle and the
  `260 deg/time` anterior speed cap, so the terminal bend is not a low-effort
  wake-carried drift.
- The assigned rearward-damping parent is nearly the same physical failure. It
  adds `0.02` recent-turn damping only after the target moves behind, yet its
  sheet also pitches upward and exits with `(-4.23,+1.80)L` head travel,
  `6.71L` minimum range, `0.226` progress, and RMS force/moment `66.7/957`.
  Its mean x velocity `-0.0687` also exceeds the local upstream flow magnitude
  `0.0475`. Thus both late fore/aft mechanisms preserve the useful approach but
  neither supplies a return toward the target.
- The sampled always-active lateral-velocity correction and range-gated damping
  variants activate during the closing leg and do worse: they reach only
  `8.20L` and `8.59L`, move `-2.72L` and `-2.48L` upstream, and still exit
  upward. Inherited normalized ahead-fraction gating is more destructive still,
  moving the head `+0.01L` in x, reaching only `9.63L`, and producing negative
  progress. These results rule out another always-active motion term or an
  angular/ratio gate that attenuates the demonstrated target-ahead law.
- The compact diagnostics report maximum lateral target offset near `6.09L`
  for both leading samples, consistent with the visible target becoming far
  off-axis during the upper turn. The supplied scalar bearing computes its
  denominator from `abs(forward_distance)`, so after a beam crossing it maps a
  target behind the fish back to an acute angle. Removing bearing or increasing
  damping in that late regime has now failed; the remaining isolated geometric
  test is to retain the direction of the full target vector instead of erasing
  its rearward component.

## Candidate hypothesis

Keep the best sampled gait, `0.60` steering gain, `12 deg` ceiling,
`0.35/0.65` allocation, fixed `0.04` recent-turn damping, joint guards, and
acceleration limiter. Replace only the aliased scalar bearing with
`atan(lateral_target_L, forward_target_L)`, the full-circle target-heading error
formed from the normalized body-frame target vector. For a target more than
`0.25L` ahead, this is exactly the existing bearing, so the demonstrated
closing leg is unchanged. At and behind the beam, it retains the rearward
quadrant and commands a bounded shortest-direction return instead of either
removing bearing authority or relying on extra damping to freeze an outward
heading.

This hypothesis is supported only if the rollout remains finite, retains about
`-4.2L` upstream head travel and a `6.7L` or better approach, then delays or
removes the upper exit without materially increasing the sampled joint extrema
or `69/957`-scale loads. It is falsified if the target never crosses the beam
before exit, the full-circle request merely tightens the same upper loop, a
lower full return appears, the dead-aft angle branch chatters, or anterior
speed again reaches the hard cap with larger loads. The change uses only
normalized body-frame target geometry and contains no coordinate, target
identity, clock, route, prescribed inflow, remote wake probe, target-station
signal, or omitted-shelf dependency. No same-worker CFD result is claimed.
