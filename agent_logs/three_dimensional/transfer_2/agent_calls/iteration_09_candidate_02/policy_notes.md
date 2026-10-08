# Course-preview steering-priority candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  quiescent initialization with `U_infinity=[0,0,0]`, no cylinders or prewarm,
  finite dynamics, and moving-window transport.  Their motion and wakes are
  self-generated rather than imposed advection.
- Both the top-down vorticity and oblique body/Lambda2 rows were inspected for
  the strongest finite rollout and an informative persistent-route failure.
  The assigned steering-priority parent lays down a coherent alternating wake
  while approaching to `1.076L`; the persistent-route comparator retains the
  same qualitative wake through a broad upper loop but reaches only `2.996L`.
  The other recapture variants also reach only `2.579--3.024L`.  Propulsion
  loss, passive advection, and three-dimensional wake breakup are therefore
  not the useful intervention targets.
- The assigned parent's allocation mechanism is a large semantic improvement:
  relative to sector interception without steering priority, minimum distance
  improves from `2.579L` to `1.076L` and mean distance from `6.913L` to
  `6.178L`.  It nevertheless passes the target and exits the upper boundary at
  `37.823T`.  At closest approach (`25.977T`) its head is
  `(8.199,8.781)L`, velocity is `(-0.493,0.582)L/T`, and the target is already
  posterior to its left-going course; the remaining `1.076L` miss is a
  course-interception error rather than lack of late recapture authority.
- The improvement also exposes a physical boundary omitted from the inherited
  pre-evaluation replay.  The posterior joint is held at its `-45 deg` hard
  limit for much of approximately `20--24T`, and the rollout's peak normalized
  lateral force/yaw moment reaches `0.441/0.211` at `25.020T`; the other three
  samples peak near only `0.0276/0.0149`.  Raw commands still exceed the
  acceleration envelope on roughly `63%/32%` of anterior/posterior samples.
  More priority magnitude, another behind-gate threshold, or another
  tail-curvature gain is not supported.
- The inherited sector notes show that its response-gated pulse first becomes
  useful around `14--16T`.  On the completed parent trajectory, however, the
  measured velocity already predicts a persistent same-sign lateral miss by
  about `14T`: the normalized velocity-to-target cross-course residual is
  approximately `0.81` at `14.31T`, while distance is `6.01L`.  Body bearing
  alone lets the swimming course descend below the target before the clipped
  redirect develops.  This motivates a new observation/feedback mechanism,
  not a scalar retune of the existing sector gate.

## Policy hypothesis

Preserve the assigned parent's oscillator, sector pulse, steering-priority
allocator, and posterior recapture.  Add one bounded course-preview branch
that compares the normalized body-frame target vector with measured
body-frame translational velocity.  The signed cross product is invariant to
world rotation and mirror-equivariant; it is zero on a collision course even
when the oscillating body heading is not aligned with velocity.  Ramp this
branch in only inside a normalized terminal preview range while distance is
closing, and blend it into the existing sector request without increasing the
request bound.  Thus the controller begins reallocating existing authority
before the sampled hard-limit turn, but the original sector and recapture
logic retain control after passage.

The falsifiable expectation is an earlier upward course correction, first
capture or a minimum below `1.076L`, and no recurrence of the parent's
`0.441/0.211` load spike because success or course alignment releases the
preview before the hard-limit passage.  Reject the mechanism if it changes the
established far approach, worsens closest distance, produces the same upper
exit without reacquisition, or retains/increases the exceptional hard-limit
load class.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: use observed route error to modulate a bounded rhythmic carrier before passage, then release corrective authority as the measured course aligns
transferable_invariant: treat target-relative course error separately from body-heading oscillation, prioritize bounded reorientation only while the predicted route misses, and continuously return authority to the traveling-wave carrier on alignment
nontransferable_details: species-specific C-start shape, published gains, motor timing, dimensional cadence, full-body kinematics, exact vortex phase, turning radius, and any task-specific route
policy_translation: form a signed normalized cross product between body-frame velocity and target direction, gate it by normalized target distance and positive closing progress, and blend the bounded mirror-equivariant request into the existing two-joint steering-priority sector without a clock or stored mode
falsification: reject if the far approach changes, the `1.076L` pass is not improved, target-course alignment does not release the branch, wake coherence is lost, or joint-limit force and moment remain in the parent's exceptional load class

## Pre-evaluation checks

- Fixed-state comparison against the evaluated parent is exactly identical
  outside the `6.5L` preview range.  On the completed parent trajectory the
  new branch first becomes nonzero at `13.442T`; representative preview
  requests at `14/16/18T` are `0.051/0.210/0.423`, advancing the combined
  sector request from `0.000/0.106/0.146` to `0.051/0.293/0.507`.  It returns
  exactly to zero as closing reverses near `26T`.  This is a counterfactual
  recorded-state calculation, not a closed-loop performance claim.
- All `78` direct `params.FIELD` references resolve among the `80` fields
  returned by `target_policy_params()`.  An `8,748`-state deterministic grid
  over target geometry, distance, body-frame velocity, closing progress, and
  joint state is finite.  Mirroring target/velocity lateral components makes
  the course error, preview request, and blended intercept request exactly
  antisymmetric; full-policy symmetry is not claimed because the inherited
  positive and negative turn gains intentionally differ.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three prescribed no-CFD checks were
  therefore run directly.  The rendered README contained the same assigned
  parent marker twice; removing only the duplicate allowed the reusable-
  guidance semantic check to identify the parent.  That check, the lightweight
  Julia public-contract check, and the solver editable-boundary audit pass.
  Formal CFD remains deferred to EvE after this worker exits.
