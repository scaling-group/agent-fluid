# Evidence-selected stroke-aware course-preview candidate

## Visual diagnosis before the policy edit

- All sampled and inherited comparison rollouts use direct uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and finite moving-
  window dynamics. Their translation and wakes are self-generated.
- Both rows of the combined sheets were inspected for the reproducible
  course-preview capture, its stroke-aware sibling, the inherited response-
  gated child, and the informative pre-preview failure. The pre-preview policy
  remains self-propelled with a coherent alternating top-down wake and compact
  oblique Lambda2 structures, but passes at `1.092L`, turns upward, and exits
  at `37.493T` with final distance `6.369L`. Wake loss is not its failure; its
  route is.
- The body-frame velocity/target course preview is the semantic improvement.
  Three identical sampled policies capture at `24.580T`, final distance
  `0.746968L`, and mean distance `2.360L`, while retaining the coherent wake.
- The behaviorally distinct sampled stroke-aware allocator also captures,
  at `24.618T` and `0.748724L`. Relative to the course-preview parent it cuts
  posterior hard-stop occupancy from `23.52%` to `12.82%`, mean absolute raw
  posterior acceleration from `42.65` to `39.50rad/T^2`, and peak normalized
  planar force/yaw moment from `0.323/0.143` to `0.203/0.089`. Raw acceleration-
  envelope exposure and rate-limit exposure remain effectively unchanged
  (`72.84%` to `72.65%` and `15.15%` to `15.10%`). The `0.0385T` arrival delay
  and `0.00208` score cost are small relative to this physical improvement.
- The inherited response-gated refinement is a negative discriminator. It
  still captures, but later at `24.761T`, and restores posterior stop occupancy
  to `22.10%` with peak force/moment `0.274/0.121`; conditioning relief on
  course alignment is worse than the unconditional joint-state guard on every
  intended safety outcome.

## Policy hypothesis

Materialize the evaluated stroke-aware course-preview controller unchanged as
this workspace's single candidate. Preserve the target-course preview,
traveling-wave carrier, closing-sector steering priority, and posterior
recapture. Only when the posterior joint is near its hard stroke and the
existing steering component pushes farther outward, continuously reduce that
posterior priority claim and admit the already-bounded inward carrier. This is
a state-dependent actuator-allocation mechanism, not a curvature or gain-only
retune, and it is dormant inside the stroke reserve or for inward steering.

The expectation is repeated capture-class topology with the sampled reduction
in posterior pinning and peak load. Falsify the transfer if the new evaluation
loses capture, changes the far route or coherent wake, arrives materially later
than the sampled `24.618T` class, or fails to reduce posterior stop/load exposure
from the unguarded course-preview parent. Do not infer the unevaluated rollout
outcome from same-state replay.

bookshelf_consulted: true
source_domain: Lighthill elongated-body posterior reactive thrust and sensor-modulated robotic-fish burst redirection
source_mechanism: retain a lagged posterior propulsive beat while bounded curvature redirects the swimmer, then hand actuator authority back without driving the tail farther into a stroke stop
transferable_invariant: when corrective steering consumes a finite posterior stroke but can only push farther outward, preserve the useful redirect while continuously restoring bounded inward carrier authority
nontransferable_details: species-specific kinematics, published gains, dimensional cadence, full-body envelopes, exact vortex phase, turning radius, and task-specific routes
policy_translation: use normalized observed posterior joint angle and the signed two-joint steering decomposition to soften only the posterior priority allocator near an outward hard-stop request; preserve all body-frame course and target feedback
falsification: reject if capture, far-route geometry, or wake coherence is lost; if posterior hard-stop residence or peak load does not fall; or if rate and acceleration-envelope exposure rise materially

## Pre-evaluation checks

- The candidate SHA-256 is
  `ae63cc9c0b9abb9f67698c74a5b82ba0c55573cba75579a0338e9228eeb90716`,
  byte-identical to the sampled stroke-aware capture controller. All `82`
  direct `params.FIELD` references resolve among the `84` fields returned by
  `target_policy_params()`, and exactly one non-empty candidate policy exists.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this ChatGPT account. Its three prescribed no-CFD checks
  were then run directly and separately. The reusable-guidance check first
  exposed the inherited duplicate assigned-parent marker in the rendered
  `README.md`; removing only that duplicate made the check pass. The lightweight
  Julia public-contract check and solver editable-boundary audit also pass.
- No formal CFD was run. The sampled capture is evidence for selecting this
  candidate, not a claim about its post-worker evaluation.
