# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting vortex streets; it is an initial condition, not
  evidence for any candidate.
- The target-blind seed (`solver_8e9f183ac950`) initially self-propels but
  curls almost straight down in the released keyframes.  It exits after
  `50.127` time units with head displacement `(-3.545,-13.300)L`, minimum
  distance `8.615L`, and both joint speed and acceleration at their limits.
- The direct bounded bearing-acceleration policy (`solver_218fe3a7d254`)
  visibly redirects down-left, crosses the interacting-wake corridor, then
  turns upward into the target.  It reaches the `0.75L` capture boundary in
  `62.304` time units with `0.940` progress, RMS relative crossflow `0.222`,
  RMS lateral force `27.25`, and RMS moment `525.79`.  This is the only sampled
  semantic success and establishes both the steering sign and the usefulness
  of preserving the seed carrier.
- The slow mean-curvature oscillator (`solver_0c51696bec78`) stays in the
  domain longer but never approaches within `9.238L`; its final keyframe is a
  large numerical blow-up, consistent with RMS relative crossflow `1.138`,
  RMS lateral force `16749.8`, RMS moment `290421`, and
  `unstable_dynamics`.  Its lower mean command effort is therefore not a
  usable improvement.
- The signed body-vector curvature policy (`solver_c6c8a69e047e`) selects the
  wrong turn topology: it initially moves away from the target and exits in
  `13.915` time units with progress `-0.160`.  Its steering sign and static
  offset construction should not be inherited.

## Candidate hypothesis

Preserve the demonstrated successful `0.55`-period traveling-bend scaffold
and same-sign bounded acceleration steering.  Add one small feedback
mechanism: a clamped windowed bearing-rate term inside the steering nonlinearity.
For the established positive steering sign, `bearing + k*bearing_window_rate`
acts as target-error derivative feedback: a negative rate (error already
closing) releases curvature before overshoot, while a positive rate (error
worsening) reinforces the turn.  The rate is body-frame, normalized per
nondimensional time, zero during padded history, and cannot enlarge steering
beyond the existing tanh bound.

Expected test: retain target reach while shortening the visibly broad S-turn
or reducing unnecessary steering reversal.  Falsify the mechanism if the next
rollout loses semantic success, takes materially longer than `62.304`, exits
on the seed's lower route, or produces larger load/effort without a straighter
useful trajectory.  The present rollout cannot establish the outcome; its CFD
evaluation occurs after this worker exits.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking
source_mechanism: sensor-modulated propulsive oscillator with bounded directional feedback and response-aware release
transferable_invariant: preserve the rhythmic carrier while slow body-frame target error sets turn direction and observed error motion modulates the turn continuously
nontransferable_details: published gains, robot geometry, clock-driven oscillator phase, species kinematics, exact vortex phase, and any task-specific route
policy_translation: keep the successful joint-state oscillator; drive the shared two-joint steering residual with tanh of bearing plus a small clamped bearing-window-rate term
falsification: reject the added rate feedback if target reach is lost, arrival degrades materially, the lower-domain exit recurs, or load and command effort rise without a more direct targetward trajectory
