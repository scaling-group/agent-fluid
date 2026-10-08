# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver evaluations, and the
  inherited optimizer notes were read before proposing a controller change.
  Every sampled run used direct uniform still water at
  `U_infinity=(0,0,0)`, with no cylinders or prewarm, and terminated in
  capture. There is no semantic failure in this sample, so the comparison uses
  the strongest finite run and the most informative mechanism tradeoff rather
  than pretending one of the captures failed.
- The combined sheets for the best-score load-selective counter-tangent, the
  v24 continuous-course baseline, and posterior half-cycle amplitude relief
  were inspected in both visual rows. Each begins with an empty field,
  self-propels through the same broad target-directed bend, develops a coherent
  alternating top-down vortex street and compact oblique Lambda2 pairs by
  `12T`, and carries that wake through the curved terminal approach. The
  mechanism differences are below keyframe resolution; trajectory, yaw, load,
  joint, and command histories must decide the intervention.
- The sampled load-selective counter-tangent is strongest by score and scoring
  mean distance (`-0.535298`, `2.433642L`) and captures at `23.8315T`, but it
  does not provide clean terminal regulation: relative to v24, target-
  transverse speed rises from `0.2393U` to `0.2449U`, peak yaw rises from
  `3.208` to `3.264 rad/T`, and peak moment rises from about `0.01406` to
  `0.01439`. Its coherent wake and progress support retaining the carrier and
  continuous target-course bend, not its extra counter-tangent.
- Sampled unconditional posterior half-cycle amplitude relief retains capture
  and the coherent wake while reducing inside-`3L` mean/peak yaw from v24's
  `1.684/3.208` to `1.606/3.063 rad/T`, target-transverse speed from `0.2393U`
  to `0.2335U`, mean lateral force from `0.011795` to `0.011351`, and mean
  moment from `0.006402` to `0.006137`. Its bounded cost is capture at
  `23.8755T` rather than `23.8315T`; the joint and projected-command evidence
  does not identify saturation as the cause. Amplitude relief is therefore the
  evidenced stabilizing actuator, but unconditional authorization discards
  some useful posterior impulse.
- The inherited v31 result is the concrete negative selector result. A
  reinforcing-yaw-moment multiplier left arrival at `23.8755T`, worsened
  score/final distance to `-0.537144`/`0.748217L`, and weakened terminal yaw
  cleanup to `1.634 rad/T`, although target-transverse speed fell to `0.2299U`.
  Its realized terminal trace admitted the gate in about `76%` of states but
  reduced mean relief weight from about `0.251` to `0.207`; instantaneous load
  multiplication merely weakened useful relief and did not recover progress.
- The assigned parent proposes route-scale rather than fluid-load
  authorization. That direction is consistent with the sampled evidence and
  avoids another gain-only iteration, but it has no completed CFD result yet
  and is treated here as a falsifiable hypothesis, not as a durable success.

## Candidate hypothesis recorded before policy edit

Use evaluated v24 as the behavioral base. Preserve its state-feedback
traveling-wave oscillator, posterior lag, response-released target C-bend,
continuous terminal course curvature, and smooth component-wise acceleration
projection. Add one bounded mechanism: inside the existing approach gate, the
already normalized, carrier-rejected target-transverse course residual selects
and scales relief of only the observed posterior half-cycle that supports
motion across the target line. The same route/yaw residual already used for
continuous terminal curvature supplies authorization, so neither fast yaw
alone nor instantaneous fluid moment can suppress a productive stroke.

This should retain the sampled relief policy's yaw/slip/load cleanup while
leaving more of the posterior wave intact whenever the fast carrier yaw does
not correspond to route-scale transverse error. Falsify it if capture or the
alternating wake is lost; if arrival/final distance regresses to or beyond
v31; if terminal yaw, transverse motion, and load do not improve materially
over v24; or if posterior joint-speed or projected-command exposure worsens.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and terminal capture control
source_mechanism: retain target-derived mean curvature while reshaping only the observed posterior half-cycle associated with unwanted lateral route motion
transferable_invariant: separate the propulsive traveling carrier and mean route bend from bounded beat-side amplitude modulation authorized by normalized target-relative motion
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific kinematics and envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: preserve v24 body-frame feedback; use its carrier-rejected target-vector/velocity course residual and approach gate to relieve only the q1+q2 posterior side supporting motion across the target line
falsification: reject if capture or coherent alternating propulsion regresses, or if v24-scale progress is not retained while terminal transverse motion, yaw, and load improve without added actuator-limit exposure
```

## Non-CFD validation

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account. Its exact material-guidance and solver-
  boundary commands were run directly and pass. The inherited duplicate
  assigned-parent marker in the rendered workspace `README.md` was removed so
  the guidance checker could identify its unique comparison baseline.
- The deterministic schema audit found all 68 direct `params.FIELD`
  references among the 70 returned fields; only metadata fields `version` and
  `control_period` are intentionally unreferenced. Exactly one nonempty target-
  policy candidate exists under `solver/`, the solver boundary check confirms
  it is the only allowed solver difference, and static guards find no clock,
  step counter, random source, file I/O, fixed coordinates, or mutable globals.
- The candidate is behaviorally identical to evaluated v24 when the existing
  terminal route/yaw residual is zero. When active, both the signed residual
  and observed tail side are bounded to unit magnitude, so the posterior wave
  gain remains in `[0.82,1]` before the inherited component-wise smooth command
  projection.
- The configured Julia smoke command could not start because no Julia
  executable is installed. No formal CFD was run.
