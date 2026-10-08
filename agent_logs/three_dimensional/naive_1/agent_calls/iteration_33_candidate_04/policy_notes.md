# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four current samples are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three comment-only variants
  of the assigned-parent composition reproduce exactly `22.187000T` capture,
  `0.748118L` crossing, `2.106255L` scored mean distance, and score
  `-0.211504`. The informative weaker sample omits the proximity extension of
  the rudder predictor and captures at `22.307997T`, with `0.748057L`
  crossing, `2.107401L` mean distance, and score `-0.212396`.
- Both rows of the current best and weaker combined sheets were inspected from
  release through capture. Their top-down rows show the same self-propelled
  S-route: a coherent alternating red/blue street develops behind the caudal
  region by `4T`, stays attached as the fish turns, and persists through the
  final approach. All current oblique rows are black render artifacts, so they
  provide no new three-dimensional wake evidence. The inherited `22.500492T`
  control has a valid oblique row; it shows discrete Lambda2 structures shed
  behind the moving tail through capture and remains the applicable 3D-wake
  bound. The sampled target-side phase-redistribution negative control was
  also inspected: it retained the top-down carrier but captured later at
  `23.452015T`, and its oblique row is likewise blank.
- The completed composition is a narrow positive mechanism, not a gain-free
  dominance result. Relative to the fixed-one-cycle rudder/recovery predictor,
  the separately proximity-led rudder improves distance increasingly after
  recruitment: the traces are identical at `4T`, differ by only about
  `0.001L` at `12T`, then favor the composition by about `0.011/0.012/0.046L`
  at `16/20/22T`. It advances capture by `0.121T`, raises final one-step
  closing speed from about `0.398` to `0.436L/T`, and preserves peak normalized
  force/moment at `0.030897/0.015839`.
- The same comparison exposes a control-allocation cost. Mean action rises
  from about `59.675` to `59.850`, although anterior/posterior exact-rate-cap
  occupancy stays near `11.53/6.40%`. Full head-relative target error at the
  crossing also rises from about `1.073` to `1.136 rad`. Thus the extra
  predicted rudder primarily improves target-directed translation; it does
  not establish better terminal alignment or lower effort. The inherited
  broad recent-yaw unloading is not a remedy: it previously let joint motion
  and the visible wake decay nearly to zero and coasted out of the domain.

## One candidate hypothesis

Preserve the assigned parent's through-water course feedback, oscillator
energy recovery, full body-frame target geometry, posterior traveling carrier,
fixed recovery-budget crossfade, separately proximity-led reactive rudder, and
stroke-qualified terminal rudder relief. Add one response-conditioned release
only to the additive anterior redirect residual. Normalize target-corrective
yaw as `-geometric_turn * turn_rate_recent` by the already bounded target-line
rate scale, smooth its positive part, and release at most 20% of the anterior
redirect only after the existing proximity gate has recruited. Do not apply
this response gate to the oscillator, curvature center, posterior carrier,
recovery allocation, or reactive rudder.

This is a bounded response-to-actuator allocation rather than another steering
gain or predictor-horizon change. In the current trace, the proximity-led tail
creates stronger target-directed closing but the always-available anterior
redirect continues through correct-sign yaw portions of the late beat. A small
release should avoid redundant late steering acceleration while retaining the
posterior load pathway that produced the `22.187000T` capture. Restricting the
release to one additive residual directly tests the boundary left by broad
recent-yaw unloading: carrier energy and the established three-dimensional
wake must remain active.

Falsify the mechanism if capture is lost or later than `22.187000T`, scored
mean distance is not below `2.106255L`, or score does not exceed `-0.211504`.
Also reject it if full head-relative crossing error does not fall below about
`1.136 rad`, mean action exceeds `59.850`, anterior/posterior exact-rate-cap
occupancy materially exceeds `11.53/6.40%`, peak normalized force/moment exceed
`0.030897/0.015839`, the pre-proximity route changes, or a valid two-view sheet
does not retain the coherent alternating 3D wake. Fixed-pose still-water
success would establish response-gate compatibility, not robustness to a new
pose, inflow, hydrodynamic condition, or external wake.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release a transient redirect after measured target-corrective yaw appears while preserving the posterior-delayed propulsive rhythm
transferable_invariant: normalized body-frame response may continuously release one bounded steering residual without unloading the traveling carrier or changing peak posterior authority
nontransferable_details: species-specific C-start envelopes, published gains, dimensional yaw rates and frequencies, robot calibration, distributed-body kinematics, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: within the existing proximity gate, smoothly release at most 20% of only the anterior redirect when measured recent yaw has the target-corrective sign; leave oscillator, curvature center, posterior carrier, recovery budget, and rudder unchanged
falsification: reject if capture is later than 22.187000T or lost, mean distance is not below 2.106255L, alignment and action do not improve jointly, or route, saturation, loads, or a valid two-view wake exceed the assigned-parent bounds
