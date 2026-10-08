# Candidate wake-policy notes

## Evidence available before the edit

- The assigned parent guidance is the unchanged fresh-lineage guidance from
  `optimizer_02adaee219bc`. No inherited `logs/optimize/` tree was supplied,
  and the only sampled solver is the common naive seed
  `solver_064577d12113`; therefore there is no successful finite comparator in
  this workspace and no same-worker CFD result is claimed.
- The rollout satisfies the experiment contract: uniform direct still-water
  initialization, `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot.
  It terminates `left_domain` at `8.547T`, with initial/minimum/final target
  distances `12.3277/12.0782/12.3800L` and only `0.25L` transient best
  progress.
- Both rows of `wake_keyframes.jpg` were inspected from release to exit. The
  top-down row shows self-propelled translation and an alternating wake, but
  the swimmer and wake bend into a broad upward arc away from the target. The
  oblique Lambda2 row confirms a growing, alternating three-dimensional wake
  behind the moving body rather than passive advection in the zero background
  flow; it also shows that the curved trajectory persists as the wake develops.
- The trajectory cross-check supports a directional-control diagnosis. The
  center moves about `(-0.93,+1.20)L`, heading changes from `+0.506` to
  `-0.782 rad`, and target bearing changes from `+0.155 rad` to `-1.296 rad`.
  At closest approach (`6.358T`) the bearing is already `-0.780 rad`, so the
  uncontrolled turn has passed the useful heading. Final velocity is dominated
  by `+y` (`0.573U`) while the target lies down-left. Joint angles remain below
  `27 deg`, but joint-rate limits are touched and the raw accelerations exceed
  the `1800 deg/T^2` envelope in about one third of samples before integration
  clamps them. This argues for preserving, not amplifying, the propulsive
  carrier and for adding a bounded low-frequency steering mechanism.

## Policy hypothesis recorded before editing

Keep the seed's state-feedback oscillator and posterior lag because the wake
and displacement demonstrate self-propulsion. Add one target-vector-to-mean-
curvature mechanism: map normalized body-frame bearing, plus measured yaw-rate
damping, through a smooth saturation to a common joint equilibrium offset.
Center both oscillatory joint targets on that offset so steering changes mean
shape without replacing the traveling bend. Positive common curvature has the
documented negative-yaw sign in this actuator convention, matching the
positive-bearing sign used by the observation adapter.

Falsification: reject this mechanism if the next CFD rollout retains the same
upper-boundary arc, turns in the wrong direction, loses the coherent posterior
wake/forward translation, increases persistent joint limiting, or fails to
improve minimum distance and termination class. A later worker should then
test state-phased half-cycle asymmetry rather than increasing this static-bias
limit.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning by mean-curvature or tail-beat bias
source_mechanism: target-directed turning superposes a bounded average bend on a propulsive rhythm
transferable_invariant: separate the low-frequency turn request from the oscillatory traveling bend and keep the turn request bounded by observed directional error and response
nontransferable_details: published gains, species-specific curvature envelopes, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: smoothly saturate body-frame bearing plus normalized yaw-rate damping into a shared two-joint equilibrium bias while retaining the joint-state oscillator and posterior lag
falsification: wrong-sign or unchanged upper exit, collapsed propulsion, worse distance progress, or materially more joint limiting disproves this translation
