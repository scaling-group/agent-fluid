# Terminal dynamic-carrier recovery candidate

## Visual and trace diagnosis before the edit

- Every sampled and inherited rollout is contract-valid direct-uniform still
  water (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  In both rows of the
  combined sheets, the useful finite policies translate with a body-attached
  alternating top-down wake and a compact three-dimensional Lambda2 trail, so
  their approach is self-propelled rather than moving-window advection.
- The posterior-redistribution prefill `solver_b6ed3f84ab58` is the informative
  failure: it remains in the upper corridor, touches the posterior angle
  boundary, and generates peak planar force/yaw moment near `0.212/0.0968`,
  roughly ten times the low-load near-miss class.  Its late oblique view also
  shows a sharper curl.  Added posterior authority or acceleration headroom is
  therefore not a safe steering argument.
- The assigned parent `solver_e7a7a878626e` and the inherited step-11/12
  descendants all preserve the coherent low-load downward path but miss the
  `0.75L` circle at `0.8278--0.8318L` and then exit left.  At closest approach
  they still translate near `0.66L/T`; both joints sit in a same-sign C-bend,
  correct-sign body yaw remains about `0.3--0.5 rad/T`, and projected course
  miss remains about `0.81L`.  The visuals and traces therefore diagnose a
  velocity-response deficit, not weak propulsion, wrong turn sign, wake loss,
  or moving-window motion.
- These completed descendants also close the nearby actuator branches.  A
  same-side anterior bearing-divergence pulse reached `0.831781L`, an anterior
  contralateral recovery sweep reached `0.828153L`, and a coordinated
  neutral-anterior/opposite-posterior recoil reached `0.830575L`; all retained
  the same visual pass-by and `left_domain` termination.  Together with the
  inherited negative results for deeper static curvature, posterior recovery,
  and posterior damping, this rules out another scalar target, threshold,
  one-joint pulse, or weak recoil edit.

## Policy hypothesis

Recover the evaluated response-released, terminal-miss-vetoed controller and
its closing-gated depth schedule from `solver_e7a7a878626e`.  Add one distinct
feedback semantic only in the capture approach: while the fish is closing on
an unsafe projected intercept and the anterior joint has attained the
preparatory same-sign bend, smoothly release both static trackers into the
existing phase-separated, course-steered traveling carrier.  The large
difference between a settled redirect command and the carrier's restoring
command makes this a complete two-joint dynamic recovery stroke rather than
another target depth or small residual.  Bend attainment removes the gate as
the body wave unloads and allows the redirect to return without a clock,
latch, or memorized route.  Outside the approach, and whenever the intercept
is safe or closing has stopped, the assigned-parent policy is unchanged.

The falsifiable expectation is an unchanged far path and coherent low-load
wake, followed by measurable rotation of the velocity vector toward the
target before closest approach and a first head crossing inside `0.75L`.
Reject the mechanism if it does not beat `0.827823L`, merely increases body
yaw, chatters without shrinking projected miss, raises terminal speed, touches
an angle boundary, or materially increases limit residence, force, or moment.

bookshelf_consulted: true
source_domain: terminal capture scheduling, biological burst-turn recovery, and reactive traveling-wave propulsion
source_mechanism: a completed preparatory bend that has not redirected translation is released into a bounded dynamic body-wave stroke instead of being held deeper
transferable_invariant: preserve the productive carrier, but use sensed intercept error and attained bend state to restore dynamic course authority when static curvature produces yaw without velocity rotation
nontransferable_details: published gains, full-body C-start timing, species-specific bend envelopes, dimensional frequencies, exact vortex phases, world coordinates, and task-specific routes
policy_translation: normalized body-frame range and projected miss identify the unsafe approach, positive closing behavior and anterior bend attainment gate a smooth two-joint blend from the redirect trackers to the existing joint-state traveling carrier
falsification: reject if minimum distance does not beat `0.827823L`, projected miss does not shrink, the far trajectory or coherent wake changes, recovery chatters, or angle, speed, acceleration, force, or moment exposure materially worsens

## Non-CFD implementation audit

Replaying the assigned-parent trajectory through its evaluated policy and this
candidate changes `277` of `7260` frozen-state actions, all at ranges
`0.8278--1.7481L`; there are zero differences at or beyond the `1.75L`
approach boundary.  The maximum component change is `29.1525 rad/T^2`, the
mean changed-sample L1 difference is `14.1761 rad/T^2`, and acceleration-clamp
incidence is unchanged at `2721` joint-samples.  A zero-speed/zero-error state
returns finite zero action, and reflecting joint state, lateral target and
velocity, bearing, and yaw negates both commands exactly.  These checks
establish material activation, locality, boundedness, schema coverage, and
reflection equivariance only; they do not predict the new CFD response or
claim an unevaluated improvement.
