# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
  inertial moving-window transport. All terminate in capture with zero angle,
  speed, or applied-acceleration contacts, so this iteration must discriminate
  route response, arrival, loads, and wake organization rather than success
  class alone.
- The combined sheets were inspected in both top-down vorticity/body and
  oblique body/Lambda2 views for the highest-score phase-rejected posterior
  sample (`solver_2515fae158ed`), the assigned moment-qualified parent
  (`solver_9660f26c87c3`), and the weakest-score upstream-vectoring baseline
  (`solver_cd2b31e85ca6`). Every fish visibly self-propels from rest, sheds the
  same orderly alternating wake, preserves compact three-dimensional vortices,
  and reaches the target through the same shallow late hook. There is no
  passive advection, broad wasteful curl, wake breakup, boundary interaction,
  numerical instability, or moving-window rotation artifact. Because no
  sampled termination failure exists, the baseline's unchanged but slower
  capture is the informative mechanism failure contrast.
- The assigned parent captures fastest at `25.8335T` and has the lowest mean
  distance, `2.496768L`. Removing its yaw-moment residual while retaining the
  instantaneous sideslip recovery captures at `25.9160T` with mean distance
  `2.497592L`; removing both middle-response mechanisms captures at
  `25.9710T` and `2.498175L`. The phase-rejected posterior alternative has the
  best scalar score (`-0.594833`) and crossing (`0.748269L`) but arrives later
  at `25.9105T` with mean distance `2.497000L`. These are finite fixed-pose
  tie-breaks, not semantic route improvements: all traces are identical
  through `16T`, all retain about `2.84--2.85L` projected miss at `20T`, and
  the two visual rows remain in one trajectory family.
- The sampled mechanisms remain physically benign. Peak angle, joint rate,
  and applied command are shared at about `0.7635 rad`, `4.5150 rad/T`, and
  `29.6581 rad/T^2`; peak planar force and yaw moment remain within
  `0.01885--0.01902` and `0.01003--0.01016`. Thus no carrier, governor, or
  safety scalar needs repair, while another posterior phase, sideslip, or
  yaw-moment threshold retune is unsupported by the inherited and current
  evidence.
- A different response observation is empirically separable. In every sampled
  `18--24T` trace, the velocity-normal hydrodynamic force correlates
  `0.9950--0.9952` with measured course rotation and opposes the sign needed
  to reduce normalized velocity-to-target course error on about
  `56.1--56.6%` of rows. For the assigned parent, adverse normal-force
  magnitude has median about `0.0059` and 99th percentile about `0.0124` in
  normalized force units. This supports a bounded fast response gate; it does
  not make force a route command or establish that cancelling every
  oscillatory force is useful.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, course/miss-
triggered response-released redirect, line-of-sight response, upstream and
post-turn posterior vectoring, capture modulation, coordinated acceleration
projection, and angle/rate viability guards. Replace only the inconclusive
yaw-moment-qualified middle residual with a translational course-response
residual. Body-frame target and velocity geometry retain steering direction.
Within the same closing middle corridor, velocity-normal force may smoothly
gate a small same-sign two-joint half-cycle correction only when the measured
force rotates the course away from the target; helpful force, weak translation,
non-closing motion, active redirect, far travel, and the capture corridor pass
through.

The falsifiable expectation is a materially tighter or earlier middle route,
lower mean distance than `2.496768L`, and visible separation before the common
late hook while retaining capture, coherent wakes, zero actuator contacts, and
the parent's `0.01902/0.01016` load regime. Reject the mechanism if it merely
reproduces the milliscale capture cluster, chatters against beat-synchronous
force, increases loads or limit exposure, slows capture, or changes target
side without an integrated course-response improvement.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG steering
source_mechanism: separate slow geometric route authority from a bounded fast hydrodynamic response residual
transferable_invariant: target geometry owns turn direction while measured adverse lateral response may qualify small phase-selective steering without cancelling helpful wake motion
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, exact vortex phase, cylinder layout, and prescribed routes
policy_translation: normalized body-frame velocity-to-target geometry defines course side, while velocity-normal force gates a bounded same-sign two-joint half-cycle residual inside the observed closing middle corridor
falsification: reject on unchanged route and course response, lost or slower capture, force-driven route reversal, wake incoherence, actuator contact, or peak force and yaw moment above the sampled parent regime

## Non-CFD audit after the policy edit

- The first composition multiplied adverse force by both the inherited
  course-slip gate and an anterior joint-phase selector. On all `4,697`
  reconstructed assigned-parent rows it changed only three commands, with a
  maximum separation below `0.000032 rad/T^2`: the instantaneous qualifiers
  occupy complementary phases. That structurally inert version was rejected
  before handoff. In the final construction, target/velocity geometry still
  determines course side and attenuates weak error, while adverse force itself
  is the sole fast phase qualifier.
- Against the sideslip-only sampled policy on reconstructed assigned-parent
  observations, the final force mechanism changes `267/4,697` post-guard
  command pairs, including `95` by more than `0.05 rad/T^2`; its maximum
  addition is `0.55717 rad/T^2`, below the configured `0.75 rad/T^2`
  authority. Activation is confined to `19.409--24.657T` and approximately
  `4.231--1.344L`. Far travel and the inner capture approach pass through,
  while the frozen-state candidate peak remains the parent's
  `29.65805 rad/T^2`. This establishes a material bounded mechanism test, not
  CFD evidence of improvement.
- Every direct `params.FIELD` reference is owned by the returned `62`-field
  parameter object, and the public contract returns two finite commands. A
  deterministic `33,750`-state stress grid spanning both lateral reflections,
  five distance regimes, negative/zero/positive closing speeds, adverse and
  helpful force, and beyond-limit joint angles/rates remains finite and within
  `30 rad/T^2`. Both the grid and all reconstructed trace reflections have
  zero numerical equivariance error.
- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this ChatGPT account. Its three
  prescribed commands were run directly as the inherited fallback. The
  guidance check first exposed the rendered `README.md`'s duplicated copied-
  parent marker; retaining exactly one marker repaired the assignment. The
  material-guidance check, Julia public-contract check, and solver editable-
  boundary check then pass. No formal CFD was run.
