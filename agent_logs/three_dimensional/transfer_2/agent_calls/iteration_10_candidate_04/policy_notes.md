# Stroke-aware course-preview candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform quiescent initialization with `U_infinity=[0,0,0]`, no cylinders or
  prewarm, finite dynamics, and moving-window transport. Their translation is
  self-propelled rather than advection from an imposed flow.
- Both rows of every combined keyframe sheet were inspected, comparing the
  assigned parent's capture with the three informative left-domain failures.
  The top-down views show a coherent alternating wake throughout the common
  approach, and the oblique body/Lambda2 views retain compact three-dimensional
  shed structures. The parent visibly bends its route before the lateral pass
  and intersects the capture sphere while still closing; the comparators defer
  the redirect, execute nearly the same broad upper hairpin, and run away.
  Wake breakup, absent propulsion, and numerical instability are not the
  limiting mechanisms.
- The body-frame velocity-course preview is a completed semantic success.
  The assigned parent captures at `24.580T` with minimum/final distance
  `0.747L` and mean distance `2.360L`. The three sampled policies without that
  branch miss at `1.076--1.148L`, have mean distance `6.178--6.289L`, and exit
  left after the common upper turn at `37.49--37.82T`. Preserve the preview,
  closing-sector timing, steering-priority allocation, and traveling-wave
  carrier; another late recapture gate or scalar preview-gain edit is not
  supported.
- The success exposes a narrower physical boundary. The posterior joint first
  reaches the `-45 deg` hard stop near `18.623T` at `4.092L`, just as its
  outward speed is reset and the largest successful-rollout force/moment event
  occurs on the next sample. It then occupies that hard stop for `23.38%` of
  the completed rollout. Peak normalized planar force and yaw moment are
  `|Fx|=0.269`, `|Fy|=0.178`, and `|Mz|=0.143`; acceleration-envelope exposure
  remains `72.84%`. These are better in lateral force/moment than the sampled
  no-preview near misses (`|Fy|=0.441--0.479`, `|Mz|=0.211--0.226`) but still
  identify a stroke-limited, grazing capture rather than a comfortably
  periodic terminal approach.
- The inherited terminal carrier-unloading result is a relevant negative
  boundary: unloading propulsion near the target without the successful
  course mechanism worsened the best pass from `1.076L` to `1.148L`. The new
  intervention therefore must not weaken the carrier globally or add more
  curvature. It should release only the posterior allocator's first-priority
  claim when observed tail angle and requested steering show that the finite
  stroke is already being consumed in the same direction.

## Policy hypothesis

Preserve the evaluated course-preview policy and add one compact finite-stroke
allocation mechanism. Form a smooth posterior stroke-pressure signal from the
observed tail-joint angle and the sign/magnitude of the already-computed tail
steering component. Only when the joint is close to its hard-angle envelope
and steering points farther outward, reduce the tail's steering-priority gate
toward a nonzero floor, admitting more of the existing inward carrier. Keep
the anterior allocator and all geometry/preview requests unchanged. The new
branch is exactly dormant away from the posterior stroke guard, adds neither
curvature nor acceleration, and continuously restores full steering priority
as the joint returns inward or the steering sign reverses.

The falsifiable expectation is preservation of the established far path and
capture, with less posterior hard-stop residence and a smaller first-contact
load impulse because the traveling bend regains bounded authority before the
tail is pinned. Reject the mechanism if any command changes outside the
stroke-pressure states, capture is lost or delayed materially, the same
`-45 deg` dwell survives, or force/moment and rate exposure worsen.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG turning
source_mechanism: strong bounded curvature is transient and releases back into the posterior propulsive rhythm when observed maneuver response consumes the available stroke
transferable_invariant: separate route authority from the rhythmic carrier, and continuously return finite actuator authority to the carrier when observed joint state shows that further same-direction steering cannot create additional usable curvature
nontransferable_details: species-specific C-start shapes, published gains, motor timing, dimensional cadence, full-body envelopes, exact vortex phases, turning radii, and task-specific routes
policy_translation: use normalized posterior joint-angle proximity and the signed tail-steering component to reduce only the existing tail steering-priority gate toward a bounded floor; preserve the body-frame course preview, anterior allocation, and two-joint state-feedback carrier without hidden time or state
falsification: reject if non-guard commands change, capture or the `2.360L` mean-distance class is lost, posterior hard-stop residence does not fall, the first-contact load impulse persists, or propulsion and joint-rate exposure worsen

## Pre-evaluation checks

- Same-state replay over all `4,469` recorded states of the successful parent
  is finite. The stroke branch changes `1,096` states, all between `18.557T`
  (`4.103L`) and capture, and produces exactly zero changes at or inside the
  `36 deg` dormant region. With the conservative `0.85` priority floor, the
  counterfactual raw acceleration-envelope exposure does not increase
  (`72.857%` in both policies) and two-joint command RMS falls from `47.927`
  to `47.402 rad/T^2`. This fixed-trajectory calculation checks algebra and
  scope; it does not predict the new closed-loop CFD path.
- A mirrored grid over posterior angle, signed steering component, and sector
  gate has zero reflection error. Every stroke-aware gate remains between the
  configured `0.85` floor and its inherited magnitude, is exactly unchanged
  inside the stroke reserve or when steering points inward, and is exercised
  on both mirrored joint sides.
- All `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`. The public-contract check returns one
  finite two-joint acceleration, and the policy contains no time, random,
  cylinder, file-I/O, or world-target-coordinate dependency.
- The configured check-runner was invoked but its agent session could not
  refresh a revoked access token. Its three prescribed no-CFD commands were
  then run directly and separately: the reusable-guidance semantic check,
  lightweight Julia policy contract, and solver editable-boundary audit all
  pass. The guidance check initially found a duplicated assigned-parent marker
  in the rendered workspace README; removing only that duplicate made the
  rerun pass. Formal CFD remains deferred to EvE after this worker exits.
