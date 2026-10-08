# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. Three executable-identical
  target-error-allocation plus line-of-sight-lead policies reproduce exactly
  `22.500492T`, `0.749267L` crossing distance, `2.120233L` scored mean
  distance, and score `-0.225086`. The allocation-only comparison captures at
  `23.122009T`, with `0.749192L` crossing, `2.127679L` mean distance, and
  score `-0.231273`.
- Both visual rows were inspected. The complete composition sheet shows
  self-propulsion rather than advection: the top-down row develops an attached
  alternating red/blue caudal street by `4T` and carries it along the captured
  S-shaped route, while the oblique row shows discrete three-dimensional
  Lambda2 structures behind the caudal region through capture. The other two
  composition repeats and the allocation-only comparison have black oblique
  rows; these are render failures and are not independent 3D-wake evidence.
  No non-capture rollout is present in the current four-solver sample, so the
  allocation-only result is the informative weaker finite comparison. The
  inherited self-motion-course experiment remains the relevant route failure:
  despite a valid coherent two-view wake it missed at `0.813329L` and later
  exited at `6.290125L`, which rules out fitted beat-motion subtraction as an
  explanation for improving this route.
- The composition is identical to allocation-only through the early launch:
  distance is `11.300L` at `4T`, `8.646L` at `8T`, and `7.959L` at `9T`.
  Its bounded de-yawed target-line lead then improves distance progressively,
  to `4.095L` versus `4.134L` at `16T`, `2.002L` versus `2.104L` at `20T`,
  and `0.970L` versus `1.134L` at `22T`. This is evidence that the predictor
  adds a later pursuit response without sacrificing the allocated launch, not
  evidence for increasing rudder magnitude or another scalar terminal gate.
- Compatibility has a measured cost boundary. Relative to allocation-only,
  mean action rises from `58.990` to `59.671`, and anterior/posterior exact
  rate-cap occupancy rises from about `11.68/6.21%` to `11.73/6.38%`.
  Peak normalized force and moment remain exactly at the allocation envelope,
  `0.030527/0.015817`. The full-angle allocator itself had retained the
  whole-carrier recovery's early lead but trailed the phase-only recovery later;
  inherited angle stacking, phase-local redistribution, rate-cap unloading,
  and unqualified moment feedback all regressed that route. A next test should
  therefore change when the fixed quadrature budget moves, not its size.

## One candidate hypothesis

Preserve the reproduced composition's through-water course observation,
anterior speed recovery, full body-frame target geometry, anterior redirect,
phase-selective carrier, line-of-sight-led reactive rudder, and qualified
terminal relief. Introduce one separately named recovery-allocation gate:
apply the existing smooth redirect thresholds to the already computed
line-of-sight-led full target error, and use that gate only for the convex
blend between whole-carrier and velocity-quadrature posterior recovery. Keep
the current-error redirect gate on every steering path. The posterior recovery
share remains `0.12`; the edit neither stacks the quadratures nor changes any
rudder, oscillator, acceleration, angle, rate, or distance limit.

The hypothesis is that the de-yawed target-line trend which reproducibly
improves late rudder recruitment can also anticipate when the fixed posterior
locomotor budget should move from aligned whole-carrier amplitude toward the
phase allocation with the better later route. On the sampled trace the led and
current allocation gates agree during the `4--8T` launch, while the led gate
responds earlier to growing error from about `9T` onward. This should retain
the allocation launch and composition's steering response while reducing the
remaining `12--22T` distance integral. It uses normalized body-frame geometry,
a bounded observed angular-rate residual, and joint state; it adds no clock,
coordinate, route memory, target identity, modeled vortex phase, scalar gain
increase, or fitted self-motion model.

Falsify the mechanism if capture is lost or later than `22.500492T`, scored
mean distance exceeds `2.120233L`, or score does not exceed `-0.225086`.
Also reject it if the `4/8T` distances exceed `11.300/8.646L`, the later
`16/20/22T` advantage disappears, mean action exceeds `59.671`, exact
anterior/posterior rate-cap occupancy exceeds `11.73/6.38%`, peak normalized
force/moment exceed `0.030527/0.015817`, or a valid top-down and oblique sheet
does not retain the established alternating 3D wake. A positive fixed-pose
still-water result would establish predictive allocation compatibility, not
robustness to changed pose, inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a posterior-delayed traveling bend while observed route demand moves one bounded locomotor budget between amplitude-like and phase-like modulation
transferable_invariant: a slowly predicted body-frame steering demand may schedule a mutually exclusive posterior amplitude/phase allocation without increasing total gait authority or disrupting the traveling carrier
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source-task prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: apply the existing bounded de-yawed target-line prediction to a separate smooth gate that only crossfades the evidenced 0.12 posterior recovery budget, while every steering gate and authority limit continues to use its completed signal
falsification: reject if capture is later than 22.500492T or lost, mean distance exceeds 2.120233L, the early allocation lead or late pursuit advantage disappears, or valid two-view wake, action, saturation, force, or moment envelopes worsen
