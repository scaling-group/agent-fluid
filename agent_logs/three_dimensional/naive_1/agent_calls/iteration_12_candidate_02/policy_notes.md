# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the released experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no numerical instability. The current combined and
  view-specific oblique sheets are black apart from frame labels, so they do
  not support a Lambda2 or three-dimensional wake claim. The top-down sheets
  remain usable and show self-propelled motion with an alternating red/blue
  caudal street that develops from rest and follows the fish to capture.
- Three independent evaluations of the prefilled reactive-rudder policy are
  exactly reproducible: each captures at `24.337509T` and `0.749625L`, scores
  `-0.325566`, has mean distance `2.224316L`, and uses 4,425 control steps.
  The top-down path closes continuously through a compact terminal turn; this
  is a semantic success over the inherited `3.692L` lower-exit topology.
- `solver_666b72f43d6a` is the informative negative comparison. It preserves
  the same controller but multiplies the proximity-and-error-gated posterior
  rudder by up to `1.20` whenever observed closing speed falls from
  `0.35L/T` toward `0.10L/T`. Its trace is identical to the successful parent
  until `22.6325T` at `1.3257L`, then it captures 14 steps later at
  `24.414513T`; score falls to `-0.325802` and mean distance rises to
  `2.224632L`. At `24T` it remains about `0.00249L` farther from the target.
  Mean command norm below `1.5L` rises from about `42.95` to `43.71`, while
  peak planar force/yaw-moment coefficients remain essentially unchanged at
  `0.03165/0.01638`. More posterior steering during the closure deficit is
  therefore the wrong allocation, not missing authority.

## One candidate hypothesis

Preserve the reproducible captured carrier, slip-aware anterior center,
full-angle half-cycle redistribution, and distance/error-gated posterior
rudder. Add exactly one response-scheduled terminal mechanism: reuse the
sampled normalized closing-deficit gate, but smoothly unload rather than boost
the posterior rudder, by at most 20%. This leaves the full far and middle
trajectory unchanged and preserves the propulsive carrier. It tests the
evidence-backed interpretation that the final radial slowdown is caused by
excess steering allocation; deficient closure should release some rudder
authority instead of adding more lateral load.

The mechanism is falsified if capture is lost or occurs no earlier than
`24.3375T`, score does not exceed `-0.325566`, the trajectory changes before
the sampled gate regime near `1.33L`, or terminal saturation, command effort,
force, or yaw moment exceed the reproduced capture envelope. Because the
oblique evidence is black in this workspace, later evaluation must also
restore a visible oblique sheet before making any three-dimensional wake
coherence claim.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal capture scheduling
source_mechanism: preserve the rhythmic propulsive carrier while observed task response continuously recruits or releases only the steering channel responsible for the maneuver
transferable_invariant: near a target, separate propulsion from steering allocation and use normalized response feedback to reduce an over-commanded channel without disturbing the carrier
nontransferable_details: published CPG gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, prescribed maneuver timing, exact vortex phase, and task-specific routes
policy_translation: retain joint-state carrier phase and body-frame geometry, then let normalized closing-speed deficit smoothly remove at most 20% of the already gated posterior rudder; the relief sign is selected by the sampled positive-boost finite difference
falsification: reject if capture is delayed or lost, score and mean distance do not improve, behavior changes before the terminal gate, or saturation, effort, force, and moment envelopes worsen
