# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the held fish above and downstream of the
  target while the four developed cylinder streets overlap around the target
  corridor. The sampled released sheets remain above and to the right of that
  corridor, so the unresolved control problem is far-field course retention,
  not wake exploitation or capture.
- The current rearward-damping prefill is genuinely self-propelled during its
  useful leg: mean x velocity is `-0.0687` versus mean local flow `-0.0475`,
  and its sheet shows a sustained leftward translation before the nose pitches
  sharply upward. It then returns toward the upper boundary without entering
  the useful wake region. The distance evidence agrees with that topology:
  head travel `(-4.23,+1.80)L`, minimum/final range `6.71/9.61L`, progress
  `0.226`, and release lifetime `65.66`. RMS force/moment remain finite at
  `66.7/957`.
- The strongest sampled score is the matched fore/aft bearing gate that keeps
  fixed `0.04` turn damping and reduces target-bearing authority to zero after
  the target moves behind. Relative to the prefill it lives longer (`69.37`),
  moves farther upstream (`-4.36L`), reaches a slightly smaller range
  (`6.64L`), improves mean/final range to `9.54/9.50L`, and raises progress to
  `0.235`, with similar RMS force/moment `68.8/947`. Its keyframes nevertheless
  show the same late nose-up return and upper exit; its anterior joint speed
  also reaches the `260 deg/time` cap. Bearing shutoff therefore preserves the
  approach better than adding rearward damping while leaving aliased bearing
  active, but it does not itself straighten the terminal heading.
- The more diagnostic early-active failures confirm why the useful leg must be
  untouched. Always-active lateral-velocity subtraction reaches only `8.20L`
  with `-2.72L` head-x travel, while distance-gated extra turn damping reaches
  only `8.59L` with `-2.48L` travel; both sheets pitch upward earlier and both
  raise loads. Inherited logs likewise report that short-window range-opening
  attenuation reaches only `7.99L` and raises RMS force/moment to `117/1568`.
  The signed fore/aft projection is the only sampled terminal selector that
  avoided this early-leg damage.

## Candidate hypothesis

Use the fore/aft gate as one bounded terminal mode rather than selecting a new
always-active signal. While the normalized target projection is ahead, retain
the sampled oscillator, guards, bearing gain, `12 deg` steering ceiling,
curvature allocation, and fixed `0.04` turn damping exactly. As the target
passes abeam, smoothly remove only the aliased bearing contribution over the
evaluated `0.5L` projection scale and simultaneously ramp in the evaluated
`0.02` rearward turn-damping boost. This is the missing factorial combination
of the two strongest sampled late-only policies: bearing shutoff removes the
term that keeps accumulating curvature after the target is behind, while the
extra damping supplies the straightening action that shutoff alone lacked.

The hypothesis is supported only if the rollout remains finite, retains about
`-4.2L` upstream travel and a `6.7L` or better approach, then delays or removes
the visible upper return without increasing joint/load extrema materially. It
is falsified if the fore/aft transition damages the target-ahead leg, the same
upper exit persists with no material metric gain, a lower return appears, or
joint-one again rides the speed cap. The candidate uses only normalized
body-frame target geometry and measured turn rate; it contains no coordinate,
clock, route, prescribed inflow, remote probe, target-station signal, or
omitted-shelf dependency. Its CFD result will be produced only after this
worker exits and is not claimed here.
