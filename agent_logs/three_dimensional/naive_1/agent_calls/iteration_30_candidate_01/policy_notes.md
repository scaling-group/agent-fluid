# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before candidate selection

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. Three
  samples execute the current half-cycle envelope-redistribution policy
  exactly. They capture at `18.6505--18.8815T`, with mean distance
  `2.08855--2.09222L` and no instability. The fourth adds a rearward-only
  route multiplier, captures at `18.9640T` and `2.09072L`, and inherits a
  reconstruction showing that the target stays forward; it tests
  non-interference, not recovery.
- I inspected every current combined keyframe sheet from release through
  termination. Both rows start in quiescent water. The top-down row develops
  a coherent alternating street whose axis bends toward the target, while the
  oblique row retains compact alternating caudal Lambda2 structures through
  first crossing. Translation is self-propelled, lateral motion remains part
  of the productive traveling bend, and there is no visible wake collapse,
  passive advection, collision, domain exit, or numerical instability.
- Metrics agree with the images but expose structural demand: the three exact
  redistribution runs contact the anterior/posterior acceleration projection
  on `60.85--61.00%`/`72.97--73.27%` of rows and the joint-rate limit on
  `11.03--11.07%`/`14.91--15.07%`, with peak planar force about
  `0.0307--0.0322` and peak normalized moment `0.0160--0.0166`. Inherited
  optimizer evidence rules out interpreting lower contact alone as progress:
  a `15%` steering-residual-priority allocator reduced acceleration contact
  to `39.23%`/`57.05%` while preserving both energetic wake views, yet reached
  only `2.43664L` and exited left at `29.711T` and `9.22177L`.
- The three executable-identical current trajectories coincide early but
  diverge hydrodynamically later: their maximum absolute body-lateral target
  fraction spans about `0.438--0.940`. Thus a broadside gate near `0.55` can
  be active in one repeat and dormant in another without any controller
  difference. The fastest capture (`18.6505T`) also has the worst mean
  distance of the trio (`2.09222L`), whereas the best-score repeat arrives at
  `18.8265T` with the best mean (`2.08855L`). Neither threshold activation nor
  arrival ordering should be selected from one realization.
- The assigned-parent and sampled inherited logs already falsify the obvious
  shelf alternatives around this carrier: terminal velocity/slip residuals,
  posterior-specific wave allocation, response-gate removal, rate barriers,
  broadside compounds, and carrier scaling all lost the evidenced route or
  failed to improve its distance band. Current evidence contains no failure
  signature requiring fast-flow rejection or near-target drive relief.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric-flapping turning
source_mechanism: preserve a coordinated posterior-lagged propulsive oscillator while target geometry applies bounded mean curvature and observed beat phase redistributes steering effort
transferable_invariant: a low-dimensional traveling-wave carrier and target-signed state-feedback allocation should be retained when extra recovery, terminal, or saturation channels do not survive route evidence
nontransferable_details: published gains, dimensional cadence, robot geometry, prescribed clock phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: adopt no new primitive and make no scalar tuning; retain the normalized body-lateral route request, non-inverting correcting-yaw release, displacement-only half-cycle steering, common-envelope redistribution, posterior lag, and exact final acceleration projection
falsification: reject the retained carrier if an executable-equivalent repeat loses capture or either wake row, confirms the inherited 0.81206L near-miss topology, or leaves the 2.08855--2.09222L mean-distance band without a distinct semantic or demand benefit
```

## Single-candidate policy hypothesis

Materialize exactly one clean executable replication of the current
half-cycle envelope-redistribution controller. This later-iteration shelf
consultation deliberately adopts no additional primitive: every remaining
candidate mechanism is either contradicted by inherited completed evidence or
lacks a present failure signature. Target geometry continues to own steering
sign, correcting yaw may release but never invert it, anterior displacement
supplies clock-free beat phase, and the existing common amplitude relief is
redistributed without changing its mean.

The candidate therefore remains executable-identical to the three sampled
captures and adds no scalar gain tuning, terminal schedule, velocity or flow
residual, posterior-only allocation, recovery gate, rate barrier, actuator
allocator, explicit time, step count, world coordinate, target identity,
mutable state, or memorized phase. Formal CFD runs after this worker exits.
Count the result as evidence for the carrier's repeatability, not as a new
mechanism; the useful next discriminator is whether capture, both wake rows,
and the established distance band survive another independent realization.
