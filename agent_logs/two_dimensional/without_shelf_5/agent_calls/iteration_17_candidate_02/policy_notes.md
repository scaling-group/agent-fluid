# Wake-policy candidate notes

## Evidence-first diagnosis

- The shared prewarm sheets are byte-identical across all four sampled solvers.
  They show the held fish above and downstream of four developed, interacting
  vortex streets, so the release flow is a common initial condition rather than
  candidate-specific evidence.
- The three uncapped samples are byte-identical policies and released sheets.
  They visibly self-propel diagonally left and down, turn toward the target,
  enter the combined wake region without collision or domain exit, and capture
  at `38.049`. Diagnostics agree: mean velocity is
  `(-0.2853,-0.1198)`, mean distance is `1.802L`, command energy/power are
  `52895/3965`, relative-crossflow RMS is `0.2249`, force/moment RMS are
  `42.01/653.13`, posterior excursion is `0.521` rad, and the episode-level
  hard posterior acceleration limit is touched at `31.416` rad/time².
- The distinct sampled policy changes only the posterior output bound to
  `1700 deg/time²`. Its sheet preserves the same safe, actively propelled
  diagonal topology and reaches the target sooner, at `34.331`, rather than
  being passively advected. Mean distance improves to `1.714L`, energy/power
  fall to `45153/3390`, mean velocity increases to
  `(-0.3164,-0.1322)`, posterior excursion falls to `0.509` rad, and its
  posterior acceleration maximum is the commanded `29.671` rad/time².
  The gain has a clear tradeoff: relative crossflow rises to `0.2312` and
  force/moment RMS rise to `54.48/766.14`.
- No sampled solver is a semantic failure. The lower-scoring uncapped capture
  is therefore the visual counterexample, while the assigned-parent guidance
  and inherited optimizer scores supply the failure boundary: damping and lag
  continuations were non-monotonic, and an inherited score-only step-16 result
  captured at `38.214/1.812L` with `40.03/630.70` force/moment RMS but does not
  materialize enough controller or visual evidence here to attribute that
  result to the acceleration-bound axis.

## Single-candidate hypothesis

Replicate the sampled `1700 deg/time²` posterior acceleration bound exactly,
with period, amplitude, oscillator drive, lag, damping, body-frame bearing law,
steering allocation, and observations unchanged. The hypothesis is that the
bounded posterior command is responsible for the earlier active traverse and
lower effort while preserving capture. This is a replication test, not a
monotonic tightening claim. It is falsified if the resulting evaluation misses
the visible diagonal route or capture, regresses beyond the uncapped
`38.049/1.802L` navigation anchor, fails to reproduce lower effort and
posterior excursion, or materially exceeds the sampled `0.2312` crossflow and
`54.48/766.14` force/moment envelope. No second controller axis is changed.
