# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture. The two
  executable-identical simple redistribution samples capture at
  `18.8265--18.8815T` and reproduce the best sampled mean-distance band,
  `2.08855--2.08896L`. The prefilled rearward-route multiplier captures at
  `18.9640T` with `2.09072L`, but inherited reconstruction places its minimum
  forward target fraction at `0.3541`; that branch never activates and is
  evidence only for non-interference. The distinct broadside reserve captures
  at `18.7055T`, but its `2.09386L` mean distance does not improve the simple
  carrier.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the best-score sampled capture, the inherited phase-separation failure,
  the inherited alignment-qualified capture, and the inherited
  steering-priority failure. The sampled capture starts in visibly quiescent
  fluid, builds a coherent alternating street that bends toward the target,
  and retains compact caudal Lambda2 structures through first crossing. Its
  translation is self-propulsion, not advection, and the lateral oscillation
  remains productive.
- Removing beat-phase modulation from mean curvature preserved an energetic
  wake in both views but bent the body and street below the target, missed at
  `0.95507L`, and exited left. The subsequent alignment-qualified phase gate
  restored capture and the same wake class, but arrived at `19.0245T` with
  mean distance `2.09737L`, outside the best simple-carrier band; its
  `61.09%/73.11%` acceleration contact and `10.87%/14.77%` rate contact also
  do not establish demand relief. Thus displacement-phase curvature remains
  route-relevant, while suppressing it near alignment has no demonstrated
  semantic or integral benefit.
- The sibling `15%` steering-residual-priority allocator is the clearest new
  negative evidence. Although its top-down street and compact oblique caudal
  structures remain energetic and acceleration contact drops to
  `39.23%/57.05%`, the route bends down and away, reaches only `2.43664L`, and
  exits left at `29.7110T` with final distance `9.22177L`. Lower clipping from
  post-oscillator joint-space allocation is therefore not useful relief when
  it changes the effective traveling-wave/curvature balance.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: classical elongated-body swimming and closed-loop robotic-fish CPG control
source_mechanism: a posterior-lagged traveling bend supplies propulsion while one bounded sensor-driven gait asymmetry supplies direction control
transferable_invariant: preserve the evidenced traveling-wave coordination and one normalized body-frame observed-phase steering allocation when added recovery or actuator-allocation channels lack semantic benefit
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, robot geometry, prescribed clock phase, exact vortex phase, and task-specific routes
policy_translation: retain lateral target fraction, non-inverting correcting-yaw release, displacement-only half-cycle curvature, common-envelope redistribution, posterior lag, and final acceleration projection; remove the inactive rearward-route multiplier and its unused forward-fraction observation without adding another modifier
falsification: reject the retained carrier as reliable if an executable-equivalent repeat misses capture, loses either coherent wake row, leaves the sampled route band, or worsens the established actuator/load class; do not claim the known rare near-miss boundary is resolved from one repeat
```

## Single-candidate policy hypothesis

Materialize exactly the executable simple half-cycle envelope-redistribution
controller represented by the two strongest sampled captures and the inherited
rollback capture. Relative to the prefill, remove only the dormant
`rearward_route_boost`, the forward target fraction used solely by that branch,
and the route multiplier. Preserve the target-owned turn sign, one-sided
correcting-yaw release, displacement-phase curvature, common half-cycle
envelope redistribution, posterior lag, and exact final acceleration
projection.

This is an evidence-backed mechanism rollback rather than scalar gain tuning.
It adds no time, step count, world coordinate, target identity, mutable state,
velocity residual, terminal compound, broadside reserve, posterior-only
allocation, actuator-priority transform, or pointwise rate barrier. Formal CFD
runs only after this worker exits. Accept this candidate only if capture and
both coherent wake views repeat; treat another executable-equivalent near miss
as falsification of reliability rather than justification for stacking another
late recovery branch.
