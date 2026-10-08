# Phase-qualified upstream course-slip vectoring

## Evidence read before editing

- The assigned parent is the prefilled `solver_fb7bddf12f80` policy. Its
  inherited optimizer guidance and log identify a capture at `0.748361L` and
  `26.1635T`, score `-0.607211`, and mean distance `2.509866L`.
- All four sampled evaluations report direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, capture termination, coherent
  self-propulsion, and no angle, speed, or acceleration contacts. Thus none is
  an unstable or non-capture visual failure; the informative negative
  comparators are the weaker translation-consistent carrier and the
  force-commutated course-slip descendant.
- Both rows of every combined keyframe sheet were inspected. The top-down
  rows show a coherent alternating wake and nearly identical left/down route
  followed by a shallow terminal hook. The oblique rows show compact,
  alternating three-dimensional Lambda2 structures that persist to capture;
  there is no sign that moving-window transport, passive advection, or wake
  collapse explains the score differences.
- Removing upstream course-slip vectoring (`solver_8e7135ef9173`) delayed
  capture to `26.2460T`, increased mean distance to `2.518971L`, and worsened
  the `8/16/24T` distances to `10.461883/6.231975/1.891086L`. The parent
  reached `10.451165/6.188785/1.810235L`. A distinct course-priority
  descendant (`solver_93fdf80136b2`) reproduced the upstream improvement
  (`10.451165/6.188785/1.806417L`, mean `2.509863L`) but did not create a
  materially different terminal route.
- Instantaneous force commutation (`solver_3065fba218c6`) retained capture and
  the same visible wake, but regressed mean distance to `2.512198L` and score
  to `-0.609997`; this agrees with the inherited negative lesson that
  same-trace load correlation is not sufficient to make force a route gate.
  Peak planar force/yaw moment remained modest across the sampled set
  (`0.01883--0.01944` / `0.00979--0.00987`).
- A phase-conditioned audit of the logged trajectories found the same 104
  upstream slip-active rows in all four samples. Desired-course-normal force
  averaged about `+0.000874` over the 28 rows where the anterior bend was on
  the requested side, versus about `-0.00161` to `-0.00162` over the 76
  opposite-bend rows. An anterior-velocity selector did not separate useful
  response. This is a phase-allocation hypothesis, not causal proof.

## Policy hypothesis

Preserve the capture-capable traveling bend, target-line response,
course-slip observation, terminal posterior modulation, and all viability
guards. Multiply only the upstream posterior course-slip target shift by a
smooth, reflection-equivariant gate formed from normalized anterior bend
alignment with the requested course side. The gate stays in `[0,1]`: it
retains the parent correction on the sampled useful half-cycle and suppresses
it on the adverse half-cycle without increasing instantaneous authority.
Startup, aligned, non-closing, redirected, and terminal states remain exact
pass-through cases through the inherited gates.

Expected test: retain capture, the coherent three-dimensional wake, and zero
actuator contacts while improving upstream course alignment or distance
integral without increasing peak loads. Reject the mechanism if capture is
lost, the `8/16/24T` progress benefit disappears, loads or limit residence
increase, or the route remains visually and metrically indistinguishable.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning
source_mechanism: half-cycle amplitude or duty-ratio asymmetry keyed to observed oscillator state
transferable_invariant: preserve the propulsive rhythm while applying bounded steering only on the joint-state half-cycle whose measured response supports the requested turn
nontransferable_details: published gains, clock phase, species-specific kinematics, exact vortex phase, and prescribed routes
policy_translation: gate the existing body-frame course-slip posterior target shift by smooth target-side anterior-bend alignment; retain the parent magnitude as the upper bound
falsification: reject if capture or coherent wake is lost, upstream progress is erased, actuator exposure or loads rise, or held-out traces do not preserve the phase-response separation
