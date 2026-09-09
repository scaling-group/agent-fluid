# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the fish held in the upper-right while the
  four staggered cylinder streets develop and merge around the target
  corridor. This wake is a common release condition, not evidence for a fixed
  phase, cylinder-aware route, or timed control mode.
- All four current sampled rollouts are deterministic semantic copies of the
  same finite success. Their sheets show active upstream swimming with the
  posterior-lagged alternating bend intact: the fish makes an initial redirect
  near the right boundary, traverses left through the interacting wakes,
  executes a compact lower-midcourse fold, and enters the capture circle from
  the right after `123.018` released units. The matching `-11.041L` upstream
  head displacement, despite mean local streamwise flow of only `-0.0630`,
  rules out passive advection as the main source of progress.
- The repeated metrics are `3.5936L` mean distance, `95084` command energy,
  and `0.14287/17.03/334.45` RMS relative crossflow/lateral force/yaw moment.
  The anterior acceleration reaches the `31.416 rad/time^2` cap while the
  joint angles remain below `0.438 rad`, so a scalar drive increase is not
  supported. No current sampled termination failure exists; the informative
  negative contrast is therefore the inherited slower, more highly loaded
  successful topology rather than a fabricated failure comparison.
- Inherited logs separate the actuator mechanism from route residuals. An
  unguarded response on both joints reaches in `130.729` units but costs
  `115750` energy and `0.1543/18.30/359.97` RMS crossflow/force/moment; the
  anterior-only response reaches in `135.019` with `110448` energy and
  `0.1535/18.53/362.61`. The signed-power-guarded two-joint response improves
  arrival, mean distance, effort, and all three load metrics together, and its
  exact reproduction across the current sample confirms that this improvement
  is deterministic for the shared wake snapshot. Earlier unconditioned
  crossflow, lateral-target, bearing-history, tail-lag, and posterior route
  residuals all worsened capture, so this candidate does not append another
  route or wake term.

## Policy hypothesis

Make one actuator-coordination change to the replicated `123.018`-unit
scaffold. Preserve instantaneous body-frame bearing as route owner, positive-
closing-qualified bearing-rate damping, the direct normalized moment
residual, state-inferred half-cycle steering, oscillator regulation, and the
posterior-lagged traveling bend. Replace the two independent signed-power
response gates with one shared gate driven by the normalized total joint power
that action history adds relative to the raw state-feedback command. When the
history term adds net kinetic power, both joints continuously return toward
their raw commands together; when it is neutral or removes net power, both
retain the same response fraction. This tests whether treating the actuator
interface as one coherent traveling-wave pair reduces phase distortion without
introducing a clock, external wake phase, world-frame route, or new residual.

The formal expectation is preserved target capture, roughly `-11L` upstream
translation, and alternating propulsion, with a shorter or less folded
midcourse path and no regression in mean distance, effort, crossflow, force,
or moment. Falsify the mechanism if capture is lost or delayed beyond
`123.018`, the lower fold widens, upstream translation weakens, joint
acceleration cap contact grows, or effort/load fail to improve together. The
new candidate is not CFD-evaluated in this workspace, so these are
expectations, not outcome claims.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish CPG actuator control
source_mechanism: preserve a coherent posterior-lagged traveling wave while sensor feedback shapes actuator continuity
transferable_invariant: history-dependent command shaping for a coupled propulsive wave should retain or release both joint commands coherently according to normalized added kinetic power
nontransferable_details: published gains, servo time constants, linkage geometry, species-specific kinematics, dimensional beat settings, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: preserve normalized body-frame route and yaw-load feedback, sum the two normalized signed lag-power contributions, and use one bounded state-feedback weight for both previous-action responses
falsification: reject if capture, upstream translation, or the alternating bend is lost, if arrival or mean distance regresses beyond the replicated parent, or if effort, loads, cap contact, and trajectory folding do not improve together
