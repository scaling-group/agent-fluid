# Terminal half-cycle energy candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and `horizon` termination at `100T`. I inspected the
  top-down mid-plane-vorticity and oblique body/Lambda2 rows of all four
  combined keyframe sheets. Every fish self-propels and retains a coherent
  alternating planar wake with compact three-dimensional structures through
  repeated turns; advection, collision, domain exit, wake collapse, and
  numerical instability do not explain the misses.
- The completed terminal course hold (`solver_6eb170b0d70a`) is the unique
  useful trajectory: it makes the visibly tightest return, reaches
  `1.241/4.158/2.082L` minimum/mean/final distance, and spends about `0.47T`
  inside `1.25L`. At its late minimum it is still moving at `0.669U`, with
  target-ray/course error `1.692 rad`, course dot `-0.121`, useful yaw only
  about `0.129 rad/T`, an active anterior velocity of `-0.260 rad/T`, and
  modest commands around `(0.75,0.92) rad/T^2`. The visible miss is a powered
  tangential arc with turn reserve, not a stopped or clipped approach.
- The other three samples close the newest terminal remedies. Rear-centerline
  selector replacement (`solver_b5de8ff4a388`) reaches only
  `2.366/3.875/3.502L`; a joint-state equilibrium unbend
  (`solver_a6820a0af3d7`) reaches `2.215/3.859/3.416L`; and the prefilled
  course-signed low-activity restart (`solver_2cc56ad90762`) reaches
  `2.369/3.869/3.455L`. All retain coherent wakes and the horizon class, but
  at their minima both joints are almost stationary in a common negative
  C-bend (`|phi_dot_1| <= 0.003 rad/T` for the latter two representative
  traces), whereas the course-hold scaffold retains an active wave. The
  inherited logs predicted that the restart would falsify itself if it made a
  one-sided bend; its completed CFD result does exactly that. More static
  equilibrium authority, rear-side selector replacement, constant signed
  restart acceleration, posterior residual, scalar radius tuning, or frozen
  replay locality is therefore unsupported.

## Policy hypothesis

Return to the completed `solver_6eb170b0d70a` course-hold scaffold and preserve
its bearing curvature, target-behind C-turn, course-response reserve, terminal
course hold, posterior brake and joint-state phase lag, wave envelope, and
command limit. Add one different actuator primitive: while the target is fully
behind and the existing terminal selector is active, inject bounded anterior
energy only on the joint-velocity half-cycle that moves toward the requested
turn. The pulse is aligned with measured joint velocity, saturates smoothly,
and is exactly zero at zero velocity. The unchanged lagged posterior target
propagates the energized bend. It therefore cannot create the static
equilibrium produced by the sampled signed restart or bend shifts.

Support requires preserving the coherent ahead-side recovery plus capture, a
pass below `1.241L`, longer residence inside `1.25L`, or a materially tighter
final loop with comparable clamp/load residence. Reject if the first recovery
changes, the selected half-cycle does not strengthen, joints again park, wave
or wake coherence degrades, clamp/load residence rises, or minimum, mean, and
final distance remain in the same noncapturing class.

```text
bookshelf_consulted: true
source_domain: asymmetric robotic-fish flapping and sensor-modulated CPG direction tracking
source_mechanism: target-direction feedback strengthens only the useful propulsive half-cycle instead of replacing the traveling rhythm with a static bend
transferable_invariant: when sustained mean curvature parks a maneuver, preserve anterior-to-posterior wave propagation and add bounded energy only while measured joint motion already proceeds in the requested turn direction
nontransferable_details: published gains, dimensional beat frequency, robot-specific duty ratios, species-specific kinematics, full-body joint count, clocked CPG phase, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target-behind geometry and target-ray/course response select the terminal maneuver; normalized anterior joint velocity selects a reflection-equivariant bounded half-cycle pulse within the unchanged two-joint lag contract
falsification: reject if the ahead-side recovery changes, the action creates a parked or oversized bend, active joint motion and wake coherence are not preserved, command/load margins worsen, or near-target and final-distance statistics do not improve
```

## Evaluation boundary

The coupled CFD result becomes available only after this worker exits. Frozen
trace replay and dry controller probes can establish selector locality,
bounded action delta, reflection equivariance, finiteness, and parameter
ownership, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed terminal course-hold policy and adds
two owned parameters for one bounded anterior half-cycle pulse. The existing
target-behind and terminal course weights select the maneuver; signed
normalized anterior velocity selects the useful half-cycle and the pulse
saturates at `2 rad/T^2`. It changes no equilibrium curvature, oscillator,
posterior target, lag, wave envelope, brake, distance/course threshold, or
`+/-28 rad/T^2` command reserve. It contains no time, step count, hidden state,
world coordinate, target identity, route, random input, or file access.

Reconstruction and replay over all `18182` completed course-hold states changes
maximum-joint action by only `0.000044/0.00199 rad/T^2` mean/maximum beyond
`3L`, but by `0.162/0.805 rad/T^2` inside `1.5L`. At the scaffold's `1.241L`
minimum, frozen action changes from about `(0.970,0.868)` to
`(0.463,0.868) rad/T^2`; the posterior action is exactly unchanged because
this test only energizes measured anterior motion. These values establish a
small far-field delta and material, bounded terminal half-cycle action only;
they do not predict the coupled trajectory.

All `46` direct parameter references are returned by
`target_policy_params()`. Full reconstructed replay remains finite and within
the declared command reserve, and sampled reflected target, velocity, joint,
and yaw states negate both actions with zero observed residual. The material
guidance check, lightweight Julia policy contract, and solver editable-boundary
check pass after removing the duplicated rendering of the assigned parent from
the workspace `README.md`. No formal CFD was run.
