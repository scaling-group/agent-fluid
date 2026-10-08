# Flow-load confidence pose candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the Phase-2 simulation contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `capture` termination.  Three
  policy-equivalent geometry-only controllers reproduce capture at
  `18.403006 T`, score `-0.140449`, and total/observed distance integrals
  `2.027810/1.418099 L`.
- The assigned v38 crossflow-confidence parent improves that repeated control
  to capture at `18.232491 T`, score `-0.126500`, and total/observed distance
  integrals `2.012983/1.399804 L`.  Its distance lead over the reproduced
  control grows from `0.0039/0.0241 L` at `2/4 T` to
  `0.1060/0.1434/0.1405/0.1415/0.1417/0.1273 L` at
  `8/12/14/16/17/18 T`.  This is a route-wide semantic improvement, not a
  deeper terminal sample.
- I inspected the sampled combined and view-specific sheets before editing.
  The parent's top-down row shows self-propulsion from quiescent water, a
  smooth target-directed arc, and a coherent alternating mid-plane wake
  through capture.  Its oblique keyframes are blank despite being listed in
  the visual manifest, so they are missing evidence and cannot establish that
  v38 preserved the three-dimensional Lambda2 wake.  The repeated geometry-
  only examples have valid top-down and oblique rows; those show compact
  startup structures becoming an alternating posterior 3D wake along the
  same capture topology.  The sampled set contains no failed termination.
  The inherited wrong-sign whole-wave route-rate projection remains the
  informative failure boundary: it exited upward at `8.4755 T`, came no
  closer than `12.2107 L`, and generated roughly tenfold force and moment
  peaks, although its wake remained organized.
- The parent's gain does not come from a looser physical envelope.  Relative
  to the repeated geometry-only control, mean/max speed changes only from
  `0.69612/0.94760` to `0.70322/0.95194 L/T`, any-joint acceleration-limit
  residence falls from `42.14%` to `41.54%`, peak normalized force remains
  `0.03068`, and peak normalized yaw moment falls from `0.01587` to
  `0.01579`.  Preserve its carrier, steering, and bounded flow-pose term.
- The trace also identifies a complementary sensing gap rather than a reason
  for scalar-only gain tuning.  During the parent's late interval,
  `|local body-frame crossflow| < 0.001 U` on `34.4%` of samples, yet the
  absolute normalized lateral force on those samples averages `0.01154` and
  reaches `0.01711` at its 90th percentile.  Across early/middle/late
  intervals, lateral force and anterior joint angle have correlations
  `0.879/0.909/0.875`, while absolute crossflow and absolute lateral force
  are only weakly or negatively correlated.  Thus load can provide bounded
  carrier-state confidence when the filtered point-flow cue crosses zero; it
  is not evidence for a signed force steering residual.

## One-candidate policy hypothesis

Preserve v38's state-feedback traveling wave, posterior lag, raw large-error
redirect, mean-preserving whole-wave pose projection, head-only route-rate
correction, geometry-released bearing-divergence recovery, half-cycle
steering, response-released cadence, carrier-first spillover allocation,
crossflow band-pass confidence, and componentwise acceleration bounds.

Add normalized lateral-load magnitude as a second bounded confidence sensor
for the existing carrier-pose correction.  Pass absolute `force_body_L[2]`
through the same zero-at-rest, moderate-signal band-pass form as crossflow and
combine the two confidences with a bounded soft union.  Continue to take the
correction's odd sign only from the de-meaned observed anterior joint phase.
The load signal therefore cannot create a world-frame route bias, change raw
redirect geometry, enter bearing/yaw rates, retime the oscillator, or become
a direct actuator residual.  This is one sensor-fusion mechanism with the
parent's unchanged two-degree pose bound.

The candidate should retain the parent's middle-route lead while filling
low-crossflow carrier-pose gaps, especially on late approach.  Falsify it if
capture is lost or not earlier than `18.2325 T`, observed distance integral
exceeds `1.39981 L`, the late lead disappears, the valid visual evidence does
not retain an alternating target-directed wake, or maximum speed,
acceleration-limit residence, normalized force, or yaw moment materially
exceeds the parent envelope `0.95194/41.54%/0.03068/0.01579` without
compensating progress.  Formal CFD occurs only after this worker exits, so
these are hypotheses rather than same-worker outcome claims.

```text
bookshelf_consulted: true
source_domain: wake-interaction sensing and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target geometry from bounded fast fluid and load feedback while retaining a joint-state locomotor phase reference
transferable_invariant: complementary normalized hydrodynamic cues may establish confidence in carrier-state rejection, but their magnitude must stay bounded and their sign must not become a persistent route command
nontransferable_details: published gains, species-specific kinematics, dimensional force scales, clocked CPG phase, exact vortex phase, cylinder-wake synchronization, full-body envelopes, and prescribed routes
policy_translation: fuse band-passed absolute local body-frame crossflow and normalized lateral force by a bounded soft union, then multiply only the existing de-meaned anterior-joint pose correction under the two-joint state-feedback contract
falsification: reject if capture, middle or late closure, or the target-directed wake regresses, or if speed, saturation, normalized force, or yaw moment exceeds the sampled parent envelope without compensating progress
```

## Evidence boundary

All numerical and visual outcome claims above come from completed sampled
CFD, the assigned parent, and inherited optimizer logs.  The flow-load fusion
candidate introduced here has not been evaluated by CFD in this workspace.

## No-CFD implementation audit

- The candidate policy SHA-256 is
  `3200ce3b14cb1ae4108a1864ad1491de3b4453a673231cd3f7fb1c70aa2cd6d5`.
  Relative to v38, executable changes are limited to reading normalized
  lateral force, one owned force scale, the bounded confidence fusion, and
  using that confidence for the existing two-degree proportional pose term.
- On the assigned-parent trace, mean crossflow/load/fused confidence is
  `0.83597/0.83426/0.96843` before `4 T`,
  `0.80905/0.91248/0.98537` from `4-14 T`, and
  `0.69086/0.91640/0.97584` after `14 T`.  Fused confidence remains in
  `[0,1]`; the mean absolute pose term is `0.751/1.012/1.015 deg` over those
  intervals and cannot exceed its unchanged `2 deg` bound.  The frozen-trace
  action difference from v38 averages `0.0705 rad/T^2`, peaks at
  `2.1002 rad/T^2`, and is not a closed-loop performance claim.
- With both hydrodynamic cues zero, candidate action is bit-identical to v38.
  A `16,875`-state sweep over distance, bearing, both joint angles, anterior
  joint rate, crossflow, and lateral load returns two finite accelerations
  within the unchanged `31.41593 rad/T^2` componentwise limit.
- The deterministic schema audit finds all `62` direct `params.FIELD`
  references among the `64` fields returned by `target_policy_params()`.
  The guidance-semantic check, lightweight Julia contract check, and solver
  boundary check pass.  The duplicated assigned-parent marker in the rendered
  workspace README was relabeled as a repeated sample so the prescribed
  guidance checker can unambiguously resolve the same parent.
