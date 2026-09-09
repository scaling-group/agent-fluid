# Wake-policy candidate diagnosis

## Evidence read before editing

The shared prewarm sheet shows the fish held above and downstream of the target
while four developed, interacting vortex streets fill the route. All sampled
released sheets start from that same state. They also show a common topology:
the fish self-propels leftward toward the target and into disturbed flow, then
turns through a broad upper hook and leaves the top boundary. This is genuine
propulsion rather than passive drift: head displacement is `-7.45L` to
`-11.33L` while the target lies upstream, and the policies remain finite for
`57.93` to `73.85` release units. The lateral oscillation is productive for
propulsion until the final turn; the terminal curvature, not lack of leftward
motion, is the immediate precursor to every domain exit.

The plain `11 deg` posterior-bias anchor reaches only `4.87L`. Adding normalized
yaw-moment rejection also misses at `4.99L`, increases RMS force/moment from
`406/4113` to `439/4516`, and leaves the same upper exit, so moment feedback is
not retained. Phase-opposition boost is the strongest finite route anchor: it
moves the head `-11.33L`, improves mean/final distance to `6.44L/6.00L` and
progress to `0.517`, and approaches within `3.03L`, although it raises RMS
force/moment to `511/5305` and still hooks upward. The assigned receding-speed
parent is worse in score, mean distance, progress, and upstream travel, but its
`2.67L` closest approach is the best sampled result. It also reduces maximum
posterior angle from about `0.78` to `0.713 rad` and RMS force/moment to
`367/3880`, despite retaining both rate and acceleration-cap hits. Its visual
sheet shows that this closer pass is not capture: the fish still turns upward
and exits.

## Candidate hypothesis

Use the phase-opposition controller exactly as the far-field anchor, then gate
the parent's bounded receding-distance bearing reversal by target distance. A
smooth gate starts below `4L` and reaches full authority by `3L`; therefore
temporary far-field increases in distance cannot erase the phase-opposition
policy's demonstrated upstream progress, while the reversal is available in
the only region where its sampled `2.67L` approach and lower posterior excursion
are useful. Steering remains posterior-only, normalized, target-relative, and
bounded, with no time, global-coordinate, target-identity, or route encoding.

This hypothesis is supported only as a mechanism composition, not as a claimed
new CFD result. It is falsified if evaluation loses the phase-opposition
anchor's upstream travel/mean distance before reaching `4L`, fails to improve
on its `3.03L` closest approach, or retains the upper exit without a meaningful
reduction in posterior excursion or force/moment load.
