# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled solver candidates are byte-identical policies and their
  released/prewarm keyframe sheets are byte-identical. Each reaches the target
  at `44.121`, with `1.70618L` mean distance, `0.748931L` final/minimum
  distance, `-10.910/-4.263L` head displacement, and `389/3909` force/moment
  RMS. They are deterministic replication evidence, not four independent
  demonstrations of robustness. No sampled failure keyframe is available, so
  the informative failure comparison is inherited evidence rather than a new
  visual claim.
- The shared prewarm sheet shows four developed interacting vortex streets and
  the held fish near the upper-right release. The released sheet shows a clear
  posterior-emphasized traveling wake behind the fish, sustained diagonal
  self-propulsion toward the cylinder wakes, and target capture without the
  long down-then-up hook reported for the inherited line-of-sight-rate
  forecast. The `-10.910L` upstream displacement and finite target termination
  support self-propulsion rather than passive downstream advection.
- The successful policy still runs near the actuator envelope: diagnostics
  report `max_abs_phi1/2 = 0.702/0.675`, both joint-rate maxima at `4.538`, and
  acceleration maxima `28.79/28.39`. Aggregate yaw load is also substantial,
  but the inherited crossflow-times-yaw magnitude gate worsened arrival,
  distance, and loads. Therefore neither base-wave relief nor another unsigned
  hydrodynamic multiplier is justified by these samples.
- The inherited score-only result at `45.975`, `1.73033L`, and `455/4405`
  force/moment RMS is worse than the replicated parent, but it has no policy or
  keyframes in this workspace. It can reject promotion of that unevidenced
  outcome; it cannot identify which mechanism caused the regression.

## Policy hypothesis

Preserve the zero-centered traveling bend, posterior progress residual,
terminal course-mismatch damping, and the magnitude of the proven yaw-load
gate. Change one steering mechanism: apply yaw-load withdrawal only in
proportion to an observed heading response that is already aligned with the
remaining body-frame route request. When the measured turn opposes the route,
retain steering authority instead of treating a large unsigned moment as if it
were helpful. This uses the already bounded predicted-bearing and heading-rate
response, does not infer yaw-moment sign, and leaves the propulsive oscillator
untouched.

Expected effect: keep the sampled diagonal trajectory and capture while
avoiding unnecessary steering withdrawal during an adverse wake-driven turn;
an improvement should appear as no later arrival or mean-distance regression,
with stable or lower force/moment RMS. Reject the mechanism if capture is lost,
the route develops a lower hook, arrival/mean distance worsen, or loads rise
without a compensating route improvement.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and response-gated burst redirection
source_mechanism: preserve the rhythmic locomotor command while modulating a bounded steering residual from sensed directional response
transferable_invariant: withdraw extra steering only after observed body response is already turning toward the body-frame target; do not weaken the propulsive rhythm
nontransferable_details: published oscillator gains, robot geometry, species kinematics, burst timing, dimensional frequencies, exact vortex phase, and task-specific routes
policy_translation: condition the existing normalized yaw-magnitude steering gate by bounded alignment between body-frame route request and measured heading response; preserve both joint-state propulsion commands
falsification: reject if target capture, diagonal topology, arrival, or mean distance regresses, or if force/moment load rises without better route tracking
