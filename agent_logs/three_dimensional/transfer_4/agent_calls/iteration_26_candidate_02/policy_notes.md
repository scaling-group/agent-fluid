# Inner-settle yaw-power-selective posterior relief

## Visual and quantitative diagnosis before editing

- I read the workspace contract, assigned parent guidance, all four sampled
  solver scores, observations, metrics, diagnostics, trajectories, and
  policies, plus the available inherited optimizer notes and completed parent
  score. Every sampled rollout starts directly from uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
- I inspected both the top-down vorticity and oblique Lambda2 rows for the
  sampled v20 scalar leader, v16 terminal-envelope comparator, and repeated
  v12 baseline. All visibly self-propel from rest and retain a coherent
  alternating top-down wake and compact three-dimensional posterior structures
  through capture. There is no sampled collision, domain exit, wake breakup,
  passive advection, or out-of-plane instability. No semantic failure sheet is
  available; the informative contrast is terminal state and actuator load.
- The sampled v20 yaw-power selector improves score from v16's `-0.064545` to
  `-0.064028`, captures slightly earlier (`18.0070T` versus `18.0235T`), and
  reaches slightly farther inside the capture boundary (`0.74842L` versus
  `0.74895L`). Far/middle distance samples through `15T` are identical, and
  center path is effectively unchanged (`13.2108L` versus `13.2111L`). Thus
  its benefit is confined to the terminal approach, not a new route or wake.
- The same v20 result does not improve terminal settling. Relative to v16,
  near mean alignment changes from `0.6722` to `0.6707`, near absolute yaw
  rises from `1.8883` to `1.9577 rad/T`, final alignment falls from `0.1818`
  to `0.1092`, final absolute yaw rises from `0.4200` to `0.9840 rad/T`, and
  near posterior acceleration-ceiling residence rises from `72.47%` to
  `75.83%`. Final speed also rises from `0.8511U` to `0.8820U`. Selective
  relief preserves useful posterior motion long enough to deepen capture, but
  leaves excessive yaw and lateral course at termination.
- Persistent forward mean-bend allocation is not independently supported.
  Inherited v19 improved yaw/alignment but regressed score/mean distance to
  `-0.064778/1.950985L`; the assigned parent's response-qualified allocation
  also retained capture but scored `-0.064760`, below v16 and v20. The new
  candidate therefore starts from v16 and does not carry that allocation.

## Single policy hypothesis

Preserve v16's odd body-frame curvature map, anterior state-feedback carrier,
posterior lag/emphasis, phase-consistent reserve, far/middle route observer,
half-cycle steering, and reversal-preserving rate governor. Change only how
its established terminal posterior-wave relief is selected. In the outer part
of the approach, apply relief when the reflection-invariant product of recent
yaw and normalized hydrodynamic yaw moment is positive, as in sampled v20, so
posterior motion is retained while the fluid moment is already damping yaw.
Inside a narrower capture region, continuously override that selector toward
v16's symmetric yaw relief, because the measured v20 terminal state shows that
waiting for positive yaw power alone leaves too much rotation and lateral
momentum.

The inner-settle gate uses only normalized target distance and is multiplied by
the existing approach, course-misalignment, and yaw gates. It changes neither
the route request nor total mean curvature, is exactly inactive outside its
inner onset, and remains reflection invariant. Expected evidence is exact
far/middle invariance, retained coherent two-view wake and capture, v20-like
outer-approach closure, and terminal yaw/alignment and posterior-limit residence
moving back toward or beyond v16. Falsify the mechanism if capture or distance
integral regresses, the terminal state remains v20-like, posterior load rises,
the wake becomes one-sided or incoherent, or reflection changes gate magnitude.

bookshelf_consulted: true
source_domain: wake/load-feedback robotic-fish control and biological burst-release turning with a distinct terminal capture regime
source_mechanism: preserve posterior motion when measured fluid moment already removes unwanted yaw, then release into stronger yaw relief when geometric capture becomes imminent
transferable_invariant: separate useful outer-approach propulsion from inner-approach settling with continuous state-qualified feedback rather than suppressing every posterior half-cycle
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body curvature distributions, world coordinates, capture radius, and task-specific routes
policy_translation: blend a reflection-invariant positive yaw-moment-power selector with an inner normalized-distance settle gate, while retaining the v16 body-frame route request, odd mean bend, and two-joint traveling wave
falsification: reject if pre-inner-approach behavior changes, capture or distance integral worsens, yaw and alignment fail to improve together, posterior limit residence rises, reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account. I ran its three commands
  directly. The material-guidance check passes, and the repository-boundary
  check passes with `candidate_target_policy.jl` as the only solver change.
- Julia is not installed or discoverable in this shell, so the executable
  include/action probe cannot run here. The deterministic static guard passes:
  all `65` direct `params.FIELD` references resolve among the `67` fields
  returned by `target_policy_params`; each public contract function occurs
  exactly once, delimiters balance, the candidate is nonempty, and no hidden
  clock, step, randomness, file I/O, cylinder coordinate, or world route is
  referenced.
- Focused algebraic probes make the inner-settle gate exactly zero at and above
  `1.20L`, fully active at and below `0.85L`, and bounded in between. Outside
  that inner region the selector reduces exactly to positive yaw-moment power;
  inside it the selector recovers the symmetric v16 relief. Simultaneous
  reflection of yaw and moment leaves every selector magnitude unchanged.
  These are contract and activation checks, not CFD evidence; EvE must evaluate
  the trajectory and wake after this worker exits.
