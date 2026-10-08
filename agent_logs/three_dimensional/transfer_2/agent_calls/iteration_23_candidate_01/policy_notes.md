# Evidence-selected terminal course-residual candidate

## Visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  still-water initialization (`U_infinity=[0,0,0]`), no cylinders, no prewarm,
  and L64 moving-window storage. Three byte-identical v38 samples capture at
  `24.6730T`, terminal distance `0.748641L`, mean distance `2.348228L`, and
  score `-0.448610`. The distinct v39 terminal course-residual sample also
  captures, at `24.6785T`, `0.748602L`, `2.348208L`, and `-0.448571`.
- Both rows of the v38 and v39 combined sheets were inspected from release to
  capture. Their top-down rows start wake-free and show self-propelled diagonal
  progress, a coherent alternating mid-plane vortex street, and a bounded hook
  into the capture disk. Their oblique rows retain compact alternating
  three-dimensional Lambda2 structures through the redirect. The routes and
  wakes are visually indistinguishable at sheet resolution; neither rollout
  shows passive advection, wake collapse, instability, or out-of-plane escape.
- V39 is a narrow terminal improvement, not a new semantic trajectory. Its
  final target-relative velocity-course angle improves from `58.834` to
  `58.221 deg`, consistent with the intended residual, and its final/mean
  distance and score improve by `0.000039L`, `0.000020L`, and `0.000039`.
  However, it captures one CFD step later, mean absolute course angle inside
  `2.10L` worsens slightly from `56.145` to `56.209 deg`, and peak near-course
  angle worsens from `102.620` to `103.611 deg`.
- The safety and load evidence is mixed but remains in the inherited class.
  V39 preserves zero sampled posterior hard-stop occupancy; total exact-rate
  exposure changes only from `13.955%` to `13.929%`, raw acceleration-envelope
  exposure rises from `73.473%` to `73.613%`, and peak absolute planar
  force/yaw-moment coefficients change from `0.02428/0.03156/0.01559` to
  `0.02335/0.03202/0.01559`. The sampled sheets contain no failed CFD rollout,
  so the inherited broad dual-joint rate barriers and posterior
  reference-velocity feedforward are used only as audited numerical failure
  context: both improved saturation counts but changed the established route
  and lost capture. No failed visual behavior is invented.

## Policy hypothesis

Use the positively evaluated v39 controller as this workspace's single
candidate. Relative to the assigned v38 parent, it preserves the anterior
state-feedback phase anchor, lagged posterior traveling bend, posterior
course-continuity curvature, carrier, stroke reserve, braking reserve, and rate
coast. Its only new mechanism sends the existing bounded, mirror-equivariant
near-range velocity-course request through unused headroom in the coupled turn
channel while range is still closing. This is evidence selection: no gains are
retuned and no further terminal layer is stacked on a marginal result.

Expected evidence is deterministic reproduction of the sampled v39 capture,
with an unchanged far route and coherent wake, terminal course angle no worse
than `58.23 deg`, mean distance no worse than `2.34821L`, zero posterior
hard-stop occupancy, and the inherited low-load class. Falsify the mechanism
if replication loses the small score/course advantage, changes any command at
or beyond `2.10L`, loses capture, or materially worsens arrival, mean near-course
error, acceleration/rate exposure, force, or moment. A reflected or perturbed
rollout must be used before treating this nominal-route result as general.
The new post-exit CFD result is not available to this worker and is not claimed.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled oscillators and terminal capture control
source_mechanism: apply bounded direction-tracking feedback as a residual over a stable propulsive traveling bend
transferable_invariant: preserve the self-propelled wave and its anterior phase anchor while target-relative velocity error modulates steering only until the observed intercept is complete
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, full-body waveforms, prescribed paths, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain the evaluated two-joint carrier and safety filters, and inside normalized near range with positive closing admit the existing body-frame course request through unused coupled-turn headroom
falsification: reject if the far route changes, the sampled course and score advantage does not replicate, capture or coherent wake is lost, or hard-stop, rate, raw-command, force, or moment classes regress

## Pre-evaluation validation

- The single candidate is byte-identical to the positively evaluated v39
  sample (LF SHA-256
  `bd5b351bbf41976db9087a93148e0538d1659ce1252d649a82a3138c352acf85`).
  This is evidence selection, not a same-worker CFD claim.
- The exact Julia public-contract probe returns two finite accelerations, and
  the deterministic schema audit resolves all `85` direct `params.FIELD`
  references among the `87` fields returned by `target_policy_params()`.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its three declared no-CFD checks were then
  run separately: reusable-guidance semantics, the Julia contract, and the
  solver editable-boundary audit all pass. The guidance check first exposed a
  duplicate assigned-parent marker in the rendered workspace README; removing
  only that duplicate repaired the metadata. No formal CFD was run.
