# Slip-conditioned half-cycle wake-shaping candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, finite dynamics, capture at `16.054375T`, 2,919 steps, and 239
  moving-window shifts. The trajectories are therefore self-propelled rather
  than background-advection artifacts.
- I inspected the combined sheets for the highest-scoring slip-damping sample
  (`solver_ddf99a38d49e`) and the repeated handoff/yaw baseline
  (`solver_1b92eb34e2e6`), including the top-down vorticity and oblique
  body/Lambda2 rows from release through termination. Both show the same
  smooth target-directed arc, a coherent alternating reverse-street wake, and
  compact three-dimensional caudal structures through capture. There is no
  visible reciprocal standing wiggle, wake breakup, collision, virtual exit,
  or out-of-plane instability. No sampled rollout has a failed termination;
  the informative negative contrast is trajectory equivalence among distinct
  terminal mechanisms rather than an instability or missed target.
- The repeated handoff/yaw policies capture at `0.745943L`, distance integral
  `1.929921L`, and score `-0.047001`. Moment-led yaw prediction is nearly
  equivalent at `0.745938L`, `1.929917L`, and `-0.046995`. The assigned-parent
  translational line-of-sight damper is strongest at `0.745869L`,
  `1.929859L`, and `-0.046924`, with the same capture step and every
  `8/6/4/2/1.25L` milestone unchanged. Against the repeated baseline it
  changes posterior acceleration by at most `1.228 rad/T^2`, lowers mean
  absolute posterior demand from `24.589692` to `24.586242 rad/T^2`, and moves
  the recorded path by at most `7.4e-5L`. Translational slip is therefore a
  supported terminal observation, but another gate or curvature-gain edit
  would remain trace-scale rather than test a new control primitive.
- The inherited logs show that the carrier, response-conditioned redirect,
  posterior traveling wave, one-sided relief, anterior safe-corridor release,
  redirect-increment handoff, and yaw damping are all individually supported.
  They also show that broad counter-curvature, high-authority steering release,
  posterior approach release, moment lead, and repeated threshold variants do
  not justify disturbing the proven cruise route. The new action must remain
  inside the already reliable closing corridor and preserve the assigned-parent
  mean slip correction.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: asymmetric robotic-fish flapping and closed-loop terminal capture control
source_mechanism: preserve a rhythmic propulsive carrier while a measured turn request selectively relieves the counterproductive half-cycle
transferable_invariant: when a bounded mean bend has the right response sign but weak authority, shape only the carrier lobe that opposes the requested correction instead of shifting the entire oscillator or amplifying both lobes
nontransferable_details: published duty ratios and gains, clock-defined CPG phase, species-specific envelopes, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: retain the evaluated two-joint carrier and terminal mean slip damper; infer posterior beat side from normalized posterior wave state, then attenuate only the lobe that opposes the slip-correcting turn while proximity, positive closing, safe predicted miss, and translational line-of-sight reopening agree
falsification: reject if the term changes pre-corridor milestones, weakens forward progress, disrupts the alternating two-view wake, delays or loses capture, increases limiting or loads materially, or produces no action beyond the existing mean-curvature slip damper

## One candidate hypothesis

Add one bounded half-cycle steering mechanism to the assigned-parent policy.
The existing normalized translational target-line rate continues to supply the
reflection-odd slip-correcting direction and its established mean-curvature
damper. In the same safe closing corridor, the new branch reads the sign of the
posterior wave reconstructed from anterior joint state and attenuates only the
wave lobe opposite that correction; the aiding lobe is unchanged and neither
lobe is amplified. This creates a phase-selective feasible-action difference
without an external clock, mutable phase, world coordinates, or a broad route
change. Expected evidence is unchanged cruise milestones and coherent wake,
retained capture, and a larger improvement in terminal line-of-sight response
than the sampled mean-only damper. This worker does not claim the unevaluated
CFD outcome.

## Non-CFD verification after the edit

- Candidate SHA-256:
  `adc5cfba21db8d74aad62c6b0198d000c780e9939e55722228d8101a9c3219c2`.
  All 51 direct `params.FIELD` references are present among the 51 fields
  returned by `target_policy_params()`.
- The lightweight contract state returns two finite accelerations. A
  deterministic 20,000-state sweep across target side/distance, body-frame
  course, bearing response, yaw response, and joint phase stays inside
  `31.416 rad/T^2`, has zero numerical lateral-reflection error, keeps exact
  joint-speed-boundary commands non-outward, and retains a finite fallback for
  non-finite task observations.
- Counterfactual replay on the assigned parent's recorded states changes only
  posterior action and only on four reconstructed samples from `0.7639L`
  through capture. The maximum difference is `2.897 rad/T^2` at the crossing;
  the anterior command is unchanged. This verifies bounded half-cycle support
  beyond the mean slip term, not the unevaluated closed-loop outcome.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its three prescribed commands were
  then run directly and separately: the material guidance/notes check, Julia
  policy contract and deterministic parameter-schema guard, and solver
  editable-boundary check all pass. The material checker required removal of
  the exact duplicate assigned-parent marker from the rendered workspace
  `README.md`; that metadata repair does not alter the solver or guidance.
