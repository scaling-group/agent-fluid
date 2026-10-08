# One-sided joint-speed feasibility projection

## Visual and metric diagnosis before the edit

- The assigned parent `solver_654687610a5f` and all four sampled solvers use
  direct-uniform still-water initialization with `U_infinity=[0,0,0]`, no
  cylinders, and no prewarm. I inspected both rows of the combined sheets for
  the assigned parent, the distinct raw-coordinate capture
  `solver_a46c8c6241a4`, the inherited phase-confidence child
  `solver_e4e6c296368e`, and the informative carrier-recruitment failure
  `solver_7a764cc19afc`.
- The three captures visibly self-propel along the same target-crossing arc.
  Their top-down rows develop an alternating signed vortex street, and their
  oblique rows retain finite tail-connected Lambda2 structures through target
  entry. The failure also self-propels and retains an organized three-
  dimensional wake, but turns past the target and leaves the domain at
  `28.232T` after reaching only `3.491L`. Thus route-response semantics, not
  passive advection or gross wake coherence, distinguish the successful
  carrier.
- The assigned mean-preserving parent is the strongest completed sample. It
  captures at `0.747896L` and `16.631994T`, with score `-0.118307`, observed
  distance integral `1.378485L`, peak planar force/moment
  `0.036777/0.018272`, and maximum joint magnitudes
  `0.547719/0.555689 rad`. Relative to the raw-coordinate capture, it arrives
  one logged step earlier while slightly lowering distance cost, joint
  excursion, near-limit residence, force, and moment. Preserve its carrier,
  steering signs, mean-preserving demodulator, and target-crossing topology.
- The inherited phase-confidence gate is a completed negative control. It
  retained capture and the connected wake, but delayed arrival to
  `16.813488T` and worsened score to `-0.135897` by raising the scored distance
  integral from `2.001992L` to `2.020231L`. The fixed carrier subtraction is
  therefore useful from release in this configuration; do not fade it in or
  repeat startup carrier recruitment.
- The remaining separable deficit is actuator feasibility. In the assigned
  parent, at least one joint is within 1% of its `260 deg/T` speed limit for
  `27.282%` of logged samples and at least one acceleration is within 5% of
  its limit for `73.942%`. Reconstructing the command signs shows that an
  acceleration still points outward while its joint is already at or above
  98% of the speed limit for `24.901%` of samples (`10.020%` anterior and
  `14.881%` posterior). The episode integrator clips the resulting velocity,
  so this component cannot increase realized joint speed; it is command effort
  without additional kinematic authority.

## Single policy hypothesis

Preserve the assigned policy through its existing smooth acceleration bound,
then project only the outward acceleration component toward zero as normalized
joint speed enters the final 1% of the released speed envelope. Keep inward
acceleration fully available so the oscillator can reverse and so the
posterior tracker can brake. This is a state-feedback actuator-feasibility
mechanism, not a global gain reduction: below the narrow guard band the policy
is exactly the assigned parent, and it never increases action.

The expected semantic improvement is to retain the `16.63T` capture arc and
organized wake while reducing commands that the hard velocity clamp would
discard, especially the measured near-limit acceleration residence. Falsify
the mechanism if capture or the target-crossing topology changes, arrival or
distance integral worsens materially, the alternating connected wake degrades,
the outward-at-limit command fraction does not fall, or joint contact,
near-limit speed residence, force, or moment exceeds the assigned-parent
envelope.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation under bounded actuation and moderate-amplitude swimming guardrails
source_mechanism: preserve a rhythmic traveling-wave carrier while constraining only actuator commands that cannot produce additional feasible motion
transferable_invariant: enforce actuator feasibility in normalized joint state without attenuating the interior carrier or the command that returns a joint from its limit
nontransferable_details: published gains, species or robot kinematics, dimensional frequencies, exact vortex phases, prescribed routes, and task-specific maneuver timing
policy_translation: normalize each observed joint speed by a policy-owned speed envelope and smoothly remove only the acceleration component pointing farther outward in the final one-percent guard band
falsification: reject if nominal capture, arrival, distance integral, route, or connected wake worsens, or if outward-at-limit commands, joint contact, saturation residence, force, or moment do not improve

## Evaluation boundary

No CFD outcome is claimed for this child. Later evaluation should compare
capture and arrival first, then distance integral and the target-relative arc,
outward acceleration conditional on near-limit joint speed, speed and
acceleration residence, joint contact, force/moment peaks, and both wake views
against `solver_654687610a5f`. The sampled fixed-pose repetitions do not
establish robustness to a changed pose or flow.
