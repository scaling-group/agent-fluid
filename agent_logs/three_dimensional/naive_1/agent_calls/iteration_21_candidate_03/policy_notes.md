# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. I
  inspected both the top-down vorticity and oblique body/Lambda2 rows for all
  four samples and cross-checked them against `wake_metrics.csv`,
  `wake_diagnostics.json`, trajectories, executable policy diffs, the assigned
  parent guidance, and inherited optimizer logs. This sampled batch contains
  no failure sheet, so the failure contrast below comes from inherited
  direct-uniform diagnostics rather than being relabeled as a current visual
  sample.
- Both executable policy classes are genuinely self-propelled. Their sheets
  develop a body-attached alternating top-down street that bends toward the
  target, and compact caudal Lambda2 structures remain visible through first
  crossing. The current sheets do not show a wake-regime difference; they show
  a subtle route-allocation difference within the same coherent wake class.
- The two common-envelope redistribution executions capture at
  `18.82649--18.88149T`, reproduce mean distance
  `2.088545--2.088964L`, and score between `-0.20106` and `-0.20041`. The two
  geometry-scheduled executions without that extra envelope term capture
  earlier at `18.65050--18.68350T`, with mean distance
  `2.093400--2.094046L` and scores between `-0.20606` and `-0.20578`. Thus the
  redistribution's small distance-integral benefit now repeats inside this
  batch, but neither faster arrival nor demand relief is established.
- The assigned guidance already rules out distance, forward-alignment, and
  response-release compounds around the redistribution: distance release
  exited left after reaching `2.2485L`, while alignment release captured but
  worsened mean distance to `2.09961L` without relieving actuator contact.
  Sampled inherited optimizer guidance adds an important robustness boundary:
  it reports a direct-uniform executable-equivalent redistribution rollout
  that missed at `0.81206L` and then exited left at `34.2320T`, despite an
  energetic top-down street, compact caudal structures, and no worse peak
  planar load. Its lower scalar integral is therefore repeatable in the
  current allocation, but capture robustness is not established across the
  inherited evaluator evidence.
- The geometry-scheduled carrier has the broader semantic record: the assigned
  parent reports three earlier captures at `18.6505--18.7550T`, and both
  current executable repeats also capture while preserving the same two-view
  wake. The inherited failure comparison also shows that coherent propulsion
  alone cannot rescue a poor allocation: posterior-specific redirect relief
  reached only `3.4260L` and exited left at `27.506T`.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and robotic-fish mean-curvature turning
source_mechanism: a posterior-lagged traveling bend with a bounded target-vector mean-curvature layer
transferable_invariant: preserve an organized traveling propulsive wave while normalized body-frame target geometry owns the persistent turn sign and mean curvature
nontransferable_details: published gains, frequencies, species-specific envelopes, robot duty ratios, clock phase, exact vortex phase, world-frame paths, and task-specific routes
policy_translation: remove only the semantically fragile common half-cycle envelope-relief redistribution; retain the evidenced geometry-scheduled common relief, target-signed anterior/posterior curvature shares, displacement-only half-cycle steering, one-sided correcting-yaw release, posterior lag, and final acceleration projection
falsification: reject this reliability ablation if it loses capture or either coherent wake row, leaves the established `18.6505--18.7550T` and `2.09340--2.09542L` carrier band, or materially worsens actuator contact or planar loads

## Single-candidate policy hypothesis

Produce exactly one reliability-focused architecture ablation from the
prefilled redistribution parent. Remove the parameter and expression that
redistribute common oscillator relief between displacement half-cycles, and
restore the evidenced geometry-scheduled common relief
`turn_amplitude_relief_fraction * abs(lateral_fraction)`. Preserve the
separate displacement-half-cycle mean-curvature steering mechanism and every
other carrier expression.

This is not scalar gain tuning: it removes one state-feedback allocation
compound whose current distance-integral benefit coexists with an inherited
executable-equivalent semantic failure. The candidate deliberately chooses
the policy topology with the larger completed capture record. Formal CFD runs
only after this worker exits; this rollout must be judged on capture and both
wake rows first, then against the established arrival, mean-distance, demand,
and load bands.

## Implementation and non-CFD validation

The candidate removes exactly one parameter-owned mechanism,
`half_cycle_relief_redistribution`, and restores the executable geometry-
scheduled carrier sampled in `solver_02eaf03fe1d2` and
`solver_8687829e1d01`. A Julia dry comparison over representative target,
joint, and yaw states confirms exact action and parameter equivalence to the
sampled carrier, finite outputs, reflection symmetry, and commands within the
owned `1800 deg/T^2` acceleration envelope.

The required check-runner passes all three final checks: the notes/guidance
provenance and material-change check, the exact lightweight Julia policy
contract, and the solver edit-boundary check. The provenance check initially
found the rendered `README.md` marked the same assigned parent twice; removing
only the redundant identical marker made parent resolution unique. No CFD was
run, and no outcome is claimed for this new candidate.
