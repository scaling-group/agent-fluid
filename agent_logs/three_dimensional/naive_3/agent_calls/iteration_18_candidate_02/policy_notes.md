# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected
  the combined sheets for the best-scoring response-selected brake and the
  informative response-released posterior S-bend, including both top-down
  vorticity and oblique body/Lambda2 rows from release to termination. Both
  show a long alternating planar wake, compact three-dimensional vortices,
  and sustained translation. The fish is self-propelled; the repeated
  `left_domain` result is not advection, collision, wake collapse, or numerical
  instability.
- The sampled policies follow nearly the same diagonal inbound path, pass
  below the target, turn nearly vertical, and remain powered to the lower
  boundary near `31T`. The response-selected brake is the strongest sampled
  action at `2.385L`; at its minimum near `17.87T`, speed is still about
  `0.705U`, full body-frame target-direction error is about `1.38 rad`, and
  target-ray/course error is about `1.15 rad`. The informative posterior
  S-bend reaches only `2.536L` and preserves the same wake and exit class.
- The assigned parent's course-selected differential S-bend also fails its
  stated falsification test. Its minimum is `2.469L`, versus `2.385L` for the
  brake, and it retains the same powered lower exit. At its minimum it remains
  near `0.690U`; the target direction and course errors remain about
  `1.34/1.12 rad`, while the changed actions are approximately
  `(19.76,-1.84) rad/T^2` versus `(7.71,0.30) rad/T^2` for the brake at its
  minimum. The inherited parent notes predicted that failure should close off
  course-triggered differential equilibrium bending rather than invite gain
  tuning, so this candidate removes that mechanism.
- Inherited logs also reject distance-only energy relief, full-direction
  posterior gating, isolated half-cycle effort, static posterior redirects,
  gait-yaw residualization, and both shared and differential course-curvature
  requests as completed recovery. None distinguishes inbound propulsion from
  propulsion after the target has moved behind the head. That missing semantic
  condition is visible after the common closest approach: the fish continues
  to carry a coherent propulsive wake away from the target until domain exit.

## Policy hypothesis

Return to the strongest sampled response-selected brake and preserve its
inbound oscillator, mean-curvature steering, posterior lag, alignment gate,
wrong-way-yaw selector, and command reserve. Add one terminal-hold mechanism:
normalized longitudinal target geometry and distance smoothly identify a
near-target overshoot only after the target lies behind the head. In that
state, add bounded damping to the anterior joint-state oscillator while
retaining both joints' mean steering curvature. The unchanged posterior lag
then follows the decaying measured anterior rhythm, attenuating the traveling
wave without a second direct tail intervention. The gate releases automatically
when turning brings the target ahead again, restoring the unchanged propulsive
carrier without a clock, stage variable, world coordinate, or memorized route.

This mechanism is deliberately inactive at the sampled minima, where the
target is still ahead, so it does not claim to improve first-pass closest
approach. Support requires a useful semantic change after the near miss:
capture on a re-approach, survival instead of the powered lower exit, or a
meaningfully different target-return trajectory without degraded inbound
progress. It is falsified by early coasting, loss of the inbound coherent wake,
increased command-limit residence, failure to turn back toward the target, or
the same powered lower exit.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach control
source_mechanism: preserve the traveling-wave gait while a geometrically confirmed overshoot invokes a bounded propulsion hold until target-directed steering recovers
transferable_invariant: separate productive inbound propulsion from post-overshoot propulsion using normalized target geometry, reduce rhythmic drive only in the latter state, and restore it on geometric recovery
nontransferable_details: published gains, clocked CPG phase, species-specific kinematics, dimensional frequencies, exact vortex phases, fixed burst or hold durations, approach radii, and task-specific routes
policy_translation: normalized body-frame longitudinal target fraction and distance gate anterior joint-state damping; the unchanged posterior lag follows the damped measured rhythm around the otherwise unchanged two-joint response-brake carrier
falsification: reject if inbound progress or wake coherence changes, command-limit residence rises, the fish fails to turn the target ahead again, or the powered lower-exit topology persists
```

## Evaluation boundary

Formal coupled CFD occurs only after this worker exits. Static contract,
symmetry, locality, and bound probes can validate the implementation but cannot
establish hydrodynamic improvement.
