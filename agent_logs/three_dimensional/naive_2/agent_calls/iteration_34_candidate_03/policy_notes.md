# Evidence-preserving multi-wake target-policy candidate

## Visual and metric diagnosis before candidate selection

- The four sampled solvers and the prefilled candidate have identical policy
  SHA-256 `452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`.
  Their trajectories, combined keyframe sheets, and both view-specific sheets
  are also byte-identical. Every rollout starts directly from uniform still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot; each
  captures at `16.604496T`, crosses at `0.743958L`, has scored distance
  integral `1.998146L`, scores `-0.113729`, and remains finite through 237
  moving-window shifts.
- I inspected both visual views from release to capture. The top-down row shows
  acceleration from rest, sustained left/down target closure on a shallow
  crossing arc, and a coherent alternating vorticity street connected to the
  tail. The oblique row shows finite, compact three-dimensional Lambda2
  structures along the traveled path through capture. With zero background
  flow, this is self-propelled motion rather than passive advection; there is
  no collision, boundary exit, wake breakup, or instability.
- The assigned parent's five inherited completed rollouts have the same policy,
  trajectory, combined sheet, and capture metrics as the four samples. Thus
  nine available evaluations collapse to one nominal behavior. They establish
  deterministic replication only, not nine controller mechanisms, distinct
  trajectory classes, or held-out pose, target, and flow robustness.
- No sampled failure image exists. The informative failure contrast is limited
  to inherited completed evidence: qualified terminal yaw-response release,
  posterior relief, projected-corridor gating, line-of-sight-rate feedforward,
  bearing or moment residualization, and carrier-correlated local-flow
  subtraction retained finite or capturing motion but worsened target cost.
  In particular, the closest terminal release arrived one `0.0055T` step
  earlier yet regressed from `0.743958L`, `1.998146L`, and `-0.113729` to
  `0.744276L`, `1.998380L`, and `-0.114037`, without a meaningful feasibility
  or load benefit. This is a metric-level negative control, not a claimed new
  image comparison.
- Capture occurs during productive motion rather than a terminal equilibrium:
  the final speed is about `1.133U` and recent yaw rate is `2.239 rad/T`, while
  the capture semantics, connected wake, joint motion, and force/moment history
  remain finite. Those endpoint values alone do not diagnose a defect in this
  first-crossing, no-dwell task.

## Sole candidate and falsifiable hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-identical as this workspace's one candidate. It preserves the evidenced
full traveling-wave carrier, raw target geometry and anterior course center,
mean-preserving yaw and lateral-response demodulation, relative-crossflow
feedback, phase-compatible posterior steering, smooth acceleration bound, and
narrow one-sided joint-speed guard. The current evidence identifies neither a
failed semantic class nor a disturbance signature that could select a new
bounded channel; another scalar tune or terminal/residual recombination would
repeat already falsified work.

Expected result: nominal capture with the same target-directed arc, connected
two-view wake, arrival, distance cost, crossing depth, joint feasibility,
effort, force, and moment envelope. Reject preservation if nominal capture does
not replicate. Reopen one bounded body-frame mechanism only after a completed
held-out pose, target, or flow rollout exposes a repeatable response deficit,
and reject it if the established nominal envelope degrades.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking, asymmetric flapping, wake-interaction control, and biological or learned terminal capture
source_mechanism: separate productive rhythmic locomotion from bounded route, disturbance, and terminal corrections, recruiting a correction only for an observed response deficit
transferable_invariant: preserve an evidenced state-feedback traveling carrier when repeated nominal rollouts contain no miss or disturbance signature and completed correction channels regress
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, capture schedules, and task-specific routes
policy_translation: retain the sampled normalized body-frame two-joint controller exactly; the current direct-still-water evidence cannot identify a useful terminal, wake-residual, or phase-modulation addition
falsification: reject preservation if nominal capture or the connected wake fails to replicate, or if held-out evidence isolates a deficit that one bounded state-feedback primitive corrects without degrading approach, feasibility, loads, or score

## Evidence boundary

No CFD result is claimed for this workspace's candidate; its evaluation occurs
after this worker exits. Favorable evidence belongs to the sampled and inherited
completed rollouts, while changed-controller negative results belong to the
inherited guidance. Later comparisons should require semantic capture first,
then assess arrival, scored and observed distance integrals, crossing depth,
trajectory topology, both wake views, joint contact, speed-limit residence,
requested action, force, and moment.
