# Candidate diagnosis and hypothesis

## Inherited evidence

- The only sampled solver, `solver_e496f399e09f`, is the assigned transferred
  2D seed. Its evaluation is contract-valid direct-uniform still water
  (`U_infinity=0`) with no cylinders or prewarm. No inherited optimizer notes
  are present in this workspace, so the parent guidance and this sampled
  rollout are the available evidence.
- Both rows of `wake_keyframes.jpg` show self-propulsion rather than advection:
  a coherent alternating wake grows behind the tail while the center travels
  from `(21,14)L` toward the lower left. The useful early segment reduces
  distance from `12.33L` to `4.78L` by `17.85T`, but the body develops a
  sustained nose-down/right-of-route yaw and passes below the target. Distance
  then grows to `9.71L`, followed by `left_domain` at center `y=0.798L` and
  head `y=0.310L` at `27.49T`.
- The beat-averaged heading rises from about `0.36 rad` at `4T` to `0.88 rad`
  at `16T`, while center `y` falls through the target row. At and after closest
  approach the body-frame target is strongly lateral/behind, yet the path does
  not redirect. This is an informative failure after a strong finite approach,
  not a propulsion failure.
- The seed's approach/recovery terms are gated by
  `1 - clamp(distance_L / 2.1, 0, 1)`. Because the rollout never enters
  `2.1L`, sweep damping, positive recovery, and centerline braking remain
  inactive throughout. Raw acceleration requests also exceed the
  `1800 deg/T^2` envelope in about `71%` of joint-1 and `77%` of joint-2
  samples; joint velocity is exactly limited in about `8%` and `10%` of
  samples. Small acceleration-level steering residuals therefore compete with
  a frequently clipped carrier.

## One candidate mechanism

Preserve the demonstrated state-feedback traveling wave and existing ordinary
route controller. Add one continuous redirect mode: large normalized
body-frame target misalignment smoothly produces a symmetric mean-curvature
posture across both joints and temporarily lowers carrier cadence. The
curvature direction comes only from current target geometry. As alignment
improves, both posture and cadence relief vanish continuously, restoring the
productive posterior-lag beat. This creates steering authority before the
unreached near-target gate and avoids depending on beat-scale bearing-rate
estimates for the redirect direction.

Expected effect: the redirect gate should begin opening as the lower-going
drift becomes geometrically clear, reduce peak lateral/behind target bearing,
and convert the `left_domain` trajectory into a bounded second approach while
retaining early self-propulsion.

An inherited-state dry replay (not new CFD evidence) gives a mean redirect
gate of `0.03` through `0-8T`, `0.095` over `8-12T`, and `0.614` over
`12-16T`, reaching full authority after `16T`. Thus the new mechanism is nearly
absent over the seed's useful early launch and becomes material over the
observed heading-divergence interval. Its curvature contribution is bounded
below `12 deg`, and its cadence multiplier is bounded to `[0.78, 1]`.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: a large-error C-start-like curvature redirect that releases into a propulsive posterior beat as the observed heading response reduces error
transferable_invariant: separate bounded redirect posture from cruise oscillation, gate it by sensed target misalignment, and release it continuously when alignment recovers
nontransferable_details: species-specific C-start shape and timing, published CPG gains, dimensional frequency, exact tail phase, and task-specific route
policy_translation: normalized body-frame bearing and target-vector angle gate a signed head-center and tail-tangent curvature bias plus bounded cadence relief within the two-joint state-feedback oscillator
falsification: reject if the same lower-boundary exit and lateral-bearing growth remain, if closest approach worsens without a useful redirected trajectory, or if cadence relief destroys the coherent thrust wake without reducing actuator clipping
