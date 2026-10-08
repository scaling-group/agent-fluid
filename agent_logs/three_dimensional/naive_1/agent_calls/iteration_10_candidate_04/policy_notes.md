# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- Every sampled rollout used direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, and no instability. In both
  rows of the combined keyframe sheets, the fish self-propel: the top-down
  view retains an alternating red/blue caudal wake and the oblique view retains
  discrete three-dimensional Lambda2 structures through approach and exit.
  The common failure is route/yaw control, not advection or wake collapse.
- The strongest sampled reference, `solver_24724bc7bb0b`, reaches `3.691L` at
  `20.46T` with a coherent wake, then passes below the target and exits the
  lower boundary at `33.27T`. Symmetric posterior relief and anterior-only
  redirection are weaker (`4.233L` and `4.018L`) with the same visible route.
  Across those policies, normalized yaw-moment and force peaks remain about
  `0.0164` and `0.0317`; the failure does not justify more phase-residual,
  relief, or drive gain.
- The assigned parent's one-sided anterior envelope (`solver_237089f89ff4`)
  preserves the early wake and lowers full error at its closest approach from
  `1.364` to `1.291 rad`, but misses at `3.712L`, exits low at `32.95T`, and
  leaves the posterior mean opposite the anterior mean (`+0.215/-0.082 rad`
  over `28--32T`) with only `0.009 rad/T` mean yaw. Trading anterior excursion
  alone therefore makes a small orientation change without a useful route or
  termination change.
- The inherited same-sign posterior C-bend supplies a decisive actuator-sign
  experiment. `solver_94750f47d14e` adds a target-signed `+12 deg` posterior
  offset beyond the large-error regime. The posterior mean does become
  positive (`+0.100 rad` over `28--32T`), but mean heading rate rises in the
  wrong direction to `+0.320 rad/T`, full target error wraps through pi, and
  the lower exit advances to `32.23T` with a `3.692L` minimum. A geometric
  same-sign body bend is not a target-turn command for this FSI system.
- The useful yaw-rate signal is obscured by the propulsive beat: in the sampled
  traces instantaneous heading rate is about `-0.47 phi_dot[1]` (correlation
  about `-0.96`). Subtracting that joint-phase component before feedback is a
  testable way to distinguish slow route yaw from the fast carrier without a
  clock or mutable filter.

## One candidate hypothesis

Preserve the sampled rear-aware half-cycle controller and its traveling wake,
but replace the failed near-target envelope with one FSI-calibrated posterior
steering servo. Full target angle sets the maneuver magnitude, lateral target
displacement sets a continuous reflection-equivariant direction, and
`heading_rate + k*phi_dot[1]` estimates slow yaw after cancelling the evidenced
beat component. A wrong-way residual strengthens a bounded posterior offset;
a target-side yaw response releases it. The offset uses the sign opposite the
failed same-sign C-bend, because that completed rollout directly established
the local posterior-offset-to-yaw sign. It starts only once target error leaves
the aligned band, so the initial carrier is unchanged, and it never suppresses
self-excitation or the lagged posterior wave.

This is one response-gated posterior steering mechanism. Falsify it if the
coherent alternating wake is lost, approach is worse than `3.691L`, full error
does not turn downward before the old lower pass, the lower exit is not delayed
or avoided, posterior rate-cap occupancy materially exceeds about `5.5%`, or
normalized moment/force peaks materially exceed `0.0164/0.0317`.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish direction tracking
source_mechanism: persistent target error recruits bounded asymmetric curvature and observed turning response releases it back toward the propulsive rhythm
transferable_invariant: separate the fast joint-state carrier from slow route yaw, use measured actuator-response sign, and release steering on actual target-side response rather than elapsed time
nontransferable_details: species-specific C-start shape, published gains, dimensional frequency, robot linkage sign, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: normalized full body-frame target geometry gates a posterior counter-bend; anterior joint rate removes the evidenced beat component from normalized heading rate, which closes a bounded response-release loop while retaining the state-feedback oscillator
falsification: reject if wake coherence or the 3.691L approach degrades, target error does not decline before the old lower pass, exit is not delayed or avoided, the inferred yaw sign is wrong, or rate and load envelopes worsen materially
