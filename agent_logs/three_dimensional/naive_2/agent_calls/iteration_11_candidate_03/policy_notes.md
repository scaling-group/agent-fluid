# Candidate diagnosis and policy hypothesis

## Visual and metric diagnosis

- The four sampled rollouts and the assigned parent's inherited completed
  rollout all satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. In every combined sheet,
  the top-down row develops an alternating vortex street and the oblique row
  retains tail-connected three-dimensional Lambda2 structures. The fish is
  self-propelled, not advected, and no sampled exit is preceded by wake
  collapse or numerical instability.
- The shared failure is directional response. All sampled paths make useful
  leftward progress but remain above the target and leave through the upper
  boundary. The closure-conditioned sample has the strongest sampled approach
  (`4.162L` at `17.51T`) but is still moving at `0.824U`, recedes to `6.363L`,
  and exits at `23.36T`. The best-score distance-relief sample reaches only
  `5.126L` and exits at `20.86T`. Course-gated and signed-agreement posterior
  half-cycle variants reach `5.000L` and `4.743L` respectively, but both retain
  essentially the same final distance near `5.93L` and the same upper exit.
  Thus carrier relief and the tested half-cycle schedulers do not supply a
  semantic route improvement.
- The assigned parent's inherited rollout is a completed falsification of its
  sign hypothesis. Reversing the course cross product to `velocity x target`
  and feeding `desired_yaw - measured_yaw` into posterior curvature preserves
  a coherent alternating wake, but it reaches only `6.850L` and exits the
  upper boundary at `15.68T`, earlier than all four samples. The failure is not
  an instability: peak speed (`0.865U`), force, and moment remain in the sampled
  range. A formally geometric signed angle therefore cannot be inserted before
  accounting for this body's forward-axis and curvature-to-yaw conventions.
- The observation contract explains the convention mismatch. Body-positive
  `x` is opposite the swimming direction, while the retained `bearing` and
  `target x velocity` values use the sign that has historically commanded
  posterior curvature. The rollouts are consistent with physical yaw response
  having the opposite sign from that actuator-coordinate request. The failed
  parent instead asked physical yaw to have the same sign as posterior
  curvature, so its response residual reinforced the upper excursion.

## Single candidate hypothesis

Preserve the prefilled full-amplitude state-feedback carrier, posterior lag,
bounded mean curvature, crossflow residual, approach-aware anterior
redistribution, and phase-compatible posterior half-cycle relief. Keep
`target x velocity` as a provisional actuator-coordinate course residual.
Change only the yaw-response semantics: a bounded posterior turn request `u`
should request physical yaw `-k*u`, and the feedback residual should therefore
be `measured_yaw + k*u`. This centers yaw damping on the requested response
rather than on zero yaw, adds restoring authority when yaw has the wrong sign,
and brakes only yaw that exceeds the requested response.

Expected result: the carrier and its alternating three-dimensional wake should
remain intact, while the fish sustains an earlier downward redirect instead of
damping all useful yaw toward zero. Reject the mechanism if it loses the
prefilled `5.000L` approach, increases load or acceleration-limit residence,
or repeats the upper exit without a meaningfully different course. A stronger
boundary is the inherited `3.259L` half-cycle result; failure to approach that
reference means this response calibration should not be deepened by gain
tuning.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking
source_mechanism: sensor feedback modulates a low-dimensional rhythmic carrier by comparing requested and measured directional response
transferable_invariant: preserve the propulsive rhythm and feed back directional response error only after mapping observations and actuator commands into a common sign convention
nontransferable_details: published gains, robot geometry, dimensional beat timing, species kinematics, exact vortex phase, and source-task routes
policy_translation: retain normalized body-frame bearing, course, crossflow, and joint-state phase; map posterior curvature request to opposite-sign physical yaw before forming a bounded measured response residual
falsification: reject if the coherent wake or closest approach is lost, loads or saturation rise materially, or upper-boundary exit persists without an earlier targetward course response

## Evaluation boundary

No CFD outcome is claimed for this candidate. The next rollout should compare
exit topology and minimum distance first, then course/slip at closest approach,
recession, acceleration residence, force and moment peaks, and both wake views.
