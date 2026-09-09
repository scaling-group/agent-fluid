# Wake-policy candidate notes

## Inherited evidence diagnosis

- All four sampled rollouts satisfy the experiment contract: direct uniform
  initialization in still water (`U_infinity=(0,0,0)`), no prewarm, and no
  cylinders. The combined sheets include both top-down vorticity and oblique
  Lambda2 views, so their motion is attributable to self-propulsion rather
  than ambient advection.
- The target-blind seed (`solver_0718f4efab03`) forms a coherent alternating
  mid-plane and three-dimensional caudal wake, but bends the wake into an
  upward arc. It improves distance only from `12.328 L` to `12.064 L`, then
  exits the upper boundary at `8.613 T` and `12.351 L`. This confirms the
  inherited lesson that its joint-state oscillator is a propulsion carrier,
  not a route controller.
- The assigned parent (`solver_c24e37740d95`) is the strongest finite scorer.
  Its posterior-only mean-curvature channel preserves a visibly coherent wake
  and improves distance monotonically to `11.096 L`, but it still exits the
  upper boundary at `10.026 T`. Reconstructing the policy observation from the
  trace shows body-frame bearing changing from `+0.155 rad` initially to
  `-0.817 rad` at termination: the target has crossed sides, yet the persistent
  bend and yaw inertia do not reverse the route in time. Both joint rates touch
  the hard limit, and `72.0%` of samples request at least one raw acceleration
  above the fixed envelope.
- The shared mean-bias/slip sibling (`solver_f0a5c173df3d`) demonstrates useful
  but uncontrolled route authority: it reaches `8.174 L` at `16.494 T`, then
  continues below the target corridor and exits the lower boundary at
  `26.043 T`; `85.6%` of its samples request an over-envelope acceleration.
  The equal head/tail bias sibling (`solver_6882de278554`) avoids clipping, but
  makes virtually no early progress before looping right and exiting at
  `15.361 L`. Together, these are negative evidence for another scalar-only
  redistribution of a persistent equilibrium bias.

## Policy hypothesis

Preserve the naive anterior state-feedback oscillator and its lagged posterior
traveling wave, but replace the parent's static posterior curvature with one
beat-synchronous mechanism. Body-frame bearing selects which posterior
half-cycle is strengthened and which is relieved. The modulation is inferred
only from the instantaneous lagged joint-state wave, stays positive and
bounded, reverses as soon as bearing changes side, and vanishes at zero target
error. Unlike a static joint offset, it leaves no stored equilibrium bend for
the hydrodynamic yaw response to unwind after target alignment.

The expected semantic change is a coherent propulsive wake whose route turns
toward the target without repeating the upper-boundary parent exit or the
lower-boundary shared-bias overshoot. Falsify the mechanism if it has the wrong
turn sign, fails to improve the termination/trajectory class, collapses net
propulsion, or retains/increases persistent rate and acceleration saturation.
The current candidate's CFD result is not yet available and is not claimed as
evidence here.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning, with classical posterior-emphasis swimming
source_mechanism: strengthen the turn-producing half-cycle of a phase-lagged propulsive beat instead of imposing persistent static curvature
transferable_invariant: signed route error can modulate beat-side posterior authority while the traveling-wave carrier and its joint-state phase remain intact
nontransferable_details: published gains, clocked CPG phase, species-specific amplitudes, exact vortex phase, and source-task routes
policy_translation: map normalized body-frame bearing to a bounded multiplicative asymmetry of the posterior lag target, with beat side inferred smoothly from that target and all phase retained in joint state
falsification: reject if turn sign or termination class does not improve, coherent propulsion weakens, or actuator clipping and overshoot retain the sampled static-bias topology
