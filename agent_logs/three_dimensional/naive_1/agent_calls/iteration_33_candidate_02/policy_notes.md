# Wake-policy candidate notes

## Evidence diagnosis before edit

- All four sampled rollouts are valid direct-uniform still-water episodes
  (`U_infinity=(0,0,0)`) and terminate in capture. The three executable-identical
  redistribution policies span `18.6505--18.8815T`, mean distance
  `2.08855--2.09222L`, and score `-0.20418` to `-0.20041`; this is a repeatability
  band, not evidence for gain differences. The rearward-route-boost sample
  captures at `18.9640T` and mean distance `2.09072L`, inside the same route
  class, while inherited guidance says the target remains forward, so that
  extra channel is not evidence of recovery.
- In both the best and worst exact-policy sheets, the fish translates through
  quiescent water under its own actuation, turns smoothly toward the target,
  and sheds an energetic alternating top-down street. The oblique row shows
  compact caudal Lambda2 structures through approach. The distinct-policy
  sheet is visually in the same class. There is no advection, collision,
  domain-exit, or instability precursor in these samples; distance decreases
  to `0.7463--0.7494L` and the diagnostics mark every rollout stable.
- Those sampled captures do not resolve the inherited semantic contradiction:
  the same common-envelope redistribution executable has also missed at
  `0.81206L` and `1.25093L` before left exits, despite coherent wakes and finite
  loads. The assigned parent therefore identifies a clean return to the
  geometry-scheduled half-cycle carrier as the next robustness discriminator.
  Two inherited optimizer logs expose only capture scores (`-0.21262` and
  `-0.21054`) and cannot justify another recovery compound. The assigned
  parent's fuller log is directly relevant: its clean geometry-scheduled
  ablation is executable-equivalent to this candidate (only comments differ)
  and captures at `18.6395T`, minimum distance `0.74766L`, and mean distance
  `2.09383L`. Its inspected sheet retains the target-bending alternating street
  and compact caudal Lambda2 structures, but acceleration contact remains
  `60.81%/73.12%`, rate contact `11.09%/15.05%`, and peak planar force/moment
  remains `0.01537/0.02894` and `0.01656`. It supports capture compatibility,
  not actuator relief or cross-repeat robustness.

## One-candidate policy hypothesis

Remove only `half_cycle_relief_redistribution` and use the existing bounded
geometry-scheduled common amplitude relief on every beat half. Preserve the
joint-displacement half-cycle steering factor, target-owned turn sign,
non-inverting correcting-yaw release, posterior lag, and exact acceleration
projection. This is a mechanism ablation rather than scalar gain tuning.

Expected result: independently reproduce the now four-rollout
geometry-scheduled capture class (`18.6395--18.7550T`, mean distance
`2.09340--2.09542L`) with both coherent wake rows. The small distance-integral
sacrifice is acceptable only if independent evaluations stop reproducing
redistribution's rare route loss.
Falsify this candidate if it loses capture, either wake row, or the established
geometry-scheduled route band. Do not claim robustness from this unevaluated
worker output; CFD runs after handoff.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning control
source_mechanism: target-signed mean curvature with observed half-cycle asymmetry
transferable_invariant: preserve a bounded target-owned bend and modulate steering from observed joint displacement without a clock
nontransferable_details: published gains, species-specific kinematics, duty ratios, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame target curvature and displacement-only half-cycle steering while ablating only unsupported common-envelope relief redistribution
falsification: reject if capture, either coherent wake view, or the `2.09340--2.09542L` geometry-scheduled mean-distance band is lost
