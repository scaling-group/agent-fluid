# Response-residual redirect candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the experiment contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, stable dynamics, and capture. Thus the
  predictive-rate sample is an informative regression, not a semantic
  failure.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  from release through capture for the strongest finite redirect-priority
  sample `solver_3fdd63b3fbda` and the weaker predictive-rate sample
  `solver_3cd7c6486ead`. Both show self-propulsion from quiescent water, a
  coherent alternating three-dimensional wake, productive lateral motion,
  and a target-directed shallow arc without collision or instability. The
  predictive policy visibly advances more slowly: its sheet is still `7.2L`
  away at `10T` and `3.8L` away at `14T`, whereas the redirect-priority sheet
  is at `6.2L` and `3.3L` at `10T` and `13T`. This supports preserving the
  gait and redirect onset rather than changing wake phase or cancelling sway.
- Metrics confirm the visual distinction. Redirect priority captures at
  `16.044T`, score `0.05824`, distance integral `1.82409L`, with a coherent
  `13.178L` head path. The predictive barrier needs `17.418T`, scores
  `-0.04522`, and has integral `1.93044L`; it lowers peak force/moment from
  `0.03579/0.01770` to `0.03001/0.01495` but loses every `10--1L` milestone.
  The byte-identical redirect repeat captures at `16.093T`, establishing a
  roughly `0.05T` timing and `0.0044` integral spread for this release.
- The sampled load-aware carrier gate also fails the inherited materiality
  boundary: capture moves to `16.258T`, path grows to `13.191L`, and peaks
  change only to `0.03500/0.01755`. More decisively, the inherited completed
  response-released-reversal evaluation captures at `16.220T/1.82991L`,
  lengthens path to `13.206L`, leaves peaks at `0.03589/0.01773`, and changes
  greater-than-90% rate residence only from `17.76/8.12%` to
  `17.46/7.90%`. Predictive, load, positive-work, and reversal refinements all
  act on the rhythmic carrier while leaving the extra course-redirect
  curvature active after measured yaw has begun to satisfy the request.

## One-candidate policy hypothesis

Keep the evaluated redirect-priority policy's target geometry, approach
schedule, phase-aware traveling bend, carrier/steering decomposition,
unfulfilled-redirect carrier priority, bounds, and public contract. Change
only the extra velocity-course redirect from a persistent boost into a
response residual: multiply its bounded head-bias and posterior-curvature
weight by the remaining normalized signed-yaw shortfall. Baseline body-frame
route steering and yaw-rate braking remain active, so this is not a terminal
gate or a removal of steering authority.

Expected signature: retain the redirect sample's `10/8/6L` milestone and
capture class, but release excess mean curvature once the fish is already
turning correctly, shortening the `13.09--13.18L` path class and reducing
force/moment and terminal yaw without the `17.4--18.5T` slowdown of carrier
protection. Falsify if capture timing/integral regress beyond the duplicate
redirect spread without material path/load/rate benefit; if either coherent
wake view degrades; or if joint margin, command effort, course error, terminal
yaw/slip, force, or moment exceed the sampled redirect-priority class. The
new CFD result is a prediction for the next worker, not evidence available
here.

bookshelf_consulted: true
source_domain: fish C-start burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a strong curvature command initiates reorientation, then observed directional response releases the burst back to ordinary rhythmic propulsion and tracking
transferable_invariant: extra steering authority should represent unmet body-frame directional response, not remain fully active after same-sign yaw develops
nontransferable_details: species-specific C-start stages, published gains and duty ratios, full-body kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: preserve baseline target/rate feedback and the two-joint traveling carrier; scale only the added normalized velocity-course head/tail redirect by the bounded shortfall of signed yaw response
falsification: reject if early milestones or capture regress beyond repeat variation without shorter path and lower load/rate cost, or if target alignment, joint margin, bounded action, or coherent top-down and oblique wakes deteriorate
