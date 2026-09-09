# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. Three
  execute the same clean common-envelope half-cycle redistribution policy and
  capture at `18.6505--18.8815T`, with mean distance
  `2.08855--2.09222L`. Their score ordering is not a gain-selection signal.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the best-score clean repeat (`solver_649d7e789a5a`) and the distinct
  rearward-route prefill (`solver_bae498322681`) from release through capture.
  Both begin in visibly quiescent water, develop a coherent alternating street
  along a target-bending path, and retain compact caudal 3D structures through
  first crossing. Motion is self-propelled, lateral motion remains productive,
  and neither view shows advection, wake collapse, collision, domain exit, or
  instability. The current batch contains no semantic failure; the distinct
  prefill is the informative weaker architecture comparison.
- Metrics agree with the images. The best clean repeat captures at `18.8265T`
  with mean distance `2.08855L`; the rearward multiplier captures later at
  `18.9640T` with mean distance `2.09072L`. It also leaves structural demand
  essentially unchanged: clean versus rearward acceleration contact is
  `60.85%/73.27%` versus `61.17%/73.00%`, rate contact is
  `11.13%/14.93%` versus `10.96%/14.76%`, and peak yaw moment is `0.01632`
  versus `0.01640`. Inherited reconstruction says the target remains forward
  throughout the rearward sample, so the branch demonstrates non-interference,
  not recovery or an improved physical mechanism.
- The assigned-parent logs supply failures absent from the all-capture sampled
  batch. A `15%` steering-residual-priority allocator lowered acceleration
  contact to `39.23%/57.05%` while keeping both wake views energetic, yet
  reached only `2.43664L` and exited left. A joint-displacement target-axis
  compensation also kept capture and both wakes but slowed arrival to
  `19.5745T`, worsened mean distance to `2.14814L`, and increased peak planar
  force/moment outside the clean-repeat band. Lower clipping and removal of a
  beat-correlated observation component are therefore not useful when they
  disturb the established route coordination.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and closed-loop robotic-fish CPG asymmetric-flapping control
source_mechanism: preserve a directed posterior-lagged traveling bend while target geometry and observed beat displacement allocate bounded steering across the useful half-cycle
transferable_invariant: when completed evidence shows coherent self-propulsion and target capture, preserve the coordinated carrier and target-signed beat-state allocation unless a distinct mechanism improves route semantics, loads, or robustness
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, clock phase, exact vortex phase, task coordinates, and memorized routes
policy_translation: remove the unevidenced rearward-only multiplier and retain normalized body-lateral route sign, non-inverting correcting-yaw release, displacement-only half-cycle steering, common-envelope redistribution, posterior lag, and exact final acceleration projection
falsification: reject if the later rollout loses capture or either coherent wake row, leaves the replicated 2.08855--2.09222L mean-distance band without a distinct benefit, materially worsens rate/acceleration contact or planar loads, or reproduces the inherited executable-equivalent 0.81206L near miss
```

## Single-candidate policy hypothesis

Materialize exactly one clean common-envelope half-cycle redistribution
controller by deleting the prefill's rearward-only route multiplier. Target
geometry continues to own turn sign; correcting yaw may release but never
invert the request. Centered anterior displacement supplies clock-free beat
phase, the existing common amplitude-relief budget shifts between half-cycles
without changing its mean, and the posterior-lagged traveling wave and hard
acceleration projection remain unchanged.

This is evidence-backed architecture selection, not scalar-only gain tuning.
It adds no new recovery, velocity, flow, terminal, posterior-only, rate-barrier,
or saturation-allocation channel and no explicit time, step, world coordinate,
target identity, mutable state, or memorized phase. Formal CFD occurs after
this worker exits. Count the result as a repeatability test of the clean
carrier, not as same-worker evidence of improvement.
