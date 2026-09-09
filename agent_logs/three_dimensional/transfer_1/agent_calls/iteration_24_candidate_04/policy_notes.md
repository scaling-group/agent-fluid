# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and capture
  termination. Three are exact copies of the prefilled
  `dogfish3d_intercept_guarded_speed_reserve_v1` controller and capture at
  `0.7466--0.7494L` after `18.3205--18.6010T`; the fourth sampled posterior
  wave-shape policy also captures, but inherited evidence rejects that
  phase-sensitive perturbation after two exact lower exits.
- I inspected both rows of all four sampled combined keyframe sheets and the
  assigned parent's informative `dogfish3d_speed_reserve_capture_hold_v1`
  failure. The captures visibly self-propel through termination with a
  substantial alternating top-down wake and compact alternating oblique
  Lambda2 structures. The capture-hold failure retains the same active wake,
  passes below at `1.4597L` while moving about `0.823L/T`, and exits the lower
  boundary. This is terminal steering topology, not advection, coasting,
  carrier collapse, collision, or instability.
- The failed capture-hold policy relaxed steering from instantaneous projected
  corridor and approach geometry. Its closest-pass projected miss is about
  `1.43L` and alignment has become negative; the restored exact baseline in
  the assigned parent's next rollout captures at `0.7485L`. This falsifies
  widening or scalar-tuning a geometry-only release floor. The carrier,
  cadence, phase-independent steering allocation, and sparse speed reserve
  should remain unchanged.
- A trace cross-check exposes a distinct observation problem. For every exact
  baseline capture and the inherited capture-hold miss below `4L`, measured
  body-frame lateral velocity is strongly anticorrelated with anterior joint
  speed: `corr(v_body_y, qd1)=-0.938-- -0.965`. Independent one-variable fits
  give a stable slope of `-0.093-- -0.104` in normalized `L/rad`. Thus the
  achieved-course servo is treating a large, repeatable carrier-phase sway as
  slow route motion, even though the inertial projected-miss and approach
  gates need the unmodified physical velocity.

## One candidate hypothesis

Retain the exact repeat-backed traveling bend, cadence scheduling, raw-velocity
intercept guard, additive steering allocation, and conditional outward-carrier
reserve. Add one bounded observation mechanism: smoothly inside the existing
terminal-response range, remove the locally evidenced `qd1`-correlated sway
from only the body-frame lateral velocity used to estimate achieved course.
Keep raw body-frame velocity for speed gating, LOS rate, projected miss, and
approach alignment. This separates beat-scale locomotor sway from the slow
mean-course feedback without adding a force, route, clock, carrier-phase
actuation pulse, or geometry-only steering release.

Expected test: preserve the sampled far-field trajectory and both coherent wake
views while making terminal mean-curvature steering less sensitive to the
instantaneous tailbeat phase. Improvement requires repeatable capture and a
clearer arrival, terminal geometry, actuator/load metric, or robustness benefit
beyond baseline variation.

Falsification: reject the phase-compensated course observation if capture is
lost, far-field closure changes, the projected pass worsens, the traveling wake
weakens, clipping or speed-limit residence rises, loads leave the baseline
envelope, or exact repeats show no semantic or secondary benefit. Do not answer
failure by tuning only the compensation coefficient or by stacking a yaw
brake, posterior pulse, or capture-corridor release floor.

## Offline mechanism check after implementation

Replaying the recorded observations through the raw and compensated course
calculations, without advancing CFD or claiming a candidate outcome, reduces
terminal turn-command standard deviation from `0.596--0.682` to
`0.468--0.505` in the three sampled baseline captures and from `0.275` to
`0.209` in the inherited miss. Sequential sign crossings fall from `9--10` to
`5--8` in the captures and from `5` to `3` in the miss. The correction is zero
at and beyond `4L`, is bounded by measured speed, and does not enter raw LOS,
projected-miss, approach-alignment, carrier, or actuator-reserve calculations.
This verifies signal separation only; the post-exit evaluator must establish
whether it improves closed-loop capture robustness or secondary metrics.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and coupled-oscillator swimming control
source_mechanism: separate the slow target-directed mean-turn request from beat-scale locomotor oscillation while preserving the posteriorly lagged propulsive wave
transferable_invariant: route feedback should reject joint-phase-correlated sway that does not represent mean achieved course, while physical interception geometry continues to use the unmodified velocity
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator clocks, exact vortex phases, full-body envelopes, prescribed paths, and task coordinates
policy_translation: below the existing terminal range, use normalized anterior joint speed to compensate only the body-frame lateral course observation; leave raw velocity, two-joint carrier, intercept gates, steering allocation, and actuator reserve unchanged
falsification: reject if capture reliability, far-field closure, wake coherence, terminal geometry, loads, or actuator metrics worsen relative to the repeat-backed speed-reserve baseline
