# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts use valid direct-uniform still water and terminate
  in capture at `18.0070--18.0125T`. Their combined sheets show the same
  self-propelled, alternating top-down vortex street and coherent three-
  dimensional oblique wake; there is no visible advection, wake collapse, or
  out-of-plane instability to motivate a transit-gait change.
- The score-leading centered duty-ratio candidate (`solver_24d38f4fb85b`,
  `-0.064000`, `18.0125T`) retains closure but finishes with only `0.1297`
  course alignment, `0.8077 rad/T` absolute yaw, and a `13.2149L` center path.
  The assigned slip-synchronous parent (`solver_98416aa924c6`, `-0.064149`,
  `18.0125T`) weakens only the slip-reinforcing half-cycle; it improves final
  alignment/yaw to `0.1728/0.6545 rad/T`, path to `13.2064L`, and near
  posterior acceleration-ceiling residence to `74.11%`, but loses mean-
  distance score because its posterior authority is unilateral.
- The informative target-normal-power allocation sample
  (`solver_33df9c38c711`) shortens the path to `13.1972L` yet ends at only
  `0.1036` alignment and `1.1215 rad/T` absolute yaw. Thus path or scalar score
  alone does not establish terminal attitude control. The inherited duplicate
  score-only completions at `-0.064554` add determinism evidence but contain no
  policy or trajectory evidence from which to infer a mechanism.

## Visual diagnosis

Both the top-down mid-plane row and oblique Lambda2 row show a mature,
alternating traveling wake from transit through capture for the best-score and
attitude-degraded samples. The route reaches the capture circle without a
collision or wake disruption, but the final body and velocity remain oblique
to the target line. The missing capability is therefore phase-specific
terminal lateral-impulse allocation, not propulsion, route-sign correction,
or another phase-free yaw/force gain.

## Policy hypothesis

Preserve the parent's state-feedback oscillator, odd target-to-curvature map,
posterior lag, conserved terminal mean-bend allocation, and rate governor.
During only a moving, misaligned approach, use normalized target-normal body
velocity and summed joint rate to center posterior wave authority around one:
weaken the half-cycle whose tail motion reinforces cross-course slip and give
the same bounded authority to the opposing half-cycle. This is exactly
inactive outside approach and independent of the mean-turn request.

Expected result: retain the parent's capture and coherent two-view wake while
recovering the closure benefit of balanced duty redistribution and retaining
or improving its alignment, yaw, path, and posterior limit residence. Reject
the mechanism if capture/mean distance regresses, transit changes, the
posterior factor has a non-unit cycle mean, actuator pressure migrates forward,
or terminal slip, alignment, yaw, and path do not improve together.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and classical tail-dominant reactive propulsion
source_mechanism: bounded half-cycle duty redistribution on a lagged posterior traveling wave
transferable_invariant: steer lateral impulse by redistributing posterior work between observed opposing stroke phases while preserving the traveling wave and cycle-scale propulsion
nontransferable_details: published CPG clocks and gains, species-specific kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target-normal velocity and summed joint rate to form a reflection-invariant slip-phase product, then apply a centered bounded factor only to the posterior wave during the moving misaligned approach
falsification: reject if far or middle motion changes, the two-view wake loses coherence, capture or distance integral regresses, or terminal slip, alignment, yaw, path, and non-migrating limit residence fail to improve together
