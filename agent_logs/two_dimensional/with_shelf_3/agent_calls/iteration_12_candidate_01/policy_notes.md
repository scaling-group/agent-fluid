# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. It is the certified common
  initial condition, not evidence that this parent selected a favorable phase.
- All four sampled solver rollouts are semantically identical realizations of
  the assigned parent. Their released sheets show an immediate correct-sign
  redirect, a persistent body-generated traveling wake, clear cylinder
  separation, and one compact diagonal crossing into the `0.75L` target circle.
  Capture at `32.472` release time, head displacement
  `(-10.912,-4.332)L`, mean fish velocity `(-0.334,-0.140)`, and mean local
  flow `(-0.197,-0.189)` confirm target-directed self-propulsion rather than
  passive advection. Exact score and metric reproduction across the samples
  establishes fixed-snapshot determinism, not robustness to wake phase.
- The parent route does not visibly lose target control during a particular
  vortex encounter, so the evidence does not support crossflow, force, or
  moment cancellation. Its main weakness is actuation intensity: both joints
  touch the `260 deg/time` speed and `1800 deg/time^2` acceleration limits,
  posterior excursion reaches `0.5834 rad`, and lateral-force/yaw-moment RMS is
  `68.70/931.60`. The body wake remains productive but is strongly corrugated
  late in the approach.
- No terminal-failure keyframe exists in the sampled solvers. The most useful
  available negative visual comparator is the inherited direction-selective
  headroom candidate: it preserves the same direct topology and reduces
  force/moment RMS to `56.29/800.58`, but delays capture to `32.7305` and lowers
  score from `0.224538` to `0.223211`. Three inherited completed evaluations
  reproduce that same trade without a new trajectory or semantic improvement.
  Together with the inherited worse blanket gate and extra-burst results, this
  argues against another residual-headroom gate or more posterior amplitude.
- The compact direct route, distributed mean curvature, and state-inferred
  helpful half-cycle are therefore retained. The single new mechanism changes
  posterior wave phase while explicitly conserving the parent harmonic
  envelope and continuously recovering the parent at target alignment.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG wave modulation interpreted through elongated-body posterior reactive propulsion
source_mechanism: change the phase relationship of a lagged posterior propulsive wave as a bounded function of sensed direction error while preserving the underlying rhythmic envelope
transferable_invariant: steer through a small observation-conditioned posterior phase change while retaining a traveling bend and posterior emphasis; use persistent body-frame target geometry rather than an external clock or prescribed wake phase
nontransferable_details: published CPG gains, dimensional frequencies, exact phase lags, species or robot kinematics, actuator allocations, vortex phases, cylinder geometry, and source-task routes
policy_translation: express the parent posterior wave as a fixed-radius rotation of normalized anterior angle and velocity, add a small phase rotation proportional to absolute filtered body-frame bearing, and recover the evaluated parent coefficients exactly at alignment
falsification: reject if direct capture or the compact diagonal topology is lost, arrival and distance integral do not improve over 32.472 and 1.64761L, or force, moment, posterior excursion, or saturation residence increase because the nominal wave envelope was conserved

## Candidate hypothesis

Produce exactly one candidate by preserving the filtered body-frame bearing,
bounded `12 deg` total-curvature request, smooth `40/60 -> 35/65` curvature
allocation, anterior state-feedback oscillator, posterior damping, and maximum
`8%` target-helping half-cycle asymmetry. Add one bounded posterior phase-rotation
mechanism: at alignment its coefficients are byte-equivalent to the parent's
`-q1 - 0.8*qd1/omega` wave, while persistent bearing error rotates those two
coefficients by at most `8 deg` at unchanged Euclidean magnitude.

This tests whether earlier phase-shaped posterior reaction can improve the
initial redirect and distance integral without the load increase seen when
extra amplitude was added. The new CFD rollout occurs only after this worker
exits; this candidate makes no same-worker performance or robustness claim.

## Static validation

- The guidance semantic-change guard passes after removing one exact duplicate
  copied-parent marker from the rendered workspace `README.md`.
- The mandated Julia policy-contract check passes with the available Julia
  runtime: `target_policy_params()` has no body-length field, every referenced
  parameter exists, and the representative multi-wake state returns two finite
  joint accelerations.
- The solver boundary check passes with only
  `cases/dogfish_2d_shape_policy/candidate_target_policy.jl` changed under
  `solver/`. No CFD rollout was run in this workspace.
