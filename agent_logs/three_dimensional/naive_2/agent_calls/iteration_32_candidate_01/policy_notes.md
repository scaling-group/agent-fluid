# Evidence-constrained multi-wake candidate after duplicate nominal captures

## Visual diagnosis before candidate selection

- I inspected the shared combined keyframe sheet from release through capture,
  including both the top-down mid-plane vorticity row and the oblique 3D
  body/Lambda2 row. The top-down row shows acceleration from rest followed by
  a shallow left/down target-closing arc and a coherent alternating wake. The
  oblique row shows compact three-dimensional structures connected to the
  posterior body and traveled path through the head crossing. The motion is
  self-propelled rather than advected; neither view shows collision, domain
  exit, wake breakup, inherited flow, or numerical instability.
- The visual claims agree with the metrics and diagnostics. All four sampled
  policies and trajectories are byte-identical, as are their combined sheets.
  Each starts from direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot; each completes
  237 moving-window shifts and captures at `16.604496T`, with
  `0.743958L` final/minimum distance, `1.998146L` scored distance integral,
  and score `-0.113729`. Distance falls from `12.327720L`, and the final
  velocity remains targetward at about `1.133U`. The trace remains finite,
  with inherited peak planar force/moment near `0.0372/0.0184` and joint speed
  reaching the released `260 deg/T` envelope under the narrow outward-only
  speed guard.
- There is no visually distinct failure comparator in this Phase-2 workspace:
  all thirteen available sampled and inherited combined sheets have the same
  hash. The most informative failures are therefore completed metric
  comparisons retained by the assigned parent, not an invented image
  contrast. Qualified terminal yaw release crossed one `0.0055T` step earlier
  but regressed crossing depth, distance integral, and score to
  `0.744276L/1.998380L/-0.114037`; local-flow carrier subtraction retained
  capture and wake class but regressed to
  `0.745252L/1.999280L/-0.115121` without a feasibility or load benefit.
  Inherited line-of-sight-rate, bearing, moment, posterior-relief, closure, and
  projected-corridor variants likewise failed to improve the capture carrier.
- Raw evidence-file inequality does not provide a new physical comparison.
  The four current `wake_metrics.csv` and diagnostics hashes differ because
  wall-clock timings, generated metadata, and artifact paths differ, while
  executable policy, full trajectory, visual sheet, termination, and physical
  metrics match exactly. These rollouts collapse to one deterministic nominal
  behavior and do not establish held-out robustness or four independent
  controller mechanisms.
- The assigned-parent logs and at least three preceding completed selections
  contain neither a new mechanism nor a semantic or useful-trajectory
  improvement, so the structured bookshelf consultation is required. The
  current nominal evidence still exposes no response deficit that can select a
  new bounded primitive without repeating an already-falsified perturbation.

## Sole candidate and falsifiable policy hypothesis

Select the prefilled normalized body-frame controller byte-identically as this
workspace's one candidate. It preserves the demonstrated full traveling-wave
carrier, raw target geometry and anterior course center, mean-preserving yaw
and lateral-response demodulation, unmodified relative-crossflow feedback,
posterior half-cycle steering, smooth acceleration bounding, and the
outward-only final-one-percent joint-speed guard. Do not add a nominal terminal
hold, carrier-correlated disturbance residual, phase modulation, or scalar gain
change when completed controls show no physical deficit for it to correct.

This is an evidence-constrained selection, not a same-worker CFD improvement
claim. The next evaluation should reproduce capture, the connected two-view
wake, `16.604496T` arrival, `1.998146L` distance integral, `0.743958L`
crossing, and the sampled joint/action/load envelope. Falsify preservation if
nominal replication fails. Reopen one compact mechanism only after a completed
nonduplicate or held-out pose, target, or flow rollout identifies a repeatable
directional, disturbance-response, or actuator-feasibility deficit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking
source_mechanism: preserve a productive rhythmic carrier and recruit distinct bounded sensor feedback only for an independently observed tracking deficit
transferable_invariant: carrier-correlated motion is not itself an error; when completed feedback perturbations retain wake class but worsen target cost without improving feasibility or loads, preserve the evidenced traveling carrier until nonduplicate evidence isolates a deficit
nontransferable_details: published gains, dimensional frequencies and speeds, species or robot kinematics, exact vortex phases, fitted coefficients from other gaits, capture thresholds, prescribed wake geometry, and task-specific routes
policy_translation: retain the evaluated two-joint normalized body-frame controller exactly; the duplicate nominal evidence cannot select another terminal, disturbance, phase, or scalar channel after the inherited negative controls
falsification: reopen one bounded state-feedback primitive only if a completed nonduplicate or held-out rollout isolates a repeatable deficit, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

Favorable values belong to the four completed sampled rollouts and the
assigned-parent repeats; changed-controller negative values belong to inherited
completed evidence. This workspace's selected candidate remains unevaluated
until the worker exits. Exact nominal replication establishes determinism, not
robustness to another pose, target, or flow.
