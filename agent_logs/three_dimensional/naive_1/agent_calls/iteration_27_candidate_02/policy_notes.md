# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. The two whole-carrier
  posterior-recovery samples reproduce `23.331013T`, `0.749672L` crossing,
  `2.135772L` scored mean distance, and score `-0.239045`. The two sampled
  phase-lag reallocations reproduce the better `23.122009T`, `0.749507L`,
  `2.133413L`, and `-0.237071` result.
- The inspected representative sheets (`solver_8d6cd2d6a3b7` for the assigned
  parent and `solver_4e1a15b275ab` for phase-lag recovery) contain both views.
  Their top-down rows show self-propelled motion along the same useful S-shaped
  approach with an attached alternating red/blue caudal street from formation
  through capture. Their oblique rows show discrete three-dimensional Lambda2
  structures at release, `4T`, `12T`, `20T`, and capture. The phase-lag route
  is behind through `8T`, crosses ahead between `9T` and `12T`, reaches
  `1.0955L` rather than `1.1916L` at `22T`, and finishes with full heading
  error `0.786` rather than `1.042 rad`; the improvement is traveling-bend and
  route allocation, not faster startup or wake collapse.
- The phase-lag result lowers early and near-target mean action from
  `79.968/44.015` to `79.110/43.656` and peak normalized force/moment from
  `0.030861/0.016213` to `0.030360/0.015861`, but total mean action rises from
  `59.044` to `60.062` and anterior/posterior exact-rate-cap occupancy rises
  from about `11.34/6.27%` to `11.92/7.06%`. On its recorded trace, the
  through-water recovery gate is active through about `4.49T`; `209` of `664`
  active samples have posterior rate above 75% of the cap and `124` are above
  95%. A smooth release of only the added phase-lag share from 80% to 100% of
  the cap would have retained about 90% of its recovery-weighted magnitude on
  that trace. This replay establishes scale and activity, not a closed-loop
  CFD prediction.
- The inherited course-aligned angle-quadrature composition is the nearest
  informative negative. It partly recovers the phase-lag policy's early
  distance deficit and lowers mean action and rate-cap occupancy, but captures
  later at `23.265013T`, raises mean distance to `2.137810L`, and scores
  `-0.241061`; by `10T` its route advantage is gone. The older unqualified
  adverse-moment composition likewise retains capture and its top-down street
  but regresses to `23.853519T/2.194872L`. Its oblique row is a black render
  artifact, so it cannot support a separate 3D-wake claim. These controls rule
  out adding another thrust quadrature or fast load residual merely because it
  reduces effort or was independently plausible.

## One candidate hypothesis

Adopt the sampled phase-lag recovery policy as the complete route, carrier,
reactive-rudder, and terminal baseline. Add one bounded actuator-headroom
mechanism only to the *incremental* `0.12` speed-deficit phase-lag share: retain
it fully while measured posterior joint rate is below 80% of the fixed rate
envelope, then release it smoothly to zero at the rate cap. The base posterior
lag, anterior recovery, mean curvature, phase-selective steering, rudder, and
terminal relief remain active, so the policy does not coast or suppress the
evidenced traveling carrier. This uses normalized joint state and the existing
body-water locomotor-deficit observation; it introduces no clock, coordinate,
route memory, global direction, exact vortex phase, or scalar gain increase.

Falsify the rate-headroom allocation if capture is lost or later than
`23.122009T`, scored mean distance exceeds `2.133413L`, the late distance lead
or `0.786 rad` terminal alignment benefit disappears, or a complete evaluation
shows degraded S-route or three-dimensional wake. Also reject it if total mean
action does not fall below `60.062` or posterior cap occupancy does not fall
below `7.06%` without worsening the `79.110/43.656` early/near action,
`11.92%` anterior cap occupancy, or `0.030360/0.015861` peak force/moment
envelope. A fixed-pose still-water improvement would establish constrained
phase-allocation compatibility, not robustness to changed pose, inflow, or
hydrodynamics.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-delayed traveling bend for reactive thrust while using measured actuator state to modulate only incremental rhythmic recruitment
transferable_invariant: retain the state-feedback carrier and release added posterior phase-lag recovery smoothly when normalized posterior joint rate shows that actuator headroom is exhausted
nontransferable_details: published gains, dimensional frequencies and speeds, distributed-body envelopes, species-specific kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: keep the sampled body-water speed-deficit addition to posterior velocity quadrature, but multiply only that added share by a smooth headroom gate that is one below 80% of the posterior rate limit and zero at the limit
falsification: reject if capture is later than 23.122009T or lost, mean distance exceeds 2.133413L, late alignment or complete wake degrades, or total action and posterior rate-cap occupancy fail to improve within the sampled force and moment envelope
