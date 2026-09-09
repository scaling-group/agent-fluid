# Step 38 multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three run
  the executable-identical common-envelope redistribution carrier and capture
  at `18.8265--18.8815T` with score-defined mean distance
  `2.08855--2.08896L`. The distinct geometry-only common-envelope carrier
  captures at `18.6010T` and `2.09042L`; this small tradeoff lies inside the
  wider inherited repeat spread and does not establish performance dominance.
- I inspected both rows of the best-score redistribution sheet and the clean
  carrier sheet from release through capture. Both begin in quiescent fluid,
  develop coherent alternating top-down streets along target-bending paths,
  and retain compact caudal Lambda2 structures through first crossing. With
  zero background flow, translation is self-propelled rather than advected;
  neither sheet shows collision, wake collapse, domain exit, or instability.
  Their diagnostics overlap: acceleration contact is about
  `60.85--60.88%`/`72.95--73.27%`, rate contact is
  `10.88--11.07%`/`14.93--14.96%`, peak planar force is about
  `0.03171--0.03259`, and peak moment is `0.01632--0.01656`.
- The assigned parent's inherited step-37 log is the informative failure. It
  replaces independent final clipping with a single radial scale on the full
  two-joint acceleration vector. Its direct-uniform rollout reaches only
  `11.52984L`, then exits upward-left at `9.713T` and `11.79982L`. The combined
  sheet shows a short, weak top-down wake and less compact oblique structures
  compared with the capture sheets; diagnostics show only `0.80L` of best
  progress, heading spanning `0.645` to `-1.104 rad`, zero rate contact, and
  acceleration contact reduced to `19.54%/42.87%`. Lower contact is therefore
  carrier starvation, not useful relief. The full-vector radial allocator is
  closed and will not be repeated.
- Sampled optimizer guidance adds the complementary semantic boundary: clean
  and redistributed envelopes both have contradictory exact-policy repeats,
  while velocity phase prediction, posterior-state phase voting,
  observation filtering, posterior-only allocation, rate barriers, terminal
  compounds, and stacked recovery already have completed negative evidence.
  The candidate therefore preserves the prefilled route and gait and tests
  one actuator-allocation mechanism that is distinct from full-vector scaling.

## Structured bookshelf transfer

The bookshelf was consulted before this architecture proposal. The inherited
radial failure falsifies scaling the entire coupled CPG command, but the
robotic-fish carrier/residual separation remains a narrower testable invariant.

```text
bookshelf_consulted: true
source_domain: low-dimensional robotic-fish CPG control with closed-loop sensory modulation
source_mechanism: preserve the rhythmic propulsive carrier while bounded sensor feedback modulates steering through the coupled joints
transferable_invariant: actuator allocation must protect the directed posterior-lagged carrier and coordinate only the target-feedback residual, rather than attenuating the whole two-joint command when one component saturates
nontransferable_details: published gains, clock phases, duty ratios, species or robot kinematics, full-body envelopes, dimensional cadence, exact vortex phases, world coordinates, and task-specific routes
policy_translation: retain normalized body-lateral target steering, displacement-phase redistribution, non-inverting response release, differential mean curvature, and posterior lag; compute the target-free carrier under the same geometry-owned envelope, clip that carrier independently, then apply one positive common headroom scale only to the target-steering residual before the exact final projection
falsification: reject if capture or either coherent wake row is lost, the inherited weak-wake upward-left exit recurs, mean distance leaves the completed carrier spread without a distinct demand benefit, rate contact does not improve, or planar force and moment exceed the sampled carrier range
```

## Exactly one candidate hypothesis

Keep the prefilled target route, displacement-phase steering, propulsion
envelope, posterior lag, and parameter values. Change only saturation
allocation. A target-free acceleration pair supplies the propulsion-priority
carrier and retains the established independent final projection. The
difference between the full target command and that carrier is the bounded
steering residual. When the combined residual would exceed either joint's
remaining one-sided acceleration headroom, apply one common positive scale to
both residual components.

This preserves carrier authority where the failed radial allocator removed it,
while retaining the residual's instantaneous anterior/posterior ratio and
target-owned sign. It is a coupled state-feedback allocation mechanism, not a
gain edit. It adds no clock, route or terminal branch, velocity/flow/force
residual, coordinate, mutable state, or memorized phase. Formal CFD occurs
after handoff, so no outcome is claimed for this unevaluated candidate.
