# Phase-neutral target-frame candidate

## Evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and semantic `capture`.  Three reproduce the v26
  yaw-neutral/carrier-first parent at `23.9305 T`, score `-0.55178099`, and
  distance integral `2.45000 L`.  The v27 common-mode candidate additionally
  removes observed carrier yaw from bearing-trend feedback and improves to
  `23.6390 T`, score `-0.54450554`, and integral `2.44217 L`.
- I inspected both the top-down vorticity and oblique Lambda2 rows for the v26
  parent, the v27 best sample, and the inherited low-speed posterior-position
  negative control.  The v26 and v27 sheets show self-propulsion from
  quiescent water: compact startup structures become a coherent alternating
  posterior wake, the wake bends with one continuous target-signed arc, and
  three-dimensional packets persist through capture.  The sheets are nearly
  identical at their coarse sample times, so the scalar gain is not by itself
  a visual mechanism claim.  The low-speed position seed also retains an
  organized wake but follows a visibly flatter middle route and reaches the
  terminal turn later; it captures at `24.7885 T` with integral `2.46154 L`,
  worse than both v26 and v27.  No sampled semantic non-capture is available;
  the inherited informative non-capture remains the response-only redirect
  release that passed above-left at `2.4625 L` and exited left, so the
  completion-gated redirect remains protected.
- Metrics bound what v27 actually improves.  Relative to v26, it is farther
  away at `2/4 T` (`12.2844/11.9855 L` versus `12.2755/11.9368 L`), nearly
  tied at `8 T`, then leads by `0.0294 L` at `16 T` and `0.1282 L` at `20 T`.
  Mean/max speed rise from `0.5458/0.7837` to `0.5532/0.8100 L/T`, and
  any-joint acceleration-limit residence rises from `45.62%` to `48.21%`,
  while sampled peak planar force and yaw moment remain `0.02974/0.01484`.
  Bearing-trend common-mode rejection is therefore a small later-route
  semantic improvement, not the hoped-for action or speed reduction.
- The remaining phase inconsistency is directly measurable in proportional
  target geometry.  After subtracting a centered one-carrier-period mean from
  the v27 trajectory, reconstructed body-frame target angle has correlation
  `-0.928` with `phi1` and a fitted slope of `-0.478`.  Adding the same
  evidenced `+0.40*phi1` common mode already used in rate feedback reduces its
  oscillatory standard deviation from `0.1257` to `0.0506 rad`; the v26
  control gives the same sign and comparable reduction (`0.1225` to
  `0.0486 rad`).  Thus proportional target error, its measured trend, and
  recent yaw all contain the same observed carrier-scale body rotation.

## One-candidate policy hypothesis

Start from the evaluated v27 controller, preserving its posterior traveling
wave, completion-gated redirect, progress-gated posterior lag, carrier-first
residual projection, and rate-level common-mode rejection.  Complete that one
observation-decomposition mechanism at zero order: rotate the normalized
body-frame target vector through the bounded joint-observed carrier angle
`carrier_yaw_rate_gain*phi1`, and use the phase-neutral vector for proportional
bearing, vector-angle steering, redirect geometry, and centerline tests.  This
removes the fish's own beat from target geometry rather than tuning any scalar
carrier or steering gain.  It adds no clock, history state, global direction,
target identity, prescribed route, or exact vortex phase.

Expected evidence is retention of v27's later-route lead and capture while
reducing half-cycle countersteering, acceleration-limit residence, and peak
speed toward the v26 envelope.  Falsify the mechanism if capture is lost or
later than `23.6390 T`, the distance integral exceeds `2.44217 L`, the
`16--20 T` lead disappears, the target-signed arc or alternating wake loses
coherence, or saturation, speed, normalized force, or moment increases.  The
new candidate has no same-worker CFD result; formal evaluation after exit must
decide whether phase-neutral proportional geometry transfers online.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and low-dimensional residual control over rhythmic locomotion
source_mechanism: separate gait-synchronous body motion from persistent target-relative guidance while retaining the propulsive oscillator
transferable_invariant: target geometry and its derivatives should be expressed in one carrier-neutral observed body frame before commanding route-scale steering
nontransferable_details: published oscillator gains, clocked phase, robot geometry, species-specific kinematics, dimensional cadence, exact vortex phase, and prescribed routes
policy_translation: use bounded observed head-joint displacement and rate to remove the same carrier rotation from normalized target-vector geometry, bearing trend, and recent yaw, then retain two-joint carrier-first residual projection
falsification: reject if capture or route integral regresses, the later-route lead vanishes, action or speed grows, or coherent target-directed wake and inherited left-exit protection are lost

## Evidence boundary

All numerical and visual comparisons above are from completed sampled CFD and
inherited logs.  This candidate is an unevaluated transfer hypothesis.
