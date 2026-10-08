# Replicated carrier after the stagnation-triggered shelf review

## Visual and metric diagnosis before candidate selection

- The assigned parent is the joint-phase-demodulated yaw/lateral-response
  controller already present in `solver/`. All four sampled solvers contain
  that exact policy (`452903db...`) and byte-identical trajectories and
  combined keyframe sheets. Each is a finite capture from direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot,
  and 237 moving-window shifts. Each reaches `0.743958L` at `16.604496T`,
  with score `-0.1137286` and scored distance integral `1.998146L`. These
  repeats establish nominal reproducibility, not held-out robustness or a new
  controller mechanism.
- I inspected both rows of the shared sampled sheet from release to capture.
  The top-down vorticity row shows self-propelled left/down translation on a
  shallow target-crossing arc and a coherent alternating wake. The oblique
  Lambda2 row shows finite, compact three-dimensional structures connected to
  the posterior body and traveled path. There is no inherited wake, passive
  advection, collision, domain exit, wake breakup, or numerical instability.
- The most informative completed contrasting rollout is the inherited
  closure-qualified yaw-response hold. I read its observation and diagnostics
  and inspected both rows of its combined sheet. It preserves the same visible
  route and tail-connected wake class and captures one `0.0055T` step earlier,
  but the crossing is shallower (`0.744276L` versus `0.743958L`), the distance
  integral is worse (`1.998380L` versus `1.998146L`), and the score regresses
  to `-0.1140375`. Mean requested acceleration and peak action, joint speed,
  planar-force component, and yaw moment are effectively unchanged, so the
  terminal hold supplies no compensating feasibility or load improvement.
- The assigned-parent guidance and inherited optimizer logs add independent
  negative controls: closure-deficit half-cycle relief, a projected capture
  corridor, line-of-sight-rate feedforward, bearing demodulation, moment
  residualization, and local-flow carrier subtraction all retained finite or
  capturing behavior but worsened target cost. The last three completed
  inherited selections then reproduced the same incumbent without a new
  mechanism or semantic gain. That sequence triggers a fresh bookshelf
  consultation under the structured protocol, but it does not expose a
  physical deficit that would distinguish another shelf primitive.

## Sole candidate selection

Keep the prefilled normalized body-frame controller byte-identical as this
workspace's one candidate. It retains the full traveling-wave carrier, raw
target bearing and anterior course center, mean-preserving yaw and lateral
response demodulation, unmodified relative-crossflow feedback, posterior
half-cycle steering, smooth acceleration bound, and the one-sided final-one-
percent joint-speed guard. Do not add another nominal terminal gate,
disturbance residual, phase modulation, or scalar gain change.

This is an evidence-constrained selection, not a same-worker CFD improvement
claim. Expected test: reproduce capture, the connected two-view wake, and the
sampled distance, action, joint, and load envelope. Falsify the selection if
the next rollout loses capture or fails to reproduce arrival, distance cost,
crossing depth, wake class, joint feasibility, effort, force, or moment. A new
mechanism should be reopened only after a completed held-out pose/flow/target
rollout or a meaningfully different trajectory identifies a specific response
deficit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking, asymmetric flapping, wake-interaction control, and terminal prey-capture control
source_mechanism: separate a productive rhythmic carrier from bounded route, disturbance, and terminal feedback, recruiting a new channel only for an observed response deficit
transferable_invariant: preserve an evidenced traveling carrier and its state-derived response separation when candidate feedback channels do not improve semantics, route cost, feasibility, or loads
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, capture thresholds, and task-specific routes
policy_translation: retain the sampled two-joint body-frame controller exactly; the direct-still-water evidence cannot identify a useful new terminal, disturbance, or phase-modulation channel after the completed negative controls
falsification: reject preservation if nominal capture or the connected wake fails to replicate, or if held-out evidence isolates a response deficit that one bounded state-feedback primitive corrects without degrading approach, feasibility, loads, or score

## Evaluation boundary

No CFD result is claimed for this workspace's candidate. Favorable evidence
belongs to the four completed sampled rollouts; the changed-controller
negative results and the three later incumbent selections belong to inherited
logs. Later evaluation should require capture and the same two-view wake class
first, then compare arrival, scored and observed distance integrals, crossing
depth, trajectory topology, joint contact, near-limit residence, requested
action, force, and moment. Nominal direct-still-water replication remains
insufficient evidence of robustness to another pose, target, or flow.
