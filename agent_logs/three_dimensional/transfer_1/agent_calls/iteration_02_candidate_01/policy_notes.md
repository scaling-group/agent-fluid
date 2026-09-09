# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the experiment contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm. Their motion is self-propelled rather than ambient advection.
- The strongest finite example, `solver_6c46616730e6`, and its prefill parent
  `solver_2ce3d25ef5a2` both show a strong alternating top-down vortex street
  and compact oblique Lambda2 structures. Distance falls from `12.3277L` to
  `6.0671L` and `6.1266L`, respectively, so the high-cadence state-feedback
  traveling bend is the only sampled propulsion mechanism worth preserving.
  In both sheets the route then curls below the target and the coherent wake
  follows the fish to a lower-boundary exit. The metrics agree: final distance
  reopens to `10.4939L`/`10.5423L`, with no numerical instability.
- The course-error residual in `solver_6c46616730e6` changed the observation
  semantics but improved minimum distance by only `0.0595L` and retained the
  same termination topology. Its raw accelerations still exceed the fixed
  `31.416 rad/T^2` envelope on `69.8%/76.1%` of samples and its yaw rate reaches
  `3.174 rad/T`, so another course gain is not supported.
- The visual failure comparator `solver_b0e1dc12d96c` is command-compatible
  and initially yaws in the target-correct direction, but its static posterior
  mean-curvature steering produces almost no closure (`12.3277L` to only
  `12.2718L`) before continuing the turn and exiting the upper boundary at
  `9.09T`. `solver_f0f4cd87e65f` likewise uses posterior mean curvature and
  reaches only `12.2055L` before an upper exit. The inherited
  `solver_e355afd704f2` log supplies the complementary same-sign two-joint mean
  bias: it avoids acceleration clipping but turns through `3.10 rad`, moves
  away, and exits right with minimum distance `12.3240L`. Thus neither sign of
  a static mean-bend simplification preserved target progress.
- These comparisons rule out scalar-only tuning of the sampled mean-curvature
  or course-residual families. The reusable signal is achieved yaw rate: the
  failed mean bends accumulate turn, whereas the useful traveling wave needs a
  steering actuator that can bias alternate half-cycles without imposing a
  persistent curved posture.

## One candidate mechanism

Preserve the anterior state-feedback oscillator and posterior state lag, but
bring their carrier scale inside the 3D envelope and replace static mean
curvature and the inherited branch-heavy turn actuator with yaw-damped
half-cycle amplitude asymmetry. A bounded error
combines normalized body-frame lateral target direction with measured recent
yaw rate. It smoothly weakens the anterior restoring acceleration on the
requested bend side and strengthens the opposite half-cycle; the posterior
joint continues to lag the observed anterior state about zero mean. Positive
body-frame lateral error requests the empirically correct positive-bend side,
while negative achieved yaw reduces or reverses that request before turn
momentum carries the fish above the target line. A smooth policy-level command
bound keeps both returned accelerations within the fixed envelope without
changing episode limits.

Expected test: retain the alternating wake and early distance closure while
reducing accumulated yaw enough to avoid both the strong policies' lower exit
and the static-curvature policies' upper/right exits. Reject the mechanism if
minimum distance does not beat `6.0671L`, if the trajectory repeats any sampled
boundary-exit topology, if wake coherence/closing speed collapses, or if the
bounded outputs dwell near their command limit despite zero evaluator clips.

## Non-CFD envelope audit

The first `0.55T`, `28 deg` translation was rejected before finalization: a
20T joint-only integration spent roughly `60%` of returned accelerations above
`95%` of the policy bound and reached about `73 deg` and `486 deg/T` without
episode clamps. A grid over carrier period and amplitude retained `0.80T` and
`14 deg`. Across constant body-frame lateral errors and yaw rates in
`{-1,0,1}`, its worst 20T probe reached `32.3 deg`, `232.2 deg/T`, and
`28.92 rad/T^2`, with `1.2%` of outputs above `95%` of the `30 rad/T^2` policy
bound. This is only an algebraic joint-envelope check; it is not CFD evidence
of propulsion, steering authority, or target success.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological asymmetric tail beats
source_mechanism: sensor-driven half-cycle amplitude asymmetry superposed on a posterior-lag propulsive rhythm
transferable_invariant: preserve the traveling bend while target error selects a bend-side asymmetry and measured yaw rate releases or reverses it to prevent accumulated turn
nontransferable_details: published gains, clocked CPG phase, robot geometry, species kinematics, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: combine target_body_L[2]/distance_L with turn_rate_recent, bound it, infer bend side continuously from phi[1], and modulate oscillator restoring strength while the second joint follows the state-lagged zero-mean target
falsification: reject if early closure or the coherent alternating wake is lost, minimum distance fails to beat 6.0671L, command effort remains boundary-dominated, or any prior upper, lower, or right left_domain topology repeats
