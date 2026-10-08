# Replicated-best carrier after local-flow residual falsification

## Visual and metric diagnosis before candidate selection

- The four sampled solvers are byte-identical policy and combined-keyframe
  repeats of the prefilled controller. Each satisfies the released contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, finite moving-window dynamics, and capture.
  Each reaches `0.743958L` at `16.604496T` with score `-0.1137286`, scored
  distance integral `1.998146L`, and 237 moving-window shifts. This establishes
  nominal fixed-case reproducibility, not held-out pose or flow robustness.
- I inspected both rows of the sampled combined sheet from release through
  capture. The top-down row shows self-propelled left/down target closure on a
  shallow crossing arc and a coherent alternating mid-plane vorticity street.
  The oblique row shows finite, compact, alternating three-dimensional Lambda2
  structures connected to the posterior body and traveled path. There is no
  passive advection, inherited wake, collision, boundary exit, wake breakup,
  or instability.
- The most informative completed contrasting rollout is the inherited
  carrier-synchronous local-flow residual. I inspected both of its visual rows
  as well. It retains the same self-propelled arc and tail-connected alternating
  wake class and captures at the same `16.604496T`, but its target crossing is
  shallower: final distance worsens from `0.743958L` to `0.745252L`, distance
  integral from `1.998146L` to `1.999280L`, and score from `-0.113729` to
  `-0.115121`; the moving-window shift count also changes from 237 to 236.
- The local-flow residual supplies no compensating feasibility or load result.
  Mean absolute requested accelerations are effectively unchanged
  (`21.733/22.674` versus `21.733/22.673 rad/T^2`), both joints reach the same
  `4.537856 rad/T` speed boundary with identical near-speed residence, peak
  planar force changes only from `0.037165` to `0.037137`, and peak moment
  increases from `0.018356` to `0.018413`. A phase fit explaining about `77%`
  of local lateral-flow variance therefore identified correlation, not a
  nuisance component whose removal improves control.
- The assigned-parent logs independently show that late alignment-based yaw
  release retained capture but regressed to `-0.1140375`, while inherited
  closure-deficit and projected-corridor descendants likewise preserved the
  coherent wake yet worsened target cost. Together these controls leave no
  evidenced nominal response deficit for another terminal gate or another
  phase subtraction.

## Sole candidate selection

Keep exactly the prefilled joint-phase-demodulated yaw/lateral-response policy,
byte-identical to all four strongest sampled captures. Preserve its full
traveling-wave carrier, raw body-frame target geometry, raw-course anterior
center, mean-preserving yaw and body-lateral response demodulation, unmodified
relative-crossflow cue, posterior half-cycle steering, smooth acceleration
bound, and final-one-percent one-sided speed guard. Do not add the falsified
local-flow carrier subtraction, another transformed target signal, or a new
terminal gate.

This is an evidence-backed candidate selection rather than an unevaluated
architecture or scalar retuning. Expected test: reproduce capture, the
connected two-view wake, and the sampled target-cost and actuator envelopes.
Falsify it if the next rollout loses capture, changes wake class, or fails to
reproduce arrival, distance cost, crossing depth, joint contact, feasible
action, force, or moment. A nominal repeat still does not establish held-out
pose or flow robustness.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve productive rhythmic locomotion while applying only bounded observed disturbance residuals that improve route or load behavior
transferable_invariant: separate the productive traveling carrier from route and disturbance feedback, but do not cancel carrier-correlated flow unless completed behavior shows that the removed component is harmful rather than useful or neutral
nontransferable_details: published gains, dimensional beat frequencies, species or robot kinematics, exact vortex phases, fitted coefficients from another gait, and source-task routes
policy_translation: retain the evaluated normalized body-frame two-joint controller and its raw relative-crossflow channel; reject the local-flow phase subtraction after it preserved wake class but worsened target cost without a feasibility benefit
falsification: reopen local-flow residualization only if a completed held-out flow or pose exposes a repeatable disturbance error and the translated residual preserves propulsion while improving capture, route, joint feasibility, effort, force, moment, and score

## Evaluation boundary

No CFD result is claimed for this workspace's candidate. Its favorable evidence
belongs to four completed sampled rollouts; the local-flow and terminal negative
controls belong to completed inherited rollouts. Later evaluation should require
capture and the same top-down/oblique wake class first, then compare arrival,
score, scored and observed distance integrals, final crossing depth, trajectory
topology, joint contact, near-limit residence, requested action, force, and
moment against the exact samples. The present evidence supports preservation
only for this carrier and nominal direct-still-water task.
