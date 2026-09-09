# Error-confirmed redirect-release candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and capture. The assigned
  parent `solver_f997a0c1ad0f` is therefore an informative mechanism
  regression rather than a failed termination.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  from release through capture for the strongest finite sampled score,
  response-released `solver_0e3ccca5bc77`, and the assigned-parent regression.
  Both fish self-propel from quiescent water along a shallow target-directed
  arc. Their alternating top-down vortices and discrete oblique Lambda2
  structures remain coherent through the middle field; neither view shows
  advection, collision, wake collapse, or numerical instability. At capture,
  however, the parent's top-down sheet has a visibly longer terminal hook and
  its oblique trajectory bends more sharply into the capture sphere. The
  policy change should therefore preserve the traveling gait and correct the
  late redirect logic, not suppress lateral oscillation or retune propulsion.
- Metrics confirm that diagnosis. The parent captures at `16.247T` with
  `1.82240L` distance integral and `13.363L` head path. Its sub-`2L` mean yaw
  magnitude is `0.269 rad/T`, terminal yaw is `-0.589 rad/T`, and anterior
  mean command is `17.34 rad/T^2`. The two byte-identical response-released
  samples capture at `16.071--16.088T`, have `1.82203--1.82366L` integrals,
  `13.129--13.166L` paths, sub-`2L` mean yaw `0.115--0.128 rad/T`, and
  anterior mean command `16.52--16.57 rad/T^2`. The plain redirect sample
  likewise captures at `16.044T` with a `13.178L` path and only
  `0.094 rad/T` sub-`2L` mean yaw. Peak force/moment and rate residence do not
  materially improve in the parent, so its longer hook is not buying actuator
  protection.
- The causal boundary is specific: the parent multiplied added course
  curvature by a residual of yaw aligned with the aggregate route request,
  even while the normalized course-redirect demand remained large. At
  capture, reconstructed body-frame course error grows to about `0.78 rad`
  while the same-sign yaw response marks the redirect roughly 86% complete.
  This confuses response onset with directional completion and withdraws the
  correction while its own error is unresolved.

## One-candidate policy hypothesis

Preserve the parent's target geometry, distance/closing drive relief,
phase-aware traveling bend, half-cycle and posterior allocation, carrier
governor, bounds, and public contract. Change only the response residual used
by the extra velocity-course head/tail redirect: completion requires both
same-sign normalized yaw response and a reduction in the bounded redirect
demand. Keep the existing yaw-response residual for carrier priority, so the
edit does not simultaneously alter rhythmic work allocation.

Expected signature: remain in the coherent capture class and retain the
sampled early milestones, while keeping redirect authority through the late
large-error hook; approach the plain/response-released `13.13--13.18L` path,
roughly `0.09--0.13 rad/T` near-target yaw, and lower anterior command instead
of the parent's `13.363L/0.269/17.34` class. Falsify if capture timing or
distance integral worsens beyond the sampled repeat spread without a material
path/yaw/load/rate benefit; if large course error still coexists with released
curvature; or if either coherent wake view, joint margin, command effort,
force, moment, or finite action regresses.

bookshelf_consulted: true
source_domain: fish C-start burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: strong bounded curvature initiates redirection and returns continuously toward rhythmic tracking only as observed directional error is actually resolved
transferable_invariant: response onset is not response completion; release extra steering only when same-sign body response coincides with shrinking normalized directional demand
nontransferable_details: species-specific C-start stages, full-body kinematics, published gains and duty ratios, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: multiply only the added body-frame velocity-course head/tail redirect by one minus the product of bounded same-sign yaw response and bounded redirect-demand completion; leave baseline route/rate feedback and carrier priority unchanged
falsification: reject if late course error, path, near-target yaw, command or load do not improve without losing early progress, capture, joint margin, finite bounded action, or coherent top-down and oblique wakes
