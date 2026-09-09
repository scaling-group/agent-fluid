# Joint-state terminal C-bend release candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot; all remain
  finite to the `100T` horizon. I inspected both the top-down
  mid-plane-vorticity and oblique body/Lambda2 rows in every combined keyframe
  sheet. The fish self-propel and form coherent alternating planar wakes with
  compact three-dimensional structures through repeated turns. Passive
  advection, collision, domain exit, wake collapse, and instability do not
  explain the misses.
- The prefilled parent's continuous course hold is the strongest sampled
  result: `1.241/4.158/2.082L` minimum/mean/final distance and about `0.47T`
  inside `1.25L`. At its late minimum, speed is about `0.669U`, course error is
  `1.692 rad`, course dot is `-0.121`, requested-sign yaw is only about
  `0.129 rad/T`, and commands remain modest. The active anterior joint still
  has `phi_dot_1=-0.260 rad/T`; this is a powered tangential miss with command
  reserve, not a stalled carrier or clipped command.
- The three sampled descendants are concrete negative results. An anterior
  response burst reaches only `2.125/3.901/3.601L`, a target-behind turn-rate
  posterior phase residual reaches `2.137/3.873/3.530L`, and a terminal
  rear-crossing direction blend reaches `2.366/3.875/3.502L`. At representative
  late minima, all three have nearly stationary joints in a common negative
  C-bend (`|phi_dot_1| <= 0.006 rad/T`), whereas the parent retains wave motion
  at its closer pass. Together with inherited failures of a target-behind
  anterior burst and a joint-state posterior stroke, this closes more static
  bend, selector replacement, and posterior phase/stroke authority on this
  scaffold. Frozen-trace locality was not enough to preserve the coupled
  return topology.
- The reusable control gap is therefore not another curvature magnitude or
  drive scalar. The sampled failures indicate that terminal modifications can
  create a hydrodynamically stable, noncapturing C-bend equilibrium. A distinct
  test should preserve the parent's selectors and posterior traveling wave,
  detect bend completion from joint state, and provide a state-released
  anterior unbend rather than waiting indefinitely for yaw response.

## Policy hypothesis

Preserve the parent's oscillator, bearing curvature, posterior brake and lag
modulation, full-direction C-turn, course-response reserve, continuous terminal
hold, wave envelope, posterior equilibrium, all steering magnitudes, and
command limit. Add one reflection-equivariant relaxation mechanism under the
existing terminal selector: when the requested-sign common joint bend is deep
and normalized joint speed is small, shift only the anterior equilibrium by at
most the existing response-curvature reserve toward unbending. As the joints
move, the quiet-state gate releases continuously, so this cannot become a
persistent opposite bend. It introduces no new route, clock, hidden state, or
scalar propulsion retune.

Support requires preservation of the coherent first return plus capture, a
pass below `1.241L`, longer residence inside `1.25L`, or a smaller terminal
loop with improved mean/final distance and comparable clamp/load residence.
Reject if the first return changes materially, the bend-release gate suppresses
the traveling wake, limit/load residence rises, the joints still park, or the
same noncapturing orbit remains.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG control
source_mechanism: a large direction error forms a bounded C-bend, while observed bend completion releases the anterior body into a posteriorly propagated propulsive stroke
transferable_invariant: maneuver engagement and release need different measured conditions; retain the propulsive carrier, then release a completed nearly stationary bend from joint state instead of adding persistent curvature
nontransferable_details: species-specific C-start stages, full-body kinematics, published gains, dimensional beat frequency, clocked CPG phase, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame terminal geometry selects recovery, while requested-sign common bend and normalized two-joint speed gate a bounded anterior equilibrium release within the two-joint state-feedback contract
falsification: reject if cruise or the first return changes, the wake loses coherence, clamp/load residence rises, the joints remain parked, or closest, near-target residence, mean, and final distance retain the noncapturing class
```

## Evaluation boundary

The coupled CFD result is unavailable until this worker exits. Frozen-trace
replay and dry controller probes can establish locality, action scale,
reflection equivariance, parameter ownership, finiteness, and bounds, but not
hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate adds three owned dimensionless thresholds for one joint-state
release gate. It reuses the existing maximum response curvature as the release
bound and changes no steering magnitude, oscillator gain, posterior
equilibrium, lag law, wave envelope, brake, distance selector, course selector,
or command limit. The release direction and completion test are odd/even under
lateral reflection as required, and joint speed continuously removes the
release once motion begins.

Frozen replay over all `18182` completed parent states changes maximum-joint
action by only `0.000075/0.00473 rad/T^2` mean/maximum beyond `3L`, but by
`6.403/8.813 rad/T^2` mean/maximum inside `1.5L`. At the parent's `1.241L`
minimum, the reconstructed frozen-state action changes from approximately
`(0.970,0.868)` to `(9.222,3.483) rad/T^2`. The posterior delta is the
instantaneous result of the preserved lagged-wave target depending on the
released anterior center; its equilibrium and feedback formula are unchanged.
These probes establish an effectively preserved far carrier and material
terminal unbend authority only; they do not predict the coupled trajectory.

All `47` direct parameter references are fields returned by
`target_policy_params()`. Full parent-trace replay remains finite and within
the declared `+/-28 rad/T^2` reserve, and mirrored target, velocity, joint, and
yaw states negate both actions with zero observed residual. The required
material guidance/notes check, lightweight Julia policy contract, and solver
editable-boundary check pass after removing the duplicate assigned-parent
marker from the rendered workspace `README.md`. No formal CFD was run.
