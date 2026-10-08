# Evidence-selected terminal course-residual candidate

## Visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  still water (`U_infinity=[0,0,0]`), no cylinders, no prewarm, and the L64
  moving storage window. Three v38 samples are byte-identical captures at
  `24.6730T`, minimum/final distance `0.748641L`, mean distance `2.348228L`,
  and score `-0.448610`. The distinct v39 sample also captures, at
  `24.6785T`, `0.748602L`, `2.348208L`, and `-0.448571` respectively.
- The combined top-down vorticity and oblique Lambda2 sheets for v38 and v39
  were inspected from release through capture. Both begin wake-free, then show
  self-propelled diagonal progress with a coherent alternating mid-plane
  vortex street and compact three-dimensional structures through the bounded
  final hook. Their route and wake class are visually indistinguishable at
  sheet resolution; neither result is passive advection, wake breakup,
  instability, or an out-of-plane escape. No failed-rollout keyframe is
  sampled in this workspace, so the failure comparison is limited to inherited
  audited metrics rather than an invented visual claim.
- V39 adds normalized target-relative velocity-course error as a bounded
  residual on the coupled turn channel below `2.10L`. Relative to v38, it
  improves the terminal course angle from `58.834` to `58.221 deg`, terminal
  distance by `0.000039L`, mean distance by `0.000020L`, and score by
  `0.000039`; anterior/posterior/total exact-rate occupancy changes slightly
  from `9.318/4.860/14.177%` to `9.294/4.858/14.152%`. It preserves zero
  posterior hard-stop occupancy and essentially the same low peak planar
  force/yaw-moment class (`0.0233/0.0320/0.0156` versus
  `0.0243/0.0316/0.0156`). Arrival is `0.0055T` later and the final hook
  remains strongly transverse, so this is a small local allocation improvement,
  not a new route or saturation cure.
- The assigned parent and inherited logs bound adjacent alternatives. V38's
  posterior-only course continuation changes terminal states but not the
  crossing class; v37 carrier relief worsens the distance integral, crossing
  margin, and loads; a binary course predicate is a measured no-op; and broad
  dual-joint velocity barriers or follower feedforward lose capture despite
  lower rate-limit counts. The sampled evidence therefore supports preserving
  the oscillator, route, safety filters, and v39 residual rather than using
  the shelf to speculate on another scalar or widespread phase intervention.

## Policy hypothesis

Use the positively evaluated v39 controller as this workspace's one candidate.
Relative to the v38 prefill, retain its bounded near-range velocity-course
residual through unused two-joint turn headroom while preserving the anterior
state-feedback phase anchor, lagged posterior traveling wave, posterior
mean-curvature continuity, stroke braking reserve, steering-residual coast,
and every active gain. This is evidence selection of an already completed
mechanism, not a claim that the small single-sample advantage generalizes.

Expected evidence is a deterministic v39-family capture near `24.679T`, mean
distance no worse than `2.348208L`, terminal distance no worse than
`0.748603L`, terminal course angle below v38's `58.834 deg`, zero posterior
hard-stop occupancy, and the established coherent-wake and low-load classes.
Falsify the selection if replication loses its score or course advantage,
changes the far route, loses capture, or regresses hard-stop, rate, raw-command,
force, or moment behavior. Do not tune `terminal_course_turn_gain` from this
single nominal sample; a later mechanism test should change actuator or
feedback structure and must preserve the v39 far path.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish coupled oscillators
source_mechanism: preserve a stable propulsive rhythm while target-relative direction error supplies a bounded sensory steering residual until the observed intercept is complete
transferable_invariant: retain the self-propelled traveling wave and admit normalized body-frame course correction only through bounded steering headroom while range is near and closing remains positive
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, robot morphology, full-body waveforms, prescribed paths, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: select the evaluated v39 policy whose near-range body-frame course residual modulates the established two-joint turn channel without changing the carrier or safety layers
falsification: reject if replication loses the score or terminal-alignment advantage, changes the far route, loses capture or coherent wake, or regresses hard-stop, rate, raw-command, force, or moment classes

## Pre-evaluation validation

- The single candidate is byte-identical to the positively evaluated v39
  sample (LF SHA-256
  `bd5b351bbf41976db9087a93148e0538d1659ce1252d649a82a3138c352acf85`).
  This is evidence selection, not a same-worker CFD claim.
- The public Julia contract returns exactly two finite joint accelerations.
  The deterministic schema audit resolves all `85` direct `params.FIELD`
  references among the `87` fields returned by `target_policy_params()`.
- The required checker was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account. After removing the duplicated marker for the
  same assigned guidance parent in the rendered workspace README, its three
  exact no-CFD checks pass locally: reusable-guidance semantics, the Julia
  policy contract, and solver editable-boundary compliance. No formal CFD was
  run.
