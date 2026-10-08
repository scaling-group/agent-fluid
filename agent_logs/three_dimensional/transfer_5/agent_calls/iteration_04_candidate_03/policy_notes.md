# Terminal yaw-relief candidate

## Evidence diagnosis

- All four sampled rollouts are contract-valid direct-uniform still-water
  evaluations with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their
  candidate files differ only in comments and `version`; the returned numeric
  parameters and executable feedback are identical. Accordingly they produce
  the same `4341`-step trajectory, keyframe sheet, `23.8755T` capture,
  `2.4357L` mean scoring distance, and `0.7490L` final distance. They are one
  deterministic result, not four independent mechanism tests.
- The sampled top-down row shows self-propelled motion along a broad
  target-directed arc with a compact alternating vortex street. The oblique
  Lambda2 row confirms persistent three-dimensional alternating shedding from
  release through capture. The earlier C-bend parent's two rows show the same
  useful topology but reach capture later, at `25.388T`; there is no sampled
  failure keyframe in this rendered workspace, so the informative upper-exit
  static-curl failure is available only through the inherited optimizer notes.
- The composed response-release plus smooth command envelope slightly improves
  the independently tested smooth-envelope result (`23.997T`, `2.438L`) while
  keeping acceleration below `1798 deg/T^2` and peak lateral load/yaw moment
  near `0.0240/0.0141`. The composition is therefore hydrodynamically useful,
  but the improvement is small and its actuator interaction is not additive:
  posterior `>=95%` speed-limit exposure is `9.38%` versus about `4.5%` for the
  smooth-envelope parent, and peak yaw rate is `2.949 rad/T` versus `2.922`.
- The terminal trace localizes the remaining weakness. Between `3L` and `1.5L`
  the body-frame bearing moves from approximately `-0.006` to `+0.213 rad`
  while yaw rate grows from `-1.27` to `-2.16 rad/T`; by capture yaw has swung
  to `+1.78 rad/T`. Both views retain a coherent wake, so this is excess
  response within a useful carrier rather than wake collapse or weak thrust.
  Another scalar cadence or bend-gain edit would not address that separation.

## Policy hypothesis

Retain the evaluated traveling-wave carrier, same-sign geometry-gated C-bend,
response-release gate, and fourth-order acceleration projection unchanged. Add
one continuous terminal response mechanism: when normalized distance is near,
closing speed is positive, and the magnitude of observed recent yaw exceeds
the magnitude of target-derived yaw demand, reduce only the oscillator
amplitude by a bounded amount. Mean redirect posture remains intact, and the
relief vanishes when far away, not closing, or still short of requested yaw.
This should damp the large terminal yaw cycle without coasting prematurely or
reintroducing the static-curl failure.

Falsification: reject the mechanism if capture is lost or later than
`23.8755T`, mean distance materially exceeds `2.4357L`, posterior speed-limit
exposure does not fall below `9.38%`, peak yaw does not improve from
`2.949 rad/T`, or either visual row loses the coherent alternating wake. A
score improvement without better yaw/speed-limit histories is insufficient.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal fish-swimming approach control
source_mechanism: sensed excess body response continuously reduces rhythmic drive authority near the goal while target-referenced steering posture remains available
transferable_invariant: separate propulsive carrier amplitude from mean steering and yield only the excess carrier authority when measured yaw exceeds current geometric demand
nontransferable_details: published CPG gains, species-specific amplitude envelopes, dimensional maneuver timing, exact vortex phase, and task-specific routes
policy_translation: derive a bounded relief from normalized distance, positive normalized closing speed, target-derived yaw demand, and recent yaw; apply it only to the two-joint state-feedback oscillator amplitude before the existing final command projection
falsification: loss or delay of capture, worse mean distance, unchanged or larger yaw and posterior speed-limit exposure, or degraded alternating wake invalidates the transfer
```

## Worker-side verification boundary

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its specified checks were therefore run
  directly where the environment supports them; no CFD was run.
- The guidance semantic check passes after pruning the duplicated assigned-parent
  marker from the rendered workspace README, and the solver editable-boundary
  check passes.
- A deterministic schema audit finds `65` returned parameter fields, `63`
  distinct direct `params.FIELD` references, no missing fields, exactly one
  `target_policy_params` definition, and exactly one `target_policy` definition.
- The exact Julia include/contract assertion cannot run because this workspace
  has no `julia` executable. Algebraically, terminal proximity, closing, yaw,
  and drive-relief gates are each clamped or passed through `tanh`, so the new
  signal remains in `[0,1]`; the inherited smooth final projection remains the
  command-envelope boundary. These checks establish contract structure and
  boundedness, not the pending hydrodynamic outcome.
