# Step 38 target-policy diagnosis

## Evidence read before the edit

- The assigned parent is the prefilled
  `dogfish3d_intercept_guarded_speed_reserve_v1`. Its direct-uniform
  still-water rollout captured at `0.74953L`; a sampled exact-byte sibling
  captured at `0.74939L`. All four sampled evaluations satisfy
  `U_infinity=(0,0,0)`, no-cylinder, no-prewarm initialization and capture at
  `0.74923--0.74986L`. The best sampled score is `-0.14991`, from the
  outer-terminal unsupported-bearing qualifier, but inherited exact replay of
  that qualifier exited after a `1.18462L` pass, so its one capture does not
  justify adoption or scalar tuning.
- The combined sheet for the best capture shows self-propulsion from release
  through target crossing: its top-down row develops a persistent alternating
  vorticity street, and its oblique row retains bilateral Lambda2 structures.
  The latest inherited capture-corridor-certificate failure also remains
  self-propelled with both organized wake signatures through closest pass and
  the subsequent lower turn. It is a steering-path failure, not advection,
  collision, numerical instability, or carrier collapse. Its direct-uniform
  metrics agree: `left_domain`, minimum `1.67826L`, final `10.28354L`, and
  `468` moving-window shifts.
- That latest certificate replaced the parent's distance-blended inner guard
  with full capture-compatibility gating throughout the `4L` terminal region.
  It was intended to prevent premature response-conditioned release, yet it
  worsened the inherited lower branch while keeping propulsion active. This
  falsifies binary full steering retention outside the projected corridor;
  it does not falsify the parent's inner veto, which has two current sampled
  captures and remains the repeat-backed controller.
- Counterfactual replay over the available traces is diagnostic rather than a
  capture claim. On the latest failed trajectory, the full certificate nearly
  eliminates response release inside `4L` (mean about `0.0003` versus `0.035`
  under the parent formula), whereas a `0.35` bounded outer retention leaves
  mean release near `0.026`. Across the four sampled captures it stays much
  closer to the parent (`0.078--0.110` versus `0.088--0.122` on the three
  comparable parent/allocation traces) than the full certificate
  (`0.047--0.074`). This brackets the intervention without claiming that
  replay predicts the coupled CFD trajectory.

## Candidate hypothesis

Preserve the assigned parent's raw achieved-course feedback, response and LOS
logic, distance-blended inner intercept veto, additive two-joint steering,
sparse outward-only speed reserve, and posteriorly lagged traveling bend. Add
one outer-terminal compatibility governor: between `4L` and the existing
`2.75L` inner-guard boundary, an incompatible target/velocity projected pass
may retain at most a bounded fraction of steering that correct-sign yaw would
otherwise release. The retention rises smoothly, is only `0.35` at full outer
authority, and hands off continuously to the unchanged inner intercept guard.
It changes neither the turn request nor the carrier.

This is a state-feedback control-allocation mechanism, not a scalar gain sweep.
Falsify it if an exact sample-like approach loses capture, the lower branch or
large projected miss remains, response release collapses toward the failed
binary certificate, or closure, either wake view, joint-speed residence,
clipping, force, or moment leaves the repeat-backed parent envelope.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over an independently sustained rhythmic carrier
source_mechanism: continuously modulated steering authority from observed target geometry and turn response
transferable_invariant: steering release should be conditioned by both observed turn response and task-compatible trajectory, while the propulsive rhythm remains separately active
nontransferable_details: published gains, dimensional cadence, clocked CPG phase, robot morphology, species kinematics, exact vortex phase, and task-specific routes
policy_translation: retain the normalized body-frame achieved-course servo and two-joint traveling bend, but use projected target/velocity compatibility to retain a bounded fraction of outer-terminal steering before the existing inner intercept veto
falsification: reject if it loses sampled capture, retains the coherent-wake lower exit, behaves like full binary retention, increases actuator or load metrics beyond the baseline envelope, or weakens either wake view
