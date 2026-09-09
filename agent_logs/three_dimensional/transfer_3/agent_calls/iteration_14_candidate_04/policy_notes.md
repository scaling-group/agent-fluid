# Acceleration-feasible response-triggered C-bend candidate

## Evidence diagnosis recorded before the policy edit

- All four assigned samples report direct uniform still-water initialization,
  background velocity `[0,0,0]`, no prewarm, and capture. The combined sheets'
  top-down rows show a self-propelled fish laying down a coherent alternating
  vorticity street; the oblique rows show compact three-dimensional Lambda2
  structures attached to the same route rather than imposed advection.
- The acceleration-feasible response-triggered C-bend is the strongest sampled
  finite result: it captures at `19.2830T` with score `-0.18218`, versus
  `19.5855--19.8880T` and scores `-0.20338-- -0.20824` for the other three
  captures. It also has the lowest sampled lateral-force RMS (`0.01248`) and
  moment RMS (`0.00699`) except for the slower prefill replication. Because
  the episode already applies the same componentwise acceleration clamp, the
  timing spread is selection evidence, not proof that the redundant policy
  clamp caused the score difference.
- The current samples bracket activation semantics without overturning the
  mechanism. Response-demand recruitment and collision-course recruitment
  both retain the alternating wake and capture near the `0.75L` threshold.
  Thus the reusable feature is continuous distributed C-bend closure, not a
  uniquely identified gate formula.
- The inherited failures define a sharper negative boundary. Safe-intercept
  release loses capture, reaches only `1.712L`, and exits left; reducing the
  posterior mean-steering share while anterior redirect is active reaches only
  `3.191L` and exits left. Its visual route stays almost horizontal above the
  target despite a coherent wake. The successful posterior joint is therefore
  doing indispensable route work as well as propulsion; neither terminal
  coasting nor an anterior-steering/posterior-thrust split is supported.
- Successful unbounded candidates request acceleration beyond the physical
  limit in roughly `39--53%` of anterior and `72--75%` of posterior trace rows.
  This rules out interpreting raw command magnitude as extra authority. The
  selected sample returns only feasible commands while preserving the
  episode-applied dynamics and the completed route.

## Policy hypothesis recorded before editing

Materialize the sampled acceleration-feasible controller exactly: preserve its
normalized body-frame bearing and rotation-invariant LOS-rate feedback, joint-
recoil-conditioned yaw response, continuously recruited anterior redirect,
posterior mean steering, and `28 degree`/`0.55T` traveling carrier. Project the
two returned accelerations componentwise at the physical `1800 degree/T^2`
boundary owned by `target_policy_params`.

This is a contract-level feasibility change rather than a new gain trial. It
should reproduce the completed capture topology without impossible returned
commands. Falsify the selection if capture is lost, arrival is materially later
than the sampled `19.283--19.888T` band, the coherent wake degrades, or loads and
joint-limit occupancy rise. Do not attribute any later score difference to the
explicit clamp alone unless repeated paired evidence separates it from solver
variability.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion and sensor-modulated robotic-fish CPG steering
source_mechanism: retain a persistent propulsive rhythm while bounded sensory feedback adds and continuously maintains mean curvature for direction control
transferable_invariant: preserve the coherent traveling bend and continuous two-joint route feedback within the actual actuator envelope
nontransferable_details: published gains, species-specific envelopes, robot linkage geometry, dimensional frequencies, exact vortex phases, anterior-steering/posterior-thrust separation, and task-specific routes
policy_translation: retain normalized body-frame LOS-response distributed curvature at both joints and expose the episode's componentwise acceleration bound in the two-joint policy output
falsification: reject new steering release or posterior-allocation transfers if they repeat the inherited `1.712L` or `3.191L` high passes; reject this selection if it loses capture or worsens the sampled arrival, wake, load, or limit-occupancy band

## Validation status

- The required guidance semantic-change check and solver boundary check pass.
- Every direct `params.FIELD` reference is owned by
  `target_policy_params()`, and the candidate contains no explicit clock, step,
  randomness, file I/O, fixed obstacle, or memorized-route construct.
- The candidate is byte-for-byte identical to the sampled
  acceleration-feasible policy that completed capture at `19.2830T`.
- The mandated Julia contract probe was invoked but cannot start because this
  environment has no `julia` executable. No CFD was run and no new outcome is
  claimed.
