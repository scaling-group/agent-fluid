# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish above and downstream of the
  target while the four developed cylinder streets overlap around the target
  corridor. It is common initial-condition evidence, not a candidate effect.
  Every released sheet inspected remains above and to the right of that
  corridor, so the present control problem is still far-field course retention.
- The prefilled range-gated damping policy turns upward before a useful
  approach. Its released sheet ends in a tight nose-up bend and upper-domain
  exit after `53.97` time; metrics show only `-2.48L` head-x travel, `8.59L`
  minimum range, `0.114` progress, and RMS force/moment `78.2/1119`. Its
  `+1.77L` head-y exit with mean local y flow only `0.0068` is not explained by
  passive crossflow.
- The strongest sampled result uses the same guarded gait, `12 deg` ceiling,
  `0.60` bearing gain, and fixed `0.04` recent-turn damping, but keeps bearing
  authority essentially unchanged until the signed body-frame forward target
  projection crosses a narrow `0.5L` transition. It preserves genuine
  propulsion (`-4.36L` head x versus `-0.0477` mean local flow x), reaches
  `6.64L`, scores `-11.397`, and remains finite at RMS force/moment `68.8/947`.
  Its keyframes nevertheless show the same late nose-up turn; zero bearing
  authority behind the beam delays but does not arrest the upper exit
  (`+1.80L` head y after `69.37` time).
- The assigned-parent logs supply a useful scale contrast. A range-normalized
  ahead gate of width `0.15` attenuated the demonstrated target-ahead leg and
  produced almost no head-x travel (`+0.01L`), `9.63L` minimum range, negative
  progress, and score `-15.445`. Other inherited always-active corrections
  (range-gated damping, lateral-velocity damping, opening-range attenuation,
  and static curvature reallocation) also shortened the approach without
  changing the upper-exit topology. The supported boundary is therefore a
  signed forward-projection gate that saturates until near the beam, not
  another correction active from release.

## Candidate hypothesis

Restore the best sampled policy exactly while the target is ahead: the complete
guarded oscillator, curvature allocation, `12 deg` ceiling, `0.60` bearing gain,
fixed `0.04` recent-turn damping, and `0.5L` fore/aft transition remain
unchanged. Change only the limiting bearing authority after that transition
from zero to `-0.25`. Once the target is genuinely behind, this bounded
opposite bearing contribution actively unwinds the accumulated nose-up mean
curvature instead of leaving recent-turn damping to recover from an upward
heading by itself. Because the transition is based on the signed normalized
body-frame target projection, the added recovery is inactive throughout the
demonstrated closing leg and contains no coordinate, route, clock, prescribed
inflow, remote wake probe, target-station signal, or omitted-shelf dependency.

This is an isolated rearward countersteer test, not a claim of same-worker CFD
improvement. It is supported only if the candidate stays finite, retains about
`-4.36L` upstream travel and the `6.64L` closest approach, and delays or removes
the upper exit without materially increasing joint extrema or loads. It is
falsified if the fore/aft transition damages the early leg, countersteer starts
before the target is rearward, the same upper return persists, a lower return
appears, closest range worsens, or loads rise materially.
