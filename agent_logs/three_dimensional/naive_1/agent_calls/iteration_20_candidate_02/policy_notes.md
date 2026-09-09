# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite moving-window transport, and capture. I inspected both
  the top-down vorticity and oblique body/Lambda2 rows for the best-scoring
  `solver_649d7e789a5a` and the lowest-scoring sampled capture
  `solver_6237b046a5e7`, then cross-checked the visual comparison against
  `wake_metrics.csv`, `wake_diagnostics.json`, trajectories, executable policy
  hashes, assigned-parent guidance, and inherited optimizer logs.
- Both sampled sheets show genuine self-propulsion: body-attached alternating
  vorticity develops into a coherent target-bending street, while compact
  caudal Lambda2 structures persist through capture. The sheets do not show a
  wake-topology difference that explains their scalar spread. Three sampled
  policies are baseline/comment-level replications; the fourth is the common
  displacement-half-cycle envelope redistribution.
- The redistribution sample is the only executable sampled mechanism with a
  measured benefit. It lowers mean distance to `2.088545L` and improves score
  to `-0.200406`, versus `2.093400--2.095423L` and scores from `-0.207435` to
  `-0.205783` for the three comparison captures. It captures later
  at `18.82649T` versus `18.65050--18.75500T`, so the evidence supports better
  far/middle progress, not faster arrival. Its anterior/posterior acceleration
  contacts (`60.85%/73.27%`) and rate contacts (`11.07%/14.93%`) remain inside
  the comparison bands; it is not demand relief.
- The inherited release experiments bound the next choice. Releasing the
  redistribution by distance lost capture, reached only `2.24855L`, and exited
  left. Releasing it by normalized forward alignment recovered the coherent
  two-view wake and capture at `18.78799T`, but mean distance worsened to
  `2.099614L`, score to `-0.211534`, and acceleration/rate contact stayed in
  the same band. Do not stack another approach-release gate on this evidence.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric flapping
source_mechanism: sensor-modulated half-cycle amplitude or duty redistribution for turning
transferable_invariant: redistribute a bounded common rhythmic envelope between observed displacement half-cycles while preserving the traveling wave and target-owned mean curvature
nontransferable_details: published gains, clock phase, robot geometry, species-specific kinematics, duty ratios, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: start from the captured geometry-scheduled carrier and redistribute only its existing common amplitude relief with normalized body-frame target side and anterior joint displacement; preserve both curvature shares, posterior lag, response release, and acceleration projection
falsification: reject the mechanism as a one-run fluctuation if a repeat loses capture or either coherent wake row, fails to retain mean distance below the `2.093400--2.095423L` comparison band, repeats the inherited left-exit topology, or worsens the established demand/load boundary

## Single-candidate policy hypothesis

Replace the prefilled baseline carrier with the exact evaluated common
half-cycle redistribution architecture from `solver_649d7e789a5a`. Add the
parameter-owned `half_cycle_relief_redistribution=0.50`; use observed anterior
displacement phase to apply less of the existing common rhythmic relief on the
target-aligned half and more on the opposed half. Keep the average
geometry-owned relief, differential target-signed curvature, displacement-only
phase, one-sided correcting-yaw release, posterior lag, and final acceleration
projection unchanged.

This is an exploitation-and-replication candidate, not a scalar-only retune or
an untested compound. Its formal CFD result will determine whether the single
best sampled route is reproducible. Accept it as reusable only if it retains
capture and both coherent wake rows while reproducing the lower mean-distance
band; otherwise treat the sampled score advantage as rollout variability.
