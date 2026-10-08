# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled episodes satisfy the released direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics,
  and `capture` termination. The assigned parent and its executable-equivalent
  sample capture at `22.154001T`, with `2.105583L` mean distance and
  `-0.210952` score. The weaker fixed-phase comparison captures at
  `22.159500T`, `2.105808L`, and `-0.211168`.
- The sampled bend-phase posterior allocator is the clear finite best. It
  advances capture to `22.027504T`, lowers mean distance to `2.100432L`, and
  improves score to `-0.206239`. It also lowers mean action from about
  `59.932` to `59.552` and peak normalized force/moment from
  `0.030897/0.015839` to `0.030199/0.015463`; anterior/posterior exact-rate-cap
  occupancy remains comparable at about `11.74/6.37%` versus
  `11.49/6.41%`. This is a phase-allocation improvement, not a scalar authority
  increase.
- The combined sheets were inspected in both views. The strongest sample's
  top-down row shows the same self-propelled S-route and compact alternating
  mid-plane street from startup through capture, with slightly better
  distances already at `4/8T` (`11.296/8.597L` versus
  `11.300/8.629L`). Its oblique row is blank and is therefore a render failure,
  not evidence of either 3D-wake preservation or collapse. The informative
  weaker comparison has a complete oblique row: discrete three-dimensional
  Lambda2 structures follow the continuously beating body to capture. That
  complete row remains the 3D-wake bound for carrying the otherwise unchanged
  controller forward.
- The only substantive sampled-best edit is to select the already capped
  posterior half-cycle envelope from normalized target-signed anterior carrier
  bend rather than anterior joint rate. The inherited retrospective load
  partition supports that selector: centered bend separated helping/opposing
  target-signed yaw moment at about `+0.00415/-0.00465`, compared with only
  `+0.00083/-0.00096` for the rate partition. The sampled result validates the
  body-state phase translation without introducing direct moment feedback.
- A reconstructed check of the sampled traces does not support the assigned
  parent's proposed full-angle/folded-bearing approach blend: while the target
  stays ahead through capture, the two angles are numerically identical. That
  edit would be trajectory-inert on the available evidence, so it is not added
  to this candidate.

## One candidate hypothesis

Materialize the sampled bend-phase controller exactly as the one candidate.
Preserve the traveling carrier, through-water course loop, anterior redirect
and speed recovery, fixed-lead posterior recovery allocation, reactive rudder,
terminal relief, and all authority ceilings. Change only the posterior
half-cycle selector from target-signed anterior rate to target-signed centered
anterior bend; retain the independently evidenced rate selector for terminal
rudder relief. The fixed-pose expectation is deterministic reproduction of a
capture no later than `22.027504T`, mean distance no greater than `2.100432L`,
and score no lower than `-0.206239`. Falsify reuse if a complete future oblique
sheet loses the established three-dimensional structures, or if route, action,
rate occupancy, force, or moment exceeds the sampled bounds.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and asymmetric flapping
source_mechanism: redistribute a continuing propulsive rhythm across an observed target-helping body-state half-cycle
transferable_invariant: select bounded oscillatory steering allocation from measured joint state and body-frame target side while preserving the traveling carrier and peak authority
nontransferable_details: published gains, clock phase, duty ratios, robot linkage geometry, species-specific kinematics, exact vortex phases, dimensional routes, and task coordinates
policy_translation: use normalized target-signed centered anterior bend to select only the existing posterior asymmetry envelope; keep target geometry, joint-rate terminal relief, carrier, recovery, and rudder paths unchanged
falsification: reject if capture is later than 22.027504T, mean distance exceeds 2.100432L, score falls below -0.206239, or complete two-view evidence shows worse route, wake, action, saturation, force, or moment
