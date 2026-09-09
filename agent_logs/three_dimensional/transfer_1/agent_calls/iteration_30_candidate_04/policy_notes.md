# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- All four sampled solvers satisfy the frozen contract: direct uniform
  initialization at `U_infinity=(0,0,0)`, no prewarm, no cylinders, finite
  dynamics, active moving-window shifts, and capture at `0.7466--0.7494L`.
  I inspected both rows of the combined sheets for the best-scoring sampled
  capture (`solver_6b0e320e2f55`) and the fixed anterior-transfer capture
  (`solver_55f3a103ab95`). Both self-propel while laying down a persistent
  alternating top-down street and bilateral oblique Lambda2 structures through
  arrival; neither is advected, coasting, colliding, or visibly unstable.
- I also inspected both rows for the assigned parent's burden-conditioned
  anterior-transfer failure. It retains the same active wake class through a
  `1.3208L` lower pass and continues swimming to a lower-boundary exit. A second
  independently parameterized burden-conditioned transfer in the inherited
  logs also exits below after reaching `1.1961L`. Thus narrowing spatial share
  transfer by posterior-over-anterior speed/action burden did not make the
  fixed transfer robust and is not a gain-tuning opportunity.
- Trace metrics agree with the visual diagnosis. The assigned-parent failure
  still moves at about `0.841L/T` at closest pass, reaches `0.917L/T` peak
  speed, and remains inside the sampled capture force/moment envelope; returned
  action clips on about `70.2%/70.0%` of rows. The issue remains trajectory
  geometry, not weak propulsion, carrier collapse, load instability, or
  passive transport.
- The lower branch precedes every recent terminal mechanism. At the first
  `10L` crossing, sampled capture head heights are `13.115--13.142L`, whereas
  the seven distinct inherited lower exits are already at `13.058--13.109L`.
  By `6L` the capture family is at `11.753--11.860L` and the failures at
  `11.471--11.679L`. Several failures there have body-frame target angle near
  `-0.3 rad` but achieved-course error near zero because inertial velocity is
  momentarily target-aligned while the body remains side-slipped. Terminal
  release, bearing-recovery, carrier-reserve, wave-shape, yaw-brake,
  mean-curvature, observer, and spatial-allocation edits activated too late or
  retained the same lower exit. The next test therefore changes the outer
  observation architecture rather than another terminal threshold or actuator
  share.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and wake-control separation of slow route motion from fast rhythmic lateral motion
source_mechanism: preserve the posteriorly lagged propulsive rhythm while using bounded body-motion feedback to prevent lateral slip from masquerading as completed direction tracking
transferable_invariant: when inertial velocity already points toward the target, keep a bounded body-to-course alignment request so the route servo cannot go quiet solely because a side-slipping body has the correct instantaneous course
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact oscillator or vortex phase, world-frame routes, and task coordinates
policy_translation: preserve the achieved-course controller and two-joint traveling bend; add a speed-gated body-frame course-angle residual only when normalized target/velocity dot product indicates a strongly aligned approach
falsification: reject if far-field closure changes adversely, the residual retains the lower-branch separation, either wake weakens, capture is lost, or clipping, joint-speed residence, force, or moment leaves the repeat-backed speed-reserve envelope

## One candidate hypothesis

Restore the prefilled intercept-guarded speed-reserve scaffold and do not retain
either burden-conditioned allocator. Add one bounded course-aligned slip
stabilizer inside the guidance module. The existing achieved-course error still
owns route correction. Only after speed is informative and target/velocity
alignment is high, blend in a limited residual with the sign of body-frame
course angle; this asks the body axis to follow an already target-directed
velocity rather than changing the inertial route. The residual fades
continuously when velocity is not target-aligned, so it does not cancel useful
course correction or indiscriminately damp the propulsive lateral rhythm.
Carrier, cadence, posterior lag, response release, steering allocation, and
speed reserve remain unchanged.

Expected test: reduce the evidenced outer lower-branch separation while
preserving the capture family's active two-view wake and terminal controller.
This is an unevaluated CFD hypothesis; a single capture would require exact
repeats and is not claimed as robustness evidence here.
