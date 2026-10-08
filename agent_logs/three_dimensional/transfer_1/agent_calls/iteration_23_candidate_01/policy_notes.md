# Crossflow-dropout load-bridge candidate

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite `capture` episodes from direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm.  Three byte-identical v38 runs reproduce score `-0.126500`,
  capture at `18.232491 T`, total/observed distance integrals
  `2.012983/1.399804 L`, mean/max speed `0.70322/0.95194 L/T`, any-joint
  acceleration-limit residence `41.54%`, and peak normalized planar
  force/moment `0.03068/0.01579`.
- I inspected the combined sheets for a reproduced v38 run and the distinct
  v39 flow-load fusion run from release through capture, including both the
  top-down mid-plane vorticity row and the oblique body/Lambda2 row.  Both fish
  visibly self-propel from quiescent water on nearly identical smooth
  target-signed arcs.  Compact startup structures develop into coherent
  alternating posterior wakes in both views; neither rollout shows passive
  advection, collision, wake collapse, domain exit, or instability.  The
  present readable v38 oblique sheet repairs the black-sheet limitation in the
  inherited log and supports retaining its gait, but the views show no
  discernible wake benefit from adding force confidence in v39.
- V39's soft union of band-pass crossflow and lateral-load magnitudes captures
  `0.033001 T` earlier, but is farther from the target by
  `0.0263/0.0422/0.0617/0.0385/0.0100 L` at `6/8/10/12/14 T`; its total and
  observed integrals worsen to `2.015906/1.402567 L` and its maximum speed
  rises to `0.96131 L/T`.  It is better by `0.0102/0.0276 L` at `16/18 T`,
  while acceleration-limit residence falls slightly to `41.37%` and peak
  force/moment remains `0.03068/0.01558`.  Thus the additional sensor has a
  useful startup/terminal signature but its full-route union is an informative
  mechanism regression, not a scalar-score ambiguity.
- On the sampled v38 trace, lateral-force confidence averages
  `0.78-0.95` while crossflow confidence varies with the carrier and route.
  Their soft union averages `0.945` in `0-2 T` and `0.975-0.992` through most
  later two-second bins, converting a selective band-pass cue into nearly
  constant pose authority.  A frozen-trace dropout bridge gated by the raw
  dimensionless crossflow magnitude would instead leave mean confidence
  unchanged to within `0.010` from `2-12 T`, add support at startup and after
  `12 T` where v39's relative route recovers, and remain closed for
  disturbance-like high crossflow.
- The inherited whole-wave route-rate projection remains the hard failure
  boundary: it kept an organized wake but turned upward, exited at `8.4755 T`,
  came no closer than `12.2107 L`, and produced roughly tenfold force/moment
  peaks.  Hydrodynamic evidence therefore stays confined to proportional
  gait-pose sensing and never becomes route-rate feedback or direct actuation.

## One-candidate policy hypothesis

Preserve v38's state-feedback traveling wave, posterior lag, raw large-error
redirect, geometry-released bearing-divergence recovery, mean-preserving
whole-wave pose projection, head-only route-rate correction, raw half-cycle
steering, response-released cadence, approach scheduling, carrier-first
rejected-head-steering spillover, and componentwise acceleration bounds.  Add
one mechanism only: compute the already sampled bounded lateral-load
confidence, but admit it as a soft union term only when the raw dimensionless
crossflow magnitude is inside a smooth near-zero dropout band.  Gating on raw
magnitude distinguishes loss of local observability from the low band-pass
confidence deliberately assigned to disturbance-like high crossflow.  Observed
joint phase remains the sole odd sign.  This keeps load from becoming a route
bias, does not change the carrier or direct actuation, and leaves the v38
sensing law unchanged whenever local flow is informative.

The candidate should retain v38's `6-14 T` closure and coherent two-view wake
while recovering v39's startup/terminal lead, targeting capture before
`18.2325 T` and observed integral no greater than `1.3998 L` without materially
exceeding the sampled `0.962 L/T`, `41.6%`, `0.03068`, and `0.01579`
speed/saturation/force/moment envelope.  Falsify the mechanism if the middle
route regresses toward v39, the earlier capture does not survive, confidence
again becomes nearly constant, the target-signed arc or alternating wake
degrades, or the physical envelope materially worsens.  Formal CFD occurs
only after worker exit; no same-worker outcome is claimed.

```text
bookshelf_consulted: true
source_domain: adaptive wake interaction and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a productive rhythmic carrier while bounded sensory feedback yields when its observation is redundant or disturbance-like
transferable_invariant: complementary body-frame sensors should add pose confidence only where the primary carrier-coherent cue loses observability, without replacing target geometry or the oscillator
nontransferable_details: published gains, species or robot kinematics, clocked CPG phase, dimensional force and flow scales, exact vortex phase, cylinder-wake synchronization, full-body envelopes, and prescribed routes
policy_translation: use normalized local crossflow as the primary band-pass pose confidence; let normalized lateral-load magnitude bridge only a smooth near-zero raw-crossflow dropout, never the high-crossflow rejection side, multiply the result by observed de-meaned anterior-joint phase, and confine it to proportional two-joint gait-pose rejection
falsification: reject if middle-route closure or capture regresses, the confidence remains route-wide constant, the alternating wake loses coherence, or speed, acceleration-limit residence, normalized force, or yaw moment materially exceeds the sampled v38-v39 envelope
```

## Evidence boundary

All numerical and visual outcome claims above come from completed sampled CFD,
the assigned parent guidance, and inherited optimizer logs.  The current
candidate's evaluation becomes evidence only for a later worker.

## No-CFD implementation audit

- The single candidate has SHA-256
  `ea5e39a33f0a5414fcdb82e78be1640c3c654b3f119738792dd55e588b73bba0`.
- The configured `check-runner` was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account.  Its three prescribed commands were
  run locally and separately after the final policy correction: the material
  guidance/schema check, lightweight Julia policy contract, and solver
  editable-boundary check all pass.
- Synthetic observation checks confirm bounded confidence in three distinct
  regimes: load bridges zero crossflow, moderate crossflow retains the primary
  cue, and high disturbance-like crossflow closes the load bridge.  No formal
  CFD was run.
