# Mid-approach posterior phase-response candidate

## Visual and metric diagnosis before the policy edit

- All four sampled solvers are byte-identical policy, trajectory, and combined
  keyframe repeats. Each satisfies the released direct-uniform still-water
  contract with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite
  moving-window dynamics, and capture. Each reaches `0.743958L` at
  `16.604496T` with score `-0.1137286`, scored distance integral `1.998146L`,
  and 237 moving-window shifts. This establishes nominal fixed-pose
  reproducibility, not held-out pose or flow robustness.
- I inspected both rows of the sampled combined sheet from release through
  capture. The top-down vorticity row shows acceleration from rest, persistent
  left/down targetward translation on a shallow crossing arc, and a coherent
  alternating wake. The oblique Lambda2 row shows compact three-dimensional
  structures connected to the posterior body and traveled path. The fish is
  self-propelled; there is no inherited wake, passive advection, collision,
  boundary exit, wake breakup, or instability.
- The most informative available weaker control is the inherited
  closure-qualified yaw-response hold. I inspected both of its visual rows as
  well. It preserves the same route and tail-connected wake class and captures
  one integration step earlier, but its score regresses to `-0.1140375`,
  distance integral to `1.998380L`, and crossing depth to `0.744276L`.
  Coherent propulsion therefore does not validate another terminal observer
  or response release.
- The assigned-parent logs strengthen that boundary. Alignment-based response
  release, closure-deficit redirect, projected-corridor hold, line-of-sight
  rate feedforward, bearing demodulation, yaw-moment rejection, and
  carrier-synchronous local-flow subtraction all retained finite or capturing
  behavior but worsened target cost. The local-flow subtraction, for example,
  captured at the same time yet regressed to score `-0.115121` and distance
  integral `1.999280L` without a feasibility or load benefit.
- The last three completed optimizer iterations introduced no new controller
  mechanism or semantic improvement and instead reselected the exact sampled
  carrier. Offline reconstruction of that completed trace shows that the
  phase-demodulated yaw-deficit gate remains materially active in the
  `6.5--3L` middle approach (mean about `0.42`, range `0--0.91`) while
  target--velocity alignment is already high (mean about `0.95`). This is a
  measured directional-response condition, but the prior evidence says not to
  modify the successful final approach or subtract another correlated signal.

## Sole candidate hypothesis

Preserve the evaluated anterior oscillator, raw target geometry, anterior
course center, yaw/lateral phase demodulators, mean posterior curvature,
half-cycle steering, acceleration bound, and one-sided final-band speed guard.
Add one orthogonal actuator primitive: rotate the posterior state-feedback wave
by a small bounded phase increment without changing its amplitude. Gate that
rotation by the existing speed-qualified yaw-response deficit and a smooth
middle-approach window that is exactly zero outside `6.5--3L`. The phase gate
is even under reflection, while the existing route curvature retains turn
polarity; the full policy remains clock-free and body-frame equivariant.

This tests wave-shape modulation rather than another terminal observer,
carrier subtraction, mean-bend burst, or scalar-only gain change. Expected
test: preserve capture and the connected two-view wake while correcting the
middle-approach response early enough to reduce arrival time or distance cost
without changing the nominal far or final control law. Falsify it if capture
is lost, if actions outside the middle window change, if the route or wake
changes adversely, or if crossing depth, distance integral, joint contact,
near-limit residence, effort, force, moment, or score worsens.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and phase-lag or wave-shape modulation
source_mechanism: modulate posterior wave timing as a bounded steering-response actuator while preserving the productive rhythmic carrier
transferable_invariant: when target-directed propulsion already works, recruit an amplitude-preserving posterior phase change only under an observed directional-response deficit and release it continuously outside that condition
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phase, source maneuver timing, and task-specific routes
policy_translation: rotate the two-joint posterior wave in its observed anterior phase plane by a bounded even gate derived from body-frame yaw deficit and normalized middle-approach distance, leaving route polarity to the evidenced curvature and half-cycle channels
falsification: reject if capture, wake connectivity, or the parent far/final action identity is lost, or if arrival, distance cost, crossing depth, joint feasibility, effort, force, moment, or score regresses

## Evaluation boundary

No CFD result is claimed for this unevaluated candidate. Favorable baseline
evidence belongs to four completed sampled rollouts, and the negative controls
belong to completed inherited logs. Later evaluation must compare semantic
capture and both wake views first, then arrival, scored and observed distance
integrals, crossing depth, route topology, action identity outside `6.5--3L`,
joint contact, near-limit residence, requested action, force, and moment against
the exact `-0.1137286` parent. One fixed-pose still-water result cannot establish
held-out pose or flow robustness.
