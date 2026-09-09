# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, no prewarm, and capture
  termination. The three half-cycle envelope-redistribution samples are
  executable-identical. They capture at `18.6505--18.8815T`, with mean distance
  `2.08855--2.09222L`. The assigned broadside-reserve parent captures at
  `18.7055T`, but its mean distance is worse at `2.09386L`.
- The combined keyframe sheets show genuine self-propulsion in every sample:
  the top-down row develops an energetic alternating street that bends with
  the target-directed route, while the oblique row retains compact caudal
  Lambda2 structures through approach. There is no visual collision, passive
  advection, wake collapse, or instability before capture. The best
  redistribution repeat, the broadside parent, and the lowest-scoring
  redistribution repeat have the same useful wake topology; their scalar
  spread is primarily a route/integral distinction, not evidence that the
  parent's extra reserve improves propulsion.
- Demand and load histories do not rescue the reserve: redistribution contacts
  the acceleration limits on `60.85--61.00%`/`72.97--73.27%` and the rate
  limits on `11.03--11.07%`/`14.91--15.07%`; the parent is within that band at
  `60.84%`/`73.04%` and `10.91%`/`14.73%`. Its peak planar force and yaw moment
  are slightly higher (`0.01563/0.02916`, `0.01704`) than the best
  redistribution repeat (`0.01537/0.02803`, `0.01632`). Thus lower mean
  distance is the only evidenced selection signal, and actuator relief is not
  claimed.
- No inherited candidate-specific optimizer log exists in this workspace. The
  inherited experience bank already warns that broadside reserve and its
  arbitration compounds do not beat isolated redistribution and that coherent
  wakes alone cannot validate stacked steering channels.

## Candidate choice

Replace the broadside curvature reserve with the sampled common-envelope
half-cycle redistribution controller. Joint-1 displacement relative to the
target-signed bias is the observable beat phase. A positive common scale shifts
the existing geometry-owned amplitude-relief budget from the target-aligned
half-cycle to the opposed half-cycle while preserving mean-curvature shares,
posterior lag, and the non-inverting response-release gate. This is an
architectural mechanism selection, not a scalar-only gain edit. The expected
benefit is retention of capture and both coherent wake views with mean distance
inside the repeated `2.0886--2.0922L` band, instead of the reserve parent's
`2.09386L` result.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and elongated-body traveling-wave control
source_mechanism: allocate steering effort by the observed useful beat half while retaining posterior phase lag
transferable_invariant: preserve a directed posterior-lagged bend and bias effort toward the target-aligned half-cycle without a clock
nontransferable_details: published gains, species kinematics, dimensional frequencies, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: use normalized body-lateral target fraction for turn sign and joint-1 displacement for phase; apply one bounded positive redistribution factor to the common two-joint gait envelope while leaving mean curvature and posterior lag intact
falsification: reject if the later evaluation loses capture, either coherent wake row, or the 2.0886--2.0922L mean-distance band, or if actuator/load contact rises beyond the sampled redistribution range; one faster arrival alone is insufficient
