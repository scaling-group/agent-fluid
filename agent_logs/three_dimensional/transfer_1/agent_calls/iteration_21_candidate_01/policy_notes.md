# Carrier-coherent crossflow-pose candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the Phase-2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and `capture` termination.  Three independent v34
  artifacts reproduce capture at `18.403006 T`, score `-0.140449`, total
  distance integral `2.027810 L`, and observed integral `1.418099 L`.
- I inspected both the top-down mid-plane vorticity and oblique body/Lambda2
  rows of the combined sheets for a reproduced v34 capture and the sampled
  v35 architectural regression from release through termination.  Both fish
  are visibly self-propelled along the same smooth target-directed arc: a
  compact startup wake becomes a coherent alternating posterior street in the
  top-down view and organized three-dimensional structures in the oblique
  view.  Neither shows passive advection, wake collapse, collision, domain
  exit, or instability.  The v35 yaw-and-closing release adds no visible wake
  benefit and captures slightly later at `18.414005 T`, with total/observed
  integrals `2.028719/1.418269 L`; it is also `0.000798 L` farther away near
  `16 T`.
- The sampled v34/v35 physical envelopes are effectively identical.  V34 has
  mean/max speed `0.69612/0.94760 L/T`, any-joint acceleration-limit residence
  about `42.17%`, and peak normalized planar force/yaw moment
  `0.03068/0.01587`; v35 has `0.69538/0.94760 L/T`, `42.12%`, and the same
  force/moment peaks.  The extra release is therefore a reproduced negative
  mechanism result, not justification for scalar retuning.
- The assigned-parent logs provide the strongest distinct finite comparator.
  The carrier-coherent crossflow-pose controller preserves capture and the
  same coherent two-view wake, arrives earlier at `18.325987 T`, and reduces
  observed integral slightly to `1.417990 L`.  Its worse scalar score
  `-0.141865` and total integral `2.028916 L` are terminal-sample sensitive,
  but its tradeoff is real: relative to v34 it is
  `0.0043 L` closer at `4 T`, `0.0150/0.0187 L` farther at `8/12 T`, and
  `0.0103 L` closer at `16 T`; mean/max speed rises to
  `0.69876/0.96311 L/T` and acceleration-limit residence to `43.58%`, while
  peak normalized force/moment remains `0.03068/0.01580`.
- The inherited wrong-sign whole-wave route-rate projection remains the
  informative failure boundary when no sampled run changes termination: it
  kept an organized wake but turned upward, exited at `8.4755 T`, improved
  only to `12.2107 L`, and raised peak normalized force/moment to roughly
  `0.3025/0.1347`.  An organized wake is not sufficient evidence that a
  correlated signal belongs in route-rate feedback.

## One-candidate policy hypothesis

Materialize the completed carrier-coherent crossflow-pose controller as the
single candidate.  Preserve v34's state-feedback traveling wave, posterior
lag, raw large-error redirect, geometry-only bearing-divergence recovery,
mean-preserving whole-wave pose projection, head-only route-rate correction,
raw half-cycle steering, response-released cadence, approach scheduling,
head-to-tail rejected-steering allocation, and componentwise acceleration
bounds.  Add only the completed bounded pose correction: use normalized local
body-frame crossflow magnitude to weight de-meaned anterior joint phase and
add the resulting odd carrier term to proportional gait-pose rejection.
Persistent crossflow sign cannot become a one-sided route command, and the
term remains outside redirect selection, rate feedback, carrier dynamics, and
direct actuation.

The candidate should reproduce capture near `18.326 T`, preserve the coherent
target-directed wake, and retain the late-route lead without exceeding the
completed `0.9632 L/T`, `43.6%`, `0.03068`, and `0.01580` speed, saturation,
force, and moment envelope.  Falsify the mechanism if capture is lost or not
earlier than `18.403 T`, observed integral exceeds `1.41810 L`, the mid-route
deficit grows without compensating late closure, the wake or target-signed arc
degrades, or the physical envelope materially worsens.  Formal CFD occurs
after worker exit; no same-worker outcome is claimed.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: separate persistent target geometry from fast carrier-correlated crossflow and confine the correction to the sensing path it explains
transferable_invariant: a normalized body-frame disturbance common mode may refine gait-pose rejection when anchored to observed joint phase and kept separate from route steering and propulsion
nontransferable_details: published gains, species kinematics, exact vortex or beat phase, dimensional crossflow scales, cylinder-wake synchronization, full-body envelopes, and prescribed routes
policy_translation: bound local crossflow, multiply only its magnitude by de-meaned anterior joint phase, and add the odd term solely to proportional whole-wave pose rejection under the two-joint state-feedback contract
falsification: reject if earlier capture and late closure do not reproduce, the mid-route deficit expands, the alternating wake loses coherence, or speed, saturation, normalized force, or yaw moment exceeds the completed envelope
```

## Evidence boundary

Numerical and visual claims above come only from completed sampled CFD, the
assigned parent, and inherited optimizer logs.  The current candidate's new
evaluation will become evidence for a later worker.

## No-CFD implementation audit

- The candidate has SHA-256
  `caf53964dfa849a2d8b0adc1d74f20a5e01e7f108340101d73168dbc981c7b89`
  and is byte-identical to the completed inherited crossflow-pose policy.
- The required guidance checker passes with a material reusable update.  The
  lightweight Julia contract returns two finite accelerations within the
  unchanged public interface, and the deterministic schema guard accepts all
  direct parameter references.
- The solver-boundary check passes with only
  `cases/dogfish_3d_shape_policy/candidate_target_policy.jl` changed from the
  frozen solver baseline.  No CFD was run.
- The configured check-runner invocation was attempted first, but its pinned
  model was unavailable for this account; the same three commands from
  `.codex/agents/check-runner.toml` were therefore executed locally and all
  passed.
