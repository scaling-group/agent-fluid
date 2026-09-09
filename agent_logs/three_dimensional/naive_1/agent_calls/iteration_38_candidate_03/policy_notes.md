# Step 38 multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Two are
  executable-identical copies of the prefilled redistribution policy and
  capture at `18.8265T`/`18.8815T` with score-defined mean distance
  `2.08855L`/`2.08896L`. The clean common-envelope comparator captures at
  `18.6010T` and `2.09042L`; the rearward-route composition captures at
  `18.9640T` and `2.09072L`, but inherited reconstruction shows its target
  remained forward, so its added branch was not exercised.
- I inspected every sampled combined keyframe sheet from release through
  capture. Each top-down row begins in quiescent fluid and develops a coherent
  alternating street along a target-bending path. Each oblique row retains
  compact bilateral and caudal Lambda2 structures through first crossing.
  Translation is self-propelled rather than background advection; no sampled
  sheet shows collision, wake collapse, domain exit, or numerical instability.
  The sampled batch has no failure-class sheet, so inherited completed
  left-domain results supply the semantic failure contrast rather than
  relabelling a capture.
- Metrics corroborate the visual equivalence and identify a shared actuator
  boundary. Across the four samples, anterior/posterior acceleration contact
  is `60.85--61.17%`/`72.95--73.27%`, rate contact is
  `10.88--11.07%`/`14.73--14.96%`, and peak planar force/moment is
  `0.03066--0.03259`/`0.01603--0.01656`. Both commands are simultaneously at
  the acceleration boundary on `39.68--39.91%` of rows, exactly one is there
  on `54.31--54.46%`, and neither is there on only `5.74--5.85%`. Independent
  clipping therefore alters the two-joint command allocation on about `94%`
  of every sampled rollout; the coherent wake and capture do not prove that
  this distortion is harmless.
- The assigned parent adds a seventh executable-identical clean capture at
  `19.0795T` and mean distance `2.10426L`, broadening its repeat spread rather
  than establishing performance. More importantly, sampled inherited
  optimizer output evaluates another executable-equivalent clean policy as a
  `left_domain` miss after reaching `0.96285L`, with final distance
  `10.44465L`. Thus the prior preference for clean envelope scheduling based
  on an unbroken capture record no longer survives the available evidence;
  both clean and redistribution architectures have contradictory rare misses.

## Structured bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and coupled robotic-fish CPG control
source_mechanism: preserve coordinated interjoint traveling-bend structure while bounded sensor feedback modulates the rhythmic carrier
transferable_invariant: actuator projection should preserve the instantaneous direction and relative allocation of the two-joint traveling-bend command rather than independently flattening its components
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, oscillator clock phases, exact vortex phases, and task-specific routes
policy_translation: retain the prefilled target-signed redistribution carrier exactly, but replace independent component clipping with one bounded infinity-norm scale applied to both raw joint accelerations
falsification: reject if capture or either coherent wake row is lost, a near-miss/left-exit topology recurs, the established redistribution route band is lost without a compensating load or demand benefit, or rate contact and planar loads worsen
```

## Exactly one candidate hypothesis

Test a coupled acceleration allocator on the current redistribution carrier.
When either raw joint command exceeds the shared per-joint acceleration limit,
scale both raw accelerations by the same positive factor so the larger
component meets the limit and the raw command ratio is preserved. Target
geometry still owns turn sign and mean curvature, anterior displacement still
owns the clock-free half-cycle signals, and response release, posterior lag,
amplitude redistribution, and the actuator envelope remain unchanged.

The expected semantic test is whether preserving interjoint command direction
retains capture and the coherent two-view wake while reducing independent-
clipping distortion, rate contact, or route variability. This is a controller-
allocation mechanism, not scalar gain tuning. It adds no terminal or recovery
branch, flow/force residual, velocity phase predictor, explicit time, step,
world coordinate, mutable state, or memorized route. Formal CFD occurs only
after handoff, so no outcome is claimed for this unevaluated candidate.
