# Wake-policy candidate notes

## Evidence diagnosis before edit

- All four sampled rollouts satisfy direct uniform still-water initialization
  (`U_infinity=(0,0,0)`) and terminate in capture. The three
  executable-identical common-envelope redistribution policies capture at
  `18.6505--18.8815T`, score `-0.20418` to `-0.20041`, and finish at
  `0.74630--0.74928L`. The distinct rearward-boost policy captures at
  `18.9640T` and `0.74945L`; inherited trajectory evidence says its target
  remains forward, so the added branch is not evidence of route recovery.
- The highest-score exact-policy sheet and the distinct-policy sheet show the
  same control class in both required views. The fish translates under its own
  actuation rather than advection, turns smoothly toward the target, and sheds
  a coherent alternating top-down street. The oblique row retains compact
  caudal Lambda2 structures from release through approach. Distance progress
  and stable capture agree with the visuals; there is no collision, exit, or
  instability precursor. No sampled failure sheet exists in this workspace,
  so the visual comparison cannot erase the assigned parent's inherited
  executable-equivalent redistribution misses at `0.81206L` and `1.25093L`
  followed by left exits.
- The assigned parent and its inherited optimizer log provide the relevant
  discriminator. A clean geometry-scheduled policy, differing from the
  redistribution carrier only by removal of phase-dependent amplitude relief,
  captures at `18.6395T`, mean distance `2.09383L`, minimum distance
  `0.74766L`, and score `-0.211377`. Its inspected top-down and oblique rows
  retain the same useful wake class. Acceleration contact
  (`60.81%/73.12%`), rate contact (`11.09%/15.05%`), and peak planar
  force/moment (`0.01537/0.02894`, `0.01656`) show capture compatibility but
  no demand relief. The other inherited optimizer records expose only capture
  scores, so they cannot justify another conditional recovery mechanism.

## One-candidate policy hypothesis

Remove only `half_cycle_relief_redistribution` and apply the existing bounded
target-geometry amplitude relief equally on both observed beat halves. Preserve
target-owned turn sign, displacement-only half-cycle steering, the
non-inverting correcting-yaw release, posterior lag, and final acceleration
projection. This is a feedback-architecture ablation and an independent
replication of the clean carrier, not scalar-only gain tuning.

Expected result: retain capture and both coherent wake rows in the established
geometry-scheduled class (`18.6395--18.7550T`, mean distance
`2.09340--2.09542L`). The slightly worse scalar/distance-integral class is
acceptable only if independent completed evaluations distinguish it from
redistribution's rare route loss. This worker's CFD runs after handoff, so no
new robustness or performance result is claimed here.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning control
source_mechanism: target-signed mean curvature with observed half-cycle asymmetry
transferable_invariant: preserve a bounded target-owned bend and modulate steering from observed joint displacement without a clock
nontransferable_details: published gains, species-specific kinematics, duty ratios, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame target curvature and displacement-only half-cycle steering while ablating only unsupported common-envelope relief redistribution
falsification: reject if capture, either coherent wake view, or the `2.09340--2.09542L` geometry-scheduled mean-distance band is lost
