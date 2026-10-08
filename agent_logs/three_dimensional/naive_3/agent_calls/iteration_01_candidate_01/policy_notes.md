# Candidate diagnosis and hypothesis

## Assigned evidence

- The only sampled solver is the common naive seed (`solver_ab755c2206e8`):
  score `-14.8252307527`, `left_domain` at `8.547T`, no capture, initial/minimum/final
  distance `12.3277/12.0782/12.3800 L`. The rollout is a direct uniform still-water
  initialization (`U_infinity=(0,0,0)`), with no cylinders or prewarm artifact.
- In the top-down keyframes the seed produces a visible alternating wake and some
  leftward self-propulsion, but its path curls upward instead of remaining aimed at
  the target. The closest finite point occurs near `6.36T`; afterward the body keeps
  rotating and translating upward until its center reaches `y=15.2004L`.
- The oblique Lambda2 row confirms a three-dimensional alternating tail wake rather
  than passive advection. It also shows the body and wake turning together before
  termination; there is no external wake to blame for the route error.
- The trajectory cross-check shows body-frame bearing drifting from `+0.155` rad to
  `-1.296` rad while heading changes from `+0.506` to `-0.782` rad. Thus the seed
  briefly sweeps through useful alignment and then overshoots. Raw joint-acceleration
  commands exceed the `1800 deg/T^2` envelope on roughly one third of samples, so a
  steering edit should not be an unbounded additive acceleration.
- The assigned parent guidance contains only the fresh-lineage contract and general
  cautions; no inherited optimizer log exists in this workspace. Therefore the one
  completed seed rollout is the available empirical parent evidence.

## Policy hypothesis

Retain the demonstrated state-feedback oscillator and posterior lag, but translate
target bearing into a bounded mean tail-tangent offset. Add a short bearing-trend
prediction inside the same steering mechanism so the offset releases or reverses as
the fish sweeps toward the centerline. Apply the offset as a target inside the damped
posterior tracker, not as an unbounded acceleration. This should preserve coherent
propulsion while preventing the unobserved seed oscillator from continuing the
wrong-way turn after it crosses target alignment.

Falsify this candidate if it keeps the same upward `left_domain` topology, fails to
hold bearing nearer zero after the first crossing, loses the coherent alternating
wake, or increases joint limit occupancy without materially improving distance or
termination class.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish direction tracking by tail-beat bias, consistent with biological mean-curvature turning
source_mechanism: sensor-driven bounded average bend superposed on a propulsive rhythm
transferable_invariant: persistent target-relative lateral error should bias mean curvature while the oscillatory traveling bend remains active, and the bias should relax as alignment improves
nontransferable_details: published gains, species-specific bend envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: use bounded body-frame bearing plus its observed windowed trend to shift the posterior joint's mean tangent while retaining the seed's joint-state oscillator and lag
falsification: reject if target bearing still diverges through the first alignment crossing, termination remains the same upper-boundary exit, propulsion collapses, or actuator-limit occupancy worsens without distance progress
