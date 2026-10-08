# Phase-classifier/course-magnitude candidate

## Evidence read before editing

- I read the assigned-parent guidance, all four sampled solver artifacts, and
  the inherited v34/v37 optimizer notes and completed results before choosing
  this candidate. Every compared rollout used direct uniform still water at
  `U_infinity=(0,0,0)`, with no cylinders or prewarm, remained finite, and
  terminated in capture.
- The samples reduce to two deterministic trajectories. The two v33 replicas
  capture at `23.842522T`, score `-0.53509095`, and have scoring mean/final
  distance `2.433543/0.746165L`. The executable split-observer equations in
  sampled v34 and v37 differ only in names and provenance comments; their
  trajectories and all visual sheets are identical. They capture one control
  step earlier at `23.837021T`, improve score to `-0.53501328`, and improve
  mean/final distance to `2.433468/0.746096L`.
- I inspected the combined sheets for sampled v33 and the split-observer
  winner, plus the inherited fully coupled observer regression, from release
  through capture. In every top-down row the fish starts in an empty field,
  self-propels along a target-directed arc, and maintains an ordered
  alternating red/blue vortex street. Every oblique row shows compact,
  alternating three-dimensional Lambda2 structures behind the translating
  body. None shows passive advection, wake breakup, boundary contact, or
  instability; the controller distinctions are too small for the sheets to
  resolve, so the trajectory and load histories decide the comparison.
- Inside `3L`, the current split observer changes v33 only slightly but in a
  useful direction: mean target-cross-track speed falls from `0.239236` to
  `0.238678U`, peak absolute moment falls from `0.013730` to `0.013581`, and
  mean absolute yaw falls from `1.679988` to `1.679385 rad/T`. Peak yaw rises
  slightly from `3.184842` to `3.193864 rad/T`; the maximum smoothly projected
  command remains essentially unchanged near `31.385 rad/T^2`, and joint-rate
  cap exposure does not increase (`9.30%` to `9.23%` across both joints).
- The inherited fully coupled distributed observer is the informative failure:
  using the cleaned two-joint rate residual for both continuous course
  authority and phase correction lowered terminal yaw but delayed capture to
  `23.8700T`, regressed score to `-0.536789`, worsened mean/final distance to
  `2.434939/0.747952L`, and raised peak moment. The new split result therefore
  supports observer-role separation, not indiscriminate yaw cancellation.

## Single candidate hypothesis

Start from the evaluated v37 split observer and preserve its normalized
body-frame target feedback, response-released C-bend, posterior traveling wave,
continuous anterior-only course brake, cadence, and smooth component-wise
projection. Refine only the phase-selected anterior residual: use the
distributed two-joint rate observer as a fast sign/half-cycle classifier, but
take the bounded correction magnitude from the established anterior-only
course residual. This separates the categorical phase decision from the slow
course-error amplitude instead of letting a fast carrier estimate determine
both.

The hypothesis is that the distributed coordinate's useful contribution is
selecting the beat side, while the legacy course residual carries the closure
authority that the fully coupled observer suppressed. The candidate should
retain the split observer's earlier capture and lower cross-track/peak-moment
behavior without further weakening useful terminal motion. Falsify it if
capture is lost or delayed, mean/final distance regresses toward the fully
coupled observer, peak yaw or moment worsens materially, the coherent wake
changes, or joint/command-limit exposure grows. The current candidate remains
unevaluated until the post-worker CFD run.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance residual control
source_mechanism: separate slow target-course regulation from fast gait-phase classification while preserving the thrust-producing oscillator
transferable_invariant: let normalized body-frame target error set correction magnitude and let observed joint-state phase choose when that smallest bounded correction acts
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, hardware duty ratios, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: preserve v37's anterior-only continuous course response; use `heading_rate + 0.50*phi_dot[1] + 0.17*(phi_dot[1]+phi_dot[2])` only for the sign and half-cycle of the anterior residual, whose magnitude comes from the anterior-only course-yaw response
falsification: reject unless CFD preserves capture, v37-scale distance progress and coherent wake while holding or improving terminal cross-track motion, yaw, moment, and actuator-envelope behavior
