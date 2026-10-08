# Wake-policy candidate diagnosis and hypothesis

## Evidence reviewed before the edit

- All four sampled diagnostics report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot.
- The assigned parent, `solver_ab59732b5ad0`, is the strongest finite sample:
  it reduced distance from `12.328L` to a `6.218L` minimum (`6.272L`
  final) over `16.879T`. Its top-down row shows a strong, coherent alternating
  wake from roughly `3T` onward, and its oblique row shows a persistent chain of
  three-dimensional Lambda2 structures. This is self-propulsion, not advection.
  The fish nevertheless moved `+1.201L` in world y and left the upper boundary.
  Its bounded commands occupied the anterior/posterior acceleration limits for
  about `0.499/0.608` of samples, so more continuous posterior bias is not a
  credible corrective mechanism.
- The informative phase-gated failure, `solver_b80f3041d568`, retained an
  alternating wake but visibly curled upward by `8--9T`, gained only `0.863L`
  of final distance, and also accumulated `+1.204L` world-y displacement before
  upper exit at `9.053T`. The inherited optimizer logs independently retain the
  `solver_e7d052036feb` two-sided half-cycle regression (`11.778/11.860L`,
  `8.800T`) and this one-sided failure (`11.448/11.465L`, `9.053T`). The sampled
  relative-crossflow candidate `solver_b8cb71a4fd97` likewise exited upward at
  `10.411T` and stopped at `10.883L`.
- Reconstructing the parent's normalized body-frame signals from its trajectory
  exposes the control mismatch. Near `4.956T`, body bearing was `-0.263 rad`
  while the signed course proxy was `-0.252 rad`: the inertial velocity was
  almost target-aligned, but `bearing - 0.55*course` remained `-0.124 rad` and
  kept steering. Near `6.606T`, bearing/course were `0.120/0.125 rad`, again
  nearly aligned while the policy retained a same-sign command. Later, when
  the velocity pointed upward away from the target, the fractional course term
  supplied weaker correction than the actual velocity-to-target angle.

## Candidate hypothesis

Keep the parent's joint-state Van der Pol carrier, posterior lag, posterior-only
mean curvature, target limit, and acceleration envelope. Replace the additive
`bearing - constant*course` proxy with a speed-gated, exact signed angle from the
observed inertial velocity vector to the observed target vector, both expressed
in the body frame. At release the gate falls back continuously to body bearing;
once translation is established, the velocity-to-target error becomes the
steering signal and releases curvature whenever sideslip already carries the
fish toward the target. This is one feedback-structure change, not a carrier or
gain sweep.

Expected signature: preserve the parent's coherent wake and x progress while
making world-y displacement turn negative or remain safely below the upper
margin; improve on the `left_domain` termination or at least the `6.218L`
closest approach. Falsify the mechanism if the same `+1.20L` upper-exit topology
persists, if the minimum distance regresses materially, or if joint/wake
amplitude collapses.

bookshelf_consulted: true
source_domain: sensor-feedback CPG direction tracking in robotic fish, with the shelf's course/slip damping translation
source_mechanism: modulate a propulsive rhythm from observed direction error and release the steering response as measured motion aligns
transferable_invariant: steer from bounded target-relative motion error while preserving the propulsive carrier and withdrawing curvature when the response is already useful
nontransferable_details: published CPG gains, robot morphology, dimensional beat settings, species kinematics, exact wake phase, and task-specific routes
policy_translation: blend body bearing at low speed into the exact signed body-frame velocity-to-target angle, then apply it only as bounded posterior mean curvature
falsification: reject if wake coherence or x progress is lost, if upper exit remains with about +1.20L y drift, or if closest approach fails to improve on 6.218L
