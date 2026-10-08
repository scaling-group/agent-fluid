# Multi-Wake Target-Policy Candidate Notes

## Inherited evidence diagnosis

- The shared prewarm sheet establishes a common developed four-cylinder wake
  and the same upper-right release pose. It is an initial condition, not a
  policy result.
- The target-blind seed is still the strongest finite trajectory. Its released
  sheet shows a vigorous traveling bend and a chain of self-shed vortices; it
  moves the head `-3.545L` upstream and survives `50.127` release-time units.
  It nevertheless curls into a near-vertical descent, reaches only `8.615L`
  minimum target distance, and exits at the lower margin after `-13.300L`
  vertical displacement. Its joint acceleration and velocity hit both hard
  caps, with command-energy mean `1496.247` and moment RMS `541.704`.
- Four completed first-generation policies moved body-frame target bearing
  into anterior/two-joint mean-curvature equilibria. Across the sampled and
  inherited results they all regress to the same distinct topology: only
  `16.731--18.106` release-time units, roughly `+2.17--2.20L` downstream
  center/head displacement, and exit at the downstream `23.2L` margin. Their
  mean velocity follows the local flow (`+0.1215--0.1315` versus local
  `+0.1299--0.1462`), while command-energy mean falls to `3.99--75.21` and
  maximum joint angles remain only about `12--20 deg`. The compact sheets show
  little active body-wave wake compared with the seed. Thus reduced clipping
  did not reveal useful steering; shifting the anterior oscillator equilibrium
  suppressed the propulsive transient needed to escape downstream advection.
- The best of those failures, the `0.85`-period split-curvature variant, lasts
  `18.106` and has the least-negative progress (`-0.1426`), but still moves
  `+2.172L` downstream and never approaches closer than its initial
  `12.424L`. This does not justify further equilibrium-bias gain tuning or an
  uncalibrated wake-rejection residual.

## Policy hypothesis

Preserve the seed's anterior state-feedback oscillator exactly so the next
rollout first tests whether its evidenced upstream thrust returns. Replace the
failed mean-curvature equilibrium with one target-dependent mechanism at the
posterior joint: body-frame bearing selects which half-cycle of the desired
total tail tangent is amplified. The base tail tangent remains the seed's
velocity-lagged traveling component; a smooth, bounded gain strengthens the
target-side half-cycle and weakens the opposite side without adding a static
anterior bend. The half-cycle phase is inferred from normalized joint state,
not time or an external vortex phase.

Expected evidence is seed-like active bending before the downstream margin,
negative/upstream x displacement, and then a target-sign turn that reduces the
seed's excessive downward trajectory. Falsify the transfer if the fish again
drifts to the downstream margin before a body wave develops, if positive
bearing produces the wrong turn, if the lower-boundary topology remains with
no better distance history, or if posterior asymmetry raises cap occupancy or
loads without changing the useful trajectory.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and the repository's free-swim half-cycle turn diagnostic
source_mechanism: target-error-selected asymmetric posterior flapping around a traveling-wave propulsion scaffold
transferable_invariant: directional error can steer rhythmic swimming by strengthening one observed tail half-cycle while retaining the underlying propulsive wave
nontransferable_details: published gains, robot and species kinematics, dimensional beat frequency, clocked phase, exact vortex phase, and any fixed route or cylinder coordinate
policy_translation: bound body-frame bearing, infer posterior beat side from the velocity-lagged tail-tangent target normalized by the owned gait amplitude, and smoothly scale opposite half-cycles while leaving the anterior seed oscillator unchanged
falsification: reject if upstream propulsion is not restored before downstream exit, the bearing-to-turn sign is wrong, closest approach does not improve over the seed, or tail clipping and loads increase without a useful trajectory change
