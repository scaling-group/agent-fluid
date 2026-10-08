# Smooth-envelope, response-released C-bend candidate

## Evidence diagnosis

- All four sampled rollouts and the inherited comparison use direct uniform
  still water (`U_infinity=(0,0,0)`), no cylinders, and no prewarm snapshot.
  The evidence is therefore valid for this Phase-2 contract.
- The assigned prefill, evaluated as `solver_6c6aaae744be` (byte-equivalent in
  behavior to `solver_d594e3893325`), captures at `25.388T` with score
  `-0.6563` and mean scoring distance `2.557L`. Its top-down row shows a broad,
  target-directed arc behind a compact alternating wake; the oblique row
  confirms persistent three-dimensional vortex shedding through capture. The
  useful mechanism is self-propelled C-bend steering, not passive advection.
- The inherited failure `solver_f578f8771e8a` provides the semantic contrast:
  both views show a tight upward curl with a weak/non-alternating detached wake;
  it parks the posterior joint at `45 deg`, improves closest approach by only
  `0.155L`, and exits the upper boundary at `7.99T`. Strong posture replacement
  and the opposite bend translation must not be reintroduced.
- `solver_82fca3f02154` changes only the C-bend's response release. It preserves
  the same visible wake/arc topology, captures `0.237T` earlier, improves mean
  scoring distance from `2.557L` to `2.522L`, lowers peak yaw rate from
  `2.781` to `2.705 rad/T`, and reduces posterior `>=95%` speed-limit exposure
  from `6.28%` to `4.29%`. The evidence supports releasing some redirect once
  observed yaw agrees with the target-derived request, although anterior
  speed-limit exposure rises slightly (`20.69%` to `21.82%`).
- The strongest sampled result, `solver_953f16c610ad`, changes only the final
  acceleration projection. It preserves the alternating wake and broad
  target-directed arc, captures at `23.997T`, improves score to `-0.5403` and
  mean scoring distance to `2.438L`, and keeps peak lateral load/yaw moment
  (`0.0252`, `0.0141`) close to the prefill (`0.0255`, `0.0138`). Its recorded
  commands remain within `1798 deg/T^2`, versus prefill peaks of
  `4584/6217 deg/T^2`. It is the appropriate carrier for the new candidate.

## Policy hypothesis

Retain `solver_953f16c610ad`'s complete normalized body-frame C-bend controller
and fourth-order command projection. Add `solver_82fca3f02154`'s bounded
response-release gate upstream of that projection, without retuning either
mechanism: large body-frame target error keeps the proven same-sign redirect,
while agreement between bounded target yaw and observed recent turn rate
continuously restores some posterior lag, drive amplitude, and propulsive wave.
The response gate and command projection are compatible because the former
schedules posture-versus-wave allocation and the latter only bounds the final
two-joint command. This single composite candidate has no clock, route, mutable
state, or global-direction cue.

Falsification: reject the composition if it loses capture; is materially slower
or has worse mean distance than the `23.997T`, `2.438L` smooth-envelope parent;
recreates the inherited upper-exit curl; weakens the alternating 3D wake; or
increases angle/speed-limit exposure or peak force/moment. Because the two
positive deltas were evaluated separately, their combined hydrodynamic effect
is a hypothesis until the next CFD rollout.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG control
source_mechanism: bounded high-curvature redirect yields to a posteriorly lagged propulsive beat when observed yaw follows the requested direction
transferable_invariant: separate target-referenced mean turning from the traveling-wave carrier, release steering from measured response, and bound the combined actuation
nontransferable_details: published gains and frequencies, species-specific bend envelopes, exact vortex phase, dimensional maneuver timing, and task-specific routes
policy_translation: multiply normalized body-frame geometric redirect by a bounded target-turn-rate/recent-yaw agreement gate, retain the two-joint state-feedback oscillator and evidenced bend polarity, then smoothly project each combined acceleration into the actuator envelope
falsification: loss of capture, slower or less direct approach, degraded alternating wake, renewed upper-exit curl, or increased joint-limit/load exposure invalidates the composition
```

## Worker-side verification boundary

- The required guidance-semantic check passes after removing a duplicated copy
  of the same assigned-parent marker from the rendered workspace README.
- The editable-boundary check passes. A deterministic audit finds `60` returned
  parameter fields, `58` direct `params.FIELD` references, and no missing field;
  it also finds exactly one `target_policy_params` and one `target_policy`
  definition in the candidate.
- Algebraic edge checks keep the response gate in `[0.72, 1]` and the smooth
  projection finite and within `1800 deg/T^2` from subnormal through extreme
  finite inputs. These checks establish schema and boundedness, not a
  fluid-dynamic counterfactual.
- The exact Julia load/contract assertion could not run because this worker
  environment has no `julia` executable. The specialized check-runner also
  could not start because its pinned model is unavailable; its three specified
  commands were therefore executed directly where supported. No CFD was run.
