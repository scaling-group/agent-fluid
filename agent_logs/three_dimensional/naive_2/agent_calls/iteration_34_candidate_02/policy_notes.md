# Evidence-identifiable multi-wake target-policy candidate

## Visual diagnosis before candidate selection

- All four sampled policies and trajectories are byte-identical, and their
  top-down, oblique, and combined keyframe sheets are also byte-identical.
  Each run begins by direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Each remains
  finite through 3019 steps and 237 moving-window shifts, captures at
  `16.604496T`, crosses at `0.743958L`, records a `1.998146L` scored distance
  integral, and scores `-0.113729`. The sample is one deterministic nominal
  trajectory, not four distinct response experiments.
- I inspected both visual views from release through capture. The top-down
  frames show acceleration from rest, left/down target closure along a shallow
  arc, and an alternating mid-plane vorticity street connected to the tail.
  The oblique frames show compact alternating three-dimensional Lambda2
  structures attached to the posterior body and traveled path. In direct
  still water this is self-propulsion, not advection. Neither view shows wake
  breakup, collision, boundary exit, or a precursor to numerical failure.
- The visible approach agrees with the diagnostics: distance falls from
  `12.327720L` to capture, the final inertial velocity is
  `(-1.100098,-0.270060)U`, and the endpoint remains finite despite active
  translation and yaw. The current no-dwell task rewards the first crossing,
  so endpoint speed, yaw, and a live posterior beat are not by themselves a
  terminal-control defect.
- No sampled or available inherited keyframe sheet is an informative failure;
  every available sheet is the same capture. The nearest changed negative
  controls therefore come from completed inherited metrics and notes. A
  closure-qualified yaw-response release arrived one integration step earlier
  but regressed from `0.743958L/1.998146L/-0.113729` to
  `0.744276L/1.998380L/-0.114037` without a meaningful feasibility or load
  benefit. Carrier-correlated local-flow subtraction likewise kept capture
  and wake class but regressed to `0.745252L/1.999280L/-0.115121`. Completed
  line-of-sight-rate, bearing, moment, projected-corridor, and terminal-relief
  additions also failed to improve the demonstrated carrier.
- The sampled `wake_metrics.csv` files have different byte hashes only because
  wall-clock runtime and absolute artifact paths vary; their policy,
  trajectory, visual artifacts, termination, steps, shifts, and target metrics
  agree. Run-local provenance is not a body-frame response deficit and cannot
  identify a new feedback channel.

## Sole candidate and falsifiable hypothesis

Select the prefilled normalized body-frame two-joint controller byte-for-byte
as the one candidate in `solver/`. It retains the evidenced full traveling-wave
carrier, raw target geometry and anterior course center, mean-preserving yaw
and lateral-response demodulation, relative-crossflow feedback,
phase-compatible posterior steering, smooth acceleration bound, and narrow
one-sided joint-speed guard. No sibling candidate, scalar gain change, or
unidentified terminal/residual channel is introduced.

This is an evidence-constrained architecture decision, not a same-worker CFD
claim. The next evaluation should reproduce nominal capture, the shallow
target-directed arc, connected two-view wake, arrival, distance cost, crossing
depth, joint feasibility, action, force, and moment envelope. Reject this
selection if that nominal envelope does not reproduce. Reopen one compact
bounded primitive only after a completed path-independent or held-out pose,
target, or flow result exposes a repeatable body-frame response deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG direction tracking, wake-adaptive swimming, and prey-capture control
source_mechanism: preserve a productive posterior-lagged rhythmic carrier and recruit separate bounded route, disturbance, or terminal correction only for an observed response deficit
transferable_invariant: useful rhythmic body and wake motion should be preserved unless nonduplicate state-response evidence identifies it as harmful or insufficient
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed capture schedules, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the existing normalized body-frame two-joint carrier because every current sample is the same successful trace and completed terminal or residual variants regress
falsification: test one bounded state-feedback primitive only after a nonduplicate or held-out rollout isolates its error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

The favorable and negative values above belong to completed sampled and
inherited evaluations. The current candidate is unevaluated until this worker
exits. The absence of a failed visual artifact is recorded rather than replaced
with a scalar-only visual claim, and exact nominal replication does not
establish robustness to a changed pose, target, inflow, or imposed wake.
