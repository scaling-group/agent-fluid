# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solver evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and no
  reported numerical instability. The three unmodified reactive-rudder
  evaluations are exactly reproducible, each capturing at `24.337509T` and
  `0.749625L` with mean distance `2.224316L` and score `-0.325566`.
- The sampled terminal-relief rollout (`solver_392ed1eddf30`) is the strongest
  finite result. Its top-down row retains the alternating red/blue caudal
  street and the oblique row shows discrete three-dimensional Lambda2
  structures from rest through capture, so the slightly earlier arrival is
  active self-propulsion rather than advection or wake collapse. It captures
  at `24.326511T` and `0.749329L`, improves mean distance to `2.224097L` and
  score to `-0.325310`, and leaves the measured peak planar force/yaw moment
  unchanged at about `0.03165/0.01638`. Its final full target error is about
  `1.307 rad`, versus `1.324 rad` for the replicated baseline.
- The inherited +20% closing-deficit rudder boost is the clean negative
  response comparison. It matches the baseline until the terminal gate acts,
  then raises mean command norm below `1.5L` from about `42.95` to `43.71`,
  delays capture to `24.414513T`, tightens the crossing to `0.749996L`, and
  worsens mean distance to `2.224632L` without changing peak force or moment.
  Its oblique row is blank, so this comparison supports only the terminal
  trajectory, command, and load interpretation—not a 3D-wake claim.
- The older same-sign posterior C-bend is the informative route-control
  failure. Both visual rows show a coherent, self-propelled wake, but the fish
  curls below and past the target, reaches only `3.692L`, and exits the lower
  boundary at `32.23T`. The successful posterior-load sign and recruitment
  must therefore remain intact; the evidence supports unloading only the
  already active rudder during deficient terminal closure.

## One candidate hypothesis

Promote the evaluated response-scheduled relief policy unchanged as the single
candidate. Joint state continues to generate the traveling carrier, normalized
full target angle and distance retain the capture-producing posterior reactive
load, and normalized closing-speed deficit smoothly removes at most 20% of
that steering channel without suppressing propulsion. This is the smallest
mechanism supported by both sides of the observed response: adding terminal
rudder delayed capture, while releasing it advanced capture and slightly
improved crossing depth, mean distance, terminal alignment, and score.

The result is narrow. Falsify the promotion if it does not reproduce capture
no later than `24.3265T`, if mean distance exceeds `2.224097L`, if its behavior
changes before the terminal gate regime near `1.33L`, or if the coherent wake,
joint-rate occupancy, command effort, peak force, or yaw moment materially
worsens. Do not extrapolate this fixed-pose improvement to other target poses
or hydrodynamic conditions until it replicates; the approximately `0.00067L`
capture margin and large terminal target error remain evidence of fragility.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal approach scheduling
source_mechanism: preserve the rhythmic propulsive carrier while observed task response continuously releases only the steering channel competing with approach
transferable_invariant: separate propulsion from steering allocation near a target and use normalized response feedback to unload an over-commanded steering channel without disturbing the carrier
nontransferable_details: published CPG gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, prescribed maneuver timing, exact vortex phase, and task-specific routes
policy_translation: joint state retains the two-joint traveling carrier; normalized distance, full body-frame target error, and closing-speed deficit gate a bounded reduction of the existing posterior rudder
falsification: reject if capture is later than 24.3265T or lost, mean distance does not remain below 2.224097L, early behavior changes, or wake, saturation, effort, force, or moment envelopes worsen
