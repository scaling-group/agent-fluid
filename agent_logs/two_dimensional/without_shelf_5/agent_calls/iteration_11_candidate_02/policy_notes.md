# Multi-Wake Policy Candidate Notes

## Evidence and visual diagnosis

- The sampled set contains four successful rollouts and no sampled failure
  keyframe sheet. The inherited failure evidence is therefore textual: the
  target-blind seed exited downward, and a slower mixed-feedback controller
  became unstable at release elapsed `2.807`. The visual comparison here uses
  the best finite sample against the most informative weaker finite sample.
- The common prewarm sheet shows the held fish at the upper-right start while
  four developed, interacting vortex streets extend downstream from the two
  staggered cylinder rows. This is shared initial-condition evidence, not a
  controller effect.
- With `tail_lag_gain=0.75`, the released sheet shows active self-propulsion:
  the fish makes a bounded diagonal descent from the upper right, turns toward
  the body-frame target bearing, crosses the developed wake without collision
  or domain exit, and reaches the target from its right side. The regular
  alternating body wake and large head displacement (`-10.913L`, `-4.349L`)
  rule out passive advection as the main transport mechanism.
- The replicated `tail_lag_gain=0.80` sheets show the same route topology and
  similarly productive lateral oscillation, with no visible precursor to
  collision or instability. Metrics resolve the small difference: `0.75`
  reaches at `38.049` rather than `38.362`, lowers mean distance from
  `1.812L` to `1.802L`, energy from `53487.3` to `52895.0`, and power from
  `4007.1` to `3965.3`. Its mean velocity magnitude is also larger in both
  route components (`-0.2853/-0.1198` versus `-0.2829/-0.1181`).
- The improvement is not a load reduction. Relative-crossflow RMS is nearly
  unchanged (`0.22494` versus `0.22437`), while force/moment RMS rise from
  `40.73/637.79` to `42.01/653.13`. Both cases reach the same rate and
  acceleration caps; posterior peak angle is effectively unchanged
  (`0.52081` rad), and anterior peak rises only from `0.49409` to `0.49638`
  rad. Thus the evidence supports a phase-response/navigation effect, not
  reduced actuation saturation or wake-load rejection.

## Candidate hypothesis

Keep the measured navigation anchor unchanged: the `0.55` period, 28-degree
oscillator, bearing gain `1.7`, 12-degree steering bound, and anterior steering
fraction `0.35`. Isolate one further equal tail-response step by reducing
`tail_lag_gain` from `0.75` to `0.70`. If the observed `0.80 -> 0.75` trend is
locally causal, `0.70` should preserve diagonal capture while reducing arrival
time, distance integral, and command effort again. The hypothesis is falsified
by loss of capture; arrival later than `38.049`; mean distance above `1.802L`;
energy above `52895`; or materially larger crossflow, force/moment, posterior
excursion, or cap-bound switching. One unevaluated candidate cannot establish
monotonicity or robustness beyond the certified wake phase and start pose.
