# Crossflow-confidence pose candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the Phase-2 evidence contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `capture` termination.  Three
  policy-equivalent geometry-released controllers reproduce capture at
  `18.403006 T`, score `-0.140449`, total/observed distance integrals
  `2.027810/1.418099 L`, and final distance `0.747223 L`.  The sampled
  yaw-and-closure release arrives slightly later at `18.414005 T`, with score
  `-0.141536` and total/observed integrals `2.028719/1.418269 L`; it supplies
  no useful wake or load tradeoff and is not retained.
- I inspected the combined keyframe sheets for the reproduced geometry-only
  controller and the response-released comparator, including both the
  top-down mid-plane vorticity rows and the oblique body/Lambda2 rows from
  release through capture.  Both fish visibly self-propel from quiescent
  water along the same smooth target-signed arc.  Compact startup structures
  develop into a coherent alternating posterior wake; there is no passive
  advection, prewarm artifact, wake collapse, collision, domain exit, or
  numerical instability.  Their policy difference is too small to create a
  visually distinct wake before the terminal crossing.
- The inherited optimizer logs add two completed fluid-pose comparisons.  A
  full-route, crossflow-weighted anterior-phase correction captures at
  `18.325987 T` and improves observed integral to `1.417990 L`, but it is
  `0.0150/0.0187 L` farther from the target at `8/12 T`, raises maximum speed
  from `0.9476` to `0.9631 L/T`, and raises any-joint acceleration-limit
  residence from `42.14%` to `43.55%`.  Restricting the same correction to a
  late distance window captures at `18.386505 T`, improves observed integral
  further to `1.417769 L`, and preserves the base `0.9476 L/T`, `42.03%`,
  `0.03068`, and `0.01587` speed/saturation/normalized-force/moment envelope.
  Its lower scalar score, `-0.141953`, is caused by a shallower discrete final
  sample (`0.748874 L`) and terminal-hold integral, not a worse observed
  approach.
- I also inspected both visual rows for those completed inherited variants.
  They retain the same coherent alternating wake and target-directed arc; the
  full-route variant is visibly only subtly farther along in the terminal
  frame.  The current sample contains no failed termination, so the inherited
  whole-wave route-rate projection is the informative failure boundary: it
  preserved an organized wake yet turned upward, exited at `8.4755 T`, came no
  closer than `12.2107 L`, and generated about tenfold force/moment peaks.
- Cross-checking the traces localizes the full-route tradeoff to the measured
  flow regime.  In the reproduced base trace, mean absolute local body-frame
  crossflow is `0.00254 U` before `4 T`, `0.00537 U` from `4-14 T`, and
  `0.00220 U` after `14 T`.  Crossflow exceeds `0.006 U` in `39.66%` of the
  middle interval but only `2.37%` of the late interval.  The monotone
  crossflow weighting therefore has its greatest authority over the same
  middle interval where its completed route trails, whereas the terminal
  comparator establishes that lower-crossflow pose feedback can improve
  observed late closure without a speed, action, force, or moment penalty.

## One-candidate policy hypothesis

Preserve the reproduced geometry-released controller's state-feedback
traveling wave, posterior lag, raw large-error redirect, mean-preserving
whole-wave joint-pose projection, head-only route-rate correction, raw
half-cycle steering, closing-response cadence release, bearing-divergence
recovery, approach schedule, carrier-first rejected-steering allocation, and
componentwise acceleration bounds.

Add one bounded multisensory pose-confidence mechanism.  Normalize the
absolute local body-frame crossflow by the inherited rollout-calibrated scale,
pass it through a smooth band-pass confidence weight that is zero at no flow,
maximal at moderate flow, and decays for large flow, and multiply that scalar
by the observed de-meaned anterior carrier phase.  Add the resulting odd,
bounded term only to proportional carrier-pose rejection.  It must not enter
raw redirect geometry, bearing or yaw rates, the oscillator, or direct actuator
residuals.  Unlike the inherited terminal schedule, this gate uses neither
elapsed time nor a task-specific route segment; unlike the full-route monotone
weight, a large crossflow observation cannot claim increasing pose authority.

The candidate should retain the sampled controller's coherent wake and middle
route while recovering more of the completed crossflow variants' early/late
lead.  Falsify it if capture is lost or not earlier than `18.403 T`, observed
distance integral exceeds `1.41810 L`, the `8-12 T` deficit remains without a
larger late benefit, or maximum speed, acceleration-limit residence,
normalized force, or yaw moment materially exceeds the completed full-route
envelope `0.9631/43.55%/0.03068/0.01580`.  Formal CFD occurs only after this
worker exits, so these are hypotheses, not same-worker outcome claims.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish control
source_mechanism: separate slow target geometry from fast crossflow and trust only the smallest bounded flow feedback that remains coherent with the locomotor state
transferable_invariant: fluid-side pose feedback should have bounded confidence and should yield, rather than grow monotonically, when crossflow magnitude becomes disturbance-like
nontransferable_details: published gains, species kinematics, clocked CPG phase, exact vortex phase, cylinder-wake synchronization, full-body envelopes, prescribed routes, and the rollout-calibrated crossflow scale and two-degree pose bound
policy_translation: use normalized absolute local body-frame crossflow in a smooth band-pass confidence weight, multiply it by de-meaned observed anterior-joint phase, and add the odd bounded term only to proportional pose rejection under the two-joint state-feedback contract
falsification: reject if capture, middle or late closure, or the coherent alternating wake regresses, or if speed, saturation, normalized force, or yaw moment exceeds the completed envelope without compensating progress
```

## Evidence boundary

The numerical and visual outcomes above come from completed sampled CFD, the
assigned parent, and inherited optimizer logs.  The candidate introduced here
has not been evaluated by CFD in this workspace.

## No-CFD implementation audit

- The candidate policy SHA-256 is
  `bbe6ffbb32f9b95da3e575b44339c76746fcfd3d6d1420e7e7abed5983317d2a`.
  Relative to the reproduced geometry-only policy, its executable changes are
  limited to two owned parameters, reading normalized local body-frame flow,
  the bounded confidence calculation, and adding that pose term to the
  existing proportional carrier-yaw projection.
- On the reproduced base trace, the inherited monotone flow weight versus the
  candidate band-pass confidence averages `0.6290/0.8431` before `4 T`,
  `0.8626/0.8015` from `4-14 T`, and `0.5247/0.7025` after `14 T`; the new law
  attenuates the monotone term on `58.97%` of middle-interval samples while
  increasing authority in the lower-flow early and late regimes.  This is a
  frozen-trace mechanism check, not a closed-loop performance claim.
- The confidence is `0/1.0/0.8/0.6/0.05995` at local crossflow magnitude
  `0/0.003/0.006/0.009/0.1 U`, respectively, and the pose correction remains
  within its `2 deg` bound.  A zero-flow state produces an action bit-identical
  to the reproduced base, while a moderate-flow state is distinct.  A
  `7,560`-state distance, bearing, joint-phase, and crossflow sweep returns two
  finite accelerations within the unchanged componentwise limit.
- The deterministic schema audit finds all `61` direct `params.FIELD`
  references among the `63` fields returned by `target_policy_params()`, with
  no missing field.  The guidance-semantic check, lightweight Julia contract,
  and solver-boundary check all pass.  The prescribed check-runner was invoked
  but its pinned model was unavailable; its exact three no-CFD commands were
  therefore run locally and passed.
