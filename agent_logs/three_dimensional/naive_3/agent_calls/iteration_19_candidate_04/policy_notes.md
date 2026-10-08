# Candidate wake-policy notes

## Evidence and visual diagnosis

- All four sampled evaluations used direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and no prewarm snapshot. All captured at about
  `18.27T`; `solver_3991cf23285f` is the strongest finite example
  (`score=-0.247735`, `minimum_distance=0.748232L`). Because this sample has no
  termination failure, the unguarded `solver_09363152d449` capture is the most
  informative control failure: it exposes a posterior hard-stop load that the
  guarded run was intended to remove.
- In both combined sheets, the top-down row develops a regular alternating
  wake from release through the target approach, while the oblique row shows
  compact three-dimensional Lambda2 structures persisting at `12T`, `16T`,
  and capture. The route and wake are visually almost unchanged by the sampled
  angle guard. This is active propulsion rather than still-water advection:
  both traces reach about `1.329U`, whereas peak local flow is only `0.0315U`.
- The unguarded capture reaches exactly `-45 deg` at the posterior joint,
  resets about `-1.97 rad/T` of outward velocity, and produces next-sample
  peaks of `0.20756` force coefficient and `0.09276` yaw-moment coefficient.
  The sampled fixed-width stopping brake preserves capture and reduces those
  peaks to `0.17183` and `0.07699`, but it still reaches exactly `-45 deg` and
  resets about `-1.67 rad/T`; posterior raw acceleration exceedance is
  essentially unchanged (`46.43%` versus `46.42%`). Its `8 deg` geometric
  guard ramps too late for the velocity carried into the boundary.

## Policy hypothesis

Preserve the captured body-frame velocity-course observation, zero-centered
anterior oscillator, posterior traveling wave, and terminal acceleration
allocation. Replace the fixed-width posterior brake with a dimensionless
stopping-risk barrier: compare outward posterior kinetic stopping distance
against the remaining joint margin inside the already-evidenced terminal
allocation regime, then continuously cap outward acceleration and approach
full bounded braking as the ratio reaches one. On an algebraic replay of the
sampled capture states, this combination leaves the broad route unchanged and
first caps the recorded command at about `18.13T`, `0.80L`, and `-34.7 deg`,
rather than waiting until the fixed-width brake is already past `-42 deg`.
The velocity-aware margin should avoid the terminal hard stop and load spike
without losing the evidenced route or coherent wake.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture
source_mechanism: sensor feedback modulates a rhythmic carrier only when an observed terminal condition requires correction
transferable_invariant: preserve the propulsive rhythm and add bounded state feedback only when a normalized mechanical margin predicts contact
nontransferable_details: published gains, species kinematics, clock phase, exact wake phase, and task-specific routes
policy_translation: preserve the two-joint course-steered carrier; form posterior stopping risk from joint angle, joint velocity, and the owned acceleration envelope; use it only to cap acceleration toward the predicted boundary
falsification: reject if capture or the alternating 3D wake is lost, if posterior angle contact remains, or if peak terminal force and yaw moment do not improve over the sampled fixed-width guard
```
