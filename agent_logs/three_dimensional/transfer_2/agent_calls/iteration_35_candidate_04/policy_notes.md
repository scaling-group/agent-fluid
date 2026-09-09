# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent is the response-released carrier-reversal policy. Its
  inherited step-32--34 score logs are three consecutive direct-task captures
  (`0.05319`, `0.05831`, and `0.05675`) without a new termination class. The
  durable parent guidance therefore calls for one new feedback mechanism rather
  than another rate, load, or steering scalar.
- All four sampled rollouts satisfy the experiment contract: direct uniform
  initialization, `U_infinity=(0,0,0)`, no prewarm, and capture termination.
  The two byte-identical all-distance response-release runs span
  `16.071--16.088T`, distance integral `1.82203--1.82366L`, and head path
  `13.129--13.166L`. The residual-redirect variant is slower and longer at
  `16.247T/1.82240L/13.363L`. The range-handoff variant is the strongest finite
  sample at `15.939T/1.82008L/13.107L`, with late `4/2/1L` milestones at
  `11.688/14.185/15.549T`.
- The combined sheets were inspected from release through capture in both the
  top-down mid-plane vorticity row and oblique Lambda2 row. They show genuine
  self-propulsion from quiescent water, a coherent alternating three-dimensional
  wake, target-directed translation, and no collision, domain-exit, or
  instability precursor. The weakest and strongest scalar samples retain the
  same broad wake class. The visible distinction is subtle approach topology,
  not wake creation: each trajectory has a modest late hook while the
  range-handoff sample reaches the sphere sooner on the shortest sampled path.
- Trajectory cross-checks keep the best sample's cost boundary explicit: peak
  planar force/yaw-moment coefficients are `0.03477/0.01715`, mean joint
  commands are `16.66/15.41 rad/T^2`, anterior/posterior greater-than-90%-rate
  residence is `17.70/8.25%`, and mean absolute body-lateral speed below `2L`
  is about `0.359U`. The all-distance response-release repeats have slightly
  lower rate residence and effort, so a hard distance-only handoff is not a
  free actuator improvement.

## Policy hypothesis

Start from the sampled range-handoff policy, but replace its unconditional
near-field withdrawal of negative-work reversal release with one compact
state-conditioned handoff. The already normalized, body-frame
`unfulfilled_redirect` combines velocity-course error, available course
authority, and absent same-sign yaw response. Use that directional demand to
restore phase-coupled carrier priority only while the approach actually needs
redirection; when the course request is small or measured yaw has answered it,
allow the negative-work reversal release to remain active. Keep propulsion,
route steering, redirect curvature, distance/closing relief, and every gain
unchanged so the later CFD result isolates this gating mechanism.

Expected effect: retain the best sample's early and late milestones while
avoiding unnecessary near-field carrier restriction on an already-aligned
approach, tightening path/effort or rate residence without destroying the
coherent wake. Falsify the mechanism if capture timing or distance integral
regresses outside the byte-identical response-release spread, if the short-path
class is lost, or if joint margin, greater-than-90/99%-rate residence, command
effort, force/moment peaks, terminal course, or either visual wake view worsens.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-feedback robotic-fish CPG modulation
source_mechanism: sustain bounded corrective curvature while directional error is unresolved, then release into the propulsive beat after measured response appears
transferable_invariant: gait allocation should follow normalized directional demand and measured response rather than elapsed time or a hard route stage
nontransferable_details: published gains, dimensional beat frequencies, species-specific C-start envelopes, exact vortex phase, full-body kinematics, and task routes
policy_translation: multiply the existing near-field carrier-priority handoff by the bounded body-frame unfulfilled velocity-course redirect, while preserving two-joint state-feedback steering and carrier dynamics
falsification: reject if repeat or held-out evaluation loses capture/coherent wakes or fails to improve path, timing-integral, or actuator residence beyond sampled variation without worse loads or joint margin
