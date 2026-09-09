# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three
  samples execute the prefilled clean common-envelope half-cycle
  redistribution policy. They capture at `18.6505--18.8815T`, have mean
  distances `2.08855--2.09222L`, and finish at `0.74630--0.74928L`. The
  fourth sample adds a rearward-route multiplier, captures at `18.9640T`, and
  has a weaker `2.09072L` mean distance; its branch is not shown to have been
  exercised beneficially.
- I inspected the combined keyframe sheets for the strongest clean sample and
  the weaker rearward-branch sample from quiescent release through capture.
  Both top-down rows show genuine self-propulsion along a smooth target-bending
  path with an energetic alternating wake; both oblique rows show compact,
  finite caudal Lambda2 structures through first crossing. Neither view shows
  advection, wake collapse, wasteful stationary flapping, collision, domain
  exit, or instability. Their similar wakes agree with the close route
  metrics. The available current and inherited combined sheets are all
  capture-class, so there is no failure visual to relabel; the inherited
  completed near-miss/left-exit records provide the failure boundary.
- The assigned-parent executable differs from the clean prefill only in
  comments. Its completed rollout adds another independent capture at
  `18.7165T`, mean distance `2.09266L`, and final distance `0.74722L`.
  Together with the three current clean samples, this makes four
  executable-identical captures spanning `18.6505--18.8815T` and
  `2.08855--2.09266L`. This strengthens the simple redistribution carrier but
  also shows that score and arrival spread within this band cannot justify a
  gain change.
- Metrics and inherited notes expose the remaining architectural issue. The
  clean carrier contacts the anterior/posterior acceleration limits on about
  `60.85--61.17%`/`72.97--73.27%` of rows and the rate limits on about
  `10.9--11.1%`/`14.7--15.1%`; prior pointwise rate tapers removed rate
  contact but lost capture. Independent final clipping can also collapse two
  unequal raw commands onto the same saturation corner, changing their ratio
  and the intended interjoint traveling-bend coordination. The durable
  guidance specifically leaves a coupled demand allocator as a separate
  untested ablation, provided target-signed curvature and carrier coupling are
  preserved.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and robotic-fish coupled-oscillator/CPG control
source_mechanism: coordinated traveling-bend actuation preserves intersegment phase and amplitude relationships while bounded feedback modulates the carrier
transferable_invariant: when the actuator envelope is reached, preserve the instantaneous two-joint command ratio so saturation does not independently reshape the coordinated traveling bend
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, full-body envelopes, exact vortex phases, duty ratios, world coordinates, and task-specific routes
policy_translation: retain the normalized body-lateral route request, non-inverting correcting-yaw release, differential curvature, displacement-only half-cycle allocation, common amplitude relief, and posterior lag; replace independent acceleration clipping with one bounded common scale on the raw two-joint command vector followed by the same exact final envelope guard
falsification: reject if the later rollout loses capture or either coherent wake row, leaves the established 2.08855--2.09266L mean-distance band without a distinct load or coordination benefit, repeats the inherited downward near-miss/left exit, increases force or moment, or merely moves contact between joints without reducing simultaneous saturation distortion
```

## Single-candidate policy hypothesis

Materialize exactly one coupled acceleration-allocation candidate. When both
raw commands already lie inside the public envelope, it is identical to the
clean redistribution carrier. When either exceeds the envelope, multiply both
raw commands by the same positive scale determined by their maximum absolute
demand, then retain the exact componentwise clamp as a numerical contract
guard. This preserves command sign, ratio, target-owned curvature, and
posterior-lag coordination instead of independently flattening the command
pair at the saturation corner.

This is one actuator-allocation mechanism, not scalar-only gain tuning. It adds
no time, step, world-coordinate, route-memory, flow, force, velocity,
posterior-only, rate-barrier, recovery, or terminal channel. Formal CFD occurs
after handoff, so no outcome is claimed for this candidate here.
