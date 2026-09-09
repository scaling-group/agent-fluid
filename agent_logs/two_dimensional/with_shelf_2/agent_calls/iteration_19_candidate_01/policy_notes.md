# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The byte-identical shared prewarm sheets show the common release condition:
  four developed, interacting vortex streets occupy the diagonal target
  corridor while the fish is held near the upper-right boundary. They are
  initial-condition evidence, not candidate-specific wake-phase or route
  information.
- All four sampled released sheets and diagnostics are byte-identical finite
  captures. They show an immediate zero-centered traveling body wave, active
  down-left swimming through the merged wakes, and entry into the target circle
  without approaching a cylinder. Mean body x velocity is `-0.2470` versus
  `-0.1848` mean local flow, and the head moves `-10.910/-4.263L`, so this is
  self-propulsion rather than passive advection. The runs reach at `44.121`,
  with `1.70618/0.74893L` mean/final distance, score `0.173450`, mean command
  energy `1036.49`, and `389/3909` force/moment RMS.
- The assigned parent's independently bounded, distance-gated body-course
  damper is an evidenced improvement over the time-to-go-only predictor:
  inherited matched results improve arrival/mean distance from
  `45.221/1.71458L` to `44.121/1.70618L` and reduce loads from `439/4345` to
  `389/3909`, with only modest extra mean command energy. Preserve its terminal
  schedule and separate authority, as well as the successful propulsive and
  yaw-gated steering scaffold.
- There is no sampled failure sheet to compare visually. The most informative
  inherited degraded finite trajectory added an independent signed
  line-of-sight-rate forecast and made a long down-then-up loop: arrival
  regressed to `70.790`, mean distance to `2.71465L`, and score to `-0.817366`,
  even though loads fell to `200/2132`. The inherited semantic failure boundary
  remains broader posterior propulsion, which passed below capture and collided
  after a `1.872L` closest approach with `537/4995` loads.
- Three closer inherited terminal variants also reject expanding or
  reallocating authority: a shared heading/course budget reaches at `45.727`
  with `1.72692L` mean distance and `449/4408` loads; positive-closure
  amplification reaches at `45.689/1.71923L` with `396/3917` loads; and
  suppressing an opposing heading forecast reaches at `45.331/1.72584L` with
  `413/4089` loads. Both joints already touch the `4.538` rate cap. This
  candidate therefore adds no propulsion, prediction channel, gain scheduler,
  signed wake cancellation, or scalar gain sweep.

## Policy hypothesis

Make exactly one representation-level change inside the validated terminal
course residual: replace raw course-angle mismatch with its sine, the bounded
signed lateral component of normalized body motion relative to the target line
of sight. This agrees with angular damping for small tracking errors while
smoothly reducing authority for large wake-induced slip, where indiscriminate
cancellation may erase useful wake motion. Keep the same distance gate,
body-speed confidence, and independent course-response gain. Preserve the
oscillator, posterior lag and allocator, time-to-go-capped heading forecast,
yaw-magnitude steering gate, half-cycle steering law, and acceleration limiter.

Expected later CFD evidence is the same first-crossing capture and diagonal
wake-entry topology with arrival/mean distance at least matching
`44.121/1.70618L`, or a material load/effort reduction without a deeper
terminal excursion. Reject the translation if capture is lost, the route hooks
or passes below the target, arrival or mean distance regresses, or weaker
course authority raises load or effort. A fixed-prewarm result cannot establish
robustness to changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and wake-interaction control
source_mechanism: bounded sensor-feedback route residuals preserve an established rhythmic gait without cancelling all wake-induced lateral motion
transferable_invariant: preserve propulsion while damping only the normalized signed lateral component of body motion relative to the target line of sight, with naturally bounded authority at large slip
nontransferable_details: published gains, dimensional distances or speeds, species-specific kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: replace raw body-course-minus-bearing angle in the independently distance-gated residual with its sine before the unchanged yaw-gated two-joint half-cycle steering law
falsification: reject if capture or diagonal topology is lost, terminal excursion deepens, arrival or mean distance regresses without material load or effort relief, or hydrodynamic loads increase
