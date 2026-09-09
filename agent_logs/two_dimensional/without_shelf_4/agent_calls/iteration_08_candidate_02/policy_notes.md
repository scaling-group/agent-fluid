# Multi-wake candidate diagnosis and hypothesis

## Evidence boundary and visual diagnosis

- The assigned parent is the evaluated `20.25 deg`, `0.67`-period phase-shell
  controller with `0.65/0.80` posterior lag/damping, `0.30` bearing scale,
  `0.25` bearing-rate lead, and an inactive `31.2 rad/time^2` guard. The four
  current solver examples have different non-semantic source hashes but
  byte-identical prewarm/released sheets and identical physical and scoring
  fields apart from wall time. Count them as one deterministic certified-
  prewarm result, not four wake-phase trials.
- The common prewarm sheet shows the fish held high and downstream/right while
  the four developed cylinder streets merge across the target corridor. In the
  released sheet, the parent makes a broad down/up approach on the right before
  straightening into the interacting wake and reaching the target nearly
  horizontally from the right. It is wake-assisted but not merely advected:
  mean head velocity x is `-0.04443` against mean local-flow x `-0.03649`, and
  mean relative-flow x is `+0.00793`. It captures at `244.547`, with mean/final
  distance `6.452/0.750L`, head travel `(-10.916,-4.187)L`, and no collision,
  domain exit, instability, approach rebound, or policy-guard contact.
- No current sampled rollout is a termination failure. The most informative
  inherited failure remains the assigned-parent `19 deg` horizon miss: it
  self-propelled upstream-left but ended at its `5.812L` minimum after all
  `300` release units, with only `-5.846L` head-x travel and weak reverse local
  flow (`-0.00682`). The evaluated `20` and `20.25 deg` captures establish a
  narrow corridor-acquisition threshold. With the current maximum anterior
  acceleration already `31.055 rad/time^2` against the `31.2` guard and
  `31.416` hard cap, more amplitude is not a supported remaining axis.
- Three available steering negatives bound a cleaner next test. At the
  `20 deg` gait, static bearing-scale sharpening `0.30 -> 0.28` retained
  capture but enlarged the lower excursion and worsened mean distance from
  `7.218L` to `8.112L`. At `20.25 deg`, softening scale toward `0.32` whenever
  rolling-window closing speed was positive also retained capture but delayed
  it from `244.547` to `256.663` and worsened mean distance to `7.394L`; its
  keyframes remain on a longer lower route even though head-x travel becomes
  more negative. Positive closing speed is therefore not a reliable gate for
  reducing bearing authority in this wake.
- The cleanest new one-axis negative changes only bearing-rate lead from
  `0.25` to `0.30`. Its sheet adds a large upper reversal before the lower
  sweep and wake entry, then captures only at `270.446`; mean distance rises to
  `8.499L`, score falls from `-4.439` to `-6.469`, and RMS lateral force rises
  from `18.263` to `18.958`. The anterior joint maxima are unchanged, while
  mean relative-flow x changes from `+0.00793` to `-0.00055` despite more
  favorable mean local-flow x (`-0.04086`). The regression is therefore an
  over-anticipated steering/topology effect, not loss of the propulsion shell
  or failure to encounter reverse flow.

## Candidate hypothesis

Preserve the complete evaluated propulsion and static-steering bundle and
change only bearing-rate lead from `0.25` to `0.20`. This is the symmetric
local contrast to the harmful `0.30` test. Because the rate input is already
clamped at `0.30 rad/time`, the change can alter predicted bearing by at most
`0.015 rad` (`0.86 deg`); large-error steering remains bounded by the same
`10 deg` posterior limit. Less anticipation should delay premature steering
unwind, remove the added upper reversal seen at `0.30`, and let the fish retain
controller-produced upstream transport while entering the same useful wake
corridor. It adds no observation, coordinate, route, target identity, or time
signal.

Under the certified prewarm, the next CFD evaluation should retain capture,
negative head-x transport, and an inactive acceleration guard while improving
release time or mean distance relative to `244.547` and `6.452L`, without
raising lateral force/moment. Falsify the hypothesis if capture is lost or
later, mean distance grows, a wider lower excursion replaces the upper
reversal, approach rebounds, or loads increase. If falsified, restore the
evaluated `0.25` lead; do not combine rate-lead changes with closing-speed
steering relief, static scale sharpening, or additional amplitude at this
period.
