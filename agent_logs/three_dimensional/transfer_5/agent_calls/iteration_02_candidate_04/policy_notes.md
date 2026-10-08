# Response-released C-bend candidate

## Evidence diagnosis

- All sampled rollouts report direct uniform initialization in still water with
  `U_infinity=(0,0,0)`; none is a prewarm artifact.
- The assigned-parent candidate `solver_d594e3893325` is the sole capture. In
  both keyframe rows it remains self-propelled, retains a coherent alternating
  wake through its broad turn, and reaches `0.7495L` at `25.39T`. Numerically it
  improves monotonically at the coarse keyframe scale from `12.328L` to capture,
  with mean distance `2.557L`, but still reaches the `260 deg/T` joint-speed cap
  in `12.7%` of anterior-joint and `3.2%` of posterior-joint samples and exhibits
  large alternating yaw-rate excursions up to `2.78 rad/T`.
- The transferred carrier `solver_24bf67867ea8` also forms a coherent wake and
  self-propels from `12.328L` to `4.780L`, so its failure is steering rather than
  propulsion: it crosses below the target, regresses to `9.709L`, and exits the
  lower boundary at `27.49T`, with both joints contacting the speed cap.
- The two response-gated posture replacements do not support suppressing the
  proven carrier. `solver_7ddfece27e92` and `solver_f578f8771e8a` visibly curl
  into tight turns with weak/non-alternating downstream wakes, make only
  `0.466L` and `0.155L` closest-approach gains, and exit the upper boundary by
  `9.01T` and `7.99T`. Their bend translation also reverses the successful
  candidate's request-to-curvature sign. The latter spends `78.0%` of samples
  on a posterior angle limit and reaches much larger lateral force/moment peaks
  (`0.292`, `0.175`) than the capture (`0.026`, `0.014`).

## Policy hypothesis

Retain `solver_d594e3893325`'s same-sign, geometry-gated C-bend and its complete
state-feedback traveling-wave carrier. Add only a smooth response-release gate:
large body-frame target error receives the existing full redirect while yaw is
absent or opposite the request; once bounded geometric target yaw and
`turn_rate_recent` have the same sign, continuously release part of the C-bend.
Because redirect load already
controls anterior center shift, posterior lag, and drive relief, this one gate
restores propulsive wave authority without a separate mode or clock. It should
reduce unnecessary sustained curvature and speed-limit contact while preserving
the capture topology. Falsify it if capture is lost, arrival/mean distance
worsens materially, the route reverts to either boundary-exit topology, or wake
coherence and actuator-limit exposure degrade.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological C-start/burst redirect and closed-loop robotic-fish CPG modulation
source_mechanism: strong curvature for large directional error, followed by response-triggered release into posteriorly lagged propulsion
transferable_invariant: steering posture should yield continuously to the propulsive carrier once observed yaw follows the body-frame turn request
nontransferable_details: species kinematics, published gains and frequencies, exact bend shape, dimensional timing, vortex phase, and task-specific routes
policy_translation: gate the existing normalized target-error C-bend by a bounded function of target yaw request times observed recent turn rate, retaining a nonzero redirect floor and the two-joint state-feedback oscillator
falsification: reject if the prior capture is lost, the wake collapses, joint limit contact rises, or distance/termination topology fails to improve
```
