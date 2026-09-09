# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- The assigned parent is `optimizer_202b1c813083`, whose candidate
  `solver_4b909c5b2efc` applies bounded target-bearing/yaw-rate mean curvature
  only through the posterior target. The sampled set also contains the common
  naive seed and two independent mean-curvature variants. All four evaluations
  confirm direct uniform still water (`U_infinity=(0,0,0)`), no cylinders, and
  valid moving-window transport, so their motion and wakes are self-generated.
- In both rows of the combined keyframes, the naive seed and strongest finite
  parent form a coherent alternating tail wake and visibly translate; the
  parent retains that wake while delaying the upper-boundary exit from
  `8.596T` to `9.146T`. Its closest approach improves only from `12.069L` to
  `12.056L`, however, and it still curls upward away from the down-left target.
  Thus its turn sign is initially useful but its sustained posterior offset
  does not arrest the same trajectory topology.
- The most informative failure is the equal-two-joint mean-curvature candidate
  `solver_12f7a289cbbc`: the top-down row shows a tight upward arc and a much
  shorter propulsive track, while the oblique row shows body-connected vortical
  structure but less useful translation. Its mean speed is `0.119L/T` versus
  `0.230L/T` for the seed, closest distance worsens to `12.297L`, and final
  distance worsens to `13.423L`. The reduced-frequency equal-bias inherited
  result is worse still (`15.408L` final distance). The weak shared
  acceleration-bias candidate also worsens closest/final distance to
  `12.235L/13.310L`.
- The parent preserves speed (`0.225L/T` mean versus `0.230L/T` for the seed)
  but increases maximum posterior angle from `0.464` to `0.704 rad` and maximum
  logged posterior acceleration from `75.4` to `111.7 rad/T^2`; both joint
  rates still reach `260 deg/T`. The next controller should retain posterior
  steering authority without imposing another static joint equilibrium or
  amplifying the carrier gains.

## Single candidate hypothesis

Keep the naive anterior Van der Pol carrier unchanged. Replace posterior mean
curvature with one bounded half-cycle amplitude-asymmetry mechanism: body-frame
target bearing requests the turn, recent measured turn rate releases a correctly
developing turn, and the sign of the instantaneous lagged posterior target
selects which half-cycle is strengthened. This keeps zero crossings and the
posteriorly lagged traveling bend while producing a signed cycle-average bend.
Clamp the returned accelerations inside the episode envelope so the candidate
cannot rely on hidden external clipping. The candidate should preserve the
parent's coherent wake and speed but recover bearing before upward momentum
causes another boundary exit. It is falsified if closest approach does not beat
`12.056L`, the upper-boundary topology persists without a materially longer
horizon, posterior angle/rate saturation worsens, or the wake/translation
collapses toward the equal-bias failures.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking by asymmetric flapping
source_mechanism: strengthen the turn-producing half-cycle of an existing propulsive rhythm instead of imposing sustained mean curvature
transferable_invariant: persistent body-frame lateral target error can choose a bounded half-cycle asymmetry while measured yaw response releases that asymmetry before overshoot
nontransferable_details: published gains, duty ratios, clocked CPG phase, robot linkage geometry, species kinematics, dimensional frequencies, exact vortex phase, and task-specific routes
policy_translation: preserve the joint-state anterior oscillator; use bearing plus recent turn rate for a bounded turn request and the signed lagged posterior target as observable beat side to modulate posterior amplitude
falsification: reject if the same upper-boundary exit and at least `12.056L` closest distance remain, if posterior saturation worsens, or if coherent self-propulsion collapses
