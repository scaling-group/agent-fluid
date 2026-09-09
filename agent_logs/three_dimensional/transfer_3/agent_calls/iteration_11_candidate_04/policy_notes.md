# Collision-course-gated distributed C-bend candidate

## Evidence diagnosis recorded before the policy edit

- Every sampled rollout is a finite, direct-uniform still-water evaluation
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The moving-window
  contract preserves inertial coordinates, so translation and wake formation
  are self-generated rather than imposed advection or storage motion.
- Both rows of the combined keyframe sheets were inspected for the closest
  parent (`solver_5188c80f90a6`) and the highest-score contrasting failure
  (`solver_adc862529891`). The parent sustains a long alternating top-down
  street and compact oblique Lambda2 structures through `29.10T`; the
  contrasting controller has a coherent but much shorter street before its
  upper exit at `16.77T`. The parent's remaining miss is therefore route
  timing, not wake collapse, instability, or failure to self-propel.
- The parent's bearing-triggered anterior C-bend is a semantic improvement:
  relative to the otherwise inherited LOS-rate controller, minimum distance
  improves from `3.369L` to `1.897L`, and the head crosses the target x station
  near `y=11.465L` instead of `12.995L`. It is the first sampled mechanism to
  bring the high pass within `2L`, so its carrier, LOS-rate response, and
  bounded `6 deg` anterior redirect should be preserved.
- The parent still crosses the target line about `1.97L` high at `19.35T`,
  with about `0.88U` speed and `+2.91 rad/T` instantaneous yaw, and reaches
  its `1.897L` minimum only after crossing. It later reaches the target's y
  level only after traveling roughly `8L` left of the target. A range-only
  damping child already slowed the approach without changing the high-pass
  topology, so another drive schedule is not supported.
- Reconstructing the parent's body-frame guidance exposes a release gap.
  At `12T` its range is `6.54L`, constant-velocity projected miss is about
  `0.77L`, and the anterior redirect is `4.6 deg`. At `14T`, instantaneous
  bearing shrinks to about `-0.257 rad`, so the bearing gate releases to only
  `0.8 deg`, although projected miss remains about `0.54L`, comparable to the
  tight `0.75L` capture radius. At `16T` projected miss has regrown to `2.36L`
  and the redirect returns to `4.4 deg`, too late to erase the lateral offset.
- An inherited sibling that distributes the full yaw residual across both
  oscillator centers reaches `2.317L` but continues into a lower-domain exit.
  This cautions against replacing the parent's successful actuator semantics;
  the next test should only bridge its geometry-induced release gap.

## Policy hypothesis recorded before editing

Preserve the evaluated `28 degree`, `0.55T` joint-state traveling bend, the
bounded bearing plus line-of-sight-rate yaw request, posterior residual
curvature, and the parent's large-bearing anterior redirect. Add one compatible
state-feedback mechanism: estimate constant-velocity closest-pass distance as
the magnitude of the body-frame target/velocity cross product divided by
resolved rigid speed. During established closing approach, smoothly recruit
the same bounded anterior C-bend when this predicted miss lies outside a
capture-safe cone, and combine that gate with the existing bearing gate. This
uses no clock, route memory, or fixed world geometry and returns continuously
to the parent when the fish is opening or already on a safe intercept.

Expected evidence is the parent's coherent far-field wake, continuous redirect
through the `12--16T` bearing-alignment gap, target-line crossing below
`y=11.465L`, and either capture or minimum distance below `1.897L`. Reject the
mechanism if it produces the sibling's lower exit or an early tight curl,
weakens the alternating wake, materially increases clipping or loads, or
retains the same above-target pass despite the predicted-miss gate activating.

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish closed-loop CPG direction tracking
source_mechanism: observed route error recruits a bounded distributed mean bend on a persistent rhythm and releases when target-directed response is restored
transferable_invariant: preserve the traveling wave while using observed target geometry and rigid-body response to sustain extra curvature until a safe intercept is re-established
nontransferable_details: published gains, species-specific C-start shapes and timing, robot linkage geometry, dimensional capture distances, clock phase, exact vortex phase, and task-specific routes
policy_translation: form a normalized body-frame constant-velocity miss estimate from `target_body_L` and `velocity_body_U`, gate it by observed closing motion, and use it only to extend the parent's bounded anterior oscillator-center shift
falsification: reject if the early curl or lower exit appears, wake coherence or envelope occupancy worsens materially, or target-line height and the `1.897L` minimum fail to improve despite predictive-gate activation

## Dry validation after editing

- Replaying parent trajectory states through the new guidance leaves the
  anterior redirect small at `6T`, then raises the predictive gate to `0.721`
  at `8T`. At the diagnosed `14T` release gap, the combined redirect weight is
  `0.641` and the anterior center remains near `3.05 deg`, rather than the
  parent's roughly `0.8 deg`; the command still stays within the unchanged
  `6 deg` bound.
- The policy-contract check loads the candidate and returns two finite
  accelerations for the full observation schema. A mirrored synthetic
  target/velocity/joint state returns sign-mirrored actions to numerical
  tolerance, and the parameter-schema references resolve.
- The reusable-guidance semantic check and solver repository boundary check
  pass. No CFD rollout was run, and no outcome for this candidate is claimed.
