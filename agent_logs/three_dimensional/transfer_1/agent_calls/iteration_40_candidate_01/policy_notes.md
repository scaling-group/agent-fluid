# Preserve v50 after two terminal-steering falsifications

## Completed evidence and visual diagnosis before candidate selection

- The four assigned solver samples are byte-identical copies of the current
  v50 policy and trajectory, so they are replication evidence rather than four
  controller comparisons.  All start directly from uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm, then self-propel to
  `capture` at `17.412992 T`, score `-0.0595203`, final distance
  `0.745094 L`, and total/observed distance integrals
  `1.945327/1.329976 L`.
- I inspected both rows of the combined sheets for the strongest replicated
  v50 result and the two completed step-39 regressions.  Their top-down rows
  show a compact startup disturbance developing into an organized alternating
  posterior street as the fish follows the same smooth target-signed arc; no
  rollout is passively advected, reverses, collides, exits the domain, or loses
  its wake before capture.  A readable v50 sheet and the wave-duty sheet show
  compact paired caudal Lambda2 structures at release, `4 T`, `12/16 T`, and
  capture, with occasional missing intermediate panels.  Other oblique rows
  are black.  The black panels are a rendering limitation, while the readable
  comparison supplies no beneficial three-dimensional topology for either
  terminal edit.
- Metrics make the step-39 policies informative failures despite retaining
  capture at the same logged step.  De-gaiting instantaneous terminal course
  slip before a posterior shape correction worsens score, total integral, and
  final distance to `-0.0599417`, `1.945667 L`, and `0.745503 L`; its observed
  integral is essentially unchanged at `1.329978 L`.  A body-frame bearing-
  divergence trigger translated into posterior half-cycle wave duty regresses
  further to `-0.0622763`, `1.947549/1.329991 L`, and `0.747766 L`.
- The failures do not buy a speed or load benefit.  V50, the de-gaited course
  residual, and wave duty keep the same `0.983097 L/T` maximum speed and
  `0.032252/0.016092` peak normalized force/moment.  Mean speed changes only
  from `0.728256` to `0.728249/0.728226 L/T`; exact any-joint acceleration-
  limit residence is unchanged at `40.11%` for the de-gaited residual and
  rises to `40.21%` for wave duty.
- A frozen v50 audit also rejects the next obvious allocation variant.  Native
  posterior steering first becomes clipped only at `12.276 T`, after the route
  is already closing strongly; all `163` such events have normalized radial
  closing at least as large as center speed.  Response-arbitrated tail-to-head
  recovery would therefore either be exactly inactive or repeat the inherited
  failure mode in which extra steering competes with productive propulsion.

## Sole candidate and policy hypothesis

Keep the completed
`dogfish_target_control_v50_geometrically_qualified_posterior_response` as the
one materialized candidate.  Preserve its normalized body-frame target
sensing, state-feedback traveling-wave carrier, posterior lag, selective
crossflow pose confidence, route and redirect steering, axis-selective launch
residual, carrier-first anterior-to-posterior spillover, half-cycle steering,
geometrically qualified posterior turn-shape response, approach priority, and
componentwise actuator projection.  Do not retain either step-39 terminal cue
and do not add reverse allocation where the completed trace shows no response
deficit.

The next formal rollout should reproduce capture near `17.413 T`, score and
total/observed integrals near `-0.05952` and `1.94533/1.32998 L`, the smooth
target-signed arc, organized two-view wake where rendered, and the established
speed/action/load envelope.  Falsify this exploit selection if the replicated
result fails, a held-out pose exposes a new termination or route topology, or
a future completed controller demonstrates earlier radial closure from a cue
that is independent of carrier-correlated sway and does not consume occupied
posterior or productive anterior authority.  Formal CFD occurs only after this
worker exits.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG navigation, asymmetric turning, and wake-interaction control
source_mechanism: retain a productive rhythmic carrier and admit bounded navigation modulation only when the observation separates persistent route error from carrier-correlated lateral motion
transferable_invariant: a coherent state-feedback traveling wave should be preserved when added body-frame steering cues do not improve target response or actuator allocation in completed closed-loop evidence
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, full-body CPG states, exact vortex phases, cylinder-wake synchronization, and task-specific routes
policy_translation: retain the v50 two-joint carrier and geometric response arbitration; reject the de-gaited terminal course residual, posterior wave-duty asymmetry, and response-incompatible reverse allocation
falsification: reject the selection if v50 capture and integrals do not reproduce, or revisit modulation only when a normalized body-frame cue improves radial closure without degrading wake coherence or the established speed, saturation, force, and moment envelope
```

## Evidence boundary

All outcome and visual claims above come from the assigned-parent guidance,
sampled completed solver results, and inherited optimizer logs.  V50 is an
evidence-backed reproducibility selection; this worker claims no same-worker
CFD result.
