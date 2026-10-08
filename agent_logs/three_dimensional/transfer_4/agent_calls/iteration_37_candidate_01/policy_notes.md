# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent and its exact sampled rerun (`solver_24d38f4fb85b` and
  `solver_900814da599b`) both capture at `18.0125T`, score `-0.064000433`,
  and finish at `0.74840L`; the byte-identical policies and trajectories make
  the second result determinism evidence, not another mechanism.
- The strongest sampled scalar result is therefore the parent v31
  course-consensus posterior-duty policy. Its combined keyframe sheet shows
  self-propelled target approach, a persistent alternating reverse-von-Karman-
  like mid-plane wake from release to capture, and compact paired three-
  dimensional Lambda2 structures in the oblique row. There is no visible wake
  collapse or passive-advection explanation, and the diagnostics confirm
  direct uniform still-water initialization with no cylinders or prewarm.
- The informative sampled regression is v26 (`solver_98416aa924c6`): it keeps
  the same coherent wake and `18.0125T` capture but scores `-0.064149483` and
  makes one fewer moving-window shift. Its one-sided slip-synchronous posterior
  feathering improves the inherited terminal alignment/yaw class, but the
  sampled guidance reports worse closure/score; the visual similarity rules
  out loss of the traveling-wave mechanism as the cause.
- Sampled v20 (`solver_adfafc9b9f71`) also preserves the same two-view wake and
  captures slightly earlier at `18.0070T`, but finishes with `0.9840 rad/T`
  absolute yaw. The v31 parent's small scalar advantage (`2.72e-5`) does not
  resolve its terminal defect: inherited trace analysis gives only `0.1297`
  final alignment, `0.8077 rad/T` yaw, and `75.89%` near posterior
  acceleration-ceiling residence.
- Inherited completed tests rule out another course/yaw gain, persistent
  posterior hold, slip-duty or phase-reset variant, force-power placement,
  mean-share/headroom redistribution, and common terminal cadence reduction.
  The latter improves the instantaneous crossing but delays capture, worsens
  the whole approach, and widens the path. The unresolved control capability is
  phase-invariant terminal carrier-energy regulation without changing the
  established route, cadence, mean bend, or posterior lag.

## Policy hypothesis

Preserve the v31 route, odd curvature map, cadence law, posterior lag, posterior
work reserve, mean-bend allocation, duty surface, and rate governor. Add one
continuous closing-stride energy-shell mechanism: only inside the established
approach, only while moving toward the target, and only while the velocity is
outside the aligned capture corridor, lower the anterior state-feedback
oscillator's dimensionless target energy. Because the posterior target remains
a lagged function of the observed anterior wave, its excursion should fall
without a direct phase reset, common-frequency change, mean-bend
redistribution, or suppression of one half-cycle.

The gate uses normalized distance, positive windowed closing speed, and
target/velocity alignment. It is independent of beat phase and exactly inactive
outside `approach_distance_L`. Expected evidence is unchanged far/middle
trajectory and wake, retained capture, lower approach speed and gait-locked
yaw, improved final alignment, and reduced posterior ceiling residence without
migrating load to the anterior joint. Reject the mechanism if it delays capture
or worsens the distance integral/path materially, erases the alternating wake,
or improves the final sample while mean near-target closure/alignment degrades.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal fish target capture
source_mechanism: sensory feedback continuously reshapes a rhythmic locomotor envelope, with excess drive reduced near a target while the traveling rhythm is retained
transferable_invariant: preserve oscillator phase and posterior lag while a bounded target-relative approach signal changes the phase-invariant carrier-energy set point
nontransferable_details: published gains, dimensional frequencies, species-specific amplitudes, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: use normalized distance, positive windowed closing speed, and body-frame course alignment to lower only the anterior joint-state oscillator energy target; keep cadence, signed mean curvature, and the posterior lagged follower unchanged
falsification: reject if far or middle transit changes, capture is lost or materially delayed, the coherent two-view wake degrades, or terminal alignment, yaw, path, closure, and non-migrating actuator residence do not improve together
