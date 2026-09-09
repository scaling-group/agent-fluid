# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their finite
  displacement and wakes are therefore self-propulsion rather than advection
  or inherited-flow contamination.
- I inspected the combined keyframe sheets for the best sampled
  response-selective brake (`2.385L` minimum) and the informative inherited
  response-gated posterior S-bend failure (`2.536L`), including every
  top-down mid-plane vorticity frame and oblique body/Lambda2 frame from
  release through termination. Both form a coherent alternating planar wake
  and compact three-dimensional vortex chain, follow the established diagonal
  inbound route, turn nearly vertical below the target, and remain powered to
  the lower virtual boundary near `31T`. There is no collision, passive
  advection, wake collapse, or numerical instability; terminal trajectory
  topology remains the limiting failure.
- The assigned parent's measured-heading-response brake is the strongest
  current sample. It improves closest approach from the inherited
  cross-track/closure hold's `2.429L` to `2.385L`, and it outperforms the
  sampled joint-wave-phase posterior counterbend (`2.512L`), full-direction
  gate (`2.494L`), and response-gated equilibrium S-bend (`2.536L`). The
  improvement is useful evidence for response selection, but all four current
  samples still exit low with nearly identical final distance
  (`9.188--9.207L`), so it is not a semantic recovery.
- At the response-brake minimum near `17.87T`, full body-frame target
  direction error is `1.38 rad`, heading rate has the wrong-way sign at
  `2.19 rad/T`, instantaneous closure is only about `0.014 L/T`, and speed is
  still `0.705U`. The inherited gate evaluates to about `0.913` there, yet its
  nonzero floor leaves roughly `41%` posterior-wave authority. Across the
  trace, anterior/posterior acceleration is already clamped for about
  `0.747/0.356` of samples. More carrier effort, a global command-bound change,
  symmetric terminal braking, or a joint-phase-only counterbend is therefore
  unsupported.

## Policy hypothesis

Start from the sampled response-selective brake, preserving its anterior
oscillator, bounded mean curvature, posterior lag, alignment envelope, command
reserve, and measured wrong-way-yaw gate. During only the gated wrong-way
response interval, reallocate part of the posterior oscillatory authority that
the brake removes into a bounded opposite-sign posterior equilibrium shift.
Corrective-yaw half-cycles and far-field cruise receive neither braking nor the
new shift. This is a response-selective posterior counterbend, not a scalar
retune of the carrier and not a joint-phase proxy for body yaw.

Expected evidence is the established far-field route and coherent traveling
wake, followed by stronger corrective body response during the specific
terminal wrong-way half-cycle. Capture, a useful new termination class, or a
minimum materially below `2.385L` without worse broad progress would support
the mechanism. Falsify it on changed cruise, a one-sided or collapsed wake,
premature speed loss, a tight curl, materially greater posterior limit/load
residence, or persistence of the same powered lower exit without a useful
minimum-distance improvement.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish half-cycle asymmetry and nonsteady fish redirect control
source_mechanism: preserve the traveling propulsive bend while measured target-relative body response selects a bounded corrective posterior asymmetry
transferable_invariant: infer whether an actuation interval is useful from signed geometric error and measured body response, then reallocate only counterproductive posterior authority instead of assuming joint phase equals turning response
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot duty ratios, prescribed C-start timing, exact vortex phases, approach radii, and task-specific routes
policy_translation: normalized target_body_L gives signed full target direction, normalized distance localizes the intervention, and bounded heading_rate gates both posterior-wave attenuation and an opposite-sign posterior equilibrium residual within the two-joint state-feedback carrier
falsification: reject on altered far-field progress, lost or strongly one-sided wake coherence, premature speed loss, a tight curl, greater posterior command/load residence, no material improvement below 2.385L, or persistence of the powered lower exit
```

## Evaluation boundary

This worker cannot claim CFD evidence for the new candidate; formal evaluation
occurs only after exit. Deterministic replay and contract probes below can
establish locality, reflection equivariance, boundedness, and implementation
correctness, not hydrodynamic improvement.

## Implemented candidate and pre-CFD checks

The candidate implements only the response-selective reallocation described
above. It starts from the sampled `2.385L` brake and adds a bounded `5 deg`
opposite-sign posterior target residual under the same approach, lateral-error,
and wrong-way-yaw gate; every mechanism parameter remains owned by
`target_policy_params`. For a representative state reconstructed around the
best sample's minimum, response weight is `0.913`, the new residual is about
`4.55 deg`, and the posterior acceleration changes from about `-0.31` to
`-10.66 rad/T^2` without touching the anterior command or the `28 rad/T^2`
reserve. This is an action-local replay, not a prediction of coupled CFD.

A direct state probe gives response weights `0.890` for a near wrong-way yaw,
`0.0022` for the mirrored corrective-yaw interval, and `0.00065` for the same
direction error at `8L`. Global reflection negates both joint commands to
floating-point tolerance, and finite extreme joint states remain within the
configured command bound. The mandated material-guidance, lightweight Julia
contract, deterministic parameter-schema, and solver-boundary checks pass;
all `324` repository non-CFD assertions also pass. Formal CFD was not run.
