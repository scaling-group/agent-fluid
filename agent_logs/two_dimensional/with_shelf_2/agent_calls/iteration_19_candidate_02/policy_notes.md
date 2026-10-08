# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet is a common initial condition: the held fish begins
  near the upper-right boundary while four developed, interacting vortex
  streets fill the target corridor. It supplies neither a candidate-specific
  wake phase nor a route.
- All four sampled solvers are byte-identical policy and keyframe replays. They
  show the fish generating an immediate traveling body wake and self-propelling
  diagonally down-left through the merged cylinder wakes to first-crossing
  capture. The metrics agree: arrival is `44.121`, mean/final/minimum distance
  is `1.70618/0.748931/0.748931L`, head displacement is
  `-10.910/-4.263L`, and mean body-x velocity (`-0.2470`) is more upstream
  than mean local flow (`-0.1848`). Force/moment RMS remains substantial at
  `389/3909`, and both joint rates reach their caps, so the replay is a strong
  finite route rather than evidence of broad wake robustness or spare
  authority.
- The inherited parent logs provide two informative finite regressions. Giving
  measured course priority over an opposing yaw forecast reaches at `45.331`
  with `1.72584L` mean distance and `413/4089` force/moment RMS. Replacing the
  yaw-only gate by an unsigned relative-crossflow/yaw coincidence detector
  reaches at `45.150` with `1.71930L` mean distance but raises loads to
  `460/4421`; its keyframes retain wake entry yet show a deeper downward
  terminal path. Neither result supports cue arbitration or magnitude-only
  wake-event classification. The broader inherited propulsion allocator that
  passed below capture and collided remains the semantic failure boundary, so
  this candidate leaves propulsion allocation unchanged.
- The fixed distance gate on the successful course-slip residual cannot adapt
  its onset to observed approach speed. That is now the narrow architecture
  hypothesis: preserve the residual and its independent authority, but express
  approach proximity as normalized time-to-go from body-frame speed and range.

## Policy hypothesis

Replace only the fixed-distance onset of the proven body-course-mismatch
damper with a smooth time-to-go onset. Compute `distance_L / body_speed` from
normalized body-frame observations, compare it with a candidate-owned response
time, and retain the existing speed-confidence factor. A fast approach then
activates slip correction earlier in range, while slow or nearly stationary
motion delays it and remains protected from noisy course angles. Preserve the
zero-centered oscillator, posterior lag and allocation, independent heading
forecast, yaw-magnitude steering gate, half-cycle steering, and soft
acceleration limiter.

The response-time scale is anchored to the successful gate's operating point,
not copied from a source. Expected evidence is preserved first-crossing capture
and diagonal wake-entry topology with a shallower terminal hook, earlier
arrival or lower mean distance, and no material force/moment or effort increase
relative to `44.121/1.70618L` and `389/3909`. Reject the mechanism if capture
is lost, the terminal excursion deepens, arrival or mean distance regresses
without load or effort relief, or action becomes more cap dominated. Success
on the fixed prewarm snapshot would not establish changed-wake robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve the rhythmic gait while sensor feedback schedules a bounded approach residual according to interception urgency
transferable_invariant: keep propulsion intact and make terminal slip damping depend continuously on normalized remaining time rather than fixed spatial range alone
nontransferable_details: published gains, dimensional timing, robot or species kinematics, exact vortex phases, cylinder and target coordinates, capture geometry, and task-specific routes
policy_translation: replace the fixed-distance course-damping gate with a smooth `distance_L / body_speed` gate before the unchanged yaw-gated two-joint half-cycle steering law
falsification: reject if capture or diagonal topology is lost, the terminal hook deepens, arrival or mean distance regresses without a compensating load or effort reduction, or rate and acceleration cap contact worsens
