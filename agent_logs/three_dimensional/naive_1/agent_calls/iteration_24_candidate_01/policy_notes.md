# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture. The
  sampled set contains no termination-failure keyframe sheet, so I compared
  the best-score capture (`solver_649d7e789a5a`) with the lower-score but
  fastest capture (`solver_de4c121e5685`) and used inherited failed-rollout
  notes only as textual negative evidence.
- In both combined sheets, the top-down row develops a body-attached,
  alternating street that bends toward the target from quiescent water. The
  oblique row retains compact caudal Lambda2 structures through approach.
  Translation is self-propelled rather than imposed-flow advection, and the
  broadside-reserve sample does not visibly disrupt the traveling bend.
- The two executable-identical half-cycle envelope-redistribution samples
  capture at `18.8265--18.8815T`, reproduce mean distance
  `2.08855--2.08896L`, and overlap in rate and acceleration contact. The
  assigned prefill's rearward multiplier also captures at `18.9640T` and
  `2.09072L`, but inherited reconstruction shows its forward target fraction
  remains positive, so the new branch never activates and establishes only
  non-interference.
- The newly sampled broadside-reserve policy captures at `18.7055T` with mean
  distance `2.09386L`. Reconstructing body-frame target direction from its
  head position and heading shows the independent reserve becomes active at
  `17.7045T`, distance `1.5945L`, with lateral/forward fractions
  `-0.5526/0.8335`; it peaks at only `0.03851` of curvature request at
  `0.9645L`. Thus this completed rollout exercises the new channel and is the
  fastest current sampled capture, but its worse mean distance and single
  realization do not establish a score, integral, demand, or recovery
  improvement. Its rate contact (`11.29%/15.08%`) and acceleration contact
  (`60.86%/73.04%`) stay in the captured-carrier band; peak planar force and
  moment (`0.03275` and `0.01704`) sit modestly above the other current
  samples and must not be called relief.
- The inherited broadside near miss reached `0.85155L` and then exited left
  despite an energetic two-view wake; its route request was already about
  `0.995` of saturation while the target was still forward. Posterior wave
  enhancement and attenuation also both failed with coherent wakes. Those
  results favor replicating the separate target-signed curvature reserve over
  another multiplier inside route saturation, a behind-only branch, or
  posterior gait allocation.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst redirects and closed-loop robotic-fish mean-curvature steering
source_mechanism: large observed direction error gates a bounded curvature reserve while the organized traveling wave remains active, then measured correcting response releases the reserve
transferable_invariant: separate normalized body-frame route geometry from a small bounded redirect channel without replacing posterior lag or the propulsive rhythm
nontransferable_details: published gains, dimensional cadence, species-specific C-start shapes, robot geometry, prescribed beat phase, exact vortex phase, and task-specific routes
policy_translation: adopt the sampled body-lateral smooth gate that adds target-signed anterior/posterior mean curvature after route saturation while target-ahead geometry and one-sided yaw response bound its activation; retain displacement-only half-cycle steering, posterior lag, common geometry-scheduled amplitude relief, and final acceleration projection
falsification: reject robust-benefit claims if an executable-equivalent repeat loses capture or either coherent wake row, fails to exercise the reserve, leaves the established capture route band without a distinct recovery benefit, or materially increases joint-limit contact or planar loads
```

## Single-candidate policy hypothesis

Replace the prefill's inactive behind-target multiplier and inherited
half-cycle envelope redistribution with the exact sampled broadside-reserve
architecture. This leaves one interpretable feedback mechanism atop the
geometry-scheduled carrier: a smooth normalized body-lateral/forward gate
bypasses the saturated route argument and adds a small target-signed share to
both established mean-curvature biases. It preserves target-owned sign,
displacement-only half-cycle steering, correcting-yaw release, posterior lag,
and the exact acceleration projection.

This is an evidence-backed architecture replication, not scalar-only gain
tuning. The next CFD evaluation should determine whether the exercised
broadside channel independently retains capture and the two-view wake class.
Accept stronger claims only if later evidence also changes the inherited
broadside near-miss topology; falsify this candidate as a robust frontier if
an executable-equivalent repeat loses capture or materially worsens demand or
loads.
