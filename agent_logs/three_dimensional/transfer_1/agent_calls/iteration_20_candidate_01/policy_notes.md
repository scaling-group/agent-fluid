# Evidence-selected carrier-coherent crossflow-pose candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled solver examples satisfy the frozen Phase-2 contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `capture` termination.  They are
  behaviorally identical geometry-only bearing-divergence controllers and
  reproduce capture at `18.403006 T`, score `-0.140449`, total distance
  integral `2.027810 L`, and observed distance integral `1.418099 L`.
- The inherited optimizer logs provide one distinct completed result.  The
  carrier-coherent crossflow-pose controller captures at `18.325987 T` and
  reduces the observed integral slightly to `1.417990 L`.  Its lower scalar
  score (`-0.141865`) and larger total integral (`2.028916 L`) come from a
  shallower discrete terminal crossing and larger terminal-hold term, so they
  do not erase the semantic arrival improvement.  The result is mixed rather
  than dominant: relative to geometry-only it is `0.0043 L` closer at `4 T`,
  `0.0150/0.0187 L` farther at `8/12 T`, and `0.0103 L` closer at `16 T`.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows of the
  combined sheets for the geometry-only parent and the inherited crossflow
  result from release through capture.  Both are visibly self-propelled along
  the same smooth target-directed arc from quiescent water, with compact
  startup structures developing into a coherent alternating mid-plane wake
  and organized three-dimensional posterior structures.  The crossflow result
  is subtly farther along at the late matched frame; neither sheet shows
  passive advection, wake collapse, collision, domain exit, a prewarm artifact,
  or numerical instability.
- The earlier arrival has a modest action/speed cost rather than a load cost.
  Geometry-only versus crossflow-pose mean/max speed is
  `0.6961/0.9476` versus `0.6988/0.9631 L/T`, and any-joint acceleration-limit
  residence is `42.14%` versus `43.55%`.  Peak normalized planar force remains
  `0.03068`, while peak normalized yaw moment changes from `0.01587` to
  `0.01580`.  The inherited wrong-sign whole-wave route-rate projection remains
  the informative failure boundary: an organized wake alone did not prevent
  an upward wrong-sign turn and `left_domain` exit at `8.4755 T`.

## One-candidate policy hypothesis

Materialize the completed carrier-coherent crossflow-pose controller as the
single candidate.  Preserve the evaluated geometry-only controller's
state-feedback traveling wave, posterior lag, raw large-error redirect,
mean-preserving whole-wave pose projection, head-only route-rate correction,
raw half-cycle steering, response-released cadence, approach scheduling,
head-to-tail rejected-steering allocation, and componentwise acceleration
bounds.  Add only the inherited bounded pose correction: use normalized local
body-frame crossflow magnitude to weight the observed, de-meaned anterior
joint phase, and add the resulting odd carrier term only to proportional
gait-pose rejection.  Persistent crossflow sign is not allowed to become a
one-sided route command, and the term is excluded from raw redirect geometry,
rate feedback, carrier dynamics, and direct actuator commands.

The candidate should reproduce capture near `18.326 T`, preserve the coherent
two-view wake, and retain the late-route improvement without exceeding the
completed `0.9632 L/T`, `43.6%`, `0.03068`, and `0.01580` speed, saturation,
force, and moment envelope.  Falsify the mechanism if capture is lost or not
earlier than the `18.403 T` geometry-only parent, observed distance integral
exceeds `1.41810 L`, the middle-route deficit persists without compensating
late closure, the wake or target-signed arc changes qualitatively, or action,
speed, force, or moment grows materially.  Formal CFD for this materialized
candidate occurs only after worker exit; all outcome claims here refer to the
completed inherited rollout.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish control
source_mechanism: separate slow target geometry from fast alternating crossflow and apply only a bounded carrier-coherent correction to the latter
transferable_invariant: an observed body-frame crossflow common mode may refine gait-pose rejection when its sign is anchored to observed joint phase and kept separate from route steering
nontransferable_details: published gains, species kinematics, exact vortex or tail-beat phase, the inherited two-degree bound and crossflow scale, cylinder-wake synchronization, full-body envelopes, and prescribed routes
policy_translation: weight de-meaned anterior joint phase by bounded normalized local-crossflow magnitude and add the odd term only to the proportional whole-wave pose correction under the existing two-joint state-feedback contract
falsification: reject if capture or late closure does not improve, the mid-route deficit grows, the coherent wake or target-signed arc degrades, or speed, saturation, normalized force, or yaw moment materially exceeds the completed envelope
```

## Evidence boundary

The sampled solver results establish the reproduced geometry-only baseline;
the assigned parent and inherited optimizer logs supply the crossflow result
and the whole-wave-rate failure boundary.  No same-worker CFD improvement is
claimed.

## No-CFD implementation audit

- The materialized policy has SHA-256
  `caf53964dfa849a2d8b0adc1d74f20a5e01e7f108340101d73168dbc981c7b89`,
  byte-identical to the completed inherited crossflow-pose controller.
- The lightweight Julia check returns two finite accelerations within the
  unchanged public policy contract.  The deterministic schema audit finds all
  `61` direct `params.FIELD` references among the `63` fields returned by
  `target_policy_params()`.
- The required guidance-semantic check and solver-boundary check pass.  No CFD
  rollout was run in this workspace.
