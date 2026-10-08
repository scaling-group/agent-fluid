# Positive-work-relieved anterior residual candidate

## Evidence read before editing

- I read the assigned-parent guidance, all four sampled solver artifacts, and
  the inherited optimizer notes and completed results before choosing this
  candidate. Every compared rollout used direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm, remained finite, and
  terminated in capture.
- The four samples reduce to two deterministic controller outcomes. V33
  captures at `23.842522T`, with score `-0.53509095`, scoring mean/final
  distance `2.433543/0.746165L`, inside-`3L` mean/peak absolute yaw
  `1.67999/3.18484 rad/T`, and peak absolute moment `0.013730`. Three
  independently materialized split-observer policies are functionally
  equivalent and produce bit-identical trajectories: capture one solver step
  earlier at `23.837021T`, improve score and mean/final distance to
  `-0.53501328` and `2.433468/0.746096L`, and reduce mean yaw and peak moment
  narrowly to `1.67938 rad/T` and `0.013581`, although peak yaw rises to
  `3.19386 rad/T`. Both joints still reach the `260 deg/T` rate envelope, and
  smoothly projected commands remain below `31.39 rad/T^2`.
- I inspected the sampled v33 and split-observer combined sheets, plus the
  inherited phase-advanced regression, from release through capture in both
  views. The top-down rows begin in quiescent water and develop a spatially
  ordered alternating red/blue vortex street along the same target-directed
  arc. The oblique rows develop compact three-dimensional Lambda2 structures
  behind a translating fish and preserve them through the terminal bend. The
  fish are self-propelled rather than advected; no view shows wake breakup,
  collision, boundary exit, or instability. Controller differences are below
  visual resolution, so trajectory, load, and actuator histories decide them.
- The inherited phase-advanced selector preserves capture and the visible
  wake but regresses score/final distance to `-0.536621/0.747739L` and raises
  peak moment to `0.013925`; a sampled sibling that let the fast phase
  classifier choose sign while the slow course residual chose magnitude also
  regresses to `-0.535212/0.746410L` and raises peak moment to `0.014081`.
  Together these results reject earlier phase activation, correction-magnitude
  reassignment, and another scalar observer-share change. The small v37
  benefit supports preserving its angle-based half-cycle and split roles.
- A read-only replay of the completed split trace bounds the new pathway. Its
  phase-selected anterior residual is active in `388/601` samples inside
  `3L`. Using the sign of the bounded center shift and normalized anterior
  joint rate as an instantaneous steering-work proxy, only `91` active
  samples (19.2% of support-weighted duty) add work to the anterior carrier;
  the other `297` oppose joint motion. A smooth positive-work relief with
  normalized scale `0.10` retains all nonpositive-work correction and about
  93.4% of total support-weighted duty on that fixed trace. This is only a
  pathway/scope diagnostic, not a closed-loop improvement claim.

## Policy hypothesis

Start from the evaluated split observer. Preserve its normalized body-frame
target feedback, response-released C-bend, anterior-only continuous course
brake, distributed rate used only for phase residual selection, posterior
traveling wave, cadence, and smooth component-wise command projection. Change
only the duty of the smallest anterior half-cycle residual: infer whether its
bounded oscillator-center shift would accelerate with the current anterior
joint velocity, and smoothly relieve only that positive-work portion. Leave
the residual unchanged whenever it opposes joint motion. This is a
state-feedback work-sign gate, not a new route, clock, waveform, steering gain,
or propulsion-gain retune.

The falsifiable expectation is that avoiding positive-work competition lets
the split observer retain its coherent wake and target closure while holding
or reducing terminal moment and actuator effort. Reject the mechanism if
capture is lost or delayed, score or mean/final distance regress from the
replicated split result, terminal yaw/cross-track speed or peak moment worsens,
the alternating wake changes, or joint-rate/command-limit exposure grows. The
candidate remains unevaluated until the post-worker CFD run.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and half-cycle asymmetric flapping
source_mechanism: preserve a thrust-producing oscillator while applying the smallest bounded steering residual only on a useful observed portion of its cycle
transferable_invariant: separate the traveling-wave carrier from target-derived steering and use normalized joint state to select residual duty without a clock
nontransferable_details: published gains, dimensional cadence, hardware duty ratios, species-specific envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: retain v37's body-frame course channel and two-joint carrier; use the sign of the existing bounded anterior residual times anterior joint rate only to relieve its positive-work duty, leaving all nonpositive-work correction unchanged
falsification: reject unless CFD preserves split-observer capture, distance progress, and coherent propulsion while holding or improving terminal yaw, target-cross-track motion, moment, and actuator-envelope behavior

## Validation boundary

- The required configured `check-runner` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its prescribed
  checks directly gives PASS for guidance materiality and PASS for the solver
  edit boundary.
- Exactly one nonempty `candidate_target_policy.jl` exists under `solver/`.
  A deterministic static schema audit finds `72` fields declared by
  `target_policy_params()` and `70` direct `params.FIELD` references, with no
  missing declaration; only metadata fields `version` and `control_period` are
  unreferenced. Static guards find no executable clock, step, randomness, file
  I/O, cylinder-coordinate, mutable-global, target-identity, or memorized-route
  access, and delimiter balance is clean.
- The Julia contract smoke check cannot start because no Julia executable is
  installed. Formal CFD was intentionally not run; the candidate remains an
  unevaluated hypothesis for the post-worker evaluator.
