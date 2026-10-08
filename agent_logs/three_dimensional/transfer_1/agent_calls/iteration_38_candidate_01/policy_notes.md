# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract and
  capture at the same logged `17.4130 T` step.  The two reproduced v50 rollouts
  are the strongest finite baseline: score `-0.05952`, total/observed distance
  integrals `1.94533/1.32998 L`, maximum speed `0.9831 L/T`, any-joint
  acceleration-limit residence `40.11%`, and peak normalized force/moment
  `0.03225/0.01609`.
- In both inspected top-down sheets, v50 and the assigned v53 parent are visibly
  self-propelled along the same smooth target-directed arc, with an organized
  alternating posterior vortex street rather than passive advection or wake
  breakup.  The v53 oblique row shows compact paired caudal structures at the
  readable `4/12/16 T` and capture frames; the sampled v50 row has a black
  `12 T` panel but shows the same structure at the other readable frames.  No
  visible new wake topology supports either course-feedback edit.
- The assigned v53 response-arbitrated terminal-course parent preserves the
  v50 action/load envelope and capture step but worsens total integral to
  `1.94566 L`, score to `-0.05994`, and crossing depth to `0.74550 L`.
  The sampled posterior-localized course-shape alternative is also effectively
  inactive until the final approach: it captures on the same step, changes the
  observed integral by only `+0.000006 L`, worsens the total integral to
  `1.94535 L`, and raises any-joint limit residence to `40.90%`.  At the coarse
  checkpoints, neither separates from v50 before `16 T`.  Instantaneous course
  slip is therefore not evidenced as useful terminal authority in this
  coherent carrier.
- The inherited v49-to-v50 comparison instead exposes an earlier allocation
  tradeoff: v50 gives up `0.0249/0.0225 L` at `6/8 T` while leading later once
  its geometrically qualified posterior response is useful.  On the completed
  v50 trace, positive body-axis speed grows from about `0.01 L/T` at `0.5 T`
  to `0.11` at `2 T`, crosses the existing `0.45` response scale near `4 T`,
  and remains roughly `0.75-0.87 L/T` through the middle route.  This provides
  a bounded observed-response boundary for launch allocation without a clock
  or route coordinate.

## Policy hypothesis

Return to the reproduced v50 route and remove both unsupported terminal-course
branches.  Preserve the carrier, redirect, cadence, route feedback, and
geometrically qualified yaw/contraction release.  Add one new arbitration
mechanism: while positive body-axis response is still below its normalized
launch scale, smoothly release at most part of the small supplementary
posterior turn-shape residual.  As axial response forms, the release vanishes
and the controller becomes v50 exactly.  This changes neither the ordinary
route request nor carrier amplitude; it protects the traveling posterior wave
only during observed launch deficit.

Expected result: recover some of the inherited early-route distance deficit
without erasing v50's `10-16 T` lead or increasing its `0.9831/40.11%/
0.03225/0.01609` speed, saturation, force, and moment envelope.  Falsify if the
new rollout loses capture, is not closer by `6-8 T`, regresses either distance
integral or late closure, or visibly weakens the organized two-view wake.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior traveling wave for reactive thrust and modulate a steering perturbation from observed locomotor response
transferable_invariant: a bounded steering residual may yield while axial propulsive response is absent, then return continuously after that response forms
nontransferable_details: published gains, dimensional cadence, species envelopes, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: use positive body-axis speed normalized by the existing launch scale to release only supplementary posterior turn shape; retain the state-feedback carrier and all route means
falsification: reject if early closure is not recovered, v50 middle or terminal closure regresses, capture or reflection symmetry is lost, or speed, saturation, loads, or the coherent wake exceed the reproduced envelope
```
