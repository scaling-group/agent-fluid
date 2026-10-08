# Evidence-constrained multi-wake carrier selection

## Visual and metric diagnosis before candidate selection

- I inspected the combined top-down-vorticity and oblique-Lambda2 sheets for
  two sampled solvers from release through termination. Their sheets, policies,
  and trajectories are byte-identical, and the other two sampled artifacts
  have the same hashes. All four therefore represent one deterministic nominal
  behavior rather than four independent policies or wake interactions.
- The shared top-down row shows the fish accelerating from rest, self-propelling
  left and down on a shallow target-crossing arc, and leaving a coherent
  alternating vorticity street. The oblique row shows compact alternating 3D
  structures connected to the posterior body and traveled path. There is no
  passive advection, inherited wake, collision, boundary exit, wake breakup,
  or numerical instability before capture.
- The diagnostics confirm direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and 237 lossless
  moving-window shifts. Every repeat captures at `16.604496T`, reaches
  `0.743958L`, has scored distance integral `1.998146L`, and scores
  `-0.113729`. The final trace still has `1.132762U` speed, `0.409227 rad`
  heading error, and `2.238745 rad/T` yaw rate; these are properties of a
  successful first-crossing phase, not evidence of a terminal miss.
- No sampled failure sheet exists in this generation. The informative failures
  are instead the inherited changed-controller controls. Qualified terminal
  yaw release crossed one `0.0055T` step earlier but regressed crossing depth,
  distance integral, and score to `0.744276L/1.998380L/-0.114037`; local-flow
  carrier subtraction retained capture and wake class but regressed to
  `0.745252L/1.999280L/-0.115121` without a feasibility benefit. Inherited
  line-of-sight-rate, bearing, moment, half-cycle, closure, and projected-
  corridor variants likewise failed to improve the demonstrated capture.
- The inherited sequence contains at least three completed iterations without
  a new mechanism, semantic improvement, or different useful trajectory, so
  the structured bookshelf consultation is active. Traveling-wave propulsion,
  route/asymmetry, response residualization, and approach scheduling are
  already represented by the incumbent or its completed negative controls;
  wake-disturbance primitives are not selected by nominal still-water evidence.

## Sole candidate and policy hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-identical to the four sampled policies as this workspace's one candidate.
It retains the evidenced full traveling-wave carrier, normalized body-frame
target geometry, mean-preserving yaw and lateral-response demodulation,
posterior route/crossflow feedback, phase-compatible steering, smooth
acceleration bound, and the one-sided final-one-percent speed guard.

This is an evidence-constrained null transfer, not a same-worker CFD result.
The next nominal evaluation should reproduce capture, both connected wake
views, arrival, route cost, crossing depth, joint/action feasibility, force,
and moment. Reject preservation if replication fails. Reopen one compact
mechanism only after a completed held-out pose, target, or flow, or a distinct
failed trajectory, isolates a repeatable response deficit that the mechanism
can address without degrading the demonstrated approach envelope.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, closed-loop robotic-fish CPG direction tracking, wake-interaction control, and terminal capture control
source_mechanism: preserve a productive rhythmic carrier and recruit a separate bounded route, disturbance, or terminal channel only for an observed response deficit
transferable_invariant: architecture review may reject every new primitive when the evidenced carrier captures and completed perturbations preserve wake class but worsen route cost without improving feasibility or loads
nontransferable_details: published gains, dimensional beat frequencies and speeds, species or robot kinematics, exact vortex phases, capture thresholds, and task-specific routes
policy_translation: retain the normalized body-frame two-joint carrier exactly; do not force another terminal, target-rate, moment, local-flow, or scalar channel into the nominal capture
falsification: reject preservation if nominal capture or connected-wake replication fails, or if held-out evidence isolates a repeatable deficit that one compact state-feedback primitive corrects without degrading approach, feasibility, loads, or score

## Evidence boundary

All favorable values belong to completed sampled rollouts, and the changed-
controller comparisons belong to inherited completed logs. This workspace's
candidate is unevaluated until the worker exits. Exact nominal repeats establish
determinism, not robustness to another pose, target, or imposed flow.
