# Actuator-consistent posterior phase candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. In the strongest (`solver_625a1e7347f1`) and least
  efficient (`solver_3ca4e16bfde3`) combined sheets, the top-down rows show
  body-led motion with coherent alternating posterior vortex streets from
  release through capture. The oblique rows independently show compact paired
  three-dimensional Lambda2 structures following the fish. Neither sheet
  shows passive advection, wake collapse, a loop, collision, or boundary exit.
- The predictive-headroom phase gate is the strongest sampled candidate. It
  captures at `18.7990T`, improves mean distance to `2.0311L`, and scores
  `-0.14330`. Its action RMS is `24.58/28.62 rad/T^2`, anterior/posterior
  99%-limit occupancy is `42.0%/74.2%`, force/moment RMS is
  `0.01315/0.00684`, and local-flow RMS is `0.01823U`. This improves both
  timing and posterior realization relative to the ungated half-cycle case
  (`18.9310T`, `2.0418L`, `76.4%` posterior occupancy,
  `0.01357/0.00707` force/moment RMS).
- The assigned-parent previous-action gate independently captures at
  `18.8925T`, mean distance `2.0378L`, with `74.5%` posterior occupancy and
  `0.01312/0.00683` force/moment RMS. Thus predicted demand and realized
  previous action are both useful actuator-state cues. In contrast, the
  always-active fixed-norm rotation captures at `18.9970T` and mean distance
  `2.0480L`: more phase exposure is not itself an improvement.
- The inherited high-pass failure remains the safety boundary: a clipped route
  missed by `1.845L`, exited left, and reached `76.4%` posterior occupancy with
  `0.01574/0.00810` force/moment RMS. Earlier curvature reallocation,
  near-range release, and terminal coasting either slowed capture or recreated
  miss/loop topologies. Continuous LOS-rate guidance, distributed C-bend,
  response-reversing half-cycle authority, and the coherent carrier therefore
  remain unchanged.

## Policy hypothesis recorded before editing

Start from the sampled predictive-headroom candidate. Preserve its normalized
body-frame bearing and LOS-rate route request, recoil-conditioned yaw response,
continuous two-joint curvature closure, response-reversing half-cycle, fixed-
coefficient-norm posterior phase rotation, and explicit physical projection.

Add one actuator-state distinction to the phase gate. Normalize the current
unclipped baseline posterior acceleration and `previous_action[2]` by the owned
physical acceleration limit. Their signed product is positive only when the
current demand continues on the same actuator side as the realized previous
command; clipping magnitude makes the product approach one. Multiply the
existing predictive activation by the positive part of this product. Phase
steering therefore remains strong under persistent same-side saturation but
releases at beat reversals or when realized action has headroom. This uses no
clock, hidden state, new gain, route coordinate, range schedule, or exact
vortex phase, and the signed-product gate is invariant under reflection.

Support requires capture no later than the replicated half-cycle lower bound
`18.931T`, preferably preserving the predictive candidate's `18.799T` timing,
while reducing posterior occupancy or load below its `74.2%` and
`0.01315/0.00684` values. Falsify the mechanism if capture is lost, arrival
exceeds `18.931T` without a material load reduction, the alternating wake
weakens, posterior occupancy exceeds `76.4%`, or force/moment RMS exceeds
`0.01574/0.00810`. Current local-flow RMS is only about `0.018U`, so no strong-
disturbance benefit is claimed without later wake-bearing evidence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and posterior phase-lag steering
source_mechanism: sensory state gates posterior oscillator timing while the propulsive traveling rhythm remains active
transferable_invariant: retain the carrier and apply bounded posterior timing changes only while observed actuator response remains consistent with the current route-response demand
nontransferable_details: published gains, clock phase, robot geometry, species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: multiply the normalized body-frame predictive-headroom phase gate by positive same-sign stress from unclipped posterior demand and observed previous posterior action, then retain the existing two-joint state-feedback law
falsification: reject if capture is lost or later than 18.931T without material load relief, wake coherence degrades, posterior occupancy exceeds 76.4%, or force/moment RMS exceeds 0.01574/0.00810
