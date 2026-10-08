# Evidence-selected steering-preserving projection candidate

## Visual diagnosis before editing

- All four sampled rollouts satisfy the fixed direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics,
  and `capture`.  The prefilled posterior-thrust parent is reproduced twice at
  `26.0425 T`, score `-0.69471683`, and distance integral `2.59751 L`.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the parent, the steering-preserving projection, and the phase-neutral yaw
  alternative.  Each fish generates a compact alternating wake from quiescent
  water, sustains finite three-dimensional structures through the broad
  target-signed arc, and reaches the capture disk without collision or wake
  collapse.  The projected policy does not win by producing a more dramatic
  wake; it retains the coherent carrier while following a more effective
  approach.
- Metrics confirm the visual comparison.  Projecting the carrier before adding
  target steering improves capture from `26.0425 T` to `25.9545 T`, distance
  at `24 T` from `2.06445 L` to `1.96584 L`, distance integral from
  `2.59751 L` to `2.55008 L`, and score from `-0.69472` to `-0.64779`.
  Mean/max speed changes from `0.508/0.717` to `0.510/0.667 L/T`; peak force
  and moment coefficients remain `0.02974/0.01484`.  More importantly, rows
  touching either acceleration bound fall from `84.35%` to `33.95%`, with no
  simultaneous two-joint saturation in the projected rollout.
- The phase-neutral yaw alternative is informative but not selected.  It
  captures earliest at `25.0745 T` and is only `1.3852 L` away at `24 T`, yet
  its distance integral (`2.55414 L`) and score (`-0.65392`) remain slightly
  worse than the projected policy, while peak speed reaches `0.781 L/T` and
  either joint is saturated in `89.41%` of rows.  Combining the two new
  mechanisms would therefore confound an already positive allocation result.
- No sampled visual rollout is a semantic failure.  The inherited quantified
  failures remain the relevant negative boundary: response-only redirect
  release missed at `2.4625 L`, terminal carrier relief missed at `1.2329 L`,
  and a policy-side outward-speed guard delayed a repeated capture.  Those
  results argue against replacing the geometric redirect or adding another
  scalar carrier/speed schedule.

## One-candidate policy hypothesis

Promote the evaluated steering-preserving projection as the single candidate.
Retain the completion-gated body-frame redirect, progress-gated posterior lag,
joint-state oscillator, and target-feedback residual.  Project each rhythmic
carrier acceleration to the parameter-owned physical envelope before adding
and projecting the steering residual.  Opposite-sign target steering can then
unload a saturated carrier half-cycle instead of being erased by carrier
overshoot; same-sign commands remain bounded by the final projection.

Expected evidence is reproduction of capture near `25.9545 T`, distance
integral near `2.55008 L`, the coherent alternating two-view wake, and the
lower one-joint saturation pattern without larger force or moment.  Falsify
the selection if reevaluation loses or delays capture beyond the parent,
returns to the parent's distance trajectory or saturation residence, degrades
wake coherence, or materially increases speed or load peaks.  No same-worker
CFD result is claimed; formal evaluation occurs after exit.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: preserve a rhythmic carrier while target feedback creates turning through bounded half-cycle amplitude or duty asymmetry
transferable_invariant: a smaller target-steering residual must retain authority over the useful half-cycle when the propulsive carrier reaches the actuator envelope
nontransferable_details: published gains, robot geometry, dimensional cadence, prescribed duty ratios, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: project each two-joint state-feedback carrier acceleration first, then add and project the normalized body-frame target-steering residual so opposite-sign steering can unload a saturated half-cycle
falsification: reject if capture time or distance integral regresses, the carrier wake or posterior-thrust benefit degrades, load peaks grow materially, or the lower saturation residence does not reproduce
