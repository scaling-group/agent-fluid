# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm. I inspected every combined sheet, including both the top-down
  mid-plane vorticity row and the oblique body/Lambda2 row. Each fish is
  self-propelled, sheds a long alternating planar wake with compact coherent
  three-dimensional structures, follows nearly the same diagonal inbound
  path, misses laterally, then remains powered on a steep lower-boundary exit
  near `31T`. There is no collision, passive advection, wake collapse, or
  numerical instability to repair.
- The assigned parent's yaw-selected posterior half-cycle brake reaches
  `2.385L` minimum and `8.436L` scored mean distance before the same lower exit.
  The sampled course-selected anterior duty action is weaker at `2.433L`, and
  the response-gated posterior S-bend is weaker at `2.536L`; their visual wake
  and trajectory classes are unchanged. Inherited logs additionally show that
  a target-behind anterior damping hold reached `2.293L` but worsened scored
  mean distance and exited earlier, while a target-behind differential burst
  redirect subsequently reached only `2.499L` and a worse `9.291L` final
  distance. Thus post-overshoot damping or equilibrium bending is not an
  evidenced recovery mechanism.
- The sampled posterior phase-lag candidate is a bounded non-equilibrium
  exception: it improves the brake to `2.326L` minimum and `8.424L` scored mean
  distance, reduces course error at the minimum from about `1.152` to
  `1.088 rad`, and preserves clamp residence near `0.75/0.36` and the coherent
  wake. It nevertheless exits low with `9.213L` final distance. Its inherited
  activation audit reports a median phase weight of about `0.507` inside
  `3L`, but its twelfth-power `3.6L` distance gate is effectively inactive
  earlier. On the completed phase trajectory, a representative state at
  `5.55L` already has lateral target fraction `0.49`, course error `0.85 rad`,
  and closure efficiency `0.66`; at `8.77L`, a similar instantaneous course
  error occurs with only `0.25` lateral target fraction. The conjunction, not
  distance alone, separates an established lateral miss from ordinary
  beat-scale course oscillation.

## Policy hypothesis

Start from the sampled `2.326L` phase-lag policy and preserve its oscillator,
bearing/yaw mean-curvature carrier, alignment envelope, response-selected
posterior brake, posterior lag modulation, and command reserve. Replace only
the phase modulation's fixed proximity envelope with a normalized closure
cone. The phase action becomes authoritative when the target has moved
laterally in the body frame and target-ray/translational-course alignment has
lost closure efficiency; speed and course-error gates still remove the
undefined stopped state and negligible mismatch. This should retain the
useful inside-`3L` modulation while beginning corrective posterior wave-shape
control around the evidenced `5--6L` miss formation, without reacting strongly
to the far-field sway event whose target remains mostly longitudinal.

Support requires retained coherent propulsion plus capture, recovery, a new
termination class, or a material closest-approach improvement over `2.326L`
without worse mean distance or clamp/load residence. It is falsified by an
altered far-field release, one-sided or collapsed wake, a short tight curl,
greater command-limit residence, or the same lower exit with only another
small scalar shift.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and terminal capture control
source_mechanism: preserve a posteriorly lagged traveling wave while measured directional error and approach quality schedule bounded wave-shape steering
transferable_invariant: separate productive cruise from an emerging lateral miss using normalized target geometry and closure response, then modulate the posterior wave without replacing the propulsive carrier
nontransferable_details: published gains, dimensional beat frequency, species-specific envelopes, clocked CPG phase, exact vortex phases, fixed approach radii, and task-specific routes
policy_translation: body-frame target and velocity unit vectors form reflection-equivariant lateral-target and closure-cone weights that gate the existing joint-state posterior phase modulation under the two-joint acceleration contract
falsification: reject if cruise progress or wake coherence changes, clamp or load residence rises, a tight curl appears, or minimum distance and the powered lower-exit class remain materially unchanged

## Evaluation boundary

Formal coupled CFD occurs only after this worker exits. Controller replay and
contract checks can establish locality, reflection equivariance, finite
bounds, activation scale, and schema consistency, but cannot establish a new
hydrodynamic trajectory or improvement.

## Controller-only activation audit

Replaying both selectors on the completed `2.326L` trajectory without state
integration gives nearly unchanged mean phase authority inside `3L` (`0.480`
for the closure cone versus `0.488` for the sampled distance envelope) and a
similar replayed lag span (`0.579--1.030`). On the inbound `5--6L` segment,
mean authority rises from `0.0014` to `0.0469` and reaches `0.381` only when
the lateral-ray and closure tests agree. During the first `2T`, the new mean
is `0.016`; its isolated maximum is `0.216`, while the lag remains within
`0.793--0.888`, so release is perturbed mildly rather than replaced. These
figures test selector locality and scale, not a coupled-flow outcome.

All `29` direct `params.FIELD` references are declared by
`target_policy_params()`. Representative approach, zero-speed, mirrored, and
extreme finite-state probes return finite actions inside `+/-28 rad/T^2`; the
mirror residual is below `1e-12`. These are controller-semantic checks only.
