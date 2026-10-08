# Terminal measured-moment rejection candidate

## Visual diagnosis and completed evidence

- All sampled and inherited rollouts report direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Their translation and wake development are controller-generated rather than
  ambient advection or moving-window transport.
- Among the four sampled solver examples, the `2.989L` response-released
  rollout is the strongest finite approach. Its top-down row shows a coherent
  alternating vorticity street and its oblique row shows persistent
  three-dimensional Lambda2 structures while body speed reaches `1.032U`
  against only `0.032U` peak local flow. Near the pass its useful rhythmic
  correction weakens and the path hooks into the upper boundary. The sampled
  anterior stiffness asymmetry is the informative visual failure: alternating
  shedding survives, but closest distance worsens to `4.859L`, peak speed
  falls to `0.947U`, and raw acceleration-envelope exceedance rises to about
  `53/64%`. A global anterior stiffness edit is therefore not supported.
- The assigned parent's speed-gated target-ray/velocity-course controller is
  the only completed observation change with a semantic improvement. Both
  visual rows retain a coherent self-propelled three-dimensional wake, closest
  distance improves to `0.857L`, and the common upper hook becomes a left
  exit. At the tangent miss the fish is still moving about `0.845U`, wrapped
  course error is about `-1.42 rad`, and the curvature request is saturated;
  the failure is terminal course authority rather than weak propulsion or an
  unreliable low-speed course estimate.
- Three inherited terminal continuations bound the missing mechanism.
  Posterior curvature escalation reached only `0.832L`, a same-sign anterior
  center shift reached `0.838L`, and anterior-angle-gated posterior
  counter-moment relief reached `0.867L`; all retained the left exit. The last
  case also worsened final distance to `9.510L`. Thus neither more static mean
  bend nor `q1` sign used as a causal moment proxy survives the evidence.
  Completed carrier traces instead establish a directly observable moment
  scale: from `4--12T`, mean normalized yaw moment is about `+0.0079` for
  positive `q1` and `-0.0078` for negative `q1`, with extrema near `0.017`.

## Policy hypothesis written before the solver edit

Start from the assigned parent's `0.857L` velocity-course controller and
preserve its full-quadrant target ray, measured course observation,
zero-centered anterior Van der Pol oscillator, posterior lag, damping, and
`12 deg` mean-curvature cap. Add one terminal measured-moment rejection
residual. Inside `3.5L`, while wrapped course error remains large, compare the
bounded observed yaw moment directly with the turn request. When their signs
match, the measured moment opposes the requested yaw in the established body
convention; apply a small bounded anterior acceleration toward the opposite
stroke until that counter-moment disappears. Leave favorable-moment portions
and all pre-terminal carrier dynamics unchanged.

This is a state-feedback translation of sensor-modulated rhythmic control: a
slow target-course command is separated from a fast measured load residual.
It does not infer exact vortex phase, amplify both half-cycles, shift an
oscillator center, or encode time or a route. Falsify it if the broad sub-`1L`
approach or alternating wake is lost, raw acceleration-limit occupancy rises
materially, the moment gate chatters without reducing wrong-way yaw, or the
rollout repeats the left exit without capture or a distinctly tighter recovery
arc.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance rejection
source_mechanism: preserve a slow direction-tracking carrier while a bounded measured-load residual rejects fast counter-turn disturbances
transferable_invariant: separate persistent body-frame target-course error from fast yaw-moment feedback and correct only measured moment that opposes the requested turn
nontransferable_details: published gains, robot linkage geometry, species-specific gait envelopes, dimensional cadence, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course steering and the two-joint traveling carrier; near the target use bounded moment_z_L2 aligned with turn_request to gate a small opposite-stroke anterior acceleration residual
falsification: reject if the inherited sub-1L course or alternating 3D wake degrades, acceleration-limit occupancy rises materially, counter-turn moment persists, or capture and termination topology do not improve
```
