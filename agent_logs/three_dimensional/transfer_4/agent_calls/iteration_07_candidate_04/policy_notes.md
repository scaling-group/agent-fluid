# Rate-headroom steering-allocation candidate

## Visual and quantitative diagnosis before the policy edit

- The assigned parent guidance, all sampled solver evidence, and inherited
  optimizer logs were read before editing. Every rendered rollout reports
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and capture. Three byte-identical copies of the strongest
  selective rate-governor policy score `-0.51274776` and capture at
  `23.3640T`; the prefilled cadence policy captures one `0.0055T` step earlier
  but has a worse mean score-distance (`2.412601L` versus `2.409486L`) and score
  (`-0.51527750`). The repeated strongest result is determinism evidence, not
  evidence for three mechanisms.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the strongest sampled rate governor, the weaker prefilled capture, and the
  inherited gait-yaw projection regression. In each top-down row the fish
  self-propels from quiescent water along a broad target-directed curve while
  shedding an alternating posterior wake; no background advection, collision,
  wake collapse, or numerical instability appears. The oblique rows retain
  compact three-dimensional posterior structures through the final turn. No
  semantic failure sheet exists in the sampled solver population, so the
  slower inherited captures are the informative mechanism failures rather
  than a fabricated domain-exit comparison.
- The inherited negative results rule out another carrier-energy reduction as
  the useful next test. Rate-headroom cadence suppression, positive-power
  gating, shared velocity damping, and a joint-load carrier gate all preserve
  capture but regress score to roughly `-0.523` through `-0.622`; the inherited
  gait-yaw projection is worse still at `-0.62377`, `24.4090T`, and
  `2.522887L` mean score-distance. These changes retain visually similar wakes,
  so neither lower rate residence nor removal of gait-synchronous yaw is an
  improvement when target progress is lost.
- The strongest trace instead exposes complementary instantaneous steering
  headroom. The two joint rates have opposite signs for `65.91%` of samples;
  exactly one joint exceeds `80%` of the owned rate envelope for `52.66%`, and
  at least one exceeds the governor's `96%` onset for `19.26%`. Thus a common
  steering sign often accelerates one joint while reversing the other, yet the
  current fixed `0.70/1.00` steering split is applied before the downstream
  rate governor discards speed-increasing acceleration.

## One candidate mechanism

Start from the strongest sampled signed-curvature rate governor, preserving
its target geometry, odd curvature polarity, traveling-wave carrier, cadence,
posterior lag, approach behavior, and full rate-reversal authority. Add one
bounded actuator-allocation mechanism inside the existing steering residual:
reuse the owned normalized-rate proximity and steering direction to lower the
allocation availability only for a joint whose steering contribution would
increase its near-limit signed speed, then renormalize the two positive shares
to preserve their total steering acceleration. Availability retains a
positive floor, and when neither joint is constrained the exact established
`0.70/1.00` split is recovered. Carrier acceleration and the downstream rate
governor are unchanged.

Expected result: retain capture and the coherent traveling wake while reducing
steering authority discarded by the governor, tightening the broad closing
course or lowering distance integral without attenuating propulsion. Reject
the mechanism if capture, reflected steering polarity, or wake coherence is
lost; if the route/path, arrival, mean distance, force/moment scale, joint
limits, or command switching worsen materially; or if rate-limited steering
residence changes without a target-progress benefit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and residual path control
source_mechanism: apply bounded route-level steering around a coordinated rhythmic carrier and condition that residual on sensed actuator state
transferable_invariant: preserve the coupled traveling-wave carrier while allocating a slow body-frame steering residual toward available actuator authority
nontransferable_details: published CPG gains, dimensional cadence, robot or species kinematics, prescribed phase, exact vortex timing, and task-specific routes
policy_translation: use each observed joint rate normalized by the policy-owned envelope and the sign of the existing turn residual to redistribute its fixed total across the two acceleration commands before the proven rate governor
falsification: reject if capture or the alternating two-view wake is lost, reflected polarity breaks, discarded steering does not fall, or distance integral, path, arrival, loads, limits, or switching worsen materially
