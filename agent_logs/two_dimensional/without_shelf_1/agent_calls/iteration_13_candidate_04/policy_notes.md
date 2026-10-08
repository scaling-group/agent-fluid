# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet shows the common held fish above and downstream of
four fully developed, interacting vortex streets; it is not already in the
second-row target corridor. All four released sheets show active upstream
swimming rather than passive advection, followed by a rising hook and upper
domain exit. The diagnostics confirm that this is a navigation failure rather
than collision or numerical instability.

The posterior phase-headroom boost is the strongest finite sampled result. It
moves the head `-11.33L` in x, versus a mean x velocity of `-0.171` and mean
local flow of only `-0.119`, reaches `3.03L`, and improves progress to `0.517`.
Visually it extends the closing leg much farther toward the second row before
curling upward. It does not fix the route: final head-y displacement remains
`+1.695L`, both joint rates and commands reach their caps, posterior angle
reaches `0.780 rad`, and RMS force/moment rise to `511/5305`. Thus its `0.35`
boost is useful closing-leg propulsion/approach allocation, not demonstrated
lateral steering.

The receding-distance reversal is the informative complementary failure. Its
`0.04` window-closing-speed scale and full `1.50` bearing reversal produce the
best sampled closest approach, `2.67L`, the longest survival, `73.85` release
units, a lower posterior peak of `0.713 rad`, and lower RMS force/moment of
`367/3880`. But the released sheet still ends in the same upper hook with
`+1.783L` head-y drift, while upstream travel/progress regress to
`-7.45L/0.405` and final distance grows to `7.39L`. The reversal therefore
changes transient approach without retaining the target route; closest
approach alone is not evidence that reversing all bearing authority is sound.

The remaining samples bound two tempting alternatives. The plain `11 deg`
anchor reaches `4.87L` with `-7.89L` x travel and `+1.792L` y drift. Adding
instantaneous yaw-moment rejection changes y drift only to `+1.674L`, worsens
closest approach to `4.99L`, and raises RMS loads to `439/4516`, while the same
upper exit remains visible. Together with the inherited phase, distance,
projection, bearing-rate, and lateral-velocity failures, this rules out
another unconditional attenuation or instantaneous load correction.

## Single candidate hypothesis

Use the `11 deg`, `25 deg`, `0.70/0.35` static anchor and the evidence-best
`0.35` opposing-phase headroom boost during target closing. Reuse the sampled
`0.04` normalized window-closing-speed scale, but when distance is increasing,
smoothly reduce the geometric bearing drive by at most `75%` instead of the
failed `150%` reversal. The anterior oscillator, posterior traveling-wave lag,
distance fade, body-rate term, and command limit remain unchanged. This makes
one staged policy: full approach authority while closing, followed by a
bounded receding-only release that never flips the requested steering sign.

The next CFD result supports the hypothesis only if it retains the
phase-boost result's upstream approach while improving its `3.03L` minimum or
preventing the upper hook, and if load/limit contact does not worsen. It is
falsified if the closing leg regresses toward the reversal sample, if the same
roughly `+1.7L` to `+1.8L` upper exit survives, or if switching between closing
and receding raises loads. In that case later workers should restore the plain
phase-boost anchor and avoid further memoryless receding-gain tuning unless a
filtered or persistent recovery state becomes available.
