# Multi-wake visual diagnosis and candidate hypothesis

## Evidence read before policy edits

- The certified prewarm sheet shows the common held fish above and downstream
  of the four-cylinder staggered array while all four vortex streets develop.
  It is an initial-condition control, not candidate-specific evidence.
- The released sheets show the same failure topology across the sampled
  posterior-only controllers: each fish self-propels left/upstream, passes
  above rather than through the useful second-row wake region, curls upward,
  and exits the upper domain without collision. This is not passive advection.
  Mean head velocity is upstream for every sample (`-0.109` to `-0.141` in
  normalized units), while mean local flow is also upstream but smaller in
  magnitude (`-0.075` to `-0.099`); the fish's mean relative-flow x remains
  positive (`0.034` to `0.042`).
- The best finite sample is the `11 deg` posterior-bias, direct-turn-rate
  `0.70/0.35` policy. It reaches `0.424` progress and `4.87L` minimum distance,
  travels `-7.89L` in head x, and scores `-8.91`. The otherwise matched
  `10 deg` policy reaches only `0.380`, `5.33L`, and `-6.93L` (`-9.53` score).
  Thus the extra degree improves useful propulsion/approach, even though it
  does not remove the loop.
- Raising turn-rate damping from `0.70` to `1.05` regresses progress to `0.369`
  and closest approach to `5.64L`; reducing bearing scale from `25` to `20 deg`
  regresses further to `0.310` and `5.77L`. Their keyframes retain the same
  upper curl. Those changes also do not desaturate the gait: all four samples
  hit about `0.669 rad` anterior angle, `4.538 rad/time` on both rates, and
  `28.798 rad/time^2` on both commands. Posterior peak angle remains
  `0.734--0.781 rad`, close to the `45 deg` hard limit.
- The best sample pays higher loads (`406/4113` RMS force/moment versus
  `325/3331` at `10 deg` and `315/3411` for the sharpened-bearing failure), so
  its scalar improvement does not establish that more static bias is safe.

## One candidate hypothesis

Use the sampled `11 deg`, `0.70/0.35` controller as the finite anchor and make
one structural repair: bound the posterior servo's desired joint angle below
the physical hard stop before computing acceleration. The current traveling
bend asks the posterior joint to realize the sum of phase lag, anterior-angle
cancellation, and steering bias; the observed posterior hard-stop contact and
both command/rate caps show that this desired target can be unreachable. A
`38 deg` desired-angle bound acts only when those terms reinforce, preserves
the oscillator and feasible portions of the traveling wave, and does not use
time, coordinates, wake probes, or a case-specific route.

The candidate is supported if it keeps upstream travel near the `11 deg`
anchor while lowering posterior peak angle/command effort and breaking or
delaying the upper curl enough to improve closest approach. It is falsified if
upstream displacement and progress collapse without reducing posterior
saturation, or if the same loop survives with no material load/effort relief;
later workers should then restore the unclipped `11 deg` anchor and test a
smooth phase-selective allocation rather than more turn-rate damping, sharper
bearing sensitivity, or another static-bias increase.
