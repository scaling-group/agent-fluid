# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=[0,0,0]`, no cylinders, finite capture, and moving-window
  transport. The three velocity-quadrature phase-lag candidates reproduce the
  exact `23.122009T` capture, `0.749507L` crossing, `2.133413L` mean distance,
  and `-0.237071` score. The whole-lagged-carrier allocation captures later at
  `23.331013T`, with `2.135772L` mean distance and `-0.239045` score.
- The sampled top-down sheets show self-propelled motion rather than background
  advection: the fish advances through quiescent water while maintaining an
  attached, alternating red/blue street and the established captured S-route.
  The complete oblique rows for `solver_4e1a15b275ab` and
  `solver_663b2207d53d` show discrete three-dimensional Lambda2 structures
  behind the moving body through capture. The blank oblique rows in
  `solver_bd37a8d7a3f9` and the whole-carrier
  `solver_ce62814ff884` are render failures, not evidence that their wakes are
  two-dimensional or absent.
- Numerical diagnostics agree with the visual reading. Reallocating the fixed
  `0.12` posterior recovery share from whole-carrier amplitude to only the
  anterior-velocity quadrature of tail lag is initially behind through about
  `8T`, then ahead over `9--12T`, and reaches `2.029L` rather than `2.158L` at
  `20T`. It also lowers peak normalized force/moment from
  `0.030861/0.016213` to `0.030360/0.015861`, although mean action and exact
  rate-cap occupancy rise. The current trace's measured through-water axial
  speed is below `0.20U` throughout `0--1T`, crosses the `0.20--0.35U` band
  mainly during `1--3T`, and stays above `0.35U` after roughly `4T`.
- Inherited results bound the edit: increasing the scalar recovery gain,
  qualifying whole-carrier recovery with the instantaneous
  `lagged_carrier*qd2` power proxy, adding an angle quadrature, or composing an
  unqualified yaw-moment residual all regress the established capture. The
  steering and terminal gates therefore remain unchanged.

## Policy hypothesis

Keep the evidenced anterior recovery and the total posterior recovery budget
at `0.12`, but allocate that posterior share by measured through-water speed.
At near-zero speed, apply it to the whole lagged posterior carrier, the variant
that has the better early trajectory. Across `0.20--0.35U`, smoothly transfer
the same share into only the anterior-velocity tail-lag quadrature; above that
band the inherited phase-lag allocation is recovered exactly. This is one
state-dependent allocation mechanism, not a gain increase or a clocked startup
stage. It should retain the whole-carrier launch benefit without surrendering
the later traveling-bend route benefit of velocity-quadrature lag.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling posterior bend while feedback reallocates a bounded gait response as locomotor state changes
transferable_invariant: posterior wave shape and lag are distinct actuator allocations, so a bounded recovery budget can move continuously from broad tail recruitment at rest to velocity-quadrature lag once through-water motion is established
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, exact vortex phases, and prescribed startup timing or routes
policy_translation: use normalized body-frame through-water axial speed to crossfade the fixed 0.12 posterior recovery share from whole lagged-carrier scaling below 0.20U to anterior-velocity tail-lag modulation by 0.35U, leaving target geometry, rudder, and carrier phase state-feedback unchanged
falsification: reject if capture is later than 23.122009T or mean distance exceeds 2.133413L, or if the route, alternating three-dimensional wake, action, rate-cap occupancy, peak force, or peak moment exceeds the established phase-lag and whole-carrier envelopes
