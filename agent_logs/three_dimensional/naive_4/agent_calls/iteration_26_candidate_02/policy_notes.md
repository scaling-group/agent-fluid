# Carrier-demodulated closing-intercept candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  prewarm or cylinders, finite dynamics, capture at approximately `16.0544T`,
  and 239 moving-window shifts. Their translation is self-propelled rather
  than background-flow advection.
- I inspected the combined sheets for the highest-scoring sampled policy
  (`solver_b8f061aba429`) and the most informative sampled regression
  (`solver_a03406b458eb`) from release through termination. In both the
  top-down vorticity and oblique body/Lambda2 rows, each fish develops and
  retains a coherent alternating caudal wake along the same smooth
  target-directed arc. There is no wake breakup, passive drift, collision, or
  out-of-plane instability. Their visible trajectories are indistinguishable
  at sheet resolution, consistent with the metric differences being confined
  to terminal control rather than a new wake topology.
- The sampled net line-of-sight-rate terminal damper
  (`solver_8474fe870fa5`) captures at `16.054375T`, final distance
  `0.745854L`, distance integral `1.929846L`, and score `-0.0469084`. Broad
  bearing-rate posterior-lobe relief (`solver_a03406b458eb`) changes only 17
  final commands and regresses to `0.745940L`, `1.929919L`, and `-0.0469984`;
  another terminal wave gate is therefore unsupported.
- The strongest current sample (`solver_b8f061aba429`) first subtracts the
  evidenced anterior-joint-phase carrier prediction from normalized bearing
  rate, but admits the residual response only inside the established closing
  capture corridor and fades it continuously into the raw terminal damper.
  It changes four feasible posterior commands between `1.518L` and `1.259L`,
  retains the same coherent two-view wake and capture step, and improves final
  distance to `0.745846L`, distance integral to `1.929840L`, and score to
  `-0.0468999`.
- The inherited stronger route-level version is the critical negative
  control. It opened a separate two-degree residual mean brake from about
  `4.34T` across roughly 950 commands. Its wake remained coherent, but it
  missed capture at `0.785816L`, curled away in both views, and exited the
  virtual domain at `29.293T` with final distance `9.122L` and score
  `-10.1782`. Carrier subtraction alone does not make instantaneous residual
  bearing rate a safe route signal.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve the rhythmic propulsive carrier while applying bounded sensor feedback to a separated target-response residual
transferable_invariant: distinguish repeatable joint-phase motion from persistent target-line response, and introduce residual steering only through a validated state-conditioned handoff that cannot suppress the carrier broadly
nontransferable_details: published gains, clock-defined CPG phase, dimensional frequencies, species-specific envelopes, exact vortex phases, morphology, and task-specific routes
policy_translation: retain the evaluated two-joint traveling-bend carrier, redirect, wave shaping, and terminal net-rate damper; subtract the normalized anterior-phase response from measured body-frame bearing rate only inside the positive-closing safe-intercept corridor, share the existing three-degree posterior mean-curvature envelope, and fade continuously to raw terminal damping
falsification: reject if the closing-corridor branch changes earlier milestones, delays or loses capture, disrupts the coherent two-view wake, raises limiting or loads materially, or repeats the inherited near-miss-and-exit topology; do not expand it route-wide unless new evidence improves milestones and capture semantics

## One candidate hypothesis

Materialize exactly the evaluated `solver_b8f061aba429` feedback structure.
The anterior oscillator, posterior lag, response-gated redirect, one-sided
wave relief, approach settling, redirect handoff, and exact-boundary
anti-windup remain unchanged. Before the tight terminal interval, normalized
bearing rate is demodulated by the existing anterior joint-phase response
model. Residual reopening can subtract posterior mean curvature only when
target closing, course reliability, and the safe predicted-intercept corridor
all agree. As proximity enters the validated terminal band, this response
fades into the sampled raw net line-of-sight-rate damper, with interpolation
weights summing to at most one.

The prior sampled evaluation supports a small but repeatable terminal benefit
without a new route or wake claim. The new rollout should reproduce capture,
the coherent alternating 3D wake, and the existing milestone/load envelope;
any loss of that semantic class outweighs the trace-scale score improvement.

## Non-CFD verification after the edit

- The materialized candidate is byte-identical to the evaluated
  `solver_b8f061aba429` policy, with SHA-256
  `650a2d0d74c0edd84a42a13119a7df8a6eafbe4dbed2b73256434fb2dbb2e6e2`.
  That rollout is prior sampled evidence, not a same-worker CFD claim.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Running its three commands directly and
  separately passes the material guidance/notes check, lightweight Julia
  policy contract, and solver editable-boundary check. No CFD was run.
- A deterministic audit finds all 48 direct `params.FIELD` references among
  the 48 fields returned by `target_policy_params()`. Across 437,400 paired
  normalized body-frame states, commands are finite, remain within the
  acceleration envelope, and have zero numerical lateral-reflection error;
  the non-finite task-observation fallback is also finite.
