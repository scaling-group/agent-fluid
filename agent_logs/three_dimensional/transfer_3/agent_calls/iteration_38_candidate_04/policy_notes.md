# Target-course-consented oscillator recovery candidate

## Evidence and visual diagnosis before editing

- All four current solver examples satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and `capture` termination. They are
  one reproduced physical rollout rather than four policy responses: every
  example captures at `19.684490 T`, scores `-0.261384287`, has mean/final
  distance `2.151092787 L`/`0.748302400 L`, follows a `12.951133 L` center
  path, triggers `243` window shifts, and has a byte-identical combined
  keyframe sheet. Three sources are the evaluated `v40` law; prefilled `v41`
  adds a terminal selector whose support never exceeds the existing allocator
  floor and is therefore behaviorally dormant.
- I inspected both release-to-capture rows of the current combined sheet. The
  top-down row begins from quiescent fluid and develops a coherent alternating
  posterior wake along a compact, nearly monotone target approach; the motion
  is self-propelled rather than advection. The oblique row shows finite,
  localized three-dimensional Lambda2 structures following the body, with no
  collision, boundary exit, detached volume-filling wake, or instability. The
  quiet curved posture crosses the capture circle without a late loop.
- The assigned parent's low-speed energy bootstrap is the informative visual
  failure. Its direct-uniform sheet remains finite in both views, but the
  early wake and route do not settle onto the parent's compact approach: later
  top-down frames show elongated/paired bands and a longer curved arrival. It
  captures only at `23.408014 T`, scores `-0.380336665`, has mean/final
  distance `2.277320982 L`/`0.749158561 L`, and requires `264` shifts. It does
  cross `12 L` sooner (`3.190 T` versus `3.806 T`), so early acceleration
  alone is a misleading success criterion.
- A second inherited phase-space-energy recovery independently shows the same
  topology tradeoff: it advances the `12 L` and `10 L` crossings to
  `2.954 T` and `6.969 T`, but slips behind by the `6 L` crossing, captures at
  `22.962509 T`, and scores `-0.330184330`. The broad outer posterior-
  divergence allocator also regresses score/mean distance to `-0.272400020`
  and `2.162221182 L`, even though it slightly advances final capture and
  shortens the center path. Together with the active sign-corrected terminal
  selector's small regression to `-0.261390567`, the evidence rejects a
  magnitude-only startup boost, more common limiting, and more terminal
  posture as general improvements.
- The current trace separates response magnitude from direction. During the
  first two seconds speed is only about `0.10--0.14 U`, but instantaneous
  center-course alignment with the target is poor or oscillatory (about
  `0.18` at `0.10 T`, `-0.32` at `0.25 T`, and `0.29` at `2 T`). Alignment
  first becomes strongly positive near `3 T`, while speed is still only about
  `0.21 U`. This leaves a narrower falsifiable locus: recover oscillator
  energy only after observed translation itself consents that the produced
  motion is target-directed, rather than treating low speed as permission.

## Policy hypothesis

Return the terminal allocation exactly to evaluated `v40` behavior by
removing the dormant `v41` selector. Preserve its steering, mean curvature,
posterior lag, saturation allocator, terminal posture, command ceiling, and
permanent oscillator coefficients. Add one mechanism to the anterior
state-feedback oscillator: a bounded velocity-parallel energy-recovery term
requires (1) distance outside the protected `4 L` band, (2) low but nonzero
body-frame translation, (3) a deficient joint phase-space radius, (4) quiet
large-angle redirect, and (5) positive alignment between center course and
the body-frame target vector. It releases continuously as speed or oscillator
energy establishes.

The course-consent factor is the architectural difference from both completed
energy regressions; it should withhold extra rhythm during the directionally
ambiguous release and admit it only when the measured locomotor response is
already useful. Same-state replay must prove the branch is active, finite,
strictly zero at/below `4 L`, zero for target-opposing course, and within the
existing acceleration limit. CFD falsification is an unchanged or later
`12 L` crossing, loss of the parent's advantage by `8--6 L`, slower or lost
capture, a changed compact route, persistent clipping/load growth, joint-stop
dwell, or degradation of either wake view.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and classical traveling-wave swimming
source_mechanism: sensory consent modulates oscillator energy while the coupled posterior lag preserves a directed traveling bend
transferable_invariant: increase rhythmic energy only when normalized locomotor response already points toward the target, then withdraw the recovery as response or oscillator energy establishes
nontransferable_details: published CPG gains, dimensional speed and frequency, species kinematics, full-body waveforms, exact vortex phase, and prescribed routes
policy_translation: multiply a bounded anterior phase-space energy-recovery term by body-frame course-to-target alignment, nonzero/low speed, outer-distance, and redirect-quiet support while leaving the posterior follower and terminal law unchanged
falsification: reject dormancy, action during target-opposing motion or at/below 4 L, failure to retain improved early crossings through midcourse, slower or lost capture, route or wake change, sustained clipping/load growth, or instability

## Deterministic pre-CFD validation

- Replaying the sampled `v40` parent states through both policies changes `429`
  of `3579` commands, beginning at `2.062500 T`, `12.292762 L` and ending at
  `5.604498 T`, `11.305143 L`. The maximum/mean-active command differences are
  `0.190076`/`0.010908 rad/T^2`; every output remains within the existing
  `30.543262 rad/T^2` software limit.
- No replayed command changes at or below `4 L`, at or below the declared
  `0.12 U` motion threshold, or when course alignment is at or below the
  declared `0.65` consent onset. Active states span course alignment
  `0.6501--1.0000` and speed `0.1245--0.5495 U`. Reconstructed
  `|action|>30 rad/T^2` counts change only from `1369/1973` to `1369/1974`
  anterior/posterior samples.
- These equal-state checks establish activity, direction consent, boundedness,
  and terminal isolation only. The new hydrodynamic outcome is unavailable to
  this worker and is not claimed as evidence.
- The required `.codex/agents/check-runner.toml` agent was invoked, but its
  pinned `gpt-5.4-mini` model is unsupported for this account and failed before
  executing a check. Running its three manifest commands separately gives PASS
  for the material guidance/notes update, finite two-joint Julia contract, and
  solver editable-boundary check. A separate schema audit resolves all `96`
  direct parameter references against the `97` returned fields; only the
  version field is intentionally unreferenced. No formal CFD was run.
