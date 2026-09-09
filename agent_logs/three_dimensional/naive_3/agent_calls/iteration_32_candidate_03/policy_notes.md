# Active-wave terminal half-cycle candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment: direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and `horizon` termination at `100T`. I inspected the
  top-down mid-plane-vorticity and oblique body/Lambda2 rows in all four
  combined keyframe sheets. Every candidate self-propels and keeps a coherent
  curved wake through repeated loops; passive advection, wake collapse,
  collision, domain exit, and instability do not explain the misses.
- The terminal-course-hold scaffold remains the strongest physical near miss
  even though its scalar score is lower: it reaches `1.241/4.158/2.082L`
  minimum/mean/final distance, spends `0.473T` inside `1.25L`, and shows the
  visibly tightest late return. At its minimum the fish still travels at about
  `0.669U`, the target-ray/course error is `1.692 rad`, course dot is `-0.121`,
  useful yaw is only about `0.129 rad/T`, and the anterior wave is active
  (`phi_dot_1=-0.260 rad/T`) with modest unclipped commands. The remaining
  `0.491L` capture gap is therefore a powered tangential miss with a traveling
  bend, not low propulsion, a stopped joint, or exhausted authority.
- The assigned parent's joint-state C-bend release is now a completed negative
  result. It improves mean distance to `3.859L` and has the highest sampled
  scalar score, but reaches only `2.215L`, never enters `1.5L`, and ends at
  `3.416L`. Its top-down and oblique sheets revert from the scaffold's tight
  late return to a broad powered loop. At its minimum both joints are nearly
  parked in a common C-bend (`phi_dot_1=0.0027`, `phi_dot_2=0.0020 rad/T`), as
  in the `2.369L` wave-restart and `2.366L` direction-blend failures. Thus a
  frozen-trace-local unbend or restart can still move the coupled trajectory
  onto the same noncapturing equilibrium; another static release, restart
  threshold, curvature magnitude, or posterior stroke is not supported.

## Policy hypothesis

Return to the completed `1.241L` terminal-course-hold scaffold and preserve
its cruise oscillator, body-frame geometry selectors, C-turn equilibria,
course-response reserve, continuous terminal hold, posterior lag, propulsion
brake, curvature magnitudes, and command limit. Add one different actuator
primitive: under the existing terminal course hold, strengthen only the
anterior half-cycle whose measured joint velocity is already moving into the
course-requested bend. The gate is normalized by `omega*amplitude`, is zero at
rest and on the opposite half-cycle, and adds no equilibrium offset or
posterior command. This tests whether a small phase-selective inward impulse
can turn the active late pass into capture without creating the quiescent
common C-bend seen in the sampled descendants.

Support requires preservation of the coherent first recovery plus capture, a
pass below `1.241L`, more than `0.473T` inside `1.25L`, or a tighter final loop
with improved minimum/final distance and comparable clamp/load residence.
Reject if the first return changes materially, the added half-cycle produces
a one-sided/static bend, the anterior wave loses activity, the wake loses
coherence, limits or loads rise materially, or the same broad `>2L` orbit
returns. Frozen replay can establish locality, phase selectivity, bounds, and
reflection equivariance, but not coupled hydrodynamic improvement.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG asymmetric-flapping control and biological nonsteady redirect maneuvers
source_mechanism: turning authority is added to the useful moving half-cycle of a retained propulsive rhythm rather than held as a larger static bend
transferable_invariant: preserve a directionally propagating carrier and make extra steering conditional on both body-frame course demand and observed beat motion so it vanishes when the joints park
nontransferable_details: published duty ratios and gains, robot linkage geometry, species-specific C-start stages, dimensional beat frequency, full-body kinematics, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: the existing normalized terminal target-ray/course selector gates a bounded anterior acceleration only when normalized anterior velocity is moving into the requested bend; the posterior traveling-wave contract and all world-independent selectors remain unchanged
falsification: reject if cruise or the first recovery changes, active-wave residence falls, a quiescent C-bend or one-sided wake appears, clamp/load residence grows, or closest, near-target, and final-distance evidence does not improve
```

## Evaluation boundary

The new coupled CFD result is unavailable until this worker exits and must not
be treated as present evidence. No formal CFD will be run in this workspace.

## Implemented candidate and non-CFD probes

The candidate removes the assigned parent's failed joint-state equilibrium
release, returns to the completed terminal-course-hold scaffold, and adds two
owned parameters for the single half-cycle mechanism. It changes only anterior
acceleration; all equilibria, curvature authorities, distance/course
selectors, oscillator settings, posterior target and lag law, propulsion
brake, and the `+/-28 rad/T^2` command reserve are unchanged.

Frozen-state replay over all `18182` states of the `1.241L` scaffold gives a
candidate/scaffold maximum-joint action difference of only
`0.000035/0.00149 rad/T^2` mean/maximum beyond `3L`. Inside `1.5L` the
difference is `0.170/0.634 rad/T^2`; at the `1.241L` minimum the reconstructed
action changes from approximately `(0.970,0.868)` to `(0.465,0.868) rad/T^2`,
prolonging the already negative requested anterior half-cycle without touching
the posterior command. Every replay state inside `3L` with combined joint
speed below `0.01 rad/T` has exactly zero action difference, establishing the
intended separation from the sampled parked-bend failures. These are locality
and action-topology checks, not a coupled-flow prediction.

All `46` direct parameter references are fields returned by
`target_policy_params()`. A mirrored terminal probe negates both actions with
zero numerical residual. The required material-guidance check, lightweight
Julia policy contract, and solver editable-boundary check pass. Shell startup
emitted irrelevant missing-workspace-SSH-file warnings during the Julia probes,
but Julia exited successfully and all assertions passed.
