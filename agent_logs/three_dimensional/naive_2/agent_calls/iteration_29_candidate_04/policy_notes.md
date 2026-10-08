# Replicated capture carrier after the continued nominal plateau

## Visual and metric diagnosis before candidate selection

- The four sampled solver artifacts contain the same policy
  (`452903db...`), combined keyframe sheet (`6d2c1aa...`), trajectory, and
  metrics. Each is a finite capture from direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, no prewarm
  snapshot, and 237 moving-window shifts. Each reaches `0.743958L` at
  `16.604496T`, with score `-0.1137286`, scored distance integral
  `1.998146L`, and observed distance integral `1.377718L`. These are exact
  nominal replications of one behavior, not four independent controller tests
  or evidence of held-out robustness.
- I inspected the shared combined sheet from release through capture. The
  top-down row shows acceleration from rest, self-propelled left/down closure
  on a shallow target-crossing arc, and a coherent alternating mid-plane
  vorticity street. The oblique row shows finite compact Lambda2 structures
  connected to the posterior body and traveled path. There is no inherited
  wake, passive advection, collision, boundary exit, wake breakup, or
  numerical instability. At the final crossing the fish is still translating
  (`velocity=(-1.100,-0.270)U`) while the coherent carrier remains active.
- No differing failure is present in the sampled set. The most informative
  completed contrast in the inherited optimizer logs is therefore the
  closure-qualified terminal yaw-response release: it preserved capture and
  the same visible route/wake class and arrived one `0.0055T` step earlier,
  but worsened score, distance integral, and crossing depth from
  `-0.113729/1.998146L/0.743958L` to
  `-0.1140375/1.998380L/0.744276L` without a joint, action, force, or moment
  benefit. The carrier-synchronous local-flow subtraction is an independent
  negative control: it retained the same arrival and wake class but regressed
  to `-0.115121/1.999280L/0.745252L`, with effectively unchanged action and
  a slightly larger moment.
- The assigned-parent guidance and inherited logs also record regressions from
  closure-deficit relief, projected-corridor steering, line-of-sight-rate
  feedforward, bearing demodulation, and moment residualization. Together with
  three consecutive completed incumbent selections, the evidence exposes no
  remaining nominal propulsion, route, terminal, or disturbance-response
  deficit. This activates the later-iteration bookshelf consultation rule,
  but does not support a new primitive or scalar-only gain change.

## Sole candidate selection and hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-identical to the four sampled captures and the assigned parent. This sole
candidate preserves the full traveling-wave carrier, raw normalized body-frame
target geometry, raw-course anterior center, mean-preserving joint-phase
demodulation of yaw and body-lateral response, unmodified relative-crossflow
feedback, phase-compatible posterior half-cycle steering, smooth acceleration
bound, and the one-sided final-one-percent joint-speed guard.

The hypothesis is conservative and falsifiable: because no completed nominal
control isolates a useful residual, retaining the evaluated carrier should
reproduce semantic capture, its connected two-view wake, `16.604496T`
arrival, `1.998146L` distance integral, `0.743958L` crossing depth, and the
sampled feasibility/load envelope. Reject this selection if the fixed-policy
rollout loses capture or fails to reproduce trajectory, wake class, joint
contact, feasible effort, force, or moment. Reopen architecture work only when
a held-out pose, flow, or target produces a repeatable response deficit that
can distinguish one bounded mechanism. A further exact nominal repeat remains
one behavioral result and does not establish robustness.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, sensor-modulated robotic-fish CPG direction tracking, asymmetric flapping, and wake-interaction control
source_mechanism: preserve a productive rhythmic carrier while assigning route, terminal, and disturbance corrections to separate bounded feedback channels only when completed response evidence identifies a deficit
transferable_invariant: carrier-correlated oscillation or flow is not itself an error; preserve the demonstrated carrier and change one response channel only for an independently observed control deficit
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, fitted coefficients from another gait, capture thresholds, and source-task routes
policy_translation: retain the evaluated normalized body-frame two-joint controller exactly; decline another terminal gate, phase residual, new primitive, or scalar tuning after completed controls preserved wake/capture class but worsened target cost without feasibility or load benefit
falsification: reopen the architecture if a completed held-out condition exposes a repeatable route, disturbance, or terminal-response deficit that one bounded mechanism corrects while preserving propulsion, capture, wake connectivity, joint feasibility, effort, force, moment, and score

## Evaluation boundary

No CFD result is claimed for this workspace's candidate. Favorable evidence
belongs to the completed sampled and parent rollouts; changed-controller
negative evidence belongs to inherited logs. The new candidate evaluation runs
after this worker exits. Later workers should compare semantic outcome first,
then trajectory topology, both wake views, arrival, scored and observed
distance integrals, crossing depth, joint contact, near-limit residence,
requested action, force, and moment.
