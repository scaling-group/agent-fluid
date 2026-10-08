# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and inertial
  moving-window transport. All terminate in capture, so the useful comparison
  is approach progress, response, wake coherence, load, and actuator viability;
  there is no sampled termination failure to reinterpret as a scalar tie.
- I inspected the combined top-down vorticity and oblique Lambda2 rows for the
  highest-score post-turn-recovery policy (`solver_7c8c0623a821`), its
  byte-duplicated assigned parent family (`solver_c65157fcb0b0` and
  `solver_cd2b31e85ca6`), and the informative but lower-score bend-qualified
  course policy (`solver_08d41e0117b7`). All visibly self-propel from rest,
  preserve an orderly alternating wake and compact three-dimensional vortices,
  and finish through the same target-side hook without wake breakup, boundary
  interaction, imposed advection, or a moving-window rotation artifact. The
  lower-score comparison is a mechanism failure rather than a physical
  instability: its much smaller middle projected miss does not improve route
  progress or arrival.
- The assigned parent duplicates capture at `0.749266L` and `25.9710T`, with
  mean distance `2.498175L`. The prefilled posterior sideslip-recovery
  descendant captures at `0.749162L` and `25.9160T`, improving mean distance
  only to `2.497592L`. It retains zero angle, rate, and applied-acceleration
  contacts and nearly the same peak planar force/yaw moment
  (`0.01902/0.01016` versus `0.01885/0.01010`). This is a reproducible finite
  arrival gain, but not the hypothesized course recovery: projected miss is
  `2.900L` versus `2.898L` at `20T` and only `2.125L` versus `2.140L` at
  `22T`, while both retain about `0.24--0.27 U` adverse body-normal velocity.
  Another scalar increase of the posterior correction is therefore not
  supported.
- The bend-qualified sample provides the useful contrasting response. It cuts
  projected miss to `1.675/1.440/0.900L` at `20/22/24T` versus the prefill's
  `2.900/2.125/1.059L`, but is behind in distance at each checkpoint and
  captures later at `26.0150T`; its mean distance worsens to `2.501515L` and
  score to `-0.599128` from `-0.595593`. Both visual rows remain coherent and
  its actuator contacts remain zero. Thus course alignment alone is not a
  reason to remove the productive course-triggered redirect, and bend-phase or
  route-side threshold retuning is not the next clean test.
- In the prefill's `1.75--4.5L` middle corridor, yaw moment correlates about
  `0.975` with measured heading acceleration, yet its sign opposes the
  geometry-defined course turn on about `56.7%` of rows. This response is
  distinct from the already saturated target-line request: it identifies the
  alternating hydrodynamic half-cycles that actually accelerate yaw. Use it
  only as a bounded phase/authority gate; target geometry must continue to own
  the steering side.

## Policy hypothesis

Preserve the prefilled state-feedback traveling bend, course/miss-triggered
response-released redirect, target-line residual, posterior course and
post-turn vectoring, capture modulation, coordinated acceleration projection,
and angle/rate viability guards. Add exactly one middle-course response
mechanism: when normalized target-course geometry still shows a response
deficit and measured yaw moment opposes the required turn, apply a bounded
same-sign two-joint correction only on the target-side joint-state half-cycle.
Positive closing speed, translation confidence, an inertial target-line
response deficit, and a continuous middle-distance window qualify it. The
instantaneous course/slip gates are not reused because the sampled adverse
moment occupies their complementary beat phase. Far travel, adequate or
non-closing response, helpful yaw moment, and the terminal controller pass
through.

The falsifiable expectation is a visibly earlier or tighter middle-course
handoff and lower mean distance than `2.497592L`, without losing capture,
changing the coherent two-view wake family, exceeding the prefill's
`0.01902/0.01016` load regime, or restoring an angle/rate/action contact.
Reject the mechanism if instantaneous moment gating merely chatters commands,
slows the productive redirect route, increases load, or reproduces only a
milliscale crossing-depth exchange.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG steering
source_mechanism: separate slow target-route authority from a bounded fast load-response residual, and use state phase to place asymmetric steering effort on the useful half-cycle
transferable_invariant: target geometry owns turn direction while measured adverse yaw response only gates a small phase-selective correction to the traveling bend
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, exact vortex phase, cylinder layouts, and prescribed routes
policy_translation: normalized body-frame inertial target-line response, closing response, and distance retain route and regime authority; normalized yaw moment gates a bounded reflection-equivariant same-sign two-joint command selected by anterior joint-state phase
falsification: reject on lost or slower capture, unchanged middle response, command chatter, wake incoherence, actuator contact, or peak planar force and yaw moment above the sampled prefill regime

## Non-CFD audit after the policy edit

- An initial composition reused the instantaneous-sideslip recovery gate. On
  all `4,712` reconstructed prefill states it changed only five command rows,
  with maximum separation below `0.00015 rad/T^2`: adverse yaw moment occurs on
  the complementary beat phase from the instantaneous sideslip gate. That
  structurally inert composition was rejected before handoff. The final gate
  uses the already evidenced inertial target-line response for direction and
  lets moment select only the fast actuation phase.
- Every one of the `62` direct `params.FIELD` names is owned by the `62`-field
  object returned from `target_policy_params()`. The public contract returns
  two finite accelerations for the prescribed multi-wake state.
- A deterministic `3,645`-state grid spanning both lateral sides, adverse and
  helpful moments, positive/zero/negative closing response, and beyond-limit
  joint angles and rates remains finite and inside the `30 rad/T^2` policy
  envelope. Paired lateral reflections have zero numerical command error.
- Re-evaluating the prefill and final candidate on reconstructed observations
  from all `4,712` prefill trajectory rows changes `412` post-guard command
  pairs, including `282` by more than `0.05 rad/T^2`. Maximum separation is
  `0.87793 rad/T^2`; the candidate's frozen-state peak remains the prefill's
  `29.65805 rad/T^2`. Activation is confined to `19.052--25.113T` and
  `4.413--1.102L`, tapering to exact pass-through before the innermost capture
  approach. This establishes one bounded, material response-phase test, not
  CFD evidence of improvement.
- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this ChatGPT account. Its three
  prescribed commands were therefore run directly as the established
  fallback: the material-guidance, Julia public-contract, and editable-boundary
  checks all pass. The guidance check first exposed two copied-parent markers
  in the rendered `README.md`; retaining one marker repaired the ambiguity.
  Formal CFD was not run, so the candidate's falsification criteria remain for
  the next evaluation.
