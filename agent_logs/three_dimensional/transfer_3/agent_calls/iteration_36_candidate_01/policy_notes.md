# Reproduced intercept-supported terminal posture candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and `capture`
  termination. Their trajectory CSVs and combined two-view sheets are
  byte-identical. Each self-propels through `3579` steps, captures at
  `19.684490 T`, scores `-0.261384287`, has mean/final distance
  `2.151092787 L`/`0.748302400 L`, follows a `12.951133 L` path, and triggers
  `243` moving-window shifts.
- Three samples use the byte-identical
  `v40_intercept_supported_terminal_posture` policy. The prefilled fourth
  sample is `v41_course_worsening_terminal_response`, but its nominal
  course/yaw allocation branch produces the exact `v40` commands and
  trajectory. Inherited reconstruction identifies the structural cause: its
  new support peaks near `0.240`, below the existing `0.82` allocation floor
  selected by `max`. The branch is redundant rather than positive evidence.
- I inspected the complete combined sheet for a reproduced `v40` rollout and
  the nearest independently active signed-yaw parent contrast, including the
  top-down mid-plane-vorticity row and oblique body/Lambda2 row from release
  through capture. The release frame is quiescent; the fish then develops a
  compact target-directed arc with coherent alternating posterior vortices.
  The oblique view shows finite localized shed structures rather than a
  volume-filling disturbance. There is no passive advection, collision
  precursor, boundary exit, out-of-plane motion, wake collapse, or numerical
  instability. The active contrast is visually indistinguishable at sheet
  resolution, consistent with a very late allocation change rather than a new
  useful trajectory.
- Metrics agree with the visual reading. `v40` crosses `4 L`, `2 L`, and `1 L`
  at `15.444014 T`, `17.809002 T`, and `19.162004 T`; it has no joint-angle
  stop dwell, although `229/302` anterior/posterior commands below `4 L`
  exceed `30 rad/T^2`. Its below-`4 L` lateral-force and yaw-moment maxima are
  about `0.02753` and `0.01567`. The assigned signed-yaw parent retains the
  same capture step, saturation counts, extrema, and crossings but regresses
  score to `-0.261390567`, mean distance to `2.151097816 L`, final distance to
  `0.748308659 L`, and path length to `12.951134 L`. Making the dormant idea
  active therefore supplies no control or load benefit.
- Inherited logs also reject neighboring loci: outward joint-response and
  posture-energy terminal selectors regress; reducing posterior phase lag
  produces a large looping route and capture only at `46.145020 T`; and an
  independently active small-angle startup mean-curvature branch delays
  capture to `23.375013 T` through stable mis-steering. These failures argue
  against forcing another response selector, changing the route-defining lag,
  or adding startup bend merely to escape the scalar plateau.

## Candidate hypothesis

Replace the prefilled `v41` source with the independently reproduced
`v40_intercept_supported_terminal_posture` as the single solver candidate.
This removes only the behaviorally dormant course/yaw selector and its three
unused parameters. Preserve the state-feedback oscillator, posterior lag,
target-angle redirect, geometry/course-agreed outer residual allocator,
normalized center-translation intercept corridor, closure preview, damped
mean-bend equilibrium, small flat terminal posture handoff, carrier floor, and
command limit.

This is an evidence-backed negative selection, not scalar-only tuning and not
a claim about unevaluated CFD. The expected rollout is reproduction of the
compact self-propelled capture near `19.684490 T`, with coherent alternating
top-down shedding, finite localized oblique structures, and no joint-stop
dwell. Falsify it on material non-reproduction, slower or lost capture, worse
distance integral or final distance, a changed outer topology, renewed
joint-stop dwell, material load growth, instability, or degradation of either
wake view. The new CFD evaluation occurs after this worker exits and is not
claimed as evidence here.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, closed-loop robotic-fish direction control, and continuous terminal approach-hold control
source_mechanism: preserve a proven posterior-lagged propulsive bend and transfer continuously toward an already bounded target-owned posture near capture
transferable_invariant: when propulsion and steering share two joints, retain the evidenced traveling-wave relation and keep any rhythm-to-posture handoff small, continuous, normalized, and supported by observed range, closure, and body-frame target geometry
nontransferable_details: published gains and frequencies, dimensional Strouhal targets, species-specific envelopes, full-body kinematics, exact beat or vortex phases, target coordinates, capture radius, and task-specific routes
policy_translation: retain the reproduced body-frame v40 law and remove the redundant v41 selector; do not force the same course/yaw idea active because the completed active parent regressed without changing loads
falsification: reject on failed reproduction, delayed or lost capture, worse distance integral, changed compact route, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The sole materialized candidate is byte-identical to all three sampled
  evaluated `v40` policies: SHA-256
  `624f4cec48f1a4c8d2eada4f72269efd16c22d4785955a09cd208447208cd659`.
  This establishes candidate identity and evidence provenance, not a new CFD
  result.
- The prescribed check-runner was invoked after the material edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this account and failed before
  executing a check. The three commands from its configuration were then run
  directly and separately. The material guidance/notes check, exact
  two-output finite Julia contract, and solver edit-boundary check all pass.
- A separate deterministic schema audit resolves all `88` direct
  `params.FIELD` references against the `89` fields returned by
  `target_policy_params()`; only the version label is intentionally unused.
  No formal CFD was run in this workspace.
