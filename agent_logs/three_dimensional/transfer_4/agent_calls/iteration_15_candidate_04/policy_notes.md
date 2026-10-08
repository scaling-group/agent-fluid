# Phase-consistent posterior-work reserve

## Evidence and visual diagnosis before editing

- I reviewed the assigned parent guidance, the four sampled policies, scores,
  observations, metrics, diagnostics, and trajectories, and the inherited
  optimizer notes that introduced the reserve variants. All four evaluations
  use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, remain stable, and terminate
  in capture. The duplicate closure-qualified samples reproduce exactly and
  count as determinism evidence rather than distinct mechanisms.
- I inspected the release-to-capture top-down vorticity and oblique Lambda2
  rows for the strongest-score posterior-work rollout and the weaker
  closure-qualified and energy-only controls. Every fish self-propels from
  rest, forms a coherent alternating mid-plane street, and retains compact
  three-dimensional posterior structures through capture. There is no passive
  advection, collision, wake breakup, or out-of-plane instability. Because
  gross wake topology and RMS yaw/force/moment class remain alike, route state
  and posterior response allocation are the useful discriminants.
- The closure-qualified target-amplitude reserve captures at `17.6935T`, with
  mean distance `1.960960L`, first-`3T` mean distance/speed
  `12.220627L/0.2453U`, a `12.8750L` path, `0.4571L` maximum head cross-track,
  `0.8806` approach alignment, and `0.6371` final alignment at only
  `-0.0459 rad/T` yaw. Its duplicate is byte-equivalent in outcome.
- The assigned parent's velocity-aligned posterior-work reserve is a qualified
  positive result for propulsion but not for route neutrality. It improves
  score/mean distance to `-0.072146/1.958037L` and first-`3T` distance/speed to
  `12.214522L/0.2519U`; both visual rows stay coherent and RMS force/moment
  remain `0.01578/0.00816`. Yet it captures later at `17.8695T`, lengthens the
  path to `13.0071L`, raises maximum cross-track to `0.6102L`, and falls to
  `0.7875/-0.0027` approach/final alignment with `-3.0677 rad/T` final yaw.
  Unconditional velocity-aligned work therefore restores early energy but can
  reinforce a posterior response even while that response is moving away from
  the lagged traveling-wave target.

## One policy hypothesis

Promote the sampled posterior-work controller, preserving its anterior
phase-plane oscillator, lagged posterior target, odd mean-curvature and
half-cycle steering, closure need gate, error-qualified far-route observer,
ordinary approach handoff, cadence schedule, and reversal-preserving rate
governors. Change only the work allocation: compute the posterior oscillatory
tracking error after removing the mean steering curvature, normalize its
product with observed posterior velocity, and admit extra velocity-aligned
work smoothly only while the joint is moving toward the lagged wave target.
This state-feedback phase-consistency gate does not prescribe an exact vortex
phase, alter the target, inject a route, or add time or mutable state.

Expected evidence is retention of the assigned parent's early-distance and
mean-distance gain plus recovery toward the closure-qualified sample's shorter
path, earlier arrival, and positive terminal alignment. Falsify the mechanism
if early speed returns to the no-work class, if capture/path/cross-track or
terminal yaw remains in the unconditional-work class, if actuator or
force/moment class worsens, or if either wake view loses its coherent
posteriorly lagged structure.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: reinforce posterior propulsive work while preserving the observed direction and lag of a traveling body wave
transferable_invariant: extra posterior work should be response-consistent, acting only when measured posterior motion advances toward its lagged oscillatory target while steering mean and route feedback remain separate
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, target coordinates, elapsed schedules, and task-specific routes
policy_translation: multiply the closure-and-carrier-deficit work reserve by a bounded normalized sign-consistency gate formed from posterior velocity and oscillatory tracking error, without moving the lagged target or mean curvature
falsification: reject if early and mean distance gains disappear, route directness or terminal state fails to recover, actuator/load class rises, reflection symmetry breaks, or top-down and oblique wake coherence regresses
