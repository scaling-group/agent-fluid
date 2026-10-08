# Replicated-best carrier after local-flow residual falsification

## Visual and metric diagnosis before candidate selection

- All four sampled solvers contain the same policy, trajectory, and combined
  keyframe sheet. Each is a finite capture from direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, no prewarm, and 237
  moving-window shifts. Each reaches `0.743958L` at `16.604496T` with score
  `-0.1137286` and scored distance integral `1.998146L`. The four repeats
  establish nominal reproducibility, not held-out pose or flow robustness.
- I inspected both rows of the shared sheet from release to capture. The
  top-down vorticity row shows acceleration from rest, persistent left/down
  targetward motion on a shallow crossing arc, and a coherent alternating
  wake rather than passive advection. The oblique Lambda2 row shows compact
  three-dimensional structures connected to the posterior body and traveled
  path through termination. There is no inherited wake, collision, domain
  exit, wake breakup, or numerical instability.
- The most informative completed inherited comparison is the new
  carrier-synchronous local-flow residual. I inspected both rows of its sheet;
  the route and tail-connected wake remain visually similar, and it captures
  at the same `16.604496T`. Yet subtracting the fitted local-flow phase term
  changes the final storage-window shift count to 236, worsens score to
  `-0.1151214`, raises distance integral to `1.999280L`, and makes the crossing
  shallower at `0.745252L`. Its final head also lies higher than the replicated
  control (`y=9.822140L` versus `9.775620L`). Thus high carrier correlation in
  a fluid measurement does not identify a nuisance component whose removal
  improves target control.
- This negative result follows completed regressions from line-of-sight-rate
  feedforward, bearing demodulation, moment-residual rejection, and three
  distinct terminal gates. Those controls retained finite or capturing
  behavior but did not beat the sampled carrier. The inherited evidence does
  not isolate a remaining nominal response deficit that warrants changing its
  wave, raw target geometry, response channels, or actuator guard.
- The assigned parent guidance therefore remains applicable: preserve the
  demonstrated full carrier and response separation until a completed
  trajectory exposes a new semantic or held-out deficit. The newly completed
  local-flow child sharpens that boundary from terminal/geometry signals to
  carrier-correlated fluid measurements; it does not support another edit.

## Sole candidate selection

Keep exactly the prefilled joint-phase-demodulated yaw/lateral-response policy,
byte-identical to all four strongest sampled captures. It preserves the full
anterior traveling carrier, raw body-frame target geometry and anterior course
center, mean-preserving yaw and lateral body-response demodulation, posterior
route/crossflow feedback, phase-compatible half-cycle steering, smooth
acceleration bound, and final-one-percent one-sided speed guard. Do not adopt
or gain-tune the failed local-fluid phase subtraction, and do not add another
nominal terminal or geometric transformation.

This is an evidence-constrained candidate selection, not a same-worker claim
of CFD improvement. Expected test: reproduce capture, the connected two-view
wake, and the sampled distance, trajectory, action, and load envelope. Falsify
the selection if the next rollout loses capture or fails to reproduce arrival,
distance cost, crossing depth, wake class, joint contact, feasible action,
force, or moment. A nominal repeat remains insufficient evidence of held-out
pose or flow robustness.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: keep productive rhythmic locomotion separate from bounded disturbance feedback and reject only disturbances identified independently of the carrier
transferable_invariant: preserve an evidenced traveling wave and require causal response evidence before removing a carrier-correlated component from a fluid-feedback channel
nontransferable_details: published gains, dimensional beat frequencies, species or robot kinematics, exact vortex phase, prescribed wake geometry, and source-task routes
policy_translation: retain the normalized body-frame two-joint carrier and its demonstrated kinematic response separation; decline the fixed local-flow phase residual after its completed nominal regression
falsification: reject preservation if capture or connected-wake replication fails, or if held-out imposed-flow evidence identifies a fluid disturbance that an independently observed bounded residual can reject without degrading the carrier

## Evaluation boundary

No CFD result is claimed for this workspace. Favorable evidence belongs to the
four completed sampled controls, while the local-flow and earlier negative
controls belong to completed inherited logs. Later evaluation should compare
semantic capture first, then arrival, scored and observed distance integrals,
crossing depth, route topology, both wake views, joint limits, near-limit
residence, requested action, force, and moment. A held-out wake may justify a
new disturbance estimator, but the direct-still-water phase fit does not.
