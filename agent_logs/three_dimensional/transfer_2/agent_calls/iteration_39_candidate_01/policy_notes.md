# Selected collision-course commitment candidate

## Evidence read before editing

- Three sampled solvers are byte-identical `v41` controls.  Each captures at
  `24.640015T` and `0.748356L`, with mean distance `2.347937L`, score
  `-0.448328283`, 284 moving-window shifts, `73.594%` raw acceleration-envelope
  exposure, and `13.839%` any-joint exact-rate exposure.  Repetition establishes
  deterministic nominal behavior, not three independent mechanisms or held-out
  robustness.
- The fourth sample is the action-changing `v44` collision-course commitment
  policy.  It captures at `24.557514T` and `0.747654L`, improves mean distance
  and score to `2.347238L/-0.447654`, uses 283 window shifts, reduces raw
  acceleration-envelope exposure to `73.393%` and total exact-rate exposure to
  `13.617%`, and lowers peak absolute lateral body-force coefficient from
  `0.03169` to `0.02893`.  Peak yaw-moment remains `0.01559`; neither result
  supplies a new load class.
- All evidence is direct-uniform still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm.  I inspected the combined sheets from release to
  termination in both views.  The top-down rows show self-propelled diagonal
  progress, an orderly alternating vortex street, and a tight terminal hook
  through the capture disk.  The oblique Lambda2 rows show compact paired
  three-dimensional structures through that hook, without wake collapse,
  passive advection, out-of-plane escape, or numerical instability.  No sampled
  termination failure exists; the inherited v42/v43 allocation regressions are
  therefore informative numerical controls rather than a fabricated visual
  failure comparison.
- The inherited parent records that v42 transfers rejected posterior effort to
  the anterior phase anchor and v43 vetoes anterior terminal effort when the
  posterior safety layer rejects its mate; both retain capture but worsen
  distance, score, or crossing margin.  In contrast, v44 neither transfers
  authority nor couples the joint safety layers.  Against the common trace its
  first action change is confined to the anterior command at
  `22.269T/1.846L`; the far route and posterior command are initially unchanged.

## Candidate selection and hypothesis

Materialize the sampled `v44` policy as the sole candidate.  Preserve the
evaluated anterior state-feedback oscillator, posterior lagged traveling bend,
terminal phase allocation, predicted-miss corridor, posterior stopping reserve,
and posterior rate coast.  When normalized body-frame range, positive closing,
course speed, and predicted miss indicate that inertial velocity already
intersects the safe capture corridor, continuously taper only additive anterior
route steering.  Leave the anterior oscillator and all posterior route and
safety authority intact.

The sampled comparison supports this as collision-course commitment rather than
scalar tuning: it stops bearing-chasing after a valid intercept without
coasting propulsion or redistributing rejected effort.  Its applicability is
the established terminal neighborhood after a closing course has formed.
Reject it if replication loses capture, changes commands outside `2.10L`,
reduces crossing margin, increases predicted miss after commitment, or regresses
the coherent-wake, zero-posterior-hard-stop, low-load, or rate-exposure classes.
Do not infer reflected-pose generalization or extend the hold to the posterior
joint without separate evidence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish oscillator modulation and terminal approach hold
source_mechanism: separate the propulsive phase anchor from bounded sensory steering and release unnecessary direction tracking after a valid velocity intercept forms
transferable_invariant: preserve the traveling-wave oscillator while normalized body-frame range, positive closing, course speed, and projected miss decide whether additive route steering remains necessary
nontransferable_details: published gains, robot hardware, species kinematics, dimensional cadence, exact vortex phase, capture geometry, and task-specific routes
policy_translation: taper only additive anterior route steering inside the existing collision-course corridor while retaining anterior oscillator acceleration and posterior propulsion, steering, and safety filters
falsification: reject if capture or crossing margin is lost, action changes outside the terminal neighborhood, projected miss grows after commitment, or wake coherence, loads, hard-stop occupancy, or rate exposure regress

## Evaluation boundary

The `v44` results above are sampled solver evidence.  Formal CFD for this
materialized candidate remains deferred until after this worker exits; no new
same-worker CFD outcome is claimed here.

## Pre-evaluation validation

- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were then
  run directly and separately.  Reusable-guidance semantics, the public Julia
  policy contract, and the solver editable-boundary audit all pass; the
  contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  The sole editable candidate has SHA-256
  `311b36856266cfb0258b452c5bec9b877f290fd30277e1f7b53262a89cf358c6`
  and is byte-identical to the evaluated v44 sample.  No formal CFD was run.
