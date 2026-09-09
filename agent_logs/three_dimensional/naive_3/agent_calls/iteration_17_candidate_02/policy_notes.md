# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the assigned-parent evaluation report
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. I inspected the combined sheets for the strongest
  sampled brake, the prefilled response-released posterior S-bend, and the
  assigned parent's course redirect, including both top-down vorticity and
  oblique body/Lambda2 views from release through termination. Each fish
  self-propels along the same diagonal approach, sheds a sustained alternating
  planar wake with compact three-dimensional vortices, turns nearly vertical
  below the target, and remains powered to a lower-boundary exit near `31T`.
  There is no evidence of passive advection, collision, wake collapse, or
  numerical instability; terminal steering allocation remains the defect.
- The measured-yaw-selected posterior brake is still the strongest sampled
  action at `2.385/8.436L` minimum/mean distance. Joint-phase counterbending
  reached `2.512L`, gait-yaw residualization reached `2.541L`, and the
  response-released posterior equilibrium S-bend reached `2.536L`; all kept
  the coherent wake and lower exit. At the brake's minimum the fish still
  travels at `0.705U`, while the target-ray/course mismatch is about
  `1.15 rad`, so coasting or additional drive relief is not indicated.
- The assigned parent's distinct approach-localized course-error request also
  failed its stated falsification test. A shared bend added the same course
  redirect to the anterior equilibrium and, through `tail_curvature_share`,
  to the posterior equilibrium. It reached only `2.398L`, worsened mean
  distance from `8.436L` to `8.470L`, and retained the powered lower exit.
  Its closest-approach speed remained `0.712U`, its action probe changed both
  joint accelerations by about the same `+7.17 rad/T^2`, and its final
  lower-boundary crossing shifted laterally from `x=8.70L` to `x=9.47L`.
  Thus the geometric selector materially changed the path, but common-mode
  C-bend allocation did not rotate the translational course into capture.
- Earlier inherited evidence provides a bounded actuator-topology contrast:
  an opposite-sign posterior S-bend improved a comparable coherent near miss
  from `2.443L` to `2.187L`, whereas same-sign posterior redirects and later
  response-released S-bends did not. This does not establish a successful
  terminal controller, but it supports testing the persistent course selector
  through differential rather than common-mode curvature.

## Policy hypothesis

Start from the strongest sampled response-gated brake and preserve its
oscillator, bearing/yaw cruise curvature, posterior lag, alignment envelope,
wrong-way-yaw selector, command reserve, and exact far-field behavior. Retain
the assigned parent's normalized target-ray/course-error gate, but translate
its bounded request into an anterior redirect and a smaller opposite-sign
posterior equilibrium request. This creates a course-selected differential
S-bend while the posterior traveling wave and its measured-yaw brake remain
active. It is a new actuator allocation, not scalar retuning of the failed
shared course bend.

Capture, a useful termination-class change, or a minimum materially below
`2.385L` with retained cruise progress and wake coherence supports the
mechanism. It is falsified by a short tight curl, degraded far-field progress,
greater limit/load residence, a minimum no better than `2.385L`, or the same
powered lower-exit topology. Failure should close off course-triggered
differential equilibrium bending on this carrier rather than invite tuning of
its distance or amplitude scalars.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric turning and biological burst redirect
source_mechanism: persistent observed directional error biases anterior bend while a bounded posterior counterbend preserves an active traveling-wave tail
transferable_invariant: when a common-mode turn changes the path but not the miss class, apply the same geometric request differentially across the body rather than increasing shared curvature
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species-specific kinematics, dimensional frequency, exact vortex phase, prescribed burst timing, and task routes
policy_translation: normalized body-frame target and velocity vectors define a signed course error; normalized distance, speed, and error smoothly gate opposite-signed anterior and posterior equilibrium requests within the two-joint state-feedback carrier
falsification: reject if cruise or wake coherence changes, a tight curl or greater actuator/load residence appears, or closest approach and the powered lower-exit class do not improve over the 2.385L brake
```

## Evaluation boundary

The candidate receives formal coupled CFD only after this worker exits.
Contract, schema, symmetry, locality, and bound checks can validate the
implementation but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD checks

The candidate implements only the differential course allocation described
above. At a state reconstructed from the strongest sampled brake near its
minimum, the assigned parent's shared course bend commands approximately
`(18.16, 6.86) rad/T^2`, while the differential candidate commands
`(18.16, -2.34) rad/T^2`; the anterior request is unchanged and the posterior
request becomes the intended counterbend. At the analogous joint and direction
state placed at `8L`, the candidate differs from the unmodified brake by less
than `0.0005 rad/T^2`. The mirrored near state negates both commands with zero
floating-point reflection error. These are static signal probes, not
coupled-flow predictions.

The mandated material-guidance check, lightweight Julia policy contract and
parameter-schema guard, and solver-boundary audit pass. All `324` repository
non-CFD assertions also pass. Formal CFD was not run.
