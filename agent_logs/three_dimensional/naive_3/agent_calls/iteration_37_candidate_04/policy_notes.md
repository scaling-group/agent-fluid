# Route-wide adverse-yaw posterior residual candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite traces, and capture termination. They have the same policy
  hash, byte-identical combined keyframe sheet, complete trajectory, and score.
  This fourfold replication is the strongest finite reference: capture at
  `16.93205T`, score `-0.20004481`, mean distance `2.08513085L`, crossing
  distance `0.74389035L`, and sublimit joint-speed peaks near
  `258.93/259.20 deg/T`.
- I inspected the combined sampled sheet from release through capture,
  including its top-down vorticity row and oblique body/Lambda2 row. The fish
  self-propels continuously toward the target while shedding a coherent
  alternating red/blue street; the oblique views retain compact, detached
  three-dimensional caudal structures through the capture sphere. There is no
  passive drift, held-joint coast, wake collapse, collision, or domain exit.
  The diagnostics agree: peak fish speed is about `1.391U`, whereas peak
  sampled local flow is only about `0.0327U`.
- I also inspected both rows of the latest informative inherited regression,
  the target-ray-rate terminal feedforward rollout. Its wake and gross path are
  visually indistinguishable from the replicated parent and it still captures,
  but score, mean distance, and crossing depth regress to
  `-0.204430`, `2.088655L`, and `0.748136L`. This follows two collision-corridor
  steering releases and an agreement-gated terminal yaw-rate increment that
  also retained capture but failed to beat the parent. Wake coherence is not
  the missing capability; adding or subtracting terminal course authority is
  an exhausted local mechanism on the available route.
- The parent trace instead shows a route-wide signed load opportunity. Its
  target-course request is large for much of the rollout (mean absolute turn
  request about `0.758`), and measured yaw moment opposes that request in about
  `53%` of samples. The existing successful signed-moment residual can act only
  during posterior speed-guard donor events, so most adverse-load observations
  cannot affect corrective work. This supports testing response-conditioned
  work allocation outside the terminal-only family while leaving the carrier,
  target-course geometry, and mechanical guards unchanged.

## Single-candidate policy hypothesis

Preserve the replicated zero-centered anterior oscillator, posterior traveling
carrier, normalized body-frame target/velocity-course request, posterior
acceleration reserve, smooth acceleration shoulder, high-onset positive-power
speed guards, proven donor-event work transfer, and posterior stopping-risk
projection. Add exactly one feedback mechanism: a small route-wide posterior
curvature residual that is nonzero only when measured yaw moment opposes the
current target-relative turn request. The residual follows the requested turn
sign, saturates on the already evidenced normalized moment scale, and passes
through the same acceleration allocation and safety layers as nominal steering.
It therefore cannot introduce a fixed bend, world-frame route, external phase,
or actuator bypass.

The intended effect is to spend corrective posterior work on the adverse-load
parts of the existing rhythmic route, reducing lateral/yaw loss without
changing favorable halves or asking for stronger nominal drive. Expect capture
with the same alternating three-dimensional wake and seek a lower mean distance
or deeper crossing than `2.08513085L/0.74389035L`. Falsify the mechanism if it
loses capture or wake coherence, changes the useful broad approach into a new
failure topology, fails to beat the replicated score, touches a joint limit,
exceeds `0.5993 rad` posterior angle or `0.0370/0.0184` force/yaw-moment peaks
without a semantic benefit, or merely reproduces a failed terminal overlay.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive swimming under measured hydrodynamic loads
source_mechanism: preserve a coupled propulsive rhythm while bounded signed sensor feedback adds corrective work only during an adverse measured response
transferable_invariant: retain the productive traveling bend and allocate a small residual only when target-relative intent and measured yaw moment identify an opposing load
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, full-body oscillator networks, exact vortex phases, capture radius, and task-specific routes
policy_translation: use normalized body-frame target/velocity-course feedback for intent and `moment_z_L2` for response; add a bounded same-sign posterior curvature residual under adverse yaw, then pass it through the inherited reserve, soft envelope, speed guards, work transfer, and stopping-risk projection
falsification: reject if replicated capture or alternating three-dimensional shedding is lost, if mean distance and crossing depth do not improve, or if joint viability, posterior excursion, or force/moment loads exceed the sampled parent without semantic benefit
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD observation-overlap check after the edit

Projecting only the new adverse-yaw gate over the 3,079 recorded parent
observation/load pairs activates the curvature residual in 1,513 samples, from
`0.105T` through capture. The residual is capped at exactly `2 deg`, and its
mean magnitude when active is about `0.803 deg`. Thus the test is route-wide
and behaviorally non-inert rather than another terminal-only scalar edit. This
projection does not evolve joint, body, or fluid state and is not evidence that
capture, score, or loads will improve.
