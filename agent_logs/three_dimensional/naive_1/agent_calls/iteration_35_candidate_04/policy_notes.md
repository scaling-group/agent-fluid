# Multi-wake policy diagnosis and single-candidate hypothesis

## Evidence read before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window
  transport, and capture termination. I inspected every combined keyframe
  sheet from release to capture. The top-down rows develop coherent alternating
  target-bending streets, while the oblique rows retain compact caudal Lambda2
  structures. With zero background flow, the translation is self-propelled;
  none of these sheets shows wake collapse, collision, domain exit, or
  numerical instability.
- The two executable-identical redistribution samples capture at
  `18.8265--18.8815T`, with score-defined mean distance
  `2.08855--2.08896L`. Their anterior/posterior acceleration contact remains
  about `60.85--61.00%`/`72.97--73.27%`, rate contact about
  `11.04--11.07%`/`14.88--14.93%`, and peak planar force/yaw moment about
  `0.0280/0.0163`. Coherent wakes and good scalar scores therefore do not make
  redistribution an actuator-relief mechanism.
- The assigned parent adds a rearward-only route multiplier to redistribution.
  It captures at `18.9640T` and `2.09072L`, with demand and loads inside the
  repeat band. The target remains forward throughout the useful route, so the
  branch is unexercised and establishes non-interference rather than recovery.
- The sampled geometry-only ablation removes phase-dependent envelope
  redistribution and captures at `18.6010T` and `2.09042L` while retaining
  both coherent wake rows. Two inherited, executable-identical comment
  variants also capture at `18.6945T`/`2.09366L` and
  `18.9585T`/`2.09594L`. Thus the inherited proposed ablation now has three
  completed successes, whereas inherited guidance records that the
  redistribution bytes also produced coherent-wake near misses at `0.81206L`
  and `1.25093L` followed by downward/left exits. The current sampled set has
  no failure keyframe sheet, so those inherited terminations are used as
  semantic counterevidence rather than presented as newly inspected visuals.
- Independent final projection is still structural on the simpler carrier:
  the sampled geometry-only rollout contacts the two acceleration limits on
  `60.88%`/`72.95%` of rows and the rate limits on `10.88%`/`14.96%`.
  Reconstructing a full direction-preserving coupled projection from this
  trace shows that it would intervene on `94.26%` of rows, with mean scale
  `0.512`; that is too large to count as a bounded allocator ablation. A `15%`
  convex blend with the existing independent projection would instead change
  mean absolute commands by only about `0.93/0.42 rad/T^2`, while every
  blended command remains inside the same acceleration envelope.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and asymmetric flapping
source_mechanism: preserve a coordinated traveling joint rhythm while target feedback modulates bounded half-cycle steering
transferable_invariant: keep target-signed displacement-half-cycle curvature separate from the propulsive envelope, and preserve interjoint command direction when allocating a shared finite actuation budget
nontransferable_details: published gains, duty ratios, dimensional cadence, clock phase, robot geometry, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: use the repeatedly captured normalized body-lateral geometry carrier, retain posterior lag and response release, remove the unevidenced rearward and phase-envelope branches, then blend independent acceleration clipping 85/15 with one common infinity-norm projection of the two raw joint commands
falsification: reject if capture or either coherent wake row is lost, the downward/left-exit topology recurs, mean distance leaves the geometry-carrier repeat band, or planar loads worsen; lower nondominant limit contact alone is not success

## Single-candidate hypothesis

The candidate uses the sampled geometry-scheduled displacement-phase carrier
as its evidence-backed base. Its only new controller mechanism is a weak
coupled demand allocator: calculate the existing independently clipped command
and a common-scale projection that preserves the raw two-joint command
direction, then take a bounded `15%` convex step toward the coupled result.
This may reduce clipping-induced interjoint distortion without erasing the
carrier, target-signed mean curvature, observed half-cycle steering, posterior
lag, or correcting-yaw response release.

The blend fraction is owned by `target_policy_params`; the candidate adds no
explicit time, step count, velocity or flow residual, pointwise rate barrier,
terminal schedule, mutable state, world coordinates, recovery route, or
memorized task identity. Formal CFD occurs only after this worker exits, so no
outcome is claimed here.
