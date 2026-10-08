# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish high and downstream of the
  target while the four cylinder streets develop and overlap around the
  target corridor. This sheet is the certified common initial condition, not
  evidence for a candidate effect.
- All four sampled release sheets and metrics show the same unresolved
  far-field topology. The fish generates a body wave and a genuine upstream
  leg, then bends nose-up and leaves through the upper boundary before entering
  the useful wake corridor. In the strongest finite sample, mean head velocity
  x is `-0.0627` versus local flow x `-0.0454`, while mean head velocity y is
  `+0.0161` versus local flow y `+0.0042`; the approach and destructive upward
  turn therefore are not passive advection. Its `6.63L` closest range remains
  far outside the `0.75L` capture radius.
- The clean signed-geometry ablation favors bounded rearward countersteer over
  either releasing rearward bearing authority or adding rearward damping.
  Holding the target-ahead gait, guards, `12 deg` ceiling, `0.60` bearing gain,
  `0.04` recent-turn damping, and `0.5L` fore/aft transition fixed, changing
  behind-beam bearing authority from `0.0` to `-0.25` extends released lifetime
  from `69.37` to `74.48`, head-x travel from `-4.36L` to `-4.44L`, progress
  from `0.235` to `0.241`, and mean/final range from `9.54/9.50L` to
  `9.45/9.43L`. It also keeps anterior speed below the `260 deg/time` hard cap
  (`254.1 deg/time`), although RMS force/moment rise from `68.8/947` to
  `76.8/1030`.
- The countersteer result is directional evidence, not a solved controller:
  its keyframes still end in a nearly vertical upper exit and its closest
  range (`6.63L`) is effectively unchanged. The current rearward-damping-only
  prefill exits after `65.66` with `-4.23L` head-x travel and `0.226` progress.
  Combining zero rearward bearing with the same `0.02` damping boost is worse
  again (`67.24`, `-4.15L`, `0.222`) despite a transient `6.57L` closest range;
  its worse `9.67L` final range confirms that minimum distance alone rewards
  an unrecovered pass.
- Inherited optimizer notes already falsify changes active during the useful
  target-ahead leg: lateral-velocity feedback, range-opening attenuation,
  absolute-bearing rolloff, static curvature reallocation, steering-ceiling
  changes, and nearby fixed damping gains all shorten the upstream approach or
  preserve the same exit. They also establish the `0.5L` signed fore/aft gate
  as safer than an early range-normalized gate. No omitted shelf or neighboring
  configuration is used here.

## Candidate hypothesis

Start from the strongest finite sampled policy and change only
`behind_bearing_fraction` from `-0.25` to `-0.50`. The complete target-ahead
controller remains identical, so the demonstrated propelled approach is
protected until the signed body-frame target projection crosses the existing
`0.5L` transition. Once the target is genuinely rearward, half-strength
opposite bearing authority should unwind the still-visible nose-up curvature
more decisively than `-0.25`, while the unchanged `12 deg` smooth ceiling keeps
the recovery bounded.

This is an isolated continuation of the only favorable sampled rearward
direction, not a claim of same-worker CFD improvement. It is supported only if
the candidate remains finite, preserves at least the `-4.44L` upstream leg and
roughly `6.63L` closest approach, exceeds the `74.48` released lifetime or
removes the upper exit, and does not materially raise the `76.8/1030` RMS
force/moment loads. It is falsified if stronger reversal merely repeats the
upper exit, creates a lower return, worsens closest/mean range, restores speed
cap contact, or increases loads without additional approach. The gate uses
only normalized target-relative body geometry and contains no coordinate,
target identity, route, clock, prescribed inflow, remote wake probe, or
target-station signal.
