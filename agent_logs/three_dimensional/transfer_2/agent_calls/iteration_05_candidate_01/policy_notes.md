# Candidate diagnosis and hypothesis

## Prior evidence

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders.  Motion is self-propelled,
  not background advection.  The top-down vorticity and oblique Lambda2 rows
  show an alternating three-dimensional wake behind the `0.55T/28 deg`
  carrier; the globally slower `0.80T/22 deg` soft-limited failure has a much
  shorter useful track and exits above at `14.91T`, after improving distance
  only from `12.33L` to `8.75L`.
- The assigned curvature-release parent preserves the coherent carrier and
  reaches `4.141L` at `20.67T`, but its head is already below the target
  (`(12.16,6.82)L` versus `(9,9.5)L`) and it continues down to the lower
  boundary at `32.20T`.  At least one raw acceleration exceeds the
  `1800 deg/T^2` envelope on `98.1%` of its logged steps, so final additive
  steering is usually filtered through clipping.
- The sampled phase-selective child is a real, useful semantic improvement:
  it retains the strong alternating wake, reaches `3.033L` at `23.24T`,
  survives to `40.33T`, and changes the termination from the lower boundary to
  the left boundary.  At closest approach its head is `(10.48,6.85)L`, body-
  frame bearing is about `+1.35 rad`, and forward body speed remains about
  `0.63L/T`; it therefore passes below the target corridor with substantial
  propulsion rather than failing from a weak wake.  Its posterior half-cycle
  relief reduces raw envelope exposure to `93.6%`, but most commands are still
  clipping-dominated.
- The seed, curvature-release parent, and phase-selective child all reach the
  `260 deg/T` joint-rate limit.  A globally softer gait removed raw
  acceleration exceedance but destroyed the deep approach, so the evidence
  supports preserving the carrier while reallocating only saturated carrier
  demand around the target-derived steering residual.

## Policy hypothesis

Use the evaluated phase-selective child as the carrier and add one compatible
actuator-allocation mechanism.  Once its inherited curvature-release signal
identifies a material off-axis polarity conflict, bound each target-derived
steering residual first, reserve its magnitude inside the known acceleration
envelope, and clamp only the carrier to the remaining symmetric budget.  The
gate preserves the child's applied early-centerline command, and unsaturated
commands remain unchanged.  When carrier and steering agree they can still
reach the actuator limit; an opposing residual instead creates a real
half-cycle reduction rather than being erased by the environment's final clip.
The mechanism uses only current joint state and normalized body-frame target
feedback.  It adds no clock, global direction, stored phase, or route.

The primary test is capture or a closest approach below the phase-selective
reference of `3.033L` while avoiding its left-boundary overshoot.  Reject the
translation if it loses the inherited early approach (especially if minimum
distance regresses beyond the `4.141L` curvature-release parent), recreates the
short upper-exit topology, weakens the alternating wake materially, or retains
the same off-axis left exit despite the intended steering priority.  Zero raw
acceleration-envelope exceedance is expected by construction and is not, by
itself, evidence of better control.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and CPG-residual path following
source_mechanism: gait-level half-cycle asymmetry with residual steering allocated before actuator saturation
transferable_invariant: target steering must retain signed authority inside the propulsive carrier's finite actuator envelope
nontransferable_details: published gains, clock-driven oscillator phase, species-specific duty ratios, body envelopes, and task routes
policy_translation: preserve the observed-joint-state traveling carrier and successful posterior half-cycle relief, then use its material off-axis release gate to reserve each bounded body-frame steering residual before clamping only the carrier demand
falsification: reject if target approach does not beat 3.033L or improve termination without losing the coherent wake, even though raw commands are bounded
