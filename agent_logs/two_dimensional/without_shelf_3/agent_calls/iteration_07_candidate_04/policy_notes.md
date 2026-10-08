# Multi-Wake Candidate Diagnosis and Hypothesis

## Visual and quantitative diagnosis

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four cylinder streets develop and overlap around the
  target. This is common initial-condition evidence, not a controller effect.
  Every sampled release remains well to the right of the useful cylinder-wake
  corridor, so this candidate addresses far-field course control while
  preserving demonstrated propulsion; it does not claim a wake-capture law.
- Uniform `0.04` opposing recent-turn-rate feedback remains the strongest
  finite anchor. Its released sheet shows a clean self-propelled upstream leg
  followed by a broad upper U-turn and top exit. The head moves
  `(-4.08,+1.80)L`, reaches `6.71L` range, and has mean x velocity `-0.0673`
  versus local flow `-0.0457`, while RMS force/moment stay at `66.5/958`.
  Thus the guarded angle-only gait produces upstream-relative motion, but the
  late course is too high.
- The current range-gated prefill raises damping from `0.04` toward `0.06`
  inside roughly `8L`. Its sheet repeats the upper loop earlier: it exits after
  `53.97` released time, moves only `(-2.48,+1.77)L`, and never gets closer
  than `8.59L`. Mean x velocity remains upstream of local flow
  (`-0.0491` versus `-0.0263`), but nearly unchanged joint extrema and RMS
  force/moment `78.2/1119` show that the distance gate neither improves course
  nor materially relieves actuation.
- The inherited parent supplies the decisive interpolation result. Uniform
  `0.05` damping initially turns from the upper-right release toward the wake
  flank and reaches `6.83L`, but its later keyframes show a downward U-turn and
  long lower-domain exit. The final head displacement is `(+0.33,-13.31)L`;
  mean y velocity `-0.142` nearly follows local flow `-0.150`, and mean x
  velocity `+0.0025` no longer preserves the anchor's upstream motion. Loads
  remain finite (`80.2/1317`), although joint-one rate reaches `4.48 rad/time`,
  close to the hard cap. This falsifies the prior claim that `0.05` is an
  untested safe interpolation.
- The inherited exact `0.06` result is consistent with that lower-course
  boundary: it briefly reached `5.41L` but reversed to
  `(+2.62,-7.92)L` and finished `14.73L` away. Together, the uniform results
  bracket a sharp course transition between `0.04` (upper exit with useful
  propulsion) and `0.05` (lower flow-following exit); damping at or above
  `0.05` within the tested `0.05--0.06` band, and the distance-gated
  escalation, are not supported.

## One candidate hypothesis

Restore the strongest finite controller exactly and change only its uniform
opposing recent-turn-rate gain from `0.04` to `0.045`. Remove the failed
distance gate and its three parameters. This is the midpoint of the newly
closed `0.04--0.05` course bracket, while the `0.75`-period angle-only gait,
gain-`0.60` bounded bearing request, `12 deg` steering limit, posterior lag,
local joint guards, and smooth `1600 deg/time^2` demand bound remain unchanged.
Every active constant remains owned by `target_policy_params`; the controller
uses only normalized target-relative bearing, recent turn rate, and joint
state, with no coordinates, clock, route, prescribed inflow, remote probes, or
omitted research shelf.

The next CFD rollout supports this candidate only if it remains finite and
self-propelled upstream while shifting net lateral travel below the anchor's
`+1.80L` upper-exit course, without approaching the uniform-`0.05` lower
reversal. Strong support would improve on or preserve the `6.71L` minimum range
without either boundary exit. It is falsified if upstream displacement
collapses, the fish repeats either U-turn, joint/action caps are touched, or
force and moment rise materially. No result is claimed for this unevaluated
candidate.
