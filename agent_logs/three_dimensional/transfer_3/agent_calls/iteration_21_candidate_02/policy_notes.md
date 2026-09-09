# Energy-neutral response-asymmetry candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders, no prewarm, finite
  dynamics, and capture. The combined sheets for the assigned-parent
  `solver_8c5ed84c4bcd` and the slower response-reversing reference
  `solver_85695f4d40af` were inspected in both views. From release to capture,
  their top-down rows show body-led progress along the broad target route and a
  coherent alternating posterior vortex street rather than passive advection.
  Their oblique rows show compact alternating three-dimensional Lambda2
  packets following the body. Neither view shows a loop, collision, boundary
  exit, or wake collapse; the final frames show continued propulsion into the
  capture circle.
- The assigned parent's actuator-consistency mechanism is a semantic timing
  improvement. It captures at `18.6725T`, mean distance `2.02129L`, and score
  `-0.13362`, versus `18.7990T`, `2.03111L`, and `-0.14330` for the predictive
  actuator-headroom candidate and `18.9310T`, `2.04175L`, and `-0.15357` for
  the replicated response-reversing half-cycle reference. Thus release of
  phase steering at observed beat reversal improves the useful trajectory.
- That timing improvement does not provide load relief. The assigned parent
  has action RMS `24.95/28.85 rad/T^2`, anterior/posterior 99%-limit occupancy
  `42.7%/76.4%`, force/moment RMS `0.01350/0.00703`, and local-flow RMS
  `0.01809U`. The predictive candidate has `24.58/28.62`, `42.0%/74.2%`,
  `0.01315/0.00684`, and `0.01823U`; the demand-lead variant lies between them
  at `75.7%` posterior occupancy and `0.01333/0.00694` loads. Since the visual
  topology and local-flow scale remain alike, increased route timing and
  increased posterior clipping are the actionable distinction.
- The current asymmetry multiplier is `1 + u`, where `u` is the product of
  bounded response direction and observed posterior wave side. It preserves
  the traveling carrier and turns successfully, but symmetric strong/weak
  values have mean square `1 + u^2`; the turning modulation therefore adds
  carrier effort even before the phase actuator is considered. The inherited
  failures rule out curvature redistribution, range-only allocation, terminal
  coasting, and another threshold-only phase-gate edit.

## Policy hypothesis recorded before editing

Start from the assigned-parent actuator-consistent phase controller. Preserve
its normalized body-frame bearing and LOS-rate route request, recoil-conditioned
yaw response, continuous two-joint curvature closure, response-reversing
half-cycle, persistent-same-side phase recruitment, and physical command
projection.

Apply one mechanism at both the baseline and phase-modulated posterior wave:
for the existing dimensionless response-asymmetry signal `u`, replace the wave
multiplier `1 + u` by `(1 + u) / sqrt(1 + u^2)`. For equal and opposite wave
sides, this leaves their strong-to-weak ratio unchanged while making their
pair-averaged squared multiplier one. It is continuous, bounded, parameter-free,
and reflection-equivariant because `u` is invariant when lateral geometry,
yaw response, and joint motion are reflected together. It does not alter the
carrier frequency, route gains, phase-recruitment thresholds, or actuator
limit.

Support requires capture no later than the predictive candidate's `18.799T`
while lowering assigned-parent posterior occupancy below `76.4%` or lowering
force/moment RMS below `0.01350/0.00703`; preserving timing near `18.6725T`
while approaching the predictive candidate's `74.2%` and
`0.01315/0.00684` would establish a Pareto improvement. Falsify the mechanism
if capture is lost, arrival exceeds the replicated half-cycle bound
`18.931T`, the alternating wake visibly weakens, posterior occupancy fails to
fall without an offsetting timing improvement, or force/moment RMS exceeds the
inherited high-pass safety boundary `0.01574/0.00810`. These expectations apply
to the coherent still-water carrier near `0.018U` local flow; no stronger-wake
benefit is claimed.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: apply bounded strong/weak half-cycle modulation around a continuously propulsive traveling rhythm
transferable_invariant: preserve the posterior traveling wave and steering contrast while preventing the asymmetric modulation from inflating pair-averaged carrier intensity
nontransferable_details: published gains, dimensional frequencies, robot geometry, clock phase, species kinematics, exact vortex phase, and task-specific routes
policy_translation: normalize the existing observed response-times-wave-side multiplier as `(1 + u) / sqrt(1 + u^2)` in both posterior target paths while retaining the two-joint state-feedback and actuator-consistent phase gate
falsification: reject if capture is later than `18.931T` or lost, wake coherence weakens, posterior occupancy does not improve without faster timing, or force/moment RMS exceeds `0.01574/0.00810`
