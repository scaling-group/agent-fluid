# Stroke-relief steering-transfer candidate

## Evidence diagnosis before the policy edit

- All four current solver examples satisfy the frozen experiment contract:
  direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
  cylinders or prewarm, finite dynamics, and moving-window transport.  Three
  examples are byte-identical copies of the inherited course-preview policy;
  the fourth is the prefilled stroke-aware variant, so there are two distinct
  controllers rather than four independent mechanisms.
- Both rows of the combined keyframe sheets were inspected for the strongest
  current capture and the informative prefilled regression, and were compared
  with the inherited steering-priority domain-exit failure.  The top-down
  vorticity rows show self-propelled, alternating wakes through the established
  diagonal approach.  The oblique Lambda2 rows retain compact three-dimensional
  shed structures.  The failure continues past a `1.076L` near miss into a
  broad northward turn and upper exit; the capture policies bend into the
  target sphere before that runout.  Wake breakup or passive advection is not
  the current limitation.
- The assigned-parent course-preview controller is a reproducible success:
  capture at `24.5795T`, minimum/final distance `0.74697L`, mean distance
  `2.36044L`, and score `-0.46067`.  It nevertheless spends `23.38%` of trace
  samples at a joint hard stop, `15.15%` at a joint-rate limit, and `72.84%`
  with at least one raw acceleration above the envelope.  Its peak normalized
  planar force and yaw moment are `0.323` and `0.143`.
- The prefilled stroke-aware policy changes only posterior steering allocation
  near the observed tail limit.  It preserves capture and the visible route,
  while reducing hard-stop occupancy to `12.60%`, peak planar force to `0.203`,
  peak yaw moment to `0.089`, and raw acceleration-envelope exposure slightly
  to `72.65%`; rate-limit exposure is essentially unchanged at `15.10%`.
  Those are useful physical improvements.  They are not free: capture is
  delayed by `0.0385T`, mean distance rises to `2.36225L`, score falls to
  `-0.46276`, and the terminal capture margin shrinks from about `0.00303L` to
  `0.00128L`.  At `20T` and `24T` its posterior acceleration is materially
  less outward than the parent while the anterior command still has envelope
  headroom, consistent with safe tail release losing some intercept authority.
- The inherited optimizer notes isolate course preview—not terminal-only
  recapture—as the semantic improvement from the `1.076L` domain-exit parent.
  They also establish that the preview becomes active from about `13.44T` and
  that simply adding more posterior priority is unsupported because the tail
  is already held at `-45 deg` during the decisive approach.

## Policy hypothesis

Preserve the evaluated body-frame course preview, sector request, joint-state
traveling-wave carrier, and the prefilled posterior stroke guard.  Add one
compact actuator-allocation mechanism: when that guard releases an outward
posterior priority claim, measure the acceleration displaced by the release
and transfer a bounded fraction with the same steering sign to the anterior
joint, but only through its currently unused raw-command headroom.  The branch
is exactly dormant unless the existing body-frame intercept request, posterior
stroke proximity, and outward steering pressure are all present.  It cannot
increase the acceleration envelope and does not alter the carrier, the far
route, target-passage gates, or target-behind recapture.

The intended invariant is anterior steering substitution for a stroke-limited
posterior propulsor: preserve the tail's inward carrier recovery without simply
discarding the route correction.  The falsifiable expectation is to retain
most of the prefilled reduction in tail hard-stop and load exposure while
recovering capture time or margin toward the assigned parent.  Reject it if
capture is lost, the early diagonal changes, posterior hard-stop/load exposure
returns to the assigned-parent class, the head reaches its own hard stop, or
arrival is no better than the untransferred stroke-aware rollout.

## Bookshelf transfer record

bookshelf_consulted: true
source_domain: Lighthill-style elongated-body swimming and sensor-modulated robotic-fish steering
source_mechanism: anterior body bending supplies steering while posterior wave motion retains a propulsion-dominant role
transferable_invariant: when posterior stroke reserve is exhausted, preserve its inward traveling-wave recovery and move only the displaced bounded steering request upstream
nontransferable_details: reactive-force coefficients, published gains, species envelopes, dimensional cadence, exact vortex phases, full-body curvature, and task-specific routes
policy_translation: use normalized posterior stroke proximity and acceleration-envelope pressure, already gated by normalized body-frame course interception, to transfer only released tail steering into available anterior command headroom
falsification: reject if early commands change, capture is lost or delayed, posterior stroke and load relief vanish, anterior saturation appears, or coherent wake propulsion degrades

The shelf motivates the division of steering and propulsion roles; the paired
course-preview and stroke-aware CFD rollouts are the evidence for testing the
translation in this policy.

## Pre-evaluation checks

- The lightweight Julia public-contract check passes with a finite two-joint
  action.  All `83` direct `params.FIELD` references resolve among the `85`
  fields returned by `target_policy_params()`; only metadata fields `version`
  and `control_period` are not read directly.
- A deterministic `19,440`-state comparison with the evaluated stroke-aware
  policy spans target range and lateral sign, bearing, body-frame course,
  anterior/posterior joint phase, and posterior stroke.  The posterior output
  is exactly unchanged in every state.  The full output is exactly unchanged
  in `18,236` states; all `1,204` transfer-active states have an active stroke
  guard, preserve the steering sign, and keep the anterior raw command inside
  the existing `1800 deg/T^2` envelope.  The maximum tested transfer is
  `7.160 rad/T^2`.  This is a fixed-state algebraic check, not CFD evidence.
- A counterfactual replay on the completed stroke-aware trace changes only the
  anterior request, on `834/4469` recorded states from `18.557T` through
  `24.547T`, with posterior bend magnitude between `36.28` and `45 deg`.
  Mean/maximum transferred acceleration are `6.153/11.053 rad/T^2`.  This
  confirms far-route dormancy and intended terminal support on inherited
  states, but does not claim the new closed-loop path.
- The material-guidance check and solver editable-boundary audit pass.  The
  required configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account; its three prescribed no-CFD checks
  were therefore run directly and separately.  Formal CFD remains deferred to
  EvE after this worker exits.
