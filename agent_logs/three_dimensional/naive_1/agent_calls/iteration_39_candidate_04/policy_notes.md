# Wake-policy candidate notes

## Visual and numerical diagnosis before the policy edit

- All four sampled rollouts satisfy the released direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and terminate in
  capture at exactly `22.154001T`, with `0.748384L` crossing distance,
  `2.105583L` scored mean distance, and score `-0.210952`. Three policies are
  executable-identical to the prefill. The fourth extends proximity preview
  into posterior recovery allocation but produces the same trajectory,
  actions, loads, and score, so that added gate is behaviorally inactive on
  the encountered route rather than an improvement to preserve.
- Both visual rows were inspected before this edit. The complete combined
  sheets for `solver_d1fa01b2365d` and `solver_e00ec3b50664` show a
  self-propelled S-route: an alternating red/blue mid-plane street forms by
  `4T`, stays attached to the beating posterior body, and persists through
  capture, while the oblique row shows discrete three-dimensional Lambda2
  structures at `4/12/20T` and crossing. The combined sheets for the other
  two samples have the same top-down route but black oblique panels after the
  labels. Those are render-evidence failures and are not independent 3D-wake
  confirmation.
- The repeated parent envelope is finite rather than bang-bang: mean action is
  `59.932`, anterior/posterior exact-rate-cap occupancy is about
  `11.49/6.41%`, and peak normalized force/moment are
  `0.030897/0.015839`. The route passes below the target before curling back:
  distance falls to `8.629/6.148/3.975/1.859/0.820L` at
  `8/12/16/20/22T`, while the head reaches about `y=8.38L` near `19T`
  versus the target at `9.5L`. The useful remaining question is therefore
  route/phase allocation, not propulsion recovery, stability, or stronger
  scalar authority.
- Inherited optimizer logs provide matched negative controls. Previewing the
  anterior redirect delays capture to about `22.258--22.286T`; releasing that
  redirect under target-signed instantaneous moment lowers mean action but
  worsens mean distance/score without lowering peak load; and replacing the
  successful historical half-cycle preview by an instantaneous full-vector
  target-line-rate proposal later scores only `-0.211406`. Together with the
  sampled recovery-preview equivalence, these results rule out another
  preview, moment-release, recovery-gate, or scalar-gain variant.

## One candidate hypothesis

Preserve the prefilled through-water course loop, full body-frame target
geometry, anterior recovery and redirect, fixed-lead posterior recovery,
proximity-led reactive rudder, terminal relief, traveling carrier, and every
authority ceiling. Add one bounded observation-to-phase allocation: when the
existing slow through-water course request and instantaneous target-side
request agree, use normalized proximity to recruit only 25% of the unused
posterior half-cycle-envelope headroom. Retain instantaneous target lateral
position for steering sign and anterior joint velocity for stroke phase.

This transfers the already useful course observation to a complementary
posterior phase path without stacking angle amplitude or increasing the
half-cycle ceiling. Offline reconstruction on the recorded parent states says
the added path is exactly zero before proximity opens, first differs near
`8.89T`, and never activates with an opposing course/target sign. It should
start correcting the below-target course before full body-pointing error alone
recruits the phase envelope, while preserving the launch and coherent carrier.

Falsify the mechanism if capture is later than `22.154001T`, mean distance
exceeds `2.105583L`, score falls below `-0.210952`, the unchanged `4/8T`
launch or preterminal S-route degrades, or a complete two-view evaluation
exceeds mean action `59.932`, anterior/posterior rate-cap occupancy
`11.49/6.41%`, or peak normalized force/moment `0.030897/0.015839`. A positive
fixed-pose still-water result would not establish robustness to changed pose,
inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric-flapping control
source_mechanism: preserve a traveling propulsive rhythm while measured course error allocates a bounded share of steering to the turn-helping half-cycle
transferable_invariant: a normalized body-frame translation error may recruit unused oscillatory steering headroom only when it agrees with current target side, while joint state retains stroke phase and the established carrier remains intact
nontransferable_details: published gains, clock phase, robot linkage geometry, species-specific envelopes, dimensional timing, exact vortex phase, fixed coordinates, and task-specific routes
policy_translation: within the established proximity envelope, use agreement between the bounded through-water course request and instantaneous target-side request to recruit one quarter of otherwise unused posterior half-cycle-envelope headroom, retaining all existing signs and ceilings
falsification: reject if arrival or mean distance fails to beat 22.154001T/2.105583L, or if launch, route, complete two-view wake, effort, saturation, force, or moment leaves the sampled parent envelope
