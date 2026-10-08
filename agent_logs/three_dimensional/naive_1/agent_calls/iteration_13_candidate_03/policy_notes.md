# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the released experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no numerical instability. The current combined
  sheets contain both required views. Their top-down rows show motion from
  rest toward the target with an alternating red/blue caudal street, and the
  oblique rows show discrete three-dimensional Lambda2 structures through the
  terminal turn. The fish are self-propelled rather than advected or coasting.
- Three independent samples of the assigned-parent reactive-rudder policy are
  exactly reproducible: each captures at `24.337509T` and `0.749625L`, scores
  `-0.325566`, has mean distance `2.224316L`, and uses 4,425 control steps. The
  path closes continuously from the upper right and enters the capture sphere
  from below while the propulsive wake remains active.
- The sampled response-scheduled relief policy is the strongest finite
  example. It is identical to the parent until the closing-deficit gate becomes
  active near the target, then captures two steps earlier at `24.326511T` and
  `0.749329L`. Its score improves to `-0.325310` and mean distance falls to
  `2.224097L`. Anterior/posterior rate-cap occupancy remains essentially
  unchanged at about `14.04/6.92%`; peak planar force and yaw-moment
  coefficients are exactly unchanged at `0.031649/0.016385`; mean command norm
  inside `1.5L` falls slightly from `42.948` to `42.934`.
- The inherited positive-boost ablation supplies the sign boundary: adding up
  to 20% rudder during the same deficient-closure regime delayed capture by 14
  steps and increased terminal effort. The older same-sign posterior C-bend is
  the informative trajectory failure. Its visible wake stays coherent, but it
  passes below the target, reaches only `3.692L`, and exits low at `32.23T`.
  Together these results support reallocating terminal steering, not adding
  whole-body curvature or propulsion gain.

## One candidate hypothesis

Preserve the assigned parent's captured joint-state oscillator, slip-aware
anterior center, full-angle phase-selective redistribution, and normalized
body-frame posterior rudder. Add the sampled response-scheduled terminal
relief as the sole mechanism change. Observed `closing_speed_L` produces a
smooth deficit gate between `0.35` and `0.10 L/T`; that gate removes at most
20% of the already proximity-and-full-error-gated rudder. The far and middle
trajectory are therefore exactly unchanged, carrier propulsion is not
unloaded, and relief disappears when geometry no longer requests the rudder.

The current evidence already supports improvement over the assigned parent.
The next evaluation should reproduce capture no later than `24.326511T`, score
above `-0.325566`, mean distance below `2.224316L`, and the sampled saturation,
effort, force, and moment envelope. Falsify the transfer if capture is delayed
or lost, behavior changes before the terminal gate, or any of those envelopes
worsens materially.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal capture scheduling
source_mechanism: preserve the propulsive rhythm while observed task response continuously recruits or releases only the steering channel responsible for the maneuver
transferable_invariant: near a target, separate propulsion from steering allocation and use normalized response feedback to reduce an over-commanded channel without disturbing the carrier
nontransferable_details: published CPG gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, prescribed maneuver timing, exact vortex phase, and task-specific routes
policy_translation: retain joint-state carrier phase and normalized body-frame target geometry, then let observed closing-speed deficit smoothly remove at most 20% of the already distance-and-error-gated posterior rudder
falsification: reject if capture is delayed or lost, score and mean distance fail to improve over the assigned parent, behavior changes before the terminal gate, or saturation, effort, force, and moment envelopes worsen
