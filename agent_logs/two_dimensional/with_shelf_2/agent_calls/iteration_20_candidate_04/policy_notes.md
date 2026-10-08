# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheets are byte-identical common initial-condition
  evidence: four developed and interacting vortex streets occupy the diagonal
  corridor while the fish is held near the upper-right boundary. They do not
  establish candidate-specific wake-phase robustness.
- All four sampled solver policies, released sheets, and diagnostics are
  byte-identical successful replays. The fish immediately generates a
  zero-centered traveling wake, self-propels diagonally down-left through the
  merged wakes without approaching a cylinder, and reaches the target at
  `44.121`. Mean/final distance is `1.70618/0.74893L`, head displacement is
  `-10.910/-4.263L`, and mean body-x velocity (`-0.2470`) is more upstream
  than mean local flow (`-0.1848`). Preserve this propulsive and route
  topology rather than treating the motion as passive advection.
- The assigned parent's bounded-sine substitution for the terminal course
  angle is now a concrete negative result. It preserves the same broad visual
  topology and target termination, but its extra downward travel
  (`-4.574L` versus `-4.263L`) delays capture to `46.074`, worsens mean
  distance to `1.73655L`, and raises force/moment RMS from `389/3909` to
  `407/4002`; only mean command energy falls slightly from `1036.49` to
  `1028.72`. Keep the raw bounded course-angle residual and its independent
  distance gate.
- No sampled termination-failure sheet is available. The inherited semantic
  boundary remains the broader posterior allocator that passed below capture
  and collided after a `1.872L` closest approach, while the independent
  line-of-sight-rate predictor made a long down-then-up loop. The current
  samples and the parent instead expose an actuator boundary: both joint rates
  reach the `4.538` cap and accelerations approach the candidate soft limit,
  with large force/moment RMS. That supports an actuator-state mechanism, not
  another route-response representation or gain scheduler.

## Policy hypothesis

Preserve the sampled oscillator, posterior lag and progress allocator,
time-to-go-capped heading response, independently distance-gated raw course
damper, yaw-magnitude steering gate, distributed half-cycle steering, and
soft acceleration limit. Add one proprioceptive outward-rate guard immediately
before the soft limiter. For each joint, compare absolute joint rate with the
existing oscillator-normalized rate reference and smoothly attenuate only the
component of commanded acceleration having the same sign as joint rate.
Opposing acceleration, which brakes and reverses the beat, remains untouched.
The guard is therefore phase-preserving and cannot disable target steering or
the base wave merely because rate magnitude is high.

Expected later CFD evidence is the same diagonal first-crossing capture with
less rate-cap contact and lower load or command effort, without arrival or mean
distance regression from `44.121/1.70618L`. Reject the mechanism if capture or
wake-entry topology is lost, upstream propulsion weakens, either rate maximum
remains cap-pinned without compensating load/effort relief, or tracking
regresses. A fixed-prewarm result cannot establish changed-wake robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded rhythmic actuation
source_mechanism: proprioceptive feedback protects the actuator envelope while preserving the established rhythmic command and its response phase
transferable_invariant: withdraw only normalized rate-increasing joint acceleration near the observed rate envelope while retaining braking, reversal, propulsion, and target-feedback structure
nontransferable_details: published gains, dimensional joint limits or frequencies, robot and species kinematics, exact vortex phases, cylinder or target coordinates, and task-specific routes
policy_translation: apply an identical smooth joint-rate headroom gate to only the outward acceleration component of each of the two state-feedback joint commands before the existing soft limiter
falsification: reject if target capture or diagonal topology is lost, upstream travel or arrival regresses without material load or effort relief, cap contact persists unchanged, or hydrodynamic loads increase
