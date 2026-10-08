# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. The prefilled posterior-
  preview policy and two executable-equivalent samples reproduce exactly
  `22.154001T` capture, `0.748384L` crossing distance, `2.105583L` scored mean
  distance, and score `-0.210952`. The semantic variant that extends recovery
  prediction as proximity fills reproduces the same trajectory exactly.
- Both visual rows of the best sample were inspected from release through
  capture. Its top-down row develops an attached alternating red/blue caudal
  street by `4T`, carries it along the smooth S-shaped approach, and retains
  it at the target crossing. Its oblique row shows discrete three-dimensional
  Lambda2 structures following the moving caudal region at `4/12/20T` and
  capture. This is coherent self-propulsion, not advection, excessive lateral
  thrashing, or an inertial coast.
- The hydrodynamic-response composition is the informative weaker sample. It
  retains capture at `22.154001T` and the broad top-down wake/route class, but
  raises mean distance to `2.105967L` and worsens score to `-0.211334` while
  lowering mean action from about `59.932` to `59.695` and anterior exact-rate
  occupancy from about `11.49%` to `11.02%`. Peak normalized force/moment stay
  at `0.030897/0.015839`. Its oblique row is black after the frame labels, so
  it is a render-evidence failure and supplies no independent 3D-wake claim.
  Favorable-moment release and posterior preview therefore do not compose
  additively on the anterior redirect path.
- Offline reconstruction explains why the proximity-extended recovery sample
  is an exact no-op. Through-water speed recovery is already zero by `4T`,
  while the normalized `8.0--5.5L` proximity gate does not open until roughly
  `9T`; the new prediction term is multiplied by a posterior recovery share
  that is inactive throughout its support. Do not retry that path or tune its
  preview horizon.

## Visual diagnosis and one candidate hypothesis

The best parent's launch and rhythmic carrier are already productive and must
be preserved. Its remaining S-route curvature occurs after proximity opens.
The reconstructed parent state shows target bearing/course-sideslip pairs of
about `0.701/-0.304`, `0.766/+0.190`, and `0.762/+0.475 rad` at `12/16/20T`.
The current partial sideslip subtraction therefore leaves slow route errors of
about `0.899/0.643/0.453 rad`; exact through-water course alignment would give
about `1.005/0.577/0.287 rad`. The geometric distinction is useful: early in
the turn it preserves saturated target recruitment, while later it should
release excess body yaw once the measured translation is already rotating
toward the target.

Produce one candidate that preserves every oscillator, speed recovery,
posterior recovery allocation, target-line predictor, anterior redirect,
posterior half-cycle asymmetry, reactive rudder, terminal relief, and authority
ceiling. Change only the slow anterior route loop: use the existing normalized
distance gate to blend `course_angle_feedback` from its established partial
value to a separately parameterized full-course value of one. This converts
the middle/near controller from partial body-heading correction toward
through-water velocity-vector interception without adding propulsion or
steering authority. It is exactly inactive during the evidenced launch and
uses only normalized body-frame target geometry and body-water velocity.

Falsify the mechanism if capture is lost or later than `22.154001T`, scored
mean distance exceeds `2.105583L`, the unchanged `4/8T` launch differs from
about `11.300/8.629L`, or the `16/20/22T` approach fails to improve. Also
reject it if mean action materially exceeds `59.932`, anterior/posterior
exact-rate occupancy materially exceeds `11.49/6.41%`, peak normalized
force/moment exceed `0.030897/0.015839`, or valid top-down and oblique sheets
do not preserve the coherent alternating three-dimensional wake. Any positive
result would remain fixed-pose still-water evidence, not robustness to changed
pose, imposed flow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and distance-conditioned terminal capture control
source_mechanism: preserve a posterior-delayed propulsive rhythm while a slow body-frame route loop transitions from heading correction toward measured through-water course alignment on approach
transferable_invariant: keep the rhythmic carrier intact and, near the target, align measured translation rather than adding steering load when body yaw and through-water motion differ
nontransferable_details: published gains, dimensional speeds, source distance thresholds, clocked CPG phase, linkage or species kinematics, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: blend only the normalized body-water sideslip coefficient in the slow anterior curvature request from the evidenced partial value to geometrically full course alignment through the existing proximity gate; leave every carrier, posterior path, and authority ceiling unchanged
falsification: reject if capture is later than 22.154001T or lost, mean distance exceeds 2.105583L, the pre-proximity launch changes, or valid two-view wake, action, saturation, force, or moment envelopes worsen
