# Wake-policy diagnosis and hypothesis

## Inherited evidence

- `solver_0c4c66457a74` is the strongest sampled finite rollout.  Its
  steering-priority closing-sector allocation improves the prior handoff
  candidate from `2.579L` to `1.076L` minimum distance, lowers raw
  acceleration-envelope exposure from `82.76%` to `74.65%`, and improves
  mean/final distance to `6.178/6.307L`.  It remains stable but exits the
  upper virtual boundary at `37.823T`.
- The top-down row shows a coherent, self-propelled reverse-vortex street and
  a useful turn through the target neighborhood, followed by a broad
  near-vertical runout with the target on the outside of the arc.  The oblique
  Lambda2 row confirms that the wake stays organized through the pass; there
  is no visible loss of propulsion or 3D instability to repair.
- `solver_a81796f958a5` is the informative control-architecture failure.  Its
  target-behind tail-pivot handoff retains a coherent wake and produces a
  recognizable hairpin, but turns too broadly/late: `2.579L` minimum,
  `7.435L` final, and an upper exit at `45.331T`.  The assigned parent's
  companion optimizer result (`solver_4b19cf3aabda`) reports
  `2.591/7.436L` minimum/final distance with the same termination family,
  closing the parent's distributed-curvature proposal as a standalone next
  step rather than supporting another posterior/anterior curvature split.
- At the strong rollout's closest approach (`25.977T`), distance is `1.076L`,
  speed remains `0.762L/T`, yaw rate is `1.413 rad/T`, local body crossflow is
  only `-0.010L/T`, and force/moment coefficients remain finite
  (`[-0.0072,-0.0098]`, `-0.0070`).  The fish is already turning while its
  momentum carries it past the `0.75L` capture disk.  This supports a terminal
  carrier-allocation test, not wake rejection or another late curvature gain.

## Candidate hypothesis

Preserve the sampled `0.55T`, `28 deg` posterior-lagged carrier, all target
steering, the closing-sector pulse, and its steering-priority allocator.
Introduce one continuous capture-approach gate from normalized distance,
measured positive closing speed, and body-frame target passage.  During only
near-and-still-closing states, reduce the anterior and posterior propulsive
carrier accelerations toward a nonzero floor while leaving curvature and
steering terms unscaled.  Release the unloading continuously when the target
is no longer closing or is materially behind.  This should trade excess
through-speed for additional steering headroom without changing the far-field
route or destroying the traveling bend.

Falsify the candidate if it does not cross the `0.75L` capture radius, loses
the inherited sub-`1.1L` approach, changes the useful pre-terminal trajectory,
collapses the coherent wake, materially raises acceleration/rate exposure or
force/moment loads, or merely reproduces the same upper-exit arc.

Implemented translation: the near gate rises continuously from zero at `3L`
to one at `1L`; positive closing speed is normalized by `0.16L/T`; the existing
posterior-sector release suppresses unloading once the target is materially
behind.  Their product scales both carrier accelerations toward a `0.50` floor.
Synthetic contract probes leave the inherited far-field action unchanged and
set the gate to zero for opening and materially-behind states.

bookshelf_consulted: true
source_domain: classical fish and robotic-fish terminal capture control
source_mechanism: continuous approach hold by reducing excess drive while preserving steering and yaw authority
transferable_invariant: when a target is near and still closing, allocate less actuator authority to the propulsive carrier and retain a nonzero carrier floor so steering can redirect the body without losing the traveling wave
nontransferable_details: published gains, species-specific kinematics, dimensional approach speeds, exact beat phases, and task-specific routes
policy_translation: use normalized distance, normalized measured closing speed, and normalized body-frame forward target position to gate bounded scaling of both carrier accelerations while leaving the two-joint curvature feedback unchanged
falsification: reject if capture is not achieved or if the inherited approach, wake coherence, actuator exposure, loads, or post-pass topology materially worsens
