# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held-fish initial condition: four
  developed, interacting vortex streets occupy the diagonal target corridor
  while the fish is held near the upper-right boundary. It is common release
  evidence, not candidate-specific wake-phase or route information.
- All four sampled solvers are finite captures. The three strongest are
  functionally identical and reach at `44.121` with `1.70618L` mean distance,
  score `0.173450`, and `389/3909` force/moment RMS. Their released sheets show
  an immediate traveling body wave and active down-left swimming through the
  merged wakes without cylinder contact. Mean body-x velocity is `-0.2470`
  versus `-0.1848` mean local flow and head displacement is `-10.910/-4.263L`,
  so this route is self-propelled rather than passive advection.
- The lower-scoring time-to-go-only sample has the same broad wake-entry
  topology but a deeper terminal lateral excursion: it reaches at `45.221`,
  has `1.71458L` mean distance and `439/4345` force/moment RMS. The matched
  independently distance-gated course-mismatch residual therefore remains a
  positive mechanism; this candidate preserves its distance, speed-confidence,
  and separate-authority structure.
- The assigned parent's positive-closure amplification of that course residual
  is a concrete negative result. It preserves capture and the same broad visual
  topology but regresses arrival/mean distance/score from
  `44.121/1.70618L/0.173450` to `45.689/1.71923L/0.161543`; force/moment RMS also
  rises slightly from `389/3909` to `396/3917`, while mean command energy falls
  only from `1036.49` to `1031.20`.
- An inherited sibling's one-sided arbitration of opposing yaw and course cues
  is a second negative boundary. It captures at `45.331` with `1.72584L` mean
  distance, score `0.154397`, and `413/4089` force/moment RMS. Both completed
  additions changed terminal response without producing a new topology or a
  semantic gain. Do not repeat closure-conditioned gain scheduling or withdraw
  the already time-to-go-bounded heading response when the cues oppose.
- Both joints still reach the `4.538` rate cap in the successful reference and
  the two negative variants. This candidate does not add propulsion, increase
  global steering gain, alter the base oscillator, or introduce a signed
  force/moment response without sign-resolved event evidence.

## Policy hypothesis

Make exactly one geometric representation change inside the validated terminal
course residual. Replace the raw course-angle mismatch by its sine, the bounded
signed lateral component of normalized body motion relative to the target line
of sight. This is locally identical to angular damping for small errors but
smoothly limits authority during large wake-induced slip, without a new gain,
mode, coordinate, or shared clamp. Preserve the zero-centered oscillator,
posterior lag and allocator, time-to-go-capped heading forecast, independent
distance/speed-confidence gates, yaw-magnitude steering gate, half-cycle
steering, and soft acceleration limiter.

Expected evidence is preserved first-crossing capture and diagonal wake-entry
topology, with arrival/mean distance at least matching the `44.121/1.70618L`
reference or a material reduction in load/effort without a deeper terminal
excursion. Reject this translation if capture is lost, the trajectory passes
below or hooks around the target, arrival or mean distance regresses, or weaker
course authority raises load or effort. A fixed-prewarm result would not prove
robustness to changed wake conditions.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and wake-interaction control
source_mechanism: bounded sensor-feedback route residuals preserve an established rhythmic gait while avoiding indiscriminate cancellation of large wake-induced lateral motion
transferable_invariant: preserve the propulsive rhythm and damp the normalized signed lateral component of body motion relative to the target line of sight, with bounded authority during large slip
nontransferable_details: published gains, dimensional approach ranges or speeds, species-specific kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: replace the raw distance-gated body-course angle mismatch by `sin(body_course - bearing)` before the unchanged yaw-gated two-joint half-cycle law
falsification: reject if capture or diagonal topology is lost, terminal excursion deepens, arrival or mean distance regresses without material load or effort relief, or hydrodynamic loads increase
