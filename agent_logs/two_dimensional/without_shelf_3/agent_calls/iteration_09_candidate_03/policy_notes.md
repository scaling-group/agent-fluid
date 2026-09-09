# Multi-Wake Candidate Diagnosis and Hypothesis

## Visual and quantitative diagnosis

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four developed cylinder streets overlap around the
  target. This is identical initial-condition evidence, not a controller
  effect. All released policies remain to the right of the cylinder rows, so
  this candidate addresses far-field course retention rather than claiming
  wake capture.
- The strongest finite sample remains the guarded angle-only gait with a
  `12 deg` steering ceiling and `0.04` opposing recent-turn-rate gain. Its
  released sheet shows a sustained nearly horizontal upstream leg followed by
  a broad upper U-turn and boundary exit. Head travel is `(-4.08,+1.80)L`,
  minimum range is `6.71L`, and mean x velocity is more upstream than local
  flow (`-0.0673` versus `-0.0457`), so the early approach is actively
  propelled. RMS force/moment are finite at `66.5/958`, although anterior
  speed reaches `4.36 rad/time`; the joint guards and smooth acceleration
  bound therefore remain necessary.
- The informative higher-authority sample also exits upward, but travels only
  `-2.45L` upstream, never gets closer than `10.35L`, and raises RMS
  force/moment to `350/5007`. Its simultaneous `16 deg` ceiling, gain `0.75`,
  absent turn damping, and different guards are confounded, so it does not
  support removing damping outright or restoring higher steering authority.
- The assigned parent's now-evaluated `0.0425` midpoint preserves the same
  visible upper-loop topology but cuts upstream head travel to `-1.93L`,
  worsens minimum range to `8.42L`, reduces progress to `0.0758`, and raises
  RMS force/moment to `76.1/1065`. Together with inherited `0.045` travel of
  about `-0.15L` and the `0.05` lower return, this closes the proposed
  `0.04--0.045` interpolation: more damping does not arrest the turn.
- The other inherited rollout's `45 deg` large-bearing rolloff also repeats
  the upper exit. It moves only `-0.50L` upstream, reaches `10.20L`, has
  negative progress, and raises RMS force/moment to `81.4/1260`. Static
  large-bearing attenuation therefore removed useful far-field authority
  before it could prevent the late loop.

## One candidate hypothesis

Restore the strongest finite controller and change only its uniform opposing
recent-turn-rate gain from `0.04` to `0.0375`. The three controlled values
above the anchor (`0.0425`, `0.045`, and the approach-gated increase) all begin
the same upper loop earlier and lose upstream travel. A symmetric small step
below the anchor is an isolated test of whether `0.04` already over-damps the
progress-producing course. Keep the `0.60` bearing gain, `12 deg` ceiling,
`0.75`-period oscillator, posterior lag, steering allocation, local guards,
and smooth `1600 deg/time^2` demand bound unchanged.

The hypothesis is supported only if the fish remains finite, retains active
upstream motion, and improves on the anchor's `-4.08L` head-x travel or
`6.71L` minimum range while delaying its `65.47`-time upper exit. It is
falsified if the visible upper loop begins earlier, a lower return appears,
upstream travel collapses, joint/action caps are touched, or force/moment loads
rise materially. Every active constant is owned by `target_policy_params`, and
the policy uses only body-frame bearing, recent turn rate, and joint state; it
adds no coordinates, clock, route, prescribed inflow, remote probe, or omitted
research-shelf dependency. No result for this unevaluated candidate is claimed.
