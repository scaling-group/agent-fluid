# Replicated-best multi-wake carrier after three-generation plateau

## Visual and metric diagnosis before candidate selection

- The four sampled solvers contain byte-identical policies, trajectories, and
  combined keyframe sheets. Each is a finite capture from direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, zero cylinders, no
  prewarm snapshot, and 237 moving-window shifts. Each reaches `0.743958L` at
  `16.604496T`, with score `-0.1137286` and scored distance integral
  `1.998146L`. The assigned parent's completed evaluation reproduces those
  values. These exact nominal repeats establish fixed-case determinism, not
  robustness to a different pose or flow.
- I inspected both rows of the shared sampled sheet from release to capture.
  The top-down row shows self-propelled left/down target closure on a shallow
  crossing arc and a coherent alternating mid-plane vorticity street. The
  oblique row shows compact alternating three-dimensional Lambda2 structures
  connected to the posterior body and traveled path. There is no passive
  advection, inherited wake, collision, boundary exit, wake breakup, or
  numerical instability.
- The most informative visual negative control available in inherited evidence
  is the completed closure-qualified terminal yaw release. Its top-down arc and
  oblique tail-connected wake are visually indistinguishable at sheet scale,
  and it captures one `0.0055T` step earlier. The metrics reject it: score
  regresses to `-0.1140375`, distance integral to `1.998380L`, and crossing
  depth to `0.744276L`, while both joints still reach `4.537856 rad/T` and
  the peak planar force/moment remain `0.037165/0.018356`. Wake coherence and
  nominal arrival alone therefore do not validate terminal feedback release.
- The assigned-parent optimizer log supplies a second completed negative
  control. Removing a carrier-correlated local-flow component retained capture
  at `16.604496T` and the same visible wake class, but worsened score/integral/
  crossing depth to `-0.115121/1.999280L/0.745252L`; mean requested actions
  were unchanged and moment rose slightly. Together with the inherited
  alignment, closure-deficit, and projected-corridor regressions, this leaves
  no measured nominal disturbance or terminal deficit for another gate.
- The inherited chain now contains three consecutive completed generations
  without a new semantic outcome or useful trajectory class. That activates
  the later-iteration bookshelf consultation rule. The shelf's useful
  invariant is to preserve an evidenced traveling carrier and add or remove a
  feedback channel only for an independently observed deficit. The present
  evidence supplies no such deficit, so adopting a new primitive or tuning a
  scalar would make the next CFD result uninterpretable as evidence-led control.

## Sole candidate selection

Keep exactly the prefilled normalized body-frame two-joint policy, byte-for-byte
identical to all four sampled captures and the assigned parent. It preserves
the full anterior traveling-wave carrier, raw target geometry, raw-course
anterior center, mean-preserving yaw and lateral response demodulation,
unmodified relative-crossflow feedback, posterior half-cycle steering, smooth
acceleration bound, and final-one-percent one-sided speed guard. Do not restore
terminal yaw release, local-flow phase subtraction, another target transform,
or a scalar-only gain change.

This is the sole multi-wake target-policy candidate in `solver/`. Expected
test: reproduce semantic capture, the connected two-view wake, `16.604496T`
arrival, `1.998146L` distance integral, `0.743958L` crossing depth, and the
sampled action/load envelope. Falsify the selection if the exact policy and
fixed configuration fail to reproduce those quantities; do not interpret
another nominal repeat as held-out robustness.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, sensor-modulated robotic-fish CPG direction tracking, and wake-interaction control
source_mechanism: preserve a productive rhythmic carrier and change a separate bounded route or disturbance channel only when completed response evidence identifies a specific deficit
transferable_invariant: an alternating carrier-correlated motion or flow component is not itself an error; preserve it unless removing or modulating it improves target semantics or cost without damaging propulsion
nontransferable_details: published gains, dimensional beat frequencies, species or robot kinematics, exact vortex phases, fitted coefficients from another gait, capture thresholds, and source-task routes
policy_translation: retain the evaluated normalized body-frame two-joint carrier and its demonstrated response separation; decline a new primitive or scalar tuning after terminal release and local-flow residual controls preserved wake class but regressed target cost
falsification: reopen the architecture only if a completed held-out pose or flow, or a meaningfully different trajectory, exposes a repeatable response deficit that a single bounded mechanism corrects while preserving capture, wake connectivity, joint feasibility, effort, force, moment, and score

## Evaluation boundary

No CFD result is claimed for this workspace's candidate. Favorable evidence
belongs to completed sampled and parent rollouts; negative controls belong to
completed inherited rollouts. The current policy is supported only for the
fixed direct-still-water task. Later evidence should treat exact duplicate
rollouts as one behavioral result and compare semantic outcome, trajectory,
both wake views, crossing depth, joint contact, feasible action, force, and
moment before scalar score.
