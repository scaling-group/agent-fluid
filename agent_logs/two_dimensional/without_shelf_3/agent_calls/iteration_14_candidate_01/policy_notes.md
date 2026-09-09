# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held above and downstream of the target while the four staggered-cylinder
  streets develop through the target corridor. The current released sheets do
  not enter that corridor. All four show active diagonal leftward motion, then
  a sharp nose-up turn and upper-domain exit; the unresolved problem is still
  far-field course retention rather than wake exploitation or capture.
- The sampled `behind_bearing_fraction=-0.25` controller is the strongest
  finite rollout. Its mean x velocity is `-0.0627` versus local flow `-0.0454`,
  confirming self-propulsion rather than passive advection. It travels
  `(-4.44,+1.78)L`, reaches `6.63L`, has progress `0.241`, survives `74.48`
  release-time units, and retains finite RMS force/moment `76.8/1030`. Its
  keyframes nevertheless show the same upper return and no target-corridor
  entry.
- The otherwise matched zero-rearward-bearing sample is directionally worse:
  it travels `-4.36L` upstream, reaches `6.64L`, has progress `0.235`, and exits
  after `69.37` time. Keeping bearing active while adding `0.02` rearward turn
  damping, and combining bearing shutoff with that damping, both preserve the
  upper exit while worsening score, lifetime, and mean/final range. Thus the
  evaluated improvement belongs to modest opposite rearward bearing authority,
  not to extra terminal damping.
- The assigned parent's rearward overspeed-damping boost is a further negative
  result. It lowers the anterior speed maximum only from about `254` to
  `250 deg/time`, still shows the same upper pitch, shortens upstream travel to
  `-3.71L`, reduces progress to `0.194`, and worsens mean/final range to
  `9.94/10.01L`. Its lower RMS moment (`925`) does not compensate for loss of
  navigation. This rules out stacking another terminal damping or guard term
  on the current architecture.

## Candidate hypothesis

Restore the strongest sampled policy exactly while the target is ahead and
change only its smoothly gated behind-target bearing authority from `-0.25` to
`-0.50`. This is one equal-sized continuation of the only favorable local
comparison (`0` versus `-0.25`), while retaining the evaluated `0.5L` fore/aft
transition, oscillator, guards, fixed `0.04` turn damping, `12 deg` ceiling,
and `0.35/0.65` curvature allocation. Because the fore/aft gate gives unit
bearing authority on the demonstrated closing leg, the candidate should leave
that leg intact and supply stronger opposite curvature only after the target
passes abeam, where the compact bearing's absolute forward denominator is
aliased.

The hypothesis is supported only if the candidate remains finite, retains
about `-4.4L` upstream travel and a `6.6L` approach, and delays or removes the
upper return without raising joint/load extrema materially. It is falsified if
the useful leg shortens, the same upper exit persists, a lower return appears,
or the stronger rearward command saturates and raises loads. The negative
full-circle-bearing result in the inherited logs also bounds this test: do not
extrapolate to unrestricted bearing rewrites or stronger reversal unless this
single gated step improves terminal topology. The candidate uses normalized
body-frame target geometry and contains no coordinate, clock, route,
prescribed inflow, remote probe, target-station signal, or omitted-shelf
dependency. No same-worker CFD result is claimed.
