# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled episodes satisfy the frozen evaluation contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, zero
  cylinders and no prewarm, finite moving-window transport, and capture
  termination. Two samples (`solver_649d7e789a5a` and
  `solver_d2a3f8408b10`) execute the same clean half-cycle envelope-
  redistribution policy. They capture at `18.8265T` and `18.8815T` with mean
  distances `2.08855L` and `2.08896L`. The geometry-scheduled prefill captures
  at `18.6010T` and `2.09042L`; a redistribution variant with a rearward-only
  multiplier captures at `18.9640T` and `2.09072L`.
- I inspected every combined keyframe sheet from quiescent release through
  capture. In each top-down row, a coherent alternating vortex street follows
  a smooth target-bending trajectory. Each oblique row develops compact
  bilateral and caudal Lambda2 structures that remain finite through first
  crossing. Because the background flow is zero, the translation is genuine
  self-propulsion; the lateral beat is productive, and no sampled sheet shows
  wake collapse, advection, collision, domain exit, or instability.
- The current sample contains no failure-class visual, so the rearward variant
  is only the most informative weaker architecture comparison, not a failure.
  Metrics agree with the visual similarity. Clean redistribution versus
  geometry scheduling contacts the anterior/posterior acceleration limits on
  `60.85--61.00%`/`72.97--73.27%` versus `60.88%`/`72.95%` of rows and the
  rate limits on `11.04--11.07%`/`14.88--14.93%` versus
  `10.88%`/`14.96%`; peak planar force/yaw moment are also overlapping
  (`0.03066--0.03171`/`0.01603--0.01632` versus
  `0.03259`/`0.01656`). Redistribution's lower mean distance is therefore a
  route-allocation result, not actuator relief.
- The assigned-parent guidance and inherited optimizer notes supply the
  failure boundary absent from the current all-capture batch: the same clean
  redistribution executable has previously missed at `0.81206L` and
  `1.25093L`, then bent downward and exited left despite energetic two-view
  wakes. Pointwise rate barriers, posterior-specific allocation, velocity
  residuals, observation-phase filtering, and stacked recovery channels also
  have completed negative route evidence. I do not reopen any of those
  mechanisms.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and robotic-fish closed-loop CPG asymmetric flapping
source_mechanism: preserve a posterior-lagged traveling bend while bounded target-signed effort is allocated over an observed useful beat half
transferable_invariant: retain the coordinated propulsive carrier and let normalized target geometry own turn sign while joint displacement, rather than a clock, allocates a small positive half-cycle modulation
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, full-body envelopes, duty ratios, exact vortex phases, world coordinates, and task-specific routes
policy_translation: retain body-lateral route feedback, non-inverting correcting-yaw release, differential mean curvature, posterior lag, and final acceleration projection; redistribute only the existing common amplitude relief between displacement half-cycles
falsification: reject if the later rollout loses capture or either coherent wake row, repeats the inherited downward near-miss and left exit, leaves the 2.08855--2.08896L current mean-distance band without a distinct benefit, or materially increases rate, acceleration, force, or moment demand
```

## Single-candidate policy hypothesis

Materialize exactly one clean common-envelope half-cycle redistribution
controller. Relative to the prefill, add a bounded displacement-phase factor
that moves the existing target-geometry-owned amplitude relief toward the
opposed half-cycle and away from the target-aligned half-cycle without changing
its nominal mean. Target geometry continues to own route sign; correcting yaw
may release but never invert the request; the displacement-only steering
factor, differential curvature shares, posterior-lagged carrier, and exact
acceleration projection remain unchanged.

This is a one-mechanism architectural selection backed by two current sampled
captures, not scalar-only gain tuning. It adds no recovery, terminal, velocity,
flow, force, posterior-only, rate-barrier, world-coordinate, time, step, mutable
state, or memorized-phase channel. Formal CFD occurs after handoff, so this
worker claims no outcome for the new evaluation.
