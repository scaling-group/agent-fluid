# Captured joint-phase-demodulated response candidate

## Visual and metric diagnosis before the edit

- All four sampled examples report direct-uniform still-water initialization
  with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. I inspected the
  combined top-down and oblique sheets for the sampled capture
  (`solver_a46c8c6241a4`) and the prefilled closure-relief failure
  (`solver_929554cd32fb`). Both show self-propelled motion, an alternating
  top-down vortex street, and tail-connected three-dimensional Lambda2
  structures. The failure retains that wake while curving above the target
  and leaving the upper boundary, so propulsion collapse and advection are not
  the discriminating mechanisms.
- The prefilled closure-gated whole-wave relief reaches `4.530L` at `17.25T`,
  recedes to `6.035L`, and exits high at `21.72T`. The other sampled failures
  likewise exit high after minima of `4.743--5.126L`. Their coherent wakes and
  bounded peak planar force/moment (`0.0294--0.0345`/`0.0152--0.0178`) show
  that effort reduction or wake appearance alone did not repair route
  response.
- The assigned parent's completed joint-phase-demodulated response policy is
  the first semantic success in this lineage: it captures at `0.7477L` and
  `16.637T`, versus the inherited phase-selective raw-yaw parent's `2.169L`
  miss and `28.04T` upper exit. Its top-down sheet shows the trajectory bending
  through the target while the oblique sheet retains connected 3D wake
  structures. Peak planar force/moment are `0.0369`/`0.0186`, and maximum
  joint angles are about `0.550`/`0.560 rad`, below the `45 deg` joint limit.
  The modest load increase is measurable, but it accompanies capture rather
  than instability or joint contact.
- The inherited regression explains why the architectural change is
  plausible: within `6L`, `93.3--99.7%` of raw short-window yaw variance was
  attributable to anterior joint phase across eight completed histories.
  The captured controller subtracts the state-derived component
  `1.25*q1 - 0.55*q1_dot` before comparing yaw response with the route request;
  unlike closure-gated wave shedding and added terminal mean curvature, that
  feedback-semantic change produces a different target-crossing trajectory.

## Single policy hypothesis

Promote the evaluated captured policy as this workspace's sole candidate,
without scalar retuning. Preserve its full-amplitude anterior state-feedback
oscillator, posterior lag, normalized body-frame bearing/course/crossflow
route, bounded anterior course redistribution, actuator-calibrated
posterior-to-yaw convention, and opposing-half-cycle posterior relief. The one
decisive response mechanism is joint-phase demodulation: subtract the
repeatable anterior-beat component from measured recent yaw, then use the
bounded residual for posterior mean tracking and yaw-deficit half-cycle
relief.

The prior CFD result makes this an evidence-backed replacement of the
prefilled `4.530L` upper-exit policy, not a claim about the unevaluated child.
Expected behavior is to reproduce target crossing near `16.64T` with the
alternating 3D carrier intact. Falsify reuse if the child does not capture, if
the compensated residual becomes phase-correlated under another pose or flow,
or if joint contact, acceleration residence, force, or moment becomes
materially worse. Later optimization should first test robustness or reduce
effort without perturbing the demonstrated route; it should not reintroduce
whole-wave terminal relief or raw-yaw response gating.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish turning by phase-compatible asymmetry
source_mechanism: retain a rhythmic propulsive carrier while feedback acts on directional response separated from fast carrier motion
transferable_invariant: compare a body-frame route request with a response residual after removing the joint-state-correlated carrier component, and modulate a distinct bounded steering half-cycle
nontransferable_details: published gains, robot or species geometry, dimensional frequency, prescribed maneuver duration, exact vortex phase, and task-specific routes
policy_translation: use normalized target, velocity, crossflow, and joint state; subtract the joint-phase yaw estimate from recent yaw before bounded posterior response tracking while preserving the full anterior oscillator
falsification: reject if capture does not repeat, phase contamination remains, the connected wake or targetward route degrades, or loads, saturation, or joint-limit contact worsen materially

## Evaluation boundary

No CFD result is claimed for this child. Its later evaluation should compare
termination and capture first, then arrival time, distance integral, route
topology, raw-versus-compensated yaw phase correlation, joint contact,
acceleration residence, peak force/moment, and both wake views against the
completed `solver_a46c8c6241a4` capture.
