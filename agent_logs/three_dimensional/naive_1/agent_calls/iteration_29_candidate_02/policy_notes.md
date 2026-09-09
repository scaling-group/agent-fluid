# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver examples satisfy the frozen evaluation contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, and `termination=capture`. The two executable-identical
  half-cycle envelope-redistribution runs are the strongest semantic pair:
  they capture at `18.8265--18.8815T`, keep mean distance at
  `2.08855--2.08896L`, and score `-0.20041-- -0.20106`. The rearward-route
  multiplier captures at `18.9640T` and `2.09072L` but its inherited
  reconstruction says the target never went rearward, so that is
  non-interference rather than recovery. The broadside reserve captures
  faster at `18.7055T`, but its `2.09386L` mean distance and `-0.20576` score
  do not recover the redistribution band.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the best-score redistribution capture, the broadside-reserve prefill,
  and the assigned parent's fresh allocator failure. The successful sheets
  begin in visibly quiescent water, develop a coherent alternating street,
  bend smoothly toward the target, and retain compact paired caudal Lambda2
  structures through capture. Their motion is self-propelled rather than
  advected, lateral oscillation remains productive, and neither wake row shows
  collapse or instability.
- The informative inherited failure tests steering-residual-priority demand
  allocation. A `15%` blend toward a common carrier projection kept an
  energetic alternating top-down street and compact 3D caudal structures, but
  the trajectory turned progressively downward after about `16T`, approached
  only to `2.43664L` at `18.4085T`, then exited left at `29.7110T` and
  `9.22177L`. Acceleration-limit contact fell from the successful
  redistribution pair's roughly `60.85--61.00%`/`72.97--73.27%` to
  `39.23%`/`57.05%`, while rate contact stayed near `10.22%`/`14.55%` and
  peak planar force/moment remained comparable. This falsifies demand relief
  as a benefit when it changes the carrier/steering balance enough to lose the
  route; wake coherence and lower clipping do not rescue a missed capture.
- The prefilled broadside-reserve policy and the inherited allocator both add
  mechanisms whose isolated scalar or demand advantages do not beat the
  replicated redistribution route. The candidate therefore returns to the
  executable-evaluated redistribution controller without gain changes. This
  is a material controller-selection improvement over the assigned prefill,
  not a claim about same-worker CFD.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG control with asymmetric flapping or duty-ratio modulation
source_mechanism: use observed beat phase to place more of a bounded turning action on the useful half-cycle while preserving the propulsive rhythm
transferable_invariant: target-signed half-cycle asymmetry can redistribute an existing gait envelope without replacing the coordinated traveling wave or requiring a clock
nontransferable_details: published gains, robot geometry, dimensional cadence, prescribed oscillator phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-lateral target steering, one-sided correcting-yaw release, differential mean curvature, and posterior lag; use anterior joint displacement relative to target-signed bias as the phase observation and redistribute the existing common amplitude relief between the two half-cycles
falsification: reject if capture or either coherent wake row is lost, if mean distance leaves the replicated 2.08855--2.08896L band without a distinct robustness or demand benefit, or if another executable-identical near miss confirms the inherited 0.81206L miss topology
```

## Single-candidate policy hypothesis

Materialize exactly the executable redistribution policy sampled twice in the
current batch. Target geometry continues to own steering sign; correcting yaw
may release but never invert it. Displacement-only joint phase applies a
positive factor to both differential-curvature shares and shifts the existing
common turn-amplitude relief toward the opposed half-cycle. The state-feedback
oscillator, posterior lag, and exact final acceleration projection remain
unchanged.

This candidate deliberately removes the prefill's broadside reserve and adds
no new route channel, scalar gain tuning, terminal compound, instantaneous
velocity residual, posterior-only allocation, rate barrier, carrier allocator,
time, step count, world coordinate, target identity, mutable state, or wake
phase. The evidence-backed expectation is capture with both coherent wake rows
and the lower mean-distance band. Its known falsification boundary remains the
inherited executable-equivalent `0.81206L` near miss; the present two sampled
captures strengthen performance selection but do not prove robust recovery.
