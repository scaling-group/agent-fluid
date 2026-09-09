# High-demand response-deficit allocation candidate

## Evidence diagnosis recorded before the policy edit

- Every sampled and inherited rollout used direct uniform
  `U_infinity=(0,0,0)` initialization without cylinders or prewarm. In the
  successful response-triggered C-bend sheets, the top-down row shows
  body-led translation and a coherent alternating mid-plane street, while the
  oblique row shows compact tail-associated Lambda2 structures through the
  direct approach. The fish is self-propelled rather than advected by local
  flow (magnitude RMS about `0.018U`) or moving-window transport.
- The assigned parent describes the acceleration-feasible C-bend as a reliable
  baseline, and the current solver samples support three finite captures by
  its exact policy hash: `19.2335T`, `19.2830T`, and `19.7395T`, with scores
  from `-0.17657` to `-0.20624`. However, a sampled inherited optimizer log
  contains a fourth run of that same hash which reaches only `1.845L`, exits
  left at `28.875T`, and scores `-9.77873`. Its visual rows retain a coherent
  wake but pass high; this is route sensitivity, not propulsion collapse.
- The identical-hash capture and miss remain close through roughly `6T`, then
  separate while the normalized route request grows. At `14T` the miss is at
  head `y=12.22L`, bearing about `-0.80 rad`, and saturated target yaw request
  `+0.50 rad/T`; by `18T` it is still `2.33L` away. The best capture is at
  head `y=11.25L`, bearing about `-0.10 rad`, and `1.56L` away at `18T`.
  Sustained posterior saturation (`73.6--74.9%` of sampled rows) therefore
  does not reliably turn a large response deficit into route closure.
- The allocation evidence bounds the change. Removing `75%` of posterior
  mean curvature from an active anterior gate loses capture at `3.191L`.
  Moving only same-sign posterior mean curvature forward while conserving
  total slow curvature captures at `20.020T` and reduces action RMS from
  `25.19/28.56` to `15.71/18.97 rad/T^2`, force-magnitude RMS from `0.01322`
  to `0.00816`, and moment RMS from `0.00690` to `0.00432`. A normalized-range
  gate is a concrete negative result: it first passes at `1.62L`, makes a
  broad orbit, and captures only at `49.742T`. Allocation must respond to route
  demand and observed yaw deficit rather than proximity alone.

## Policy hypothesis recorded before editing

Preserve the evaluated state-feedback oscillator, posterior lag, normalized
body-frame bearing and rotation-invariant LOS-rate request, phase-conditioned
yaw residual, continuously closed two-joint steering, and componentwise
physical acceleration projection. Add one allocation semantic: compute the
already evaluated sign-coherent, total-curvature-conserving transfer, but
multiply it by the existing smooth high-route-response weight. Thus early
allocation remains negligible; posterior correction moves into the anterior oscillator
center only when the LOS request is large and the phase-conditioned yaw error
asks for correction in the same direction. Opposing posterior correction is
never removed, and no range, time, coordinate, or terminal-release gate is
introduced.

The candidate should preserve the strong early wake, intervene on the sampled
high-pass branch once route demand saturates, and reduce duplicated posterior
work without reproducing the near-range orbit. Falsify it if capture is lost,
arrival exceeds the conserving allocator's `20.020T`, the direct route becomes
a broad orbit, force/moment or acceleration-boundary occupancy do not fall
relative to the bounded baseline, or anterior joint position approaches its
`45 degree` bound. The new CFD outcome is not available in this workspace and
is not claimed.

bookshelf_consulted: true
source_domain: Lighthill reactive-thrust allocation, sensor-modulated robotic-fish CPG steering, and response-released C-start redirection
source_mechanism: preserve posterior phase-lagged propulsion while recruiting distributed slow curvature only for an observed large direction demand that the current yaw response has not met
transferable_invariant: keep the traveling bend and route loop closed, preserve opposing corrective curvature, and condition actuator redistribution on normalized demand plus response rather than elapsed phase, absolute position, or target range
nontransferable_details: analytical force coefficients, published gains, species envelopes, robot linkage geometry, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: multiply same-sign normalized anterior/posterior curvature transfer by the existing body-frame high-LOS-response weight, add the transferred bend to the anterior oscillator center, subtract it from the posterior mean target, and retain the bounded two-joint carrier
falsification: reject if capture or early wake coherence is lost, arrival exceeds `20.020T`, the high-pass or long-orbit topology remains, loads fail to improve, or anterior position saturation appears

## Validation status

- The required guidance semantic-delta check and solver edit-boundary check
  pass after removing a duplicated assigned-parent marker from the rendered
  workspace `README.md`.
- Static schema checking confirms all `23` direct `params.FIELD` references
  are returned by `target_policy_params()`. A deterministic `10,000`-state
  equation audit confirms finite bounded actions, reflection equivariance,
  exact slow-curvature conservation, and allocation weight in `[0,1]`.
- The independent Julia contract command was invoked but cannot start because
  this container has no Julia executable or Julia environment module. No CFD
  was run, and no outcome for this candidate is claimed.
