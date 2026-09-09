# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled rollouts and both inherited optimizer rollouts report direct
  uniform still water, `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In
  every combined sheet, the top-down row develops a body-connected alternating
  vorticity street and the oblique row shows coherent three-dimensional
  Lambda2 structures. The fish is self-propelled; the failures are route and
  terminal-control failures rather than advection or loss of propulsion.
- The scalar-best sample reaches only `4.650L`, although its straighter wake
  gives the lowest mean distance (`6.304L`). The sampled course-responsive
  policy reaches `2.595L` but has both joints at `-45 deg` at closest approach,
  then hooks around the target and exits the upper boundary. The assigned
  posterior-bend-release parent reduces tail dwell beyond `40 deg` to
  `0.930T`, yet regresses to `3.312L` and raises normalized peak planar
  force/moment to `0.890/0.414`. Both visual rows show the coherent approach
  wake folding around an over-bent body before the common boundary exit.
- The assigned guidance proposes a reverse-half-cycle reserve, but the
  inherited optimizer log already falsifies that mechanism: its visual wake
  remains coherent while closest/final distance worsen to `2.937L/9.264L`,
  score falls to `-10.506`, and the trajectory exits left. An actuator reserve
  is therefore not a navigation signal and will not be repeated.
- The inherited terminal mean-curvature handoff is the strongest semantic
  trajectory. It retains zero joint dwell beyond `40 deg`, peak planar
  force/moment of only `0.034/0.017`, and improves closest approach from the
  course-residual controller's `1.173L` to `1.033L`. The top-down and oblique
  sheets show the fish crossing just outside the capture sphere with a compact
  alternating wake, then escaping lower-left. At `1.500L`, speed is
  `1.110L/T` and target closing speed is still `1.008L/T`; at the `1.033L`
  minimum, speed remains `1.067L/T` and closing speed has reversed to
  `-0.346L/T`. The remaining defect is excess terminal propulsion, not missing
  mean-turn authority.

## Single candidate hypothesis

Use the inherited course-residual traveling bend and continuous terminal
mean-curvature handoff as the base mechanism. Add one closing-responsive CPG
amplitude envelope: inside the existing normalized distance gate, reduce the
oscillator amplitude only in proportion to positive target closing speed.
Keeping the carrier equilibrium, frequency, posterior lag, and steering
handoff unchanged should damp the beat before the high-speed crossing without
coasting prematurely; zero or negative closing speed continuously restores
the full carrier for recovery. The envelope uses only normalized body-frame
target and velocity observations and has no clock, route, target identity, or
world-frame cue.

Support requires capture, or at minimum a pass below `1.033L` with a target-
side recovery and no joint/load regression. The mechanism is falsified if it
loses the inherited near approach, repeats the lower-left escape, creates any
persistent `40 deg` dwell, exceeds the `0.034/0.017` load reference without
capture, or collapses the coherent alternating wake outside the terminal gate.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG control and terminal capture by undulatory swimmers
source_mechanism: modulate propulsive rhythm amplitude from observed approach state while retaining a separate target-signed mean-curvature channel
transferable_invariant: reduce excess propulsion continuously only during a near, positively closing approach and restore it when closing stops so steering is not replaced by permanent coasting
nontransferable_details: published gains, robot linkage geometry, species bend envelopes, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: compute closing speed from normalized body-frame target and velocity, then shrink the two-joint state-feedback oscillator amplitude through the existing smooth terminal-distance gate without changing its equilibrium or posterior lag
falsification: reject if the 1.033L pass is lost, the lower-left exit remains, joint or load occupancy worsens, or far-field wake coherence changes

## Dry validation

- The prescribed guidance-materiality, Julia policy-contract, and solver
  editable-boundary checks pass. All 20 direct `params.FIELD` references are
  present in `target_policy_params()`, and the source contains no clock, step,
  random, cylinder, world-route, or fixed-target cue.
- A deterministic 50,625-state grid spanning joint angles/rates, full-circle
  target geometry, translational velocity, and distance produced finite actions
  strictly inside the smooth `30 rad/T^2` envelope. Left/right reflection
  error was exactly `0.0`.
- Far from the terminal gate, action difference from the inherited `1.033L`
  controller was exactly `0.0` on the comparison grid. Maximum action jumps
  across a `2e-6L/T` closing-speed interval and a `2e-5L` distance interval
  were `1.14e-7` and `1.63e-5 rad/T^2`. At the evidenced `1.5L`,
  `1.0L/T` closing state, the analytic amplitude scale is `0.405`; an
  opening state restores `1.0`.

No CFD was run and no same-worker physical improvement is claimed; the later
formal evaluation must decide every route, wake, limit, and load falsifier.
