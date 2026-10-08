# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no instability. The assigned parent captures at
  `22.159500T`, with `0.748393L` crossing distance, `2.105808L` scored mean
  distance, and score `-0.211168`.
- The sampled posterior phase-allocation variant is the only candidate that
  beats the assigned-parent scalar and distance-integral boundaries. Applying
  the already bounded, proximity-grown target-line preview only to the
  posterior half-cycle-asymmetry envelope captures at `22.154001T`, lowers
  crossing/mean distance to `0.748384/2.105583L`, and improves score to
  `-0.210952`. Its launch is unchanged at `4/8T` (`11.300/8.629L`), and its
  complete top-down and oblique sheet preserves the self-propelled alternating
  street and discrete three-dimensional Lambda2 structures through capture.
  Mean action rises modestly from about `59.830` to `59.932`, exact joint-rate
  occupancy remains comparable at about `11.5/6.5%`, and peak normalized
  force/moment remain exactly `0.030897/0.015839`.
- The two anterior-path controls bound the inference. Previewing the anterior
  redirect gate regresses to `22.285997T`, `2.106929L`, and `-0.212075`
  despite slightly lower mean action and unchanged peak loads. Releasing that
  redirect under target-signed yaw moment crosses sooner at `22.093502T` and
  slightly lowers mean distance to `2.105699L`, but its shallow `0.749422L`
  crossing produces the worse `-0.211397` score. Its complete two-view sheet
  confirms that this is allocation loss, not wake collapse. The blank oblique
  row in the anterior-preview sample is a render failure and supplies no 3D
  evidence.
- Inherited logs already rule out more rudder or recovery gain, release-only
  predictive steering, stacking posterior angle amplitude onto the successful
  velocity quadrature, unloading that quadrature near the rate cap, and an
  unqualified yaw-moment residual. The new samples sharpen the boundary:
  target-line prediction is locally useful on the posterior target-side stroke
  allocator, but does not transfer automatically to either anterior path.

## Visual diagnosis

The best sample is self-propelled rather than advected: under zero imposed
flow, a compact alternating red/blue caudal street develops by `4T`, follows
the smooth S-route at `8/12/20T`, and stays coherent at capture. The oblique
row shows separated three-dimensional structures following the beating tail
over the same interval. The response-gated regression has the same visible
route class and complete wake, so the useful difference is not more thrust or
stability. It is the placement of predictive steering within the carrier.

## One candidate hypothesis

Materialize exactly the sampled best architecture from the assigned parent:
retain every anterior course, redirect, recovery, rudder, terminal-relief,
carrier, and authority expression, and use the existing bounded de-yawed
target-line preview only to schedule the magnitude of posterior half-cycle
asymmetry. Preserve instantaneous measured target side and anterior joint
velocity for stroke sign. This is a single state-feedback phase-allocation
mechanism, not scalar-only tuning; it adds no authority, clock, coordinate,
route memory, target identity, prescribed vortex phase, or mutable state.

Because the released fixed-pose case is deterministic, falsify this carry-
forward if it fails to reproduce capture with score at least `-0.210952` and
mean distance at most `2.105583L`, changes the `4/8T` launch, loses the valid
two-view wake, or materially exceeds the observed action, rate-cap, force, or
moment envelope. Replication would establish only fixed-pose still-water
repeatability, not robustness to pose, inflow, hydrodynamics, or external
wakes.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric-flapping control
source_mechanism: retain a rhythmic propulsive carrier while steering through bounded half-cycle effort allocation
transferable_invariant: redistribute existing oscillatory action between target-side and return strokes instead of adding static bend or scalar drive
nontransferable_details: published gains, clocked oscillator phase, robot linkage geometry, species kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target geometry plus bounded de-yawed line-of-sight preview only on the posterior asymmetry envelope; infer stroke side from anterior joint state and retain every established ceiling
falsification: reject if the fixed-pose repeat fails to match the -0.210952 score and 2.105583L mean-distance bounds, changes launch, or worsens the valid two-view wake, action, saturation, force, or moment envelopes
