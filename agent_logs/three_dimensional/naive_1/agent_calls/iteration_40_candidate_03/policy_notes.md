# Wake-policy diagnosis and single-candidate hypothesis

## Evidence read before the edit

- All four sampled episodes satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and capture.
  The assigned prefill and its executable duplicate capture at
  `22.154001T`, with `0.748384L` crossing distance, `2.105583L` mean distance,
  and score `-0.210952`. The informative predecessor without predictive
  posterior half-cycle scheduling is slightly weaker at `22.159500T`,
  `2.105808L`, and `-0.211168`.
- The sampled bend-phase posterior allocator is the clear finite best. It
  captures at `22.027504T`, lowers mean distance to `2.100432L`, and improves
  score to `-0.206239`. Relative to the assigned prefill, it is already ahead
  at `4/8/12/16/20/21/22T` (`11.293/8.597/6.128/3.946/1.796/1.271/0.765L`
  versus `11.297/8.629/6.148/3.972/1.856/1.333/0.820L`). It also lowers mean
  action from about `59.932` to `59.552`, keeps anterior/posterior exact-rate-
  cap occupancy comparable at about `11.74/6.37%`, and lowers peak normalized
  force/moment from `0.030897/0.015839` to `0.030199/0.015463`.
- The only executable mechanism separating that best sample from the assigned
  prefill is the half-cycle selector for the already capped posterior carrier
  asymmetry. The prefill partitions phase with target-signed anterior joint
  rate; the best sample uses normalized centered anterior bend. Inherited
  diagnostics predicted this result: after `8T`, target-signed yaw moment
  correlates about `0.86` with centered bend but only `0.24` with anterior
  rate, and the bend-side partition separates mean target-signed yaw load by
  roughly `+0.00415/-0.00465` versus `+0.00083/-0.00096` for the rate-side
  partition.
- Inherited controls rule out spreading prediction to anterior redirect or
  posterior recovery, replacing de-yawed line-of-sight rate with full-vector
  target-line rate, adding unqualified yaw-moment residuals, stacking posterior
  angle recovery, unloading the velocity-quadrature recovery near its rate
  cap, and scalar increases to carrier, recovery, or rudder authority. This
  candidate therefore does not combine the successful phase selector with a
  second unvalidated mechanism.

## Visual diagnosis

The complete assigned-prefill and weaker-predecessor sheets show a continuously
beating fish following the same smooth target-directed S-route in quiescent
water. A compact alternating red/blue street forms behind the caudal region by
`4T`, remains attached along the approach, and the oblique rows show separated
three-dimensional Lambda2 structures through head-first capture. This is
self-propulsion, not advection or an inertial coast, and neither comparison
shows collision, domain exit, wake collapse, or instability. The best sample's
top-down row preserves and slightly shortens that route, but its oblique row is
blank; that is a rendering failure, so it cannot independently establish 3D-
wake preservation. Its improved distance history plus lower action and load
peaks nevertheless supports its actuator allocation, while the complete parent
sheet remains the conservative two-view wake bound.

## Exactly one policy hypothesis

Materialize the sampled best architecture from the assigned prefill. Preserve
the full-angle geometry, through-water course loop, all proximity previews,
anterior redirect and speed recovery, posterior recovery allocation, reactive
rudder, terminal relief, carrier, and every authority ceiling. Change only the
phase selector used by the capped posterior asymmetry: infer the target-helping
half-cycle from normalized centered anterior bend instead of anterior joint
rate. Keep the independently evidenced rate-based gate for terminal rudder
relief unchanged. This is one bounded joint-state phase-allocation mechanism,
not scalar tuning or added authority.

The fixed-pose rollout should reproduce capture no later than `22.027504T`,
mean distance no greater than `2.100432L`, and score no lower than `-0.206239`.
Reject the transfer if it changes the smooth S-route adversely, loses a valid
two-view carrier wake, raises mean action materially above `59.552`, raises
anterior/posterior exact-rate-cap occupancy materially above `11.74/6.37%`, or
exceeds peak normalized force/moment `0.030199/0.015463`. A repeat would
establish fixed-pose deterministic confirmation, not robustness to another
pose, inflow, hydrodynamic model, or external wake.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and asymmetric-flapping control
source_mechanism: preserve a traveling propulsive carrier while sensed directional state redistributes bounded posterior effort between oscillation half-cycles
transferable_invariant: use measured body and joint state to allocate existing rhythmic authority to the phase that produces target-signed turning without adding static bend or scalar drive
nontransferable_details: published gains, clock phase, duty ratios, linkage geometry, species-specific kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: retain the bounded predictive target-error envelope and every authority ceiling, but select its posterior helping half-cycle from normalized target-signed centered anterior bend; retain the separately evidenced anterior-rate terminal-relief qualification
falsification: reject if capture is later than 22.027504T, mean distance exceeds 2.100432L, score falls below -0.206239, the route or complete two-view carrier wake degrades, or action, rate-cap occupancy, normalized force, or moment exceed the sampled best bounds
