# Replicated multi-wake carrier after a fourth evidence-preserving selection

## Visual and metric diagnosis before candidate selection

- The four sampled solvers have identical policy, trajectory, and combined-
  keyframe hashes. Each is a finite capture from direct uniform still water
  with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and 237
  moving-window shifts. Each reaches `0.743958L` at `16.604496T`, with score
  `-0.1137286`, scored distance integral `1.998146L`, and no instability.
  These are deterministic nominal repeats, not four independent trajectory
  classes and not evidence of held-out pose, target, or flow robustness.
- I inspected the shared combined sheet and both view-specific sheets from
  release to capture. The top-down row shows acceleration from rest and
  self-propelled left/down target closure on a shallow crossing arc, with a
  coherent alternating mid-plane vorticity street. The oblique row shows
  compact alternating three-dimensional Lambda2 structures connected to the
  posterior body and traveled path. There is no passive advection, inherited
  wake, collision, boundary exit, wake breakup, or numerical instability.
- No sampled failure exists in this generation: all four policies,
  trajectories, and sheets are byte-identical. The most informative completed
  negative controls therefore come from the inherited guidance and optimizer
  logs. Terminal yaw release, posterior half-cycle relief, projected-corridor
  gating, line-of-sight-rate feedforward, bearing or moment residualization,
  and carrier-correlated local-flow subtraction all retained finite or
  capturing behavior but worsened target cost. The local-flow child, for
  example, preserved arrival and wake class yet regressed from
  `-0.113729/1.998146L/0.743958L` score, distance integral, and crossing depth
  to `-0.115121/1.999280L/0.745252L`, without a feasibility or load benefit.
- The inherited sequence contains at least three consecutive completed
  selections with neither a new mechanism nor a semantic improvement, so the
  structured bookshelf consultation is required. The shelf offers no
  evidence-backed reason to force another terminal, disturbance, phase, or
  scalar channel into a nominally capturing controller.

## Sole candidate and policy hypothesis

Select the prefilled normalized body-frame two-joint controller unchanged as
this workspace's one candidate. It preserves the evaluated traveling-wave
carrier, raw target geometry, raw-course anterior center, mean-preserving yaw
and lateral-response demodulation, unmodified relative-crossflow feedback,
posterior phase-compatible steering, smooth acceleration bound, and narrow
one-sided speed guard.

The hypothesis is deliberately conservative: because the sampled population
collapses to one deterministic trajectory and inherited changed-controller
controls all regress, preserving the byte-identical carrier is more
informative than inventing an unmotivated mechanism or scalar retune. The next
evaluation should reproduce capture, the connected two-view wake, arrival,
distance cost, crossing depth, joint contact, feasible effort, force, and
moment. Falsify this selection if nominal replication fails, or reopen one
bounded primitive only when a completed held-out pose, target, or flow exposes
a specific directional-response deficit that the incumbent does not handle.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking, asymmetric flapping, wake-interaction control, and terminal prey-capture control
source_mechanism: preserve productive rhythmic locomotion and recruit a bounded route or disturbance channel only for an independently observed response deficit
transferable_invariant: separate the evidenced traveling carrier from route and disturbance feedback, and require completed behavioral evidence before changing either part
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, capture thresholds, and task-specific routes
policy_translation: retain the sampled normalized body-frame two-joint carrier exactly; byte-identical nominal captures and inherited negative controls do not identify a useful new terminal, residual, or phase-modulation channel
falsification: reject preservation if nominal capture or the connected wake fails to replicate, or if held-out evidence isolates a deficit that one bounded state-feedback primitive corrects without degrading approach, feasibility, loads, or score

## Evidence boundary

No CFD result is claimed for this workspace's candidate. Favorable evidence
belongs to the four completed sampled rollouts; changed-controller negative
results belong to inherited completed rollouts. Artifact equality must be
checked before treating a sampled population as diverse evidence. Later
evaluation should compare semantic capture first, then arrival, scored and
observed distance integrals, crossing depth, trajectory topology, both wake
views, joint limits, requested action, force, and moment.
