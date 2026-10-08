# Tail-end carrier-response candidate

## Visual and metric diagnosis before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  capture. Three are exact evaluations of the prefilled lateral-residual
  policy, capturing at `16.604496T` with score `-0.113729`, final distance
  `0.743958L`, and scored distance integral `1.998146L`. The distinct
  one-sided-speed-guard predecessor captures one `0.0055T` step later with
  score `-0.115560`, final distance `0.745621L`, and integral `1.999656L`.
  Exact nominal repeats support determinism only, not held-out robustness.
- I inspected both rows of the combined keyframe sheets for a strongest
  lateral-residual rollout and the weaker predecessor. Their top-down rows
  show self-propelled targetward motion, shallow target crossing, and a
  coherent alternating vorticity street from release through capture. Their
  oblique rows show finite, compact, tail-connected three-dimensional
  Lambda2 structures. Neither is passive advection, wake breakup, collision,
  or instability. There is no semantic failure in the sampled set, so the
  weaker capture is the controlled comparator.
- I also inspected the inherited approach-bearing-residual result because it
  is the most informative completed negative mechanism. It retains the same
  alternating top-down and tail-connected oblique wake class and still
  captures, but only at `17.094002T`; its score regresses to `-0.121357` and
  distance integral to `2.006259L`. Removing beat-correlated raw bearing from
  the established posterior route signal therefore delays useful approach
  despite a finite coherent wake. Raw body bearing is not a response signal
  that should be independently residualized or gain-tuned in this carrier.
- The current candidate has a narrower response-observer limitation. Inside
  `6.5L`, hydrodynamic yaw moment and lateral force remain approximately 95%
  explained by anterior joint phase, while their phase-removed residuals
  weakly predict directional-yaw change; they do not justify a new load or
  disturbance feedback term. By contrast, after subtracting the current
  preliminary slow posterior center, a parity-preserving through-origin fit
  from realized tail-tip tangent and tail-tip velocity reduces approach yaw
  reconstruction RMSE from `0.152` for a refitted anterior-only observer to
  `0.131 rad/T`. The fitted tail-end coefficients are stable across the
  `3--6.5L` and inside-`3L` bands (`-2.48/-0.56` and `-2.38/-0.55`) and give
  `0.130 rad/T` RMSE on the distinct speed-guard predecessor. This identifies
  posterior traveling-wave state, not another scalar carrier setting, as the
  next bounded mechanism to test.

## Sole candidate hypothesis

Preserve the sampled-best traveling-wave carrier, raw-bearing route signal,
lateral and anterior-course residuals, phase-selective posterior steering,
and one-sided speed guard. Keep the existing anterior-only yaw demodulator as
the far-field response estimate. Within the existing `6.5L` approach gate,
first reconstruct the current slow posterior steering center with that
estimate, subtract the center from the measured tail tangent, and blend to a
two-joint tail-end carrier-yaw observer formed from the centered tail tangent
and its realized velocity. Feed only the resulting directional-yaw residual
back through the existing bounded response channel.

The controller remains clock-free, reflection-equivariant state feedback in
normalized body-frame observations and the two-joint acceleration contract.
The edit adds no gain sweep, carrier relief, fixed route, bearing
residualization, LOS-rate command, or load cancellation. It tests whether
tail-end kinematics provide a less phase-contaminated yaw response while the
current preliminary center prevents slow steering from being mistaken for
carrier motion. Falsify it if capture is lost, the far route changes before
`6.5L`, the target-crossing arc or connected two-view wake changes adversely,
directional yaw remains carrier-correlated, or arrival, distance integral,
joint contact, saturation, action effort, force, or moment regresses.

bookshelf_consulted: true
source_domain: Lighthill reactive tail-end kinematics combined with sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve the rhythmic traveling-bend carrier while separating its realized posterior yaw response from slower route steering
transferable_invariant: use centered tail-end traveling-wave state to estimate beat-synchronous body response before a bounded directional residual drives steering
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phase, prescribed maneuvers, and task-specific routes
policy_translation: retain the current anterior response estimate to reconstruct the slow posterior center, then blend on approach to a parity-preserving yaw carrier estimate from centered two-joint tail tangent and joint velocities
falsification: reject if capture, inherited far route, residual phase separation, target arc, connected wake, actuator envelope, effort, force, moment, or score worsens

## Evaluation boundary

No CFD result is claimed for this unevaluated workspace. Later evaluation
should first require capture and the same top-down/oblique wake class, then
compare arrival, scored and observed distance integrals, yaw residual
correlation with both anterior and tail-tip phase, pre-approach trajectory,
head crossing geometry, joint contact, speed/acceleration residence, mean
action, and peak planar force/moment against the three exact sampled-best
rollouts. The fitted nominal observer does not establish robustness to a
changed pose, flow, morphology, carrier family, or posterior-center model.

## Post-edit non-CFD verification

- A recorded-state algebraic comparison leaves posterior commands exactly
  unchanged outside `6.5L`. On the sampled-best trace, the mean absolute
  posterior-acceleration delta is `0.044 rad/T^2` from `3--6.5L` and
  `0.066 rad/T^2` inside `3L`, with a `1.108 rad/T^2` maximum. The response
  residual changes without replacing the evidenced carrier or demanding a
  larger acceleration envelope; this replay is localization evidence only,
  not a counterfactual CFD result.
- The workspace guidance-delta and editable-boundary checks pass. A static
  contract check finds every one of the 34 direct `params.FIELD` references in
  `target_policy_params()`, balanced delimiters, two public functions, a
  two-joint return, and a material candidate delta. The configured Julia
  smoke command could not run because this worker image has no `julia`
  executable; formal CFD and Julia execution remain for downstream EvE.
