# Phase-advanced anterior half-cycle candidate

## Evidence read before editing

- I read the assigned-parent guidance, all four sampled solver results, and the
  inherited optimizer notes before selecting this candidate. Every sampled run
  used direct uniform still water at `U_infinity=(0,0,0)`, with no cylinders
  and no prewarm, remained finite, and terminated in capture.
- The samples form two replicated controller outcomes. The two v33 policies
  capture at `23.84252T`, with score `-0.535091`, scoring mean/final distance
  `2.433543/0.746165L`, and 4,335 steps. The two functionally equivalent
  split-role policies capture one solver step earlier at `23.83702T`, improve
  score to `-0.535013` and mean/final distance to
  `2.433468/0.746096L`, and use 4,334 steps. The second group therefore
  supplies completed evidence that a distributed full-tail-rate observation
  is useful when confined to anterior half-cycle selection while the proven
  anterior-only course channel is preserved.
- I inspected representative combined sheets from both groups from release to
  capture in both views. Their top-down rows begin in quiescent water, develop
  an ordered alternating red/blue vortex street, and retain it along the
  target-directed terminal arc. Their oblique rows develop a compact
  three-dimensional Lambda2 chain behind the translating fish. The fish are
  self-propelled rather than advected, and neither view shows wake breakup,
  collision, boundary exit, or instability. The controller difference is not
  visually resolvable, so the trajectory and load histories decide it.
- Inside `3L`, the split-role controller slightly reduces mean absolute yaw
  from `1.67999` to `1.67938 rad/T`, center-referenced mean target-cross-track
  speed from `0.22808` to `0.22773U`, and peak absolute moment from
  `0.013730` to `0.013581`. Peak yaw rises slightly from `3.18484` to
  `3.19386 rad/T`; both joints still touch the `260 deg/T` velocity envelope,
  and projected commands stay below `31.39 rad/T^2`. This supports preserving
  the carrier and split observer while changing only when its small anterior
  correction acts.
- The current half-cycle selector uses tail-tangent angle alone. On the
  completed split-role trace, replacing that coordinate offline by an
  amplitude-normalized `tail_angle + 0.35*tail_rate/omega` quadrature changes
  the active half-cycle classification in about `52/601` samples inside `3L`.
  At capture it raises the selector magnitude from about `0.077` to `0.202`
  while positive yaw is rising. This is a phase-coverage diagnostic, not a
  closed-loop improvement claim.

## Policy hypothesis

Retain the evaluated split-role controller's target geometry, response-released
C-bend, posterior traveling-wave carrier, continuous anterior-only course
brake, distributed phase-yaw observer, cadence, and smooth command projection.
Change only the observed tail-side coordinate used by the anterior residual:
combine tail-tangent angle with a small normalized tail-rate quadrature and
normalize its amplitude. This advances the state-derived selector without a
clock, route state, or extra steering authority. It should begin the bounded
counter-curvature before the yaw-supporting tail displacement peaks and release
it before the useful half-cycle has passed.

The falsifiable expectation is preservation of the split-role controller's
coherent wake and capture-scale progress with a reduction in terminal peak yaw
or cross-track motion and no increase in moment or actuator-limit exposure.
Reject the mechanism if capture is lost or delayed, mean/final distance
regresses beyond the replicated v33 scale, the alternating wake degrades, or
the terminal yaw/load/limit histories worsen jointly.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and half-cycle asymmetric flapping
source_mechanism: infer locomotor phase from observed oscillator angle and rate, then apply a bounded steering residual on the useful half-cycle
transferable_invariant: separate the thrust-producing traveling carrier from a small target-derived correction and use an angle-rate phase coordinate so feedback anticipates, rather than follows, the relevant bend side
nontransferable_details: published CPG gains, dimensional cadence, hardware duty ratios, species-specific envelopes, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: preserve normalized body-frame course feedback and both-joint carrier dynamics; amplitude-normalize `tail_tangent + phase_lead*tail_rate/omega` and use only its bounded sign/magnitude to select the existing anterior excess-yaw residual
falsification: reject unless CFD preserves split-role capture and coherent propulsion while holding or improving mean/final distance, terminal peak yaw, target-cross-track motion, moment, and joint/command-limit exposure

## Validation boundary

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account and the agent could not start. Running
  its prescribed checks directly gives PASS for guidance materiality and PASS
  for the solver edit boundary.
- The Julia contract smoke check cannot start because no Julia executable is
  installed. A deterministic static schema audit finds `72` declared fields
  and `70` referenced fields, no undeclared `params.FIELD`, and only metadata
  fields `version` and `control_period` unused. The static forbidden-input scan
  also passes.
- No formal CFD was run. The phase-advanced controller remains a falsifiable
  candidate whose outcome belongs to the post-worker evaluator.
