# Multi-wake candidate diagnosis

## Evidence boundary and visual diagnosis

- The assigned parent is the fresh-lineage guidance copied from
  `optimizer_a20a3b18a5ef`. I used its inherited optimizer notes, the four
  sampled solver evaluations, and the compact rollout evidence in this
  workspace. I did not consult the omitted shelf, neighboring configurations,
  repository history, MP4, or VTK fields.
- The shared prewarm sheet is common to all samples: before release, the fish
  is held above and downstream of the target while four developed vortex
  streets merge across the target corridor. It establishes the asymmetric
  initial wake but does not rank policies.
- The current prefill, `solver_f5cca4991f3d`, is the first sampled policy to
  remain finite for the full `300`-unit release. Its keyframes show an active
  gait, an early downward excursion with several course corrections, and then
  sustained leftward travel toward the target. It reaches the target's lateral
  level but remains upstream-distance limited at the horizon; there is no
  visible collision, passive downstream sweep, lower-boundary ejection, or
  numerical breakup.
- Metrics and JSON diagnostics support that reading. The head moves
  `(-5.846, -4.282)L`, while center displacement `-4.326L` in y nearly matches
  the initial `4.5L` center-to-target lateral offset. Final distance equals the
  best distance, `5.812L`, progress is `0.5322`, and mean distance is
  `9.4569L`, showing that the terminal state is continued approach rather than
  rebound. Mean fish velocity
  `(-0.01942, -0.01442)` is more upstream than mean local flow
  `(-0.00682, -0.01812)`, while mean relative y flow is only `-0.00370`; this
  is evidence of self-propelled upstream slip plus useful lateral correction.
- The surviving gait is energetic but not hard-cap defined. Its maximum
  anterior angle/rate/acceleration are `18.98 deg`, `178.27 deg/time`, and
  `1669.51 deg/time^2`, versus the `45/260/1800` envelope; posterior maxima are
  `24.30 deg`, `134.28 deg/time`, and `1260.10 deg/time^2`. RMS lateral force
  and moment, `17.92` and `352.44`, are also below the saturated seed's `21.94`
  and `541.70`.
- The failure samples bound the change. The target-blind seed does produce
  upstream displacement, but exact rate/acceleration cap contact accompanies
  a `-13.300L` vertical ejection and lower-domain exit after `50.13`. Conversely,
  the weaker target-aware samples are swept downstream or exit without
  sustained closure: `solver_09e7db9bb0ee` moves `+2.186L` in x and finishes
  at `14.301L`, while `solver_355c263e69c9` moves `+2.408L` in x and exits
  after `24.37`. The inherited optimizer notes anticipated this propulsion
  threshold and also show why steering must remain out of the anterior
  oscillator origin.

## Policy hypothesis

Preserve the current `0.67`-period, `19 deg` phase-space oscillator and the
bounded posterior-only bearing/rate steering, because they are the only sampled
combination that gives full-horizon survival, upstream slip, and correct
lateral placement. Increase posterior traveling-wave authority without moving
the anterior acceleration closer to its cap: raise `tail_lag_gain` from `0.65`
to `0.78` and reduce `tail_damping` from `0.80` to `0.72`. This moves only the
posterior phase/amplitude toward the propulsive seed while retaining the
current finite drive shell and steering sign.

A deterministic joint-only integration at the configured `0.0055` step over
the full `300` horizon is an envelope check, not CFD evidence. At zero bearing,
constant `0.15 rad` bearing, slowly varying `0.18 rad` bearing, and a wider
`0.35 rad` sweep, the proposed settings produced no angle, rate, or
acceleration cap contacts. Across those probes, maxima were `18.98/25.16 deg`,
`178.27/159.41 deg/time`, and `1669.51/1490.08 deg/time^2` for the two joints.

The falsifiable expectation is to retain full-horizon stability and the
current small final lateral error while making upstream displacement and final
distance materially better than `-5.846L` and `5.812L`. The posterior change
is rejected if it increases RMS moment/lateral force toward the seed, restores
a steep lower exit, causes cap contact, or worsens distance closure. Because
the two posterior parameters are coupled in this single candidate and the
evidence comes from one fixed wake realization, a later result can validate
the mechanism family but cannot separately attribute improvement to lag or
damping; a later single-axis comparison would be required for that.
