# Acceleration-feasible replicated-capture C-bend candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization, background velocity `[0,0,0]`, no cylinders or prewarm, and
  finite `capture` termination. They begin at `12.3277L` and cross the `0.75L`
  head-capture boundary at `19.2335--19.8880T`; scores span
  `-0.17657-- -0.20397` and mean-distance terms span `2.06505--2.09373L`.
- The combined top-down and oblique sheets were inspected for the best-scoring
  acceleration-feasible sample (`solver_efd2345fc503`) and the slowest
  unclipped-command sample (`solver_3ae17fe04671`). This generation contains
  no failed termination, so the slowest completed route is the most
  informative available contrast. Both fish are self-propelled: each lays
  down a coherent alternating mid-plane vorticity street and compact
  three-dimensional tail-associated Lambda2 loops through capture, rather
  than drifting with an imposed flow. The slower route finishes on the high
  side of the target (`head_y=10.237L`), whereas the best route finishes nearly
  level (`head_y=9.392L`). Neither view shows wake collapse or a terminal
  three-dimensional instability.
- Metrics agree with the visual diagnosis. Local-flow RMS is only
  `0.01798--0.01879U`, lateral-force RMS is `0.01176--0.01285`, and moment RMS
  is `0.00661--0.00723`; capture therefore comes from the closed-loop route and
  coherent carrier, not advection. Applied acceleration sits at the physical
  bound in `39.5--53.2%` of anterior and `71.6--74.9%` of posterior rows, so
  more raw acceleration cannot be interpreted as more steering authority.
- The two unclipped-command replications capture at `19.5855--19.8880T`; the
  two candidates that explicitly return componentwise feasible acceleration
  capture at `19.2335--19.2830T`. Because the episode already imposes the same
  clamp and identical-policy runs separate appreciably, this supports choosing
  the feasible interface but does not identify the clamp as the cause of the
  timing difference.
- The assigned parent guidance establishes how the response-triggered C-bend
  arose: bearing-only anterior recruitment reached `1.897L` high, while
  continuously sharing the raw yaw residual passed low at `2.317L`. The
  sampled four-capture generation now shows that bounded route-demand
  recruitment between those topologies is a semantic improvement, not merely
  a scalar-score fluctuation. Inherited optimizer notes sharpen the boundary:
  safe-intercept release lost capture at `1.712L`, and reducing posterior mean
  steering while anterior redirect was active lost capture at `3.191L`.
  Continuous two-joint route work must therefore remain active through the
  capture crossing.

## Policy hypothesis recorded before editing

Materialize the sampled acceleration-feasible response-triggered C-bend. Keep
its normalized body-frame bearing, rotation-invariant LOS-rate response,
joint-recoil-conditioned yaw feedback, response-recruited anterior oscillator
center, posterior mean curvature, and `28 degree`/`0.55T` traveling carrier.
Add only the sampled policy-boundary componentwise acceleration projection,
with its physical `1800 degree/T^2` limit owned by `target_policy_params()`.

This candidate should retain the replicated capture topology and coherent wake
while never returning an action outside the actuator envelope. Falsify the
selection if it loses capture, arrives materially outside the sampled
`19.2335--19.8880T` band, degrades the alternating wake, or worsens load and
limit occupancy. Do not attribute later timing or score differences to the
explicit projection without repeated paired evidence separating them from the
observed solver variability.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: persistent propulsive rhythm with bounded sensory feedback continuously adding and releasing mean curvature for route control
transferable_invariant: preserve the coherent traveling bend and keep distributed two-joint route feedback active until observed geometry completes capture, all within the physical actuator envelope
nontransferable_details: published gains, species-specific envelopes, robot linkage geometry, dimensional frequencies, exact vortex phases, anterior-steering/posterior-thrust separation, and task-specific routes
policy_translation: retain normalized body-frame LOS-response recruitment at the anterior oscillator center and posterior curvature, then project both returned accelerations componentwise at the policy-owned physical limit
falsification: reject if capture is lost, arrival leaves the sampled band, the coherent wake degrades, loads or saturation worsen, or a release/separation change repeats the inherited `1.712L` or `3.191L` high passes

## Validation status

- The guidance semantic check, solver boundary check, deterministic parameter-
  schema check, and required non-empty-file checks pass.
- The candidate is byte-identical to the sampled acceleration-feasible policy
  that captured at `19.2335T` with score `-0.17657`.
- The Julia contract probe was invoked but cannot start because this worker
  environment has no `julia` executable. No CFD was run, and no new outcome is
  claimed for this candidate.
