# Body-response-completed terminal redirect candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, active moving-window transport, and finite capture from
  `12.32772L` at about `25.11T`.
- I inspected the combined sheets for the strongest finite sample
  (`solver_89a97c83567b`) and the informative weaker finite comparator
  (`solver_6a46e49f8216`) from release through capture, including the
  top-down mid-plane vorticity row and oblique body/Lambda2 row. Both are
  self-propelled along the same compact target-directed arc, sustain a coherent
  alternating posterior wake with finite three-dimensional shed structures,
  and enter the capture sphere without collision, domain-exit precursors, or
  visible instability. Several early oblique panels and most comparator
  oblique panels are blank; those missing panels are not treated as wake
  evidence, and the visual claims are cross-checked against the complete
  top-down rows and finite trajectory/diagnostic records.
- The coordinated response-release policy is reproduced exactly by three
  sampled candidates. Each scores `-0.5283387731`, captures at `25.11852T`,
  reaches `0.746410L`, and has mean distance `2.429293780L`. The distinct
  phase-selective departure-pressure gate is marginally worse at
  `-0.5283756345`, mean distance `2.429298361L`, and `0.746517L`. It captures
  one integration step earlier but with a shallower crossing. This agrees with
  inherited logs showing that stacking the two response signals regressed to
  `-0.5309900794`; another joint-phase gate is not supported.
- Inside `4L`, the sampled best has no acceleration samples above
  `30 rad/T^2`, no joint-stop dwell, and bounded peak lateral-force/yaw-moment
  coefficients near `0.01547/0.00800`. Its final speed remains useful at
  `0.6539L/T`, so the inherited `51.645T` low-drive orbit continues to rule out
  broad terminal braking or coasting.
- The remaining response gap is geometric rather than an actuator shortage.
  After the two-joint equilibrium settles, the body-frame target angle falls
  monotonically from its clipped large-error regime but is still about
  `0.7125 rad` at capture. The measured yaw rate is about `-0.3134 rad/T`, while
  the existing bounded target-rate request remains more negative. That
  turn-rate loop affects the baseline carrier but is largely removed when the
  geometry-gated terminal redirect replaces it.

## Policy hypothesis

Preserve the evaluated coordinated response release, closure preview, outer
carrier, target-relative equilibria, and all existing limits. Add one bounded
body-response completion mechanism inside the terminal curvature controller:
once the normalized body-frame redirect angle has fallen out of the clipped
large-error regime, smoothly use the difference between the already-computed
target yaw rate and measured recent yaw rate to shift the anterior target and
total tail-tangent target together. This closes the redirected mean bend on
actual body response without changing its sign, splitting joint roles, adding
another phase gate, or using a clock, world coordinate, or velocity course.

The mechanism must be exactly inactive before the terminal range/closure gate
and while body-frame misalignment remains large. It should preserve the outer
wake and use the demonstrated terminal actuation/load margin to reduce the
remaining line-of-sight angle or deepen the first capture crossing. Reject it
if capture is delayed or lost, the pre-terminal trajectory changes, the rate
residual opposes target-relative curvature, terminal command caps/joint stops
return, force or moment rises materially, or a low-drive loop appears.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological C-start response release
source_mechanism: retain target-signed mean curvature until measured body turning, not only internal joint motion, completes the redirect, then preserve coordinated rhythmic propulsion
transferable_invariant: when steering and propulsion share limited joints, close mean-curvature allocation on bounded body-frame geometry and measured yaw response rather than elapsed time or prescribed gait phase
nontransferable_details: published gains, dimensional yaw rates and cadence, species-specific C-bend envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: after normalized body-frame alignment confirms the large redirect has responded, a saturated target-yaw-rate error shifts both terminal curvature targets coherently while the evaluated two-joint response release and closure gate remain intact
falsification: reject if the outer commands or wake change, capture/mean distance regresses, the correction fights the target-signed bend, or terminal saturation, load growth, instability, or low-drive loitering returns

## Non-CFD implementation audit

The deterministic schema scan resolves all 73 direct `params.FIELD`
references in the returned parameter object, and the synthetic contract state
returns two finite bounded commands. Against the evaluated coordinated-release
parent, a synthetic `6L` state is command-exact, while a sampled-like `0.8L`
state changes from `(0.08194, 0.21244)` to `(-0.08650, -0.03727) rad/T^2`;
the new values remain far inside the declared command limit and bend in the
negative direction requested by both target geometry and yaw-rate error. This
checks activation, noninterference, sign, and boundedness only, not coupled-flow
performance.

The new CFD evaluation occurs after this worker exits and is not claimed here.
