# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- The assigned parent and all four sampled rollouts satisfy the released
  direct-uniform still-water contract: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, and finite `left_domain` termination. The combined and view-specific
  sheets show self-propulsion rather than advection. Their top-down rows develop
  persistent alternating vortex streets, and their oblique rows retain
  tail-connected three-dimensional Lambda2 structures through the final
  excursion. The missing capability is therefore route response, not wake
  production.
- The most informative sampled failure (`solver_37a652a3989e`) keeps the full
  anterior carrier and reaches `4.162L` at `17.51T`, but then recedes to
  `6.363L` and exits through the upper boundary at `23.36T`. At closest
  approach it still moves at about `0.824U`, with normalized body-frame lateral
  slip about `-0.24U`, bearing about `-0.97 rad`, and the inherited
  target-to-velocity course angle about `-1.26 rad`. Its late keyframes show a
  strong bend without target capture. The best scalar sample
  (`solver_4482d3d05d9c`) has the same coherent wake and upper-exit topology,
  but distance-only carrier relief loses approach (`5.126L`).
- Moving posterior half-cycle authority earlier did not fix that topology.
  Course-magnitude activation (`solver_963e74a3f179`) reached only `5.000L`;
  requiring signed bearing/course agreement (`solver_1a2ba9f2dbb2`) recovered
  only `4.743L`. Both retained the wake and reduced near-limit action relative
  to some full-wave samples, but both were worse in closest approach than the
  `4.162L` closing-aware comparison and the inherited `3.259L` proximity-gated
  half-cycle result. Early posterior attenuation is therefore not the next
  route actuator.
- The assigned parent's combined sign rewrite is a stronger negative result.
  It changed the course cross product from target-to-velocity to
  velocity-to-target and replaced additive recent-yaw feedback with a
  desired-minus-measured yaw residual. Its wake remains coherent, peak planar
  force and yaw moment remain bounded near `0.027` and `0.015`, and its speed
  remains about `0.81U` at termination, yet it reaches only `6.850L` and exits
  high at `15.68T`. Thus the regression is directional rather than a carrier or
  load failure. Because the fish nose is the negative body-x direction and the
  posterior curvature command has its own turn convention, a mathematical
  world-yaw sign is not automatically the correct actuator sign. The completed
  rollout falsifies that uncalibrated two-sign rewrite, although it cannot
  isolate its course and yaw changes from one another.

## Policy hypothesis

Restore the full posterior traveling wave and the empirically better inherited
target-to-velocity course and additive recent-yaw conventions. Keep the small,
previously useful centerline anterior course redistribution, but replace its
late distance expansion with one response gate: normalize bearing and
speed-qualified course independently, use their positive signed product as a
bounded agreement magnitude, and extend anterior redistribution away from the
centerline only while both cues request the same turn. Disagreement makes the
new extension exactly silent; restored course alignment releases it
continuously. The posterior steering mean and carrier remain unchanged.

This is a transient, response-conditioned redirect rather than the failed
static 8--9 degree anterior center. It is limited to four degrees around the
28-degree state-feedback oscillator and uses actual normalized body-frame
motion rather than distance, time, a world direction, or a memorized route.
It should preserve the early centerline correction, add anterior authority in
the `8--12T` interval where bearing and course become persistently negative,
and leave the full posterior thrust wave available.

Expected result: retain the alternating tail-connected wake and early leftward
progress, produce a visible downward course response before the prior
`16--18T` miss, and beat the sampled `4.162L` closest approach without raising
the roughly `0.028` peak planar-force or `0.018` peak-yaw-moment envelope.
Reject the mechanism if it recreates the static-bend speed collapse, weakens
the far carrier, increases limit residence or loads materially, loses the
`4.162L` approach, or repeats the upper exit without an earlier useful course
change.

bookshelf_consulted: true
source_domain: biological C-start redirect and closed-loop robotic-fish CPG turning
source_mechanism: apply a transient curvature redirect only while observed route error and directional response agree, then release back into the propulsive rhythm
transferable_invariant: preserve the rhythmic carrier and gate extra steering by bounded body-relative geometry, measured motion, and current joint state rather than time or a fixed route
nontransferable_details: maneuver duration, published gains, dimensional beat timing, species or robot kinematics, exact vortex phase, and task-specific paths
policy_translation: retain the two-joint state-feedback wave; extend the four-degree anterior course center away from its proven centerline window only by the geometric-mean agreement of normalized bearing and speed-qualified course, while keeping the posterior wave complete
falsification: reject if far progress or the coherent wake weakens, bearing/course disagreement activates the extension, closest approach exceeds 4.162L, the same upper exit survives without earlier course correction, or actuator and hydrodynamic loads rise materially

## Non-CFD gate audit

Replaying only the new response algebra on the assigned-parent and four sampled
histories makes the extension exactly zero for every bearing/course
disagreement sample (about `26--29%` of each history). The complete head center
remains below `3.77 deg`; on the four sampled histories its mean magnitude is
about `0.99--1.01 deg` at distances of at least `8L`, `2.51--3.09 deg` from
`5--8L`, and `3.48--3.70 deg` inside `5L` when that band is reached. Thus the
new mechanism is bounded below the failed static 8--9 degree centers and moves
authority into the diagnosed middle/late miss without altering the posterior
wave. This algebra audit establishes gating and scale only, not a CFD benefit.
