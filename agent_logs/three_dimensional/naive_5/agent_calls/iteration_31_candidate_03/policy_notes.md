# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- All four sampled solver rollouts, the assigned-parent rollout, and the
  inherited force-response rollout satisfy the direct-uniform still-water
  contract (`U_infinity=[0,0,0]`, no cylinders, no prewarm). All capture, so
  the useful comparison is route, arrival, wake coherence, loads, and actuator
  feasibility rather than the milliscale first-crossing distance alone.
- The current samples occupy one narrow family. The translation-side sample
  reaches `0.748338L` at `26.2460T` with the best score, `-0.616147`; course-
  priority reaches `0.748591L` at `26.2405T`; phase-coherent arbitration
  reaches `0.749076L` at `26.2130T`; and carrier relief reaches `0.748792L` at
  `26.3615T`. Each has zero angle, speed, and acceleration contacts, peak
  planar force `0.018834`, and peak yaw moment `0.00979--0.00990`.
- Both visual rows were inspected for all four samples and the assigned
  parent. The top-down sheets show genuine self-propulsion, an orderly
  alternating traveling wake, and the same late upward hook into capture. The
  oblique Lambda2 sheets retain an organized three-dimensional wake through
  approach. There is no imposed advection, wake breakup, boundary event, or
  moving-window rotation artifact. The weaker carrier-relief rollout changes
  timing rather than visible trajectory topology.
- The assigned parent's target-side duty-ratio dwell is now a completed
  negative: it captures at `0.749723L` and `26.3395T` with score `-0.617645`,
  retains the same two-view wake and zero contacts, and does not improve the
  common route. The inherited force-commutated course residual similarly
  captures at `0.748796L` with score `-0.617028`. These results do not support
  tuning dwell strength, late force gating, route/response arbitration, or
  another terminal amplitude.
- The shared path exposes an untested physical deficit before those late gates
  activate. All four sampled trajectories are identical through about
  `19.16T`, when distance first falls below `4.5L`. At `5T` the head is still
  at `y=13.591L` and velocity is `(-0.401,+0.174)L/T`; at `10T` it is at
  `y=13.389L` with velocity `(-0.579,+0.235)L/T`, although the target is at
  `y=9.5L`. Downward translation becomes sustained only later. At the same
  checkpoints, normalized velocity-to-target course error is about
  `0.69--0.72`, while folded body target bearing is only about
  `0.13` to `-0.18 rad`. Thus the body is much better aimed than its
  translational course: more anterior yaw is not the only plausible response.

## Policy hypothesis

Start from the best sampled translation-side controller. Preserve its
state-feedback anterior oscillator, posterior lag, target-aware redirect,
line-of-sight response, capture-scale posterior term, coordinated acceleration
projection, and angle/rate viability guards. Add one upstream posterior
thrust-vectoring mechanism: when translation is observable and normalized
velocity-to-target course error exceeds body target bearing, use the calibrated
course side and anterior joint-state phase to shift the posterior traveling-
wave target slightly toward the required course. Positive closing and the
complement of the existing late translation-distance gate keep the mechanism
on the evidenced far/middle route; startup, low-speed, body/course-aligned,
non-closing, redirect-dominated, and late capture states pass through
continuously.

This changes actuator allocation and wake direction rather than a carrier gain
or terminal threshold. The falsifiable expectation is earlier downward course
acquisition, visible separation from the common pre-`19T` route, lower mean
distance or earlier capture, and retention of the coherent carrier and zero-
contact load envelope. Reject it if the path remains identical until `4.5L`,
capture or wake coherence is lost, propulsion slows, any actuator contact
returns, or peak force/moment exceeds the sampled envelope. If rejected, later
workers should not tune this posterior shift; they should test a different
course-response actuator mapping rather than another late-route scalar edit.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and sensor-modulated robotic-fish phase-lag turning
source_mechanism: anterior motion sustains the body wave while bounded posterior wave-shape modulation redirects reactive thrust under route feedback
transferable_invariant: when body aim is adequate but translational course is not, allocate bounded correction through posterior traveling-wave shape instead of demanding only more anterior yaw
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, clock phase, exact wake phase, and prescribed routes
policy_translation: compare normalized body-frame velocity-to-target course error with body target bearing, then use the calibrated course side and joint-state phase for a bounded posterior target shift only during observable closing motion outside the inherited late corridor
falsification: reject on lost capture or coherent three-dimensional propulsion, unchanged pre-4.5L path, slower approach, any actuator contact, or increased peak force or yaw moment

## Non-CFD implementation audit after policy edit

- Replaying the best sampled policy and the candidate on all `4772` frozen
  sampled states changes `1843` post-guard commands, with `1402` changes above
  `0.05 rad/T^2`. Activation spans `0.011--21.934T` and turns off by
  `3.001L`; the largest command difference is `3.048 rad/T^2`, while the
  candidate's frozen-state peak remains the parent's
  `29.72585 rad/T^2`. This verifies a material upstream mechanism and late
  pass-through, not a hydrodynamic outcome.
- Every direct `params.FIELD` reference is owned by the returned 48-field
  parameter object. A deterministic `20,000`-state edge/random probe returns
  finite two-joint commands within the `30 rad/T^2` envelope and has zero
  numerical lateral-reflection error. Formal CFD was not run in this worker.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account. Running its exact three commands directly
  exposed and repaired a duplicated assigned-parent marker in the rendered
  `README.md`; the guidance semantic check, lightweight Julia contract check,
  and solver editable-boundary check then all passed.
