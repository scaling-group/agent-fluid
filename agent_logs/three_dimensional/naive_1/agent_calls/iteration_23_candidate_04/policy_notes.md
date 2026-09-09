# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four assigned examples satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and
  `termination=capture`. I inspected both the top-down vorticity and oblique
  body/Lambda2 rows for the best-scoring `solver_649d7e789a5a`, the weaker
  geometry-scheduled capture `solver_02eaf03fe1d2`, and the inherited
  posterior-relief failure `solver_d293f2bce584`, then cross-checked the
  visible routes against scores, diagnostics, trajectories, executable policy
  diffs, the assigned-parent guidance, and inherited optimizer notes.
- The two executable-identical common-envelope redistribution samples
  (`solver_649d7e789a5a` and `solver_d2a3f8408b10`) show genuine
  self-propulsion in both views: a body-attached alternating top-down street
  bends toward the target, and compact paired caudal Lambda2 structures
  persist through capture. They reproduce mean distance
  `2.088545--2.088964L`, score `-0.200406-- -0.201056`, and capture at
  `18.82649--18.88149T`. Their anterior/posterior acceleration contact
  (`60.85--61.00%`/`72.97--73.27%`) and rate contact
  (`11.04--11.07%`/`14.88--14.93%`) overlap, so this is route replication,
  not demand relief.
- The geometry-scheduled comparison also has a coherent two-view wake and
  captures earlier at `18.65050T`, but its mean distance is worse at
  `2.093400L`. The assigned prefill's rearward-route multiplier captures at
  `18.96399T` and `2.090724L`, but inherited reconstruction shows normalized
  forward target fraction remains positive on every row (`0.35412--1.0`), so
  its new branch never activates. Its outcome cannot support post-overshoot
  recovery and its scalar difference is within ordinary rollout variation.
- The newest inherited parent result closes the proposed posterior-demand
  direction. Mildly attenuating only the zero-mean posterior
  displacement-plus-lag wave during redirect preserves an energetic
  alternating top-down wake and compact caudal Lambda2 structures, but the
  route bends below and away from the target, reaches only `3.924760L`, and
  exits left at `26.21302T` with final distance `6.740994L` and score
  `-8.245975`. Together with the earlier posterior-enhancement failure at
  `3.1465L`, this rejects posterior-specific wave allocation in either
  direction around this carrier; wake coherence is not route correctness.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and closed-loop robotic-fish mean-curvature turning
source_mechanism: retain a lagged posterior propulsive wave while normalized target geometry owns bounded mean curvature
transferable_invariant: preserve the evidenced anterior steering rhythm, posterior lag, and target-signed curvature as one organized traveling-bend carrier
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, robot duty ratios, clock phase, exact vortex phase, world-frame paths, and task-specific routes
policy_translation: remove the prefill's inactive rearward multiplier and retain the exact twice-captured body-frame half-cycle redistribution carrier, including both curvature shares, displacement-only phase, response release, posterior lag, and acceleration projection
falsification: reject the carrier as the current reproducible frontier if another execution loses capture or either coherent wake row, or if mean distance leaves `2.088545--2.088964L` by more than established rollout variation

## Single-candidate policy hypothesis

Produce exactly one exploitation candidate by replacing the assigned prefill
with the exact executable policy shared by `solver_649d7e789a5a` and
`solver_d2a3f8408b10`. Remove only parameter-owned
`rearward_route_boost` and its forward/rearward geometry branch; restore
`route_request = tanh(lateral_fraction / target_lateral_scale)`. Preserve the
replicated common half-cycle envelope redistribution, target-signed
anterior/posterior mean curvature, displacement-only phase steering,
one-sided correcting-yaw response release, posterior lag, and exact final
acceleration projection.

This is an evidence-backed architecture selection, not scalar-only gain
tuning or a claim that the dormant branch caused the prefill's score. The
formal CFD result occurs only after this worker exits. It should be judged
first on capture and both wake rows, then on reproduction of the established
mean-distance, arrival, demand, and load bands.
