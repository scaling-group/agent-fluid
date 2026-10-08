# Target-normal power-selective posterior relief

## Visual and quantitative diagnosis before editing

- I read the workspace and inherited guidance, all four sampled scores,
  observations, metrics, diagnostics, trajectories, and policies, plus the
  assigned-parent and inherited optimizer notes. Every current sample uses
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  prewarm, no cylinders, and capture termination. The two v12 samples are
  exact-policy and exact-trajectory repeats at `18.0125T` and `-0.064599`, so
  they are determinism evidence rather than distinct mechanisms.
- I inspected the combined sheets for the sampled v20 scalar leader, the v16
  terminal-allocation comparator, and the inherited phase-demodulated-envelope
  failure, including both the top-down mid-plane vorticity row and the oblique
  Lambda2 row from release through capture. All visibly self-propel from rest,
  maintain a coherent alternating street and compact three-dimensional
  posterior structures, and show no passive advection, wake breakup, boundary
  interaction, or out-of-plane instability. The demodulated case is an
  informative mechanism failure rather than a termination failure: the useful
  distinction is approach allocation and transverse motion, not wake creation.
- The assigned v20 parent is the sampled scalar leader at `18.0070T`, mean
  distance `1.950358L`, and score `-0.064028`, but its raw-yaw-power selector
  gives back the v16/v19 terminal benefit. Relative to v16, final alignment
  falls from `0.1818` to `0.1092`, absolute final yaw rises from `0.4200` to
  `0.9840 rad/T`, head cross-track widens from `0.7232L` to `0.7317L`, and
  near posterior acceleration-ceiling residence rises from `72.22%` to
  `75.83%`. The completed v19 conserved forward mean-bend allocation improves
  final alignment/yaw to `0.1957/0.2875 rad/T` and cross-track to `0.7207L`,
  but its score regresses to `-0.064778`; preserve it as terminal allocation,
  not as an established score mechanism.
- The inherited phase tests bound the next step. A posterior envelope selected
  by fitted carrier-demodulated yaw reduces near posterior acceleration-ceiling
  residence to `63.97%` and raises final alignment to `0.3295`, but delays
  capture to `18.0895T`, widens center path to `13.2309L`, and regresses score
  to `-0.065436`; its final yaw is still `0.8403 rad/T`. Half-cycle mean-bend
  allocation and demodulated shared rate feedback likewise score
  `-0.065267` and `-0.064780` while ending at only `0.0743` and `0.1026`
  alignment. Thus neither another yaw observer, shared course-rate residual,
  nor phase/share tune is supported.
- A target-frame translational signal is available and has an evidenced sign
  and scale. For each sampled approach I projected body-frame velocity and
  hydrodynamic force onto the normal of the instantaneous head-to-target line.
  Their positive product marks force adding cross-course kinetic energy and
  correlates `0.965`--`0.972` with the change in that energy four samples
  (`0.022T`) later. It is positive for about `45%`--`47%` of approach samples;
  the positive 75th/90th percentiles remain about `0.0060`--`0.0073` and
  `0.0086`--`0.0107`. On v20, a smooth `0.008`-scale gate gives mean/maximum
  posterior-relief authority `0.0853/0.5688`, comparable to the reconstructed
  raw-yaw selector's `0.0951/0.6078`, without using phase-dominated yaw.

## Single policy hypothesis

Preserve the evaluated v20 state-feedback carrier, posterior lag and emphasis,
phase-consistent reserve, odd body-frame route controller, approach-only work
partition, conserved v19 forward mean-bend allocation, half-cycle steering,
and reversal-preserving rate governor. Replace only v20's raw yaw-times-moment
selector for the existing posterior-wave envelope. Resolve body-frame velocity
and measured hydrodynamic force along the normal to the instantaneous target
line; smoothly gate the existing approach relief only when their product is
positive, meaning the current force is adding target-transverse kinetic energy.

The power and gate are reflection invariant because both normal projections
change sign under lateral reflection. The selector is zero at rest, for force
removing cross-course motion, outside `2.10L`, or once the course-alignment
gate is satisfied. It changes neither the shared route request nor total signed
mean tangent. Expected evidence is v20-identical transit and coherent two-view
wake, retained capture and distance-integral class, but v16/v19-like reductions
in terminal cross-track, yaw, and posterior limit residence. Falsify it if
transit changes, capture or score regresses materially, positive target-normal
power is not reduced, alignment/yaw/path do not improve together, actuator
pressure migrates forward, reflection changes selector magnitude, or either
wake view deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake/load-feedback swimming
source_mechanism: preserve the propulsive rhythm while using measured load to withdraw only stroke portions that inject energy into unwanted transverse motion
transferable_invariant: separate slow body-frame route geometry from a bounded reflection-invariant load-power selector and apply the selector only to an allocation envelope rather than the shared steering command
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: project normalized body-frame velocity and force onto the instantaneous target-line normal, smooth-gate their positive product at a rollout-measured scale, and use it only to qualify the established approach posterior-wave relief while preserving the two-joint carrier, posterior lag, and conserved mean bend
falsification: reject if pre-approach action changes, capture or distance integral worsens materially, target-normal power and terminal path/alignment/yaw do not improve together, saturation migrates without benefit, reflection fails, or either coherent wake row deteriorates

## Lightweight validation after editing

- The mandated dedicated check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its immutable
  checks directly first exposed two identical assigned-parent markers in the
  rendered workspace `README.md`; removing only the duplicate preserved the
  selected parent. The guidance-materiality check then passed, and the solver
  boundary check confirms that `candidate_target_policy.jl` is the only solver
  change.
- Julia is not installed, so the executable include/action probe cannot run.
  Deterministic static checks find one definition of each public function,
  resolve all `63` direct `params.FIELD` references among the `65` fields
  returned by `target_policy_params`, confirm balanced delimiters and a
  nonempty candidate, and find no elapsed time, step count, random source,
  file I/O, cylinder coordinate, target coordinate, or memorized route input.
- Offline replay of only the new selector on the sampled v20 trace is exactly
  zero for every sample at or beyond `2.10L`. Within approach its relief
  authority has mean/maximum `0.085298/0.568798` and is positive on `38.68%`
  of samples. Focused probes make the selector zero at rest and when force
  removes transverse kinetic energy; simultaneous lateral reflection preserves
  gate magnitude to numerical precision. These are contract and activation
  checks, not a new CFD result; EvE must evaluate capture, wake, and terminal
  response after this worker exits.
