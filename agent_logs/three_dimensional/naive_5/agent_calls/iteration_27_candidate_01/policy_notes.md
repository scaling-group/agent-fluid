# Course-priority response-conflict allocation

## Evidence diagnosis before editing

- All sampled and inherited evaluations use direct-uniform still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, and inertial moving-window
  transport. The strongest sampled policy captures at `0.748829L` and
  `26.2955T` in three byte-identical runs; its no-posterior-modulation control
  also captures at `0.749242L` and the same arrival time.
- Both rows of the strongest sampled sheet and the assigned-parent sheet were
  inspected from release through termination. Their top-down rows show genuine
  self-propulsion and a compact alternating wake followed by a late target-side
  hook. Their oblique Lambda2 rows show an orderly three-dimensional wake with
  no breakup, imposed advection, boundary interaction, or moving-window yaw.
  The assigned parent's arbitration changes the late heading but does not
  create a new visible route or wake topology.
- Metrics support the visual diagnosis. The assigned parent gives
  line-of-sight response priority over an opposing bearing/course half-cycle;
  it still captures, but later (`26.3395T`), at a slightly shallower sampled
  crossing (`0.749581L`), and with peak yaw moment rising from `0.009789` to
  `0.009862`. Its mean distance is effectively unchanged (`2.520067L` versus
  `2.519671L`). This meets its falsification boundary: withdrawing the direct
  route half-cycle in favor of the target-line request is not an improvement.
- The other inherited completed mechanism tests do not rescue this branch.
  Collision-cone redirect re-entry captures at `0.749413L` with a worse score,
  and true posterior half-cycle redistribution captures at `0.749146L` without
  a semantic route change. Together with the sampled posterior offset's maximum
  `0.000591L` centerline displacement, these results reject further terminal
  lag, waveform, corridor-threshold, or residual-amplitude tuning.

## Policy hypothesis

Retain the capture-proven traveling carrier, direct bearing/course half-cycle,
line-of-sight response law, posterior capture modulation, coordinated command
envelope, and joint viability guards. Add one complementary conflict allocator:
inside the inherited middle/near proximity window, when closing translation is
observable and a positive line-of-sight response deficit requests the opposite
side from the direct bearing/course channel, smoothly withdraw only that
opposing line-of-sight residual. The direct route half-cycle remains intact.
Agreement, adequate response, far travel, redirect behavior, and the posterior
terminal channel pass through exactly. This A/B test uses the failed parent's
same state gates but reverses which sensory steering request has priority; it
is a mechanism allocation, not a scalar gain retune.

The expected testable effect is a materially different middle/near approach or
deeper capture without delaying arrival, changing the coherent wake, or
restoring actuator contacts. Reject it if capture is lost, the result remains
in the milliscale-equivalent cluster, projected miss grows, arrival slows,
force/moment or limit exposure rises, or a held-out case shows that suppressing
the target-line response removes the only successful turn.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric half-cycle turning
source_mechanism: sensory feedback allocates steering authority to selected portions of a persistent propulsive rhythm
transferable_invariant: when two sensory steering requests oppose one another, resolve their authority without changing the underlying traveling carrier
nontransferable_details: published gains, robot morphology, clock phase, species kinematics, obstacle routes, exact vortex phases, and task coordinates
policy_translation: use normalized body-frame distance, closing speed, course observability, target-line response deficit, and request-side conflict to suppress only the opposing line-of-sight half-cycle during middle/near approach
falsification: reject if capture or coherent wake structure is lost, arrival or load exposure worsens, actuator contacts return, or the trajectory remains milliscale-equivalent to the sampled carrier

## Non-CFD audit after editing

- The parameter schema is exact. Synthetic finite states remain inside the
  `30 rad/T^2` policy envelope and produce sign-reflected two-joint commands
  under lateral reflection. Far, aligned-request, and non-closing states are
  command-identical to the sampled policy; an active conflict state changes
  only the anterior command.
- A frozen-state reconstruction over the completed assigned-parent trace
  changes 508 command rows, beginning at about `4.012L`. No state at or beyond
  the `4.25L` gate changes, the largest command difference is about
  `1.986 rad/T^2`, and the recorded peak command remains `29.726 rad/T^2`.
  This establishes selective, material activation only; it cannot establish
  hydrodynamic improvement. The new CFD rollout occurs after this worker exits.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account. Its exact three non-CFD commands were therefore
  run separately as the configured fallback; guidance semantics, Julia policy
  contract/schema, and solver editable-boundary checks all pass.
