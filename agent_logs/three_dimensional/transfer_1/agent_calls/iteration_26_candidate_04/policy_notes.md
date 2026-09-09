# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled rollouts and the assigned-parent rollouts use direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm. Their translation and wake formation are self-propulsion rather
  than ambient advection or inherited-flow artifacts.
- I inspected both rows of all four sampled combined keyframe sheets and the
  assigned parent's latest failure sheet. The three exact speed-reserve
  captures and its exact-byte failure all retain a strong alternating
  top-down vortex street and compact oblique three-dimensional wake structures
  through closest approach. The failure continues beating and self-propelling
  to the lower boundary; there is no carrier collapse, collision, or numerical
  instability to repair.
- The exact speed-reserve samples capture at `0.7466--0.7494L` after
  `18.320--18.601T`, but the assigned parent's exact-policy replay passes at
  `1.5478L` and exits below. At closest approach its speed is `0.820L/T`, peak
  force and moment are `0.0306` and `0.0158`, and action clamps on about
  `70.2%/71.8%` of rows; these overlap the captures' `0.827--0.862L/T`,
  `0.0309--0.0315`, `0.0160--0.0164`, and `68.4--68.7%/70.6--71.0%` ranges.
  Propulsion, load, and gross steering authority therefore do not explain the
  failure.
- The useful difference precedes the existing `2.75L` intercept gate. At the
  first `4L` crossing the failed head is at `y=10.605L`, versus
  `10.952--11.004L` in the three exact captures; at `3L` it is at `10.056L`,
  versus `10.551--10.623L`. Across the approaching `4--3L` band, the failed
  rollout's instantaneous achieved-course command has a mean turn request of
  about `+0.58`, versus `+0.09--+0.31` in the captures. Its direct target-
  bearing request is smaller (`+0.41--+0.59`) and does not contain the extra
  velocity-course discrepancy. This supports changing the terminal outer-loop
  observation before the lower branch, not adding route gain or suppressing
  the traveling bend.
- The inherited course-convergence guard (`1.4503L` miss), phase-compensated
  course observer (`1.5445L` miss), and mean-curvature servo (`1.8818L` miss)
  all retained active wakes but did not recover capture. Their evidence rules
  out another release veto, joint-phase correction scalar, or steering-
  realization add-on for this candidate.

## One candidate hypothesis

Preserve the exact traveling-bend carrier, cadence, response-conditioned
intercept guard, additive two-joint steering allocation, and sparse outward-
carrier reserve. Change only the route observation: outside `6L`, retain the
repeat-backed achieved-course error; from `6L` inward, smoothly blend toward
the normalized body-frame target bearing, reaching direct bearing guidance by
`3L`. This removes the instantaneous velocity-course term before the evidenced
lower-branch divergence while retaining target-conditioned feedback and every
evaluated propulsion and actuation mechanism.

The hypothesis is that direct bearing is unsuitable for far-field acquisition
but is the less phase-sensitive terminal observable once broad acquisition is
complete. The candidate should preserve the far wake and closure, reduce the
excess steering request in a low-running approach, and enter the existing
intercept gate from the capture-backed upper corridor. Falsify it if the path
changes outside `6L`, any exact replay loses capture or retains the lower-exit
topology, either wake view weakens, terminal speed falls, or clipping and loads
leave the sampled baseline envelope. Do not answer a miss by tuning only the
blend distances or stacking the rejected phase, yaw, projected-miss, or
mean-curvature mechanisms.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal capture control
source_mechanism: keep the propulsive rhythm active while the outer-loop directional observation changes continuously from broad course regulation to direct near-target alignment
transferable_invariant: rhythmic propulsion and terminal target alignment can share the same carrier while using distinct distance-appropriate task errors
nontransferable_details: published gains, dimensional distances, clock-driven CPG phase, robot or species kinematics, exact vortex phases, and prescribed routes
policy_translation: blend the achieved-course residual into normalized body-frame target bearing over a distance gate, then send the resulting bounded request through the unchanged two-joint traveling-bend and steering contract
falsification: reject if far-field closure changes, capture is lost or remains threshold-fragile, the lower branch persists, either wake view weakens, or speed, clipping, force, or moment leave the evaluated baseline envelope
