# Candidate diagnosis and hypothesis

## Evidence read before editing

- The only sampled Phase-2 rollout is the assigned transferred 2D champion.
  It is a valid direct-uniform still-water run (`U_infinity=0`, no cylinders,
  no prewarm), not an advected or snapshot-initialized artifact.
- Both visual rows show self-propulsion and a coherent alternating wake.  The
  top-down row shows useful target progress through about 16--18 T, followed
  by a persistent downward trajectory.  The oblique Lambda2 row confirms that
  the three-dimensional wake remains organized through that turn rather than
  disappearing in a thrust collapse.
- Metrics agree with the images: distance falls from `12.3277 L` to
  `4.7800 L` at `17.853 T`, then rises to `9.7089 L`; the fish exits the lower
  virtual boundary at `27.495 T`.  Speed is already about `0.8 L/T` near the
  closest approach.  This makes propulsion preservation and cross-track
  overshoot correction higher priorities than a stronger carrier.
- The useful finite segment and the terminal failure are two phases of the
  same sampled trajectory; no successful comparison candidate or inherited
  optimizer note is available in this fresh lineage.  Claims are therefore
  bounded to preserving the observed gait and falsifying the same failure
  topology in the next evaluation.

## Policy hypothesis

Preserve the state-feedback oscillator, posterior lag, and bounded
mean-curvature/half-cycle steering.  Replace the instantaneous target-vector
angle in the route request with a bounded velocity-lead target vector computed
from normalized `target_body_L` and `velocity_body_U`.  This is a compact
motion-aware redirect mechanism: when the fish has substantial cross-track
momentum, it asks for the return turn before instantaneous bearing alone has
grown.  Because the reconstructed geometry implies that the existing request
is already bounded by about 16 T while the mean yaw remains wrong-way, let a
large request temporarily strengthen posterior mean curvature only when
observed recent turn rate is not aligned with that request.  Release the boost
continuously when the response aligns.  This is state-gated burst redirection,
not a stronger carrier or hidden timed mode.

Expected result: the fish should begin the negative correction earlier around
the sampled 14--17 T approach, arrest the downward crossing, and improve on
`4.7800 L` or at least avoid `left_domain`, while retaining the coherent wake.
Reject the mechanism if the next rollout preserves the same lower-boundary
exit, destroys the alternating wake, materially reduces early closing, or
causes persistent joint/acceleration saturation.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-feedback modulation in robotic-fish CPG control
source_mechanism: preserve a rhythmic propulsive carrier while observed direction error and yaw response gate a transient curvature redirect
transferable_invariant: observed transverse motion should advance the target-directed correction, and large wrong-way response should briefly increase turning curvature without replacing the traveling posterior-lag wave
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species kinematics, exact vortex phases, and task-specific routes
policy_translation: form a bounded lead target vector from normalized body-frame target displacement minus a short horizon of measured body velocity, then use request/turn-rate alignment to gate a capped posterior-curvature boost in the existing two-joint steering path
falsification: reject if early closing or wake coherence degrades, command saturation becomes persistent, or the closest approach and lower-boundary termination fail to improve
