# Turn-response intercept-preview candidate

## Evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm) and capture in 4567 steps at
  `25.11852 T`. Three independent v29 evaluations reproduce exactly: score
  `-0.5280772274`, mean distance `2.429087214 L`, and final distance
  `0.746135294 L`. The v30 target-opposing-force veto first changes commands
  only at `1.325 L` and regresses slightly to score `-0.5280778498`, mean
  distance `2.429087705 L`, and final distance `0.746135950 L`; instantaneous
  force should not be stacked onto the already supported intercept gate.
- In both the best finite v29 sheet and the informative v30 regression, the
  top-down row shows self-propulsion along the same compact target-directed
  arc with a coherent alternating wake; the oblique row confirms finite
  three-dimensional Lambda2 structures rather than planar advection. The
  terminal body is quiet and does not collide, leave the domain, dwell at a
  joint stop, or lose wake continuity. Metrics agree: below `1.6 L`, v29 has
  peak command `0.243 rad/T^2`, peak planar force coefficient about `0.00219`,
  peak yaw-moment coefficient about `0.000565`, and joint excursion below
  `0.218 rad`.
- The remaining useful discrepancy is kinematic rather than visual wake
  failure. Over the final approach the body yaw rate is consistently negative
  (`-0.241` to `-0.318 rad/T`) and rotates the course toward the target. The
  inherited constant-velocity corridor ignores that achieved response: at
  ranges `1.60/1.20/0.75 L`, its reconstructed miss is approximately
  `0.687/0.457/0.229 L`, while rotating the body-frame course through only
  `0.75` control periods at the measured yaw rate predicts
  `0.527/0.341/0.134 L`. This is distinct from treating residual bearing as
  an isolated yaw error; the sign and magnitude affect only whether the
  existing paired carrier release is earned.

## Policy hypothesis

Replace the straight-course miss used by the optional terminal release with a
bounded constant-turn-response preview. Rotate the normalized body-frame
course by the measured recent yaw over a fraction of one declared control
period, then recompute cross-track miss. Keep the outer oscillator, target
redirect, shared mean bend, settled/closure/crossflow gates, and maximum `3.5%`
coupled two-joint release unchanged. This should make the gate independently
active earlier only when observed turning is already bending the projected
course toward the target; it adds no steering sign, beat-phase choice, joint
role split, force cancellation, world route, or extra authority.

Falsify the mechanism if the outer trajectory or two-view wake changes, the
preview increases miss under helpful yaw, capture is delayed or lost, mean or
final distance regresses, terminal commands exceed the inherited quiet band,
or joint-stop dwell, force/moment growth, instability, or wake degradation
returns.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish CPG control
source_mechanism: release redirect allocation toward propulsion after measured turn response carries the projected path toward the goal
transferable_invariant: an achieved state response, rather than elapsed phase or instantaneous load, should continuously gate release from turning into propulsion
nontransferable_details: species-specific C-start kinematics, published oscillator gains, exact tail-beat phase, dimensional preview time, and task-specific routes
policy_translation: rotate normalized body-frame course through a bounded recent-yaw preview and use the resulting miss only in the existing small coupled response-release gate
falsification: reject if the gate is inactive, helpful yaw does not reduce projected miss, outer motion changes, capture or distance worsens, or terminal action/load/wake stability regresses
