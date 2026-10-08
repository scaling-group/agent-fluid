# Stroke-reserve steering-redistribution candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform quiescent initialization with `U_infinity=[0,0,0]`, no cylinders or
  prewarm, finite dynamics, and inertial moving-window transport. Three exact
  evaluations of the assigned course-preview policy capture at `24.5795T`
  and `0.7470L`; the stroke-aware sibling also captures, at `24.6180T` and
  `0.7487L`.
- Both visual rows were inspected for the capture-class course-preview policy,
  its stroke-aware sibling, and the preceding informative steering-priority
  miss. The top-down vorticity sheets show a strong alternating wake following
  each translating body, and the oblique Lambda2 sheets show compact shed
  structures throughout approach. The preceding policy turns only after
  passing the target and exits on a broad northward arc after reaching
  `1.0760L`; course preview instead bends the self-propelled trajectory into
  the capture sphere before passage. Absent propulsion, wake breakup, and
  passive advection are not the current limitations.
- The reproducible capture policy is the control baseline: mean distance is
  `2.36044L`, raw acceleration exceeds the `1800deg/T^2` envelope on
  `55.56%/47.33%` of anterior/posterior trace samples, and rate-limit exposure
  is `9.33%/5.82%`. Its posterior joint is nevertheless pinned at `45deg` for
  `23.38%` of the episode, while the anterior joint never reaches its stroke
  limit and peaks at only `36.43deg`. Near capture, body-frame target geometry
  remains strongly lateral and the posterior steering request points farther
  into the occupied negative stroke, so this is an actuator-allocation issue,
  not evidence for more curvature gain.
- The sampled tail-only stroke guard is a useful but incomplete counterfactual.
  It preserves the same coherent visual route and capture class, halves
  posterior hard-stop occupancy to `12.60%`, and lowers peak logged lateral
  force/yaw moment from `0.1784/0.1426` to `0.1180/0.0893`. However, capture is
  `0.0385T` later and mean distance is slightly worse (`2.36225L`). Its edit
  releases posterior steering priority to an inward carrier but does not use
  the demonstrably available anterior stroke to retain redirect authority.
  Copying that tail-only release or tuning its floor alone is not supported as
  a score improvement.
- Inherited optimizer notes corroborate the mechanism sequence. Sector
  interception without priority reached only `2.579L`; steering priority
  improved that to `1.076L` but produced the hard-stop pass; course/target
  cross-product preview created the first capture. These completed results
  require preserving course preview and modifying only terminal allocation.

## Policy hypothesis

Start from the exact evaluated course-preview capture controller. Add a single
bounded stroke-reserve arbitration mechanism that is dormant unless the
existing terminal intercept request is active, the posterior joint approaches
its hard stop, and posterior steering points farther outward. In that state,
continuously release a small share of posterior steering priority so the
already-bounded inward traveling-wave carrier can recover posterior stroke,
and transfer a small same-sign share of steering to the anterior joint only
while that joint has directional stroke reserve. The mechanism uses observed
joint angle and decomposed carrier/steering acceleration; it adds no route,
clock, phase lookup, or world-frame command and is mirror-equivariant.

The falsifiable expectation is to preserve the pre-sector path and coherent
wake exactly, retain capture, keep posterior hard-stop occupancy materially
below the capture baseline's `23.38%`, and recover the tail-only guard's
`0.0385T` delay through anterior redirect authority. Reject the mechanism if
capture is lost, arrival is later than the tail-only sibling, posterior stroke
occupancy returns to the baseline class, or peak force/moment exceed the
course-preview baseline.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG turning
source_mechanism: release a bounded high-curvature redirect back into the propulsive rhythm when actuator state shows that further curvature cannot add useful turn, while retaining direction control through available degrees of freedom
transferable_invariant: separate rhythmic carrier from steering, use observed joint excursion to stop spending steering authority into a hard stop, and move only bounded residual redirect authority to an actuator with measured reserve
nontransferable_details: species-specific C-start shapes, published CPG gains, dimensional cadence, full-body joint maps, exact vortex phases, and task-specific routes
policy_translation: during the existing normalized body-frame terminal intercept only, form mirror-invariant posterior stroke and outward-steering gates from joint state, admit the inward posterior carrier, and apply a bounded same-sign steering transfer only when the anterior joint has directional stroke reserve
falsification: reject if the established pre-sector trajectory changes, capture is lost or delayed beyond the tail-only guard, posterior hard-stop occupancy is not reduced, the coherent wake degrades, or force/moment exceed the evaluated course-preview baseline

The shelf motivates carrier/steering separation and response-aware release; the
sampled capture, stroke occupancy, and tail-only tradeoff are the evidence for
this particular joint-space translation.

## Pre-evaluation checks

- All `85` direct `params.FIELD` references resolve among the `87` fields
  returned by `target_policy_params()`; only metadata fields `version` and
  `control_period` are not read directly by the candidate.
- A deterministic `24,576`-state grid spanning mirrored target geometry,
  distance, body-frame velocity, closing progress, bearing history, yaw rate,
  and joint state is finite. The `18,432` states with no active intercept or
  with posterior angle inside the stroke guard produce exactly the evaluated
  course-preview parent's two-joint output. All `256` direct reflection checks
  of the new stroke-reserve arbitration pass.
- Recorded-state replay on the replicated capture trace first activates the
  new mechanism at `18.5625T` and never before the terminal sector. This is a
  fixed-state counterfactual check, not a closed-loop performance claim.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed no-CFD commands were
  therefore run directly: reusable-guidance semantics, the exact lightweight
  Julia public-contract check, and the solver editable-boundary audit all
  pass. Formal CFD remains deferred to EvE after this worker exits.
