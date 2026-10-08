# Terminal posterior half-cycle redistribution

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, stable dynamics,
  and inertial moving-window transport. All capture, so the assigned parent is
  the informative control for terminal margin and mechanism effect rather than
  a semantic failure.
- Both visual rows were inspected for the assigned coordinated-envelope parent
  and the best sampled posterior descendant. The top-down sheets show genuine
  self-propulsion from rest, an organized alternating wake through the long
  approach, and the same smooth target-side hook at capture. The oblique sheets
  show the same compact, connected three-dimensional Lambda2 wake through the
  turn. The wake trails the fish, and neither view shows imposed advection,
  breakup, a boundary interaction, or moving-window-induced rotation.
- The assigned parent captures at `0.749242L` and `26.2955T`, with mean score
  distance `2.519981L`, zero hard-limit contact, and peak planar force/yaw
  moment `0.018834/0.009789`. The three sampled posterior policies byte-match
  one another in policy, trajectory, and combined visual sheet and reproduce
  `0.748829L`, `26.2955T`, and mean distance `2.519671L`.
- Relative to the assigned parent, the posterior edit first changes an action
  at `24.5025T` and `1.64683L`, changes 327 recorded command rows, changes a
  two-joint command by at most `0.43860 rad/T^2`, and displaces the centerline
  by at most `0.000591L`. Maximum joint angle/rate/acceleration and peak planar
  force/yaw moment remain exactly `0.772361`, `4.512809`, `29.725850`, and
  `0.018834/0.009789` in the recorded normalized units. The visual sheets do
  not resolve a route or wake-topology difference. This meets the inherited
  falsification boundary: the scalar score gain is not a semantic improvement
  or evidence for more lag gain.
- The terminal sample still crosses shallowly. Its head-relative target vector
  is about `(0.423,-0.618)L`; speed is `0.648L/T`, but only `0.219L/T` is
  closing while `0.610L/T` is transverse, and the instantaneous projected miss
  remains about `0.705L`. The tested posterior expression multiplies `qd1` by
  `phase_velocity`, which has the same sign as `qd1`; that product is even over
  the beat and therefore creates a same-side posterior target offset rather
  than alternating the two half-cycle amplitudes. Strengthening that expression
  would be another unsupported mean-curvature scalar.

## Policy hypothesis

Preserve the assigned parent's capture-proven traveling-bend carrier,
line-of-sight response closure, redirect, coordinated acceleration envelope,
and reflection-equivariant angle/rate guards. Replace the falsified even-phase
posterior offset with one terminal-only half-cycle amplitude redistribution.
When approach, projected miss, positive closing, target-line response deficit,
and course/line-of-sight side agreement all hold, use normalized anterior joint
position as the beat-side selector: strengthen the posterior traveling-bend
target on the target-side half-cycle and weaken it on the opposite half-cycle.
The signed selector reverses with both target side and joint reflection, so the
scale itself is reflection invariant and the posterior target remains
reflection equivariant. Existing common command compression and joint
viability guards bound the result.

This is a mechanism test, not a same-worker performance claim. The formal
rollout should retain capture, coherent two-view self-propulsion, and zero
limit contact while producing a route change materially larger than the
`0.000591L` offset cluster or a deeper capture. Reject it if it loses capture,
alters the far carrier, recreates the prior high-load posterior failure,
breaks the wake, restores contact/clipping, or again remains only milliscale.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: bounded half-cycle amplitude asymmetry of a productive rhythmic carrier
transferable_invariant: steering authority can be redistributed between observed oscillator half-cycles while leaving the mean carrier and its state-feedback phase intact outside the error gate
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, clock phase, exact vortex phase, task-specific routes, and fixed world directions
policy_translation: use normalized body-frame approach, projected miss, closing and target-line response signals with anterior joint position as the phase selector, and modulate only the posterior carrier target inside the capture corridor
falsification: reject if capture or wake coherence is lost, the far carrier changes, angle/rate/acceleration contact or loads increase materially, or the route remains in the inherited sub-0.001L effect cluster

## Non-CFD implementation audit

- The required checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three configured commands were run
  directly and separately: the guidance semantic-delta/schema check, finite
  Julia policy contract, and solver editable-boundary check all pass. The
  duplicate assigned-parent marker in the rendered workspace `README.md` was
  removed so the first check could identify exactly one parent.
- A deterministic grid of 2,880 finite states gives exact lateral reflection
  equivariance and exact parent pass-through for target distances at or beyond
  `2L`; 264 terminal states activate the new mechanism. A frozen-state replay
  over the assigned parent's 4,781-row trace changes 193 commands, first near
  `1.650L`, by at most `1.82982 rad/T^2`, leaves all states at or beyond
  `1.75L` exact, and remains within the `30 rad/T^2` policy limit. These are
  contract and mechanism audits, not a CFD performance result.
