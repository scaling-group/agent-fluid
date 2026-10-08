# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent guidance is the fresh-lineage baseline, while inherited
  optimizer logs expose four completed sibling tests.  All finite rollouts use
  direct-uniform still water (`U_infinity=(0,0,0)`) without cylinders or a
  prewarm snapshot, so their motion and wakes are self-generated.  The
  prefilled alignment-gated candidate itself has no physical evidence: its
  evaluation failed before release because it omitted the evaluator-required
  `control_period` field.
- The transferred 2D carrier is the useful finite comparator.  Both visual
  rows show a strong alternating mid-plane wake and coherent three-dimensional
  Lambda2 loops.  It closes from `12.328L` to `4.780L`, then continues below
  the target at about `0.8U` and exits the lower boundary.  Its raw acceleration
  requests exceed `1800 deg/T^2` on roughly `71%/78%` of the two joint samples,
  so adding a small steering residual to that carrier is not a credible fix.
- Two proposed slow-guidance substitutes are concrete negative results.  A
  course-error/loss-of-closure C-bend turns away early, reaches only `11.865L`,
  and exits the upper boundary at `8.98T`.  A joint-phase-demodulated bearing
  controller reaches only `12.120L` and exits the upper boundary at `8.48T`.
  Their top-down and oblique rows show intact but misdirected swimming, not
  numerical instability.  Neither instantaneous velocity course nor an
  offline fitted phase correction is therefore safe as the primary route
  signal in this lane.
- The large-error body-frame redirect is the strongest finite mechanism.  It
  preserves the organized wake, improves the minimum distance to `1.135L`,
  and delays `left_domain` to `41.84T`.  From `18T` to `24T` it continues to
  close at about `0.5L/T`, but at `24--26T` it is still moving near `0.64U`
  while the median target angle is about `1.28 rad`.  At the `26.78T` closest
  approach, the target is behind/broadside, closure is already negative, and
  joint 1 is at `-44.4 deg`; the fish then traces a wide loop away.  The
  internal `1750 deg/T^2` guard is active on about `32%/26%` of commands and
  the joint-rate limit is approached on about `8.8%/5.0%`, whereas median
  local flow is only `0.020U` against median body speed `0.632U`.  This is an
  over-energetic, misaligned terminal pass, not ambient advection, a lost wake,
  or weak far-field propulsion.

## Single policy hypothesis

Retain the evidenced large-error body-frame mean-curvature redirect and its
posterior-lag carrier outside the capture neighborhood.  Add one continuous
terminal energy-shedding mechanism: distance opens an approach window, but
only large normalized body-frame target angle activates it.  Inside that
window, reduce the oscillator's target amplitude and add bounded damping to
the anterior joint while leaving the signed head and posterior mean-curvature
references active.  This trades oscillatory thrust for turning time only on a
misaligned near approach; an aligned intercept keeps the existing carrier.
All phase information remains in observed joint angle and rate, and there is
no clock, hidden mode, world coordinate, target identity, or memorized route.

The expected change is lower speed and less joint-limit contact from about
`4L` inward, allowing the already correct broad redirect to cross the `0.75L`
capture circle instead of passing at `1.135L`.  Falsify the mechanism if it
weakens the pre-`4L` approach, stalls outside capture, keeps the same fast wide
loop, reverses the evidenced turn direction, or replaces command limiting with
persistent angle/velocity dwell.  The new CFD result is intentionally not
claimed here; only the prior completed rollouts support this hypothesis.

bookshelf_consulted: true
source_domain: fish terminal capture and robotic-fish target-conditioned rhythmic control
source_mechanism: continuous approach hold that sheds propulsive oscillation while retaining bounded steering curvature
transferable_invariant: after broad target-directed swimming is established, a misaligned near approach should reserve time and actuator authority for turning by reducing excess rhythmic drive without coasting completely
nontransferable_details: published gains, species-specific braking kinematics, dimensional distance thresholds, exact vortex phases, prescribed approach routes, and clocked gait stages
policy_translation: normalized distance and body-frame target angle gate a lower observed-state oscillator amplitude plus joint-rate damping while the successful signed two-joint mean-curvature redirect remains active
falsification: reject if pre-approach propulsion degrades, minimum distance or termination topology does not improve, the fish stalls before capture, or terminal commands remain dominated by hard limits

## Non-CFD activation audit after editing

Replaying the completed best rollout's recorded geometry through the new gate
leaves it exactly zero through `18T`, raises its mean to `0.643` at `22--24T`
and `0.981` at `24--26T`, and lowers the corresponding oscillator radius from
`28 deg` to about `17.6 deg` and `12.1 deg`.  Under a fixed representative
terminal observation, a separate joint-only integration retains a small
bounded oscillation around the signed curvature reference and has no command-
guard contact in its final `2.2T`.  These checks establish schema, activation,
and boundedness only; they do not advance fish or fluid state and are not new
CFD evidence.
