# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The four sampled solver examples contain byte-identical prewarm and release
  keyframe sheets and the same physical metrics, although comments in their
  policy sources differ. They are therefore one effective rollout sample, not
  four independent confirmations. It is both the best finite sample and the
  informative failure available in the current evidence.
- The shared prewarm sheet shows the held fish above and far downstream of four
  developed, interacting cylinder streets, with the target in the second-row
  wake corridor. After release, the fish visibly drives leftward toward the
  target but remains outside the useful near-target wake region, pitches into a
  large nose-up return after its closest approach, and exits the upper boundary.
- The diagnostics support active but insufficient propulsion rather than mere
  advection: over `70.14` released time the head moves `-4.676L` in x while
  mean x velocity/local flow are `-0.0708/-0.0494`; progress is `0.254` and the
  minimum range is `6.609L`. The return then leaves a `9.266L` final range and
  `+1.798L` head-y displacement. RMS relative crossflow is `0.204`, while
  finite RMS force/moment are `75.6/985`; the failure is a domain exit, not a
  collision or instability.
- The current dual-opening terminal allocation reaches about `33.23 deg` and
  `251.35 deg/time` on the anterior joint with acceleration near the
  `1600 deg/time^2` soft limit. Sampled optimizer guidance and inherited logs
  bracket its gated anterior/posterior `0.10/0.65` allocation: full anterior
  unload and posterior fractions `0.55` or `0.75` all worsen navigation while
  preserving the same `6.609L` closest range and nose-up exit. Allocation
  interpolation is therefore exhausted as a recovery mechanism.
- The inherited optimizer logs close two proposed continuations that are not
  yet distilled in the assigned parent. Terminal-gated anterior speed
  protection worsens score to `-11.259`, head-x travel to `-4.531L`,
  mean/final range to `9.430/9.380L`, and progress to `0.245`, while preserving
  the `6.609L` closest range and upper exit. The strict dual-opening-gated
  body-lateral-velocity subtraction was also evaluated: it worsens score to
  `-11.177`, head-x travel to `-4.637L`, mean/final range to `9.365/9.295L`,
  and progress to `0.252`, with essentially unchanged RMS force/moment
  (`75.6/984`) and the same `+1.798L` terminal rise. Thus neither actuator-state
  clipping nor lateral-motion feedback changes the return, even when inactive
  on the closing leg.

## Single policy hypothesis

Preserve the evaluated oscillator, rearward bearing law, joint guards,
`12 deg` steering ceiling, and relative `0.10/0.65` terminal allocation. Add no
new motion or actuator-state feedback. Instead, multiply the already saturated
steering bias by a recovery scale that remains exactly `1` until the existing
rearward-plus-dual-opening gate activates, then rolls total mean-curvature
authority toward the previously sampled `0.25` residual scale. This isolates
the selector from the earlier absolute-bearing rolloff that damaged the
closing leg: both joint biases retain their locally bracketed ratio, while the
terminal controller stops sustaining a large target-induced turn after range
has begun persistently opening. The symmetric oscillator and fixed turn
damping remain active to carry propulsion and dissipate the existing turn.

Falsify the mechanism if it loses roughly `-4.68L` upstream head travel,
worsens the `6.61L` closest approach, raises force/moment above the anchor, or
repeats a boundary return without improving mean/final range or lifetime. A
positive result requires topology and distance evidence, not merely a lower
joint peak or a transient scalar-score change. A lower return would also
falsify the hypothesis rather than count as course recovery.
