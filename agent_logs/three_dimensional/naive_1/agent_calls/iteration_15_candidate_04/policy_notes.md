# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the released direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, capture
  termination, and no reported instability. Their byte-identical trajectories
  capture at `24.326511T` and `0.749329L`, with mean distance `2.224097L`,
  score `-0.325310`, and 282 moving-window shifts. The common top-down sheet
  shows continuous self-propelled approach behind an alternating red/blue
  caudal street. Three complete oblique sheets show discrete three-dimensional
  Lambda2 structures through capture. `solver_d802465f301b` has the identical
  top-down and numerical evidence but a blank oblique row, which is a render
  failure rather than contrary wake evidence.
- The assigned parent's velocity-alignment replacement remains a capture, but
  takes 4,428 steps and crosses at `0.749543L`, versus 4,423 steps and
  `0.749329L` for the sampled one-step closing-deficit relief. The inherited
  bearing-response replacement is weaker again at 4,437 steps and
  `0.749983L`. These are concrete negative results: replacing the successful
  trigger with a smoother translation or bearing signal does not improve this
  fixed-pose approach, even though each preserves the termination class.
- Reconstructing the existing gates on the replicated trajectory provides a
  narrower hypothesis. Below `0.9L`, the closing-deficit gate has correlation
  about `0.64` with the already computed target-side anterior half-cycle gate;
  its mean is about `0.87` on that half-cycle and `0.33` on the return. This
  cannot prove causality from a replayed trace, but it shows that the successful
  beat-scale sensor is not acting like broad terminal damping. The current
  relief already concentrates on one joint-observed stroke phase while the
  complete sheets retain the traveling wake.
- The older same-sign posterior C-bend and recent-yaw unloading remain the
  informative behavioral failures from inherited logs: the former produced
  wrong-sign mean yaw and a lower exit, while the latter decayed into an
  inertial coast. The capture-producing posterior-rudder sign, joint-state
  carrier, and carrier amplitude therefore remain unchanged.

## One candidate hypothesis

Keep the replicated one-step closing-deficit gate and its tested 20% posterior
rudder-relief ceiling, but multiply the relief by the existing smooth
target-side anterior half-cycle gate. This is a phase-allocation change, not a
gain retune: deficient closure can release the posterior mean offset on the
stroke where the sampled gate already concentrates, while the return stroke
retains full rudder authority. The joint-state traveling carrier, anterior
redirect, posterior carrier scale, rudder sign, distance/error recruitment,
and all numerical parameter values remain intact. The multiplication is
bounded and reflection equivariant because target-side sign and joint-rate
sign reverse together.

Falsify the candidate if it loses capture, arrives later than `24.326511T`,
raises mean distance above `2.224097L`, or materially worsens terminal target
error, action effort, rate-cap occupancy, the established normalized
force/moment envelope near `0.03165/0.01638`, or the coherent top-down and
complete oblique wake. Also reject the phase interpretation if the rollout
differs before the existing closing-deficit gate first activates; one fixed-pose
success would still not establish held-out robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and half-cycle asymmetry
source_mechanism: preserve a rhythmic propulsive carrier while sensory response reallocates a bounded steering offset by observed stroke phase
transferable_invariant: separate propulsion from steering and retain steering relief only on the joint-observed half-cycle where the measured response indicates competing load
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional frequencies, duty ratios, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: multiply the existing normalized closing-deficit relief by the smooth reflection-equivariant gate formed from target-side sign and anterior joint velocity; leave carrier phase and amplitude untouched
falsification: reject if capture is later than 24.326511T or lost, mean distance exceeds 2.224097L, early behavior changes, or wake, saturation, effort, force, or moment envelopes worsen
