# Outer target-helpful-motion steering-release candidate

## Evidence and visual diagnosis before editing

- All four current solver examples satisfy the frozen Phase-2 contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. Their
  combined keyframe sheets and trajectories are byte-identical. Three contain
  the same evaluated `v40` law and the fourth is only source-level variation,
  so the samples reproduce one physical result rather than four mechanisms:
  capture at `19.684490 T`, score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, and `243` moving-window shifts.
- I inspected the full combined sheet from release through capture. The
  top-down row begins in quiescent fluid, follows a compact target-directed
  path, and develops a coherent alternating posterior wake, establishing
  self-propulsion rather than advection. The oblique row retains finite,
  localized Lambda2 structures; neither view shows collision, boundary exit,
  wake collapse, or volume-filling instability before capture.
- The inherited low-speed oscillator bootstrap is the most informative visual
  failure. Its top-down wake remains coherent and its oblique structures remain
  finite, but the trajectory bends below the compact corridor and needs a long
  late correction. Advancing the `12 L` crossing therefore regresses capture
  to `23.408014 T`, score/mean distance to `-0.380336665`/`2.277320982 L`,
  and window shifts to `264`. The related phase-space recovery captures at
  `22.962509 T` with score `-0.330184330`. Faster initial wake formation is
  not evidence for more oscillator energy.
- Other inherited completed results close nearby propulsion and posterior-
  response loci. A mature-carrier cadence governor changes `448` sampled
  commands yet delays capture to `20.322491 T` and regresses score to
  `-0.266846005`. Posterior-divergence allocation captures slightly earlier
  but regresses the distance integral and score to `-0.272400020`; reversing
  the response selector into convergence credit produces a large finite loop,
  capture at `45.848015 T`, and score `-0.929745304`. These outcomes argue
  against another cadence, energy, posterior-lag, or clipping-priority edit.
- The reproduced parent already contains a small successful terminal precedent:
  body-frame relative crossflow is allowed to relieve bounded allocation only
  when it represents target-helpful translation with positive closure. The
  unresolved question is whether the same qualitative consent signal can
  remove a little unnecessary *additive steering residual* during the outer
  approach without touching the validated mean bend, traveling carrier, or
  terminal handoff.

## Policy hypothesis

Preserve the evaluated `v40` oscillator, cadence, posterior target and lag,
mean-curvature steering, saturation allocator, and complete terminal law.
Outside `4 L`, after normalized center speed establishes the mature response
and while large-angle redirect is quiet, use normalized body-frame target side,
relative crossflow, and positive range closure to recognize lateral translation
that is already helping the target approach. Smoothly release at most a small
declared fraction of the existing additive two-joint steering residual in that
state. Target-opposing motion, weak lateral geometry, low-speed release, lost
closure, redirect, and every state at or below `4 L` retain the parent command
path.

This is a one-sided motion-consent mechanism, not a permanent steering-gain
retune and not a crossflow-cancellation command. It adds no energy or authority
and cannot change the posterior phase target or terminal posture. The CFD
hypothesis is a slightly shorter outer path and better distance integral while
retaining the same alternating top-down wake, finite oblique structures, and
capture. It is falsified by dormancy, any terminal command change, slower or
lost capture, worse distance integral, a wider path or loop, extra saturation
or loads, joint-stop dwell, instability, or degradation of either view.

bookshelf_consulted: true
source_domain: wake-aware fish control and closed-loop robotic-fish target tracking
source_mechanism: preserve lateral motion that already helps the route instead of spending actuation to cancel every crossflow response
transferable_invariant: use body-frame target-side and closure consent to distinguish helpful translation from target-opposing disturbance before modulating an existing steering residual
nontransferable_details: published gains, cylinder-wake phases, dimensional flow thresholds, species kinematics, robot geometry, exact vortex timing, and task-specific routes
policy_translation: outside the protected terminal band and after normalized center speed establishes translation, smoothly release only a small paired share of the existing additive steering residual when target side, relative crossflow, and positive closure all indicate target-helpful motion; leave carrier, lag, mean curvature, redirect, limits, and terminal posture unchanged
falsification: reject dormancy or any terminal leakage, slower or lost capture, worse distance integral, changed compact topology, saturation or load growth, joint-stop dwell, instability, or degradation of either wake view

## Evaluation boundary

The current worker can establish only same-state activity, boundedness, schema
integrity, and exact isolation from the terminal band. Coupled hydrodynamic
benefit is intentionally unclaimed until a later formal CFD evaluation.

Reconstruction over all `3,579` stored parent states changes `1,270` two-joint
commands. The first change is at `5.0215 T`, `11.5628 L`, after the low-speed
release; the last is at `15.4385 T`, `4.0009 L`. There are exactly zero changes
at or below `4 L`. The release reaches but never exceeds its declared `2.5%`
ceiling, the maximum same-state per-joint command delta is
`0.110294 rad/T^2`, and all outputs remain within the inherited
`30.543262 rad/T^2` software limit. Parent and candidate retain identical
same-state `|action|>30 rad/T^2` counts (`1368/1973` anterior/posterior).
These checks establish activity, boundedness, response gating, and terminal
isolation only; they are not CFD evidence.

## Final non-CFD checks

- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account and failed before executing a check.
  Running its three manifest commands directly and separately passes the
  material guidance/notes check, finite two-joint policy contract, and solver
  editable-boundary check. The rendered `README.md` contained the assigned
  guidance parent twice; removing only that duplicate marker was required for
  the semantic check to identify the parent.
- A direct schema audit resolves all `95` referenced `params.FIELD` names
  among the `96` fields returned by `target_policy_params()`; only metadata
  `version` is intentionally unreferenced. A deterministic grid of `32,768`
  extreme finite states remains within the declared software acceleration
  limit. No formal CFD rollout was run.
