# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase 2 evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `left_domain` termination. I
  inspected the combined sheets for the best finite posterior phase-lag case
  (`2.326L` minimum), the response-released posterior-equilibrium S-bend
  failure (`2.536L`), and the prefilled response-selected brake (`2.385L`). In
  both the top-down vorticity rows and oblique body/Lambda2 rows, all three
  self-propel along nearly the same diagonal inbound path, shed a long
  alternating planar wake with compact coherent three-dimensional structures,
  pass laterally outside the `0.75L` capture radius, and remain powered on a
  steep lower-boundary exit near `31T`. There is no passive advection, wake
  collapse, collision, or instability to repair.
- The sampled phase-lag action is the only current mechanism with a consistent
  small advantage over the brake: minimum/mean distance improve from
  `2.385/8.436L` to `2.326/8.424L`, while anterior/posterior command-clamp
  residence stays near `0.749/0.355` versus `0.747/0.356`. At its minimum the
  fish still travels at about `0.687U`; local flow is only about
  `(-0.018,-0.001)U`, so the persistent miss is controlled motion rather than
  ambient-wake advection. The phase action therefore remains useful as a
  cruise/approach scaffold but is insufficient for recovery.
- The inherited closure-cone extension of that phase mechanism falsified
  earlier activation as the missing capability: it regressed to `2.390L`,
  mean `8.431L`, and the same lower exit. The assigned parent's target-behind
  differential burst also retained the topology at `2.499L` with worse
  `9.291L` final distance. Together with sampled anterior duty asymmetry
  (`2.433L`) and the equilibrium S-bend (`2.536L`), this closes scalar gate
  broadening, anterior duty/damping, and another static posterior redirect.
  What has not been tested on the useful phase scaffold is a geometrically
  selected reduction of the harmful posterior wave half-cycle itself.

## Policy hypothesis

Start from the sampled `2.326L` phase-lag controller, preserving its oscillator,
bearing/yaw mean-curvature loop, alignment envelope, response-selected brake,
proximity-selected lag modulation, and command reserve. Add one compatible
half-cycle steering action. The normalized signed angle from the body-frame
target ray to translational course remains the slow route error. Joint state
reconstructs the posterior traveling-wave target. Near approach, attenuate
only the posterior wave half-cycle whose signed bend agrees with that course
error; leave the opposite half-cycle and the posterior mean unchanged. This
creates a bounded opposite-sign mean impulse through posterior wave authority
rather than another equilibrium bend, and can only reduce rather than boost
the relevant raw posterior wave target. The distance, speed, and course-error
envelope already validated by the phase candidate makes the action negligible
during release and removes undefined stopped-course behavior.

Support requires preservation of the coherent inbound wake plus capture, a
return leg, a new useful termination class, or a material improvement over
`2.326L` without worse mean distance or clamp/load residence. The mechanism is
falsified by a changed far-field release, a one-sided/collapsed wake, tight
curl, greater actuator/load residence, or the same powered lower exit with only
another small closest-approach shift. Formal CFD occurs only after this worker
exits; controller probes below can establish only locality, symmetry, schema,
and bounds.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping control and classical posteriorly emphasized traveling-wave swimming
source_mechanism: measured route error selects a bounded half-cycle asymmetry in the posterior propulsive rhythm while the traveling-wave carrier remains active
transferable_invariant: steer a productive rhythm by reducing the posterior half-cycle that reinforces persistent signed course error, while preserving wave direction, lag, and the opposite propulsive half-cycle
nontransferable_details: published gains, robot duty ratios, dimensional beat frequency, species-specific kinematics, prescribed waveforms, exact vortex phases, capture radius, and task-specific route
policy_translation: normalized body-frame target-ray/course error and measured two-joint state select a reflection-equivariant attenuation of only the same-sign posterior wave half-cycle inside the evidenced approach envelope
falsification: reject if cruise progress or wake coherence changes, posterior clamp/load residence rises, a tight curl appears, or minimum distance and the powered lower-exit class remain materially unchanged
```

## Evaluation boundary

Formal coupled CFD occurs only after this worker exits. The checks below do not
establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the sampled fixed-proximity phase-lag policy and adds
only the hypothesized posterior half-cycle attenuation. It introduces no time,
world coordinate, route, mutable state, flow-file access, or command boost.
Replaying its selector on the completed `2.326L` trace without integrating new
dynamics gives an unchanged release: during the first `2T`, the mean scale is
`0.99999999` and the minimum is above `0.99999994`. Inside `3L`, the posterior
half-cycle scale averages `0.909` and bottoms at `0.770`; at the sampled closest
approach it is `0.795`. Thus the new mechanism is localized and material while
retaining more than three quarters of instantaneous posterior wave authority
in this counterfactual replay. These are selector diagnostics, not a coupled
flow prediction.

Representative approach and mirrored states return exactly negated commands
with zero floating-point residual. Zero-speed and extreme finite states remain
finite, and extreme actions clamp to the declared `+/-28 rad/T^2` reserve. All
`29` direct controller parameters are owned by `target_policy_params()`. The
mandated contract, schema, guidance-difference, and editable-boundary checks
are run separately before completion; no CFD rollout is run in this workspace.
