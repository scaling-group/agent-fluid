# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled solver evaluations satisfy the direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm, active moving
  window) and capture. Two are the exact intercept-guarded speed-reserve
  baseline (`567de354...`), capturing at `0.7466--0.7494L` in
  `18.3205--18.6010T`; two are the prefilled posterior wave-shape policy
  (`393aac05...`), capturing at `0.7480--0.7492L` in
  `18.1995--18.4690T`. Their distance-integral and scalar-score ranges
  overlap, so the posterior residual does not separate as an improvement.
- The assigned parent's completed inherited rollout is a third exact-byte
  posterior evaluation, and it contradicts the parent's pre-evaluation
  hypothesis: termination is `left_domain`, closest approach is `1.3584L`,
  final distance is `10.5799L`, and score is `-11.4031`. Thus the completed
  record available here is `2/3` captures for the posterior residual, not the
  anticipated three captures. The inherited durable guidance must be revised
  from repeat-compatible success to a concrete negative result.
- I inspected both rows of the combined sheets for all four sampled captures
  and for the inherited posterior failure. The sampled baseline and posterior
  runs all self-propel along nearly identical early paths, lay down coherent
  alternating mid-plane vortices through the terminal approach, and show
  compact three-dimensional Lambda2 structures without carrier collapse. In
  the failure the carrier and wake remain active, but the fish passes below
  the target, continues turning down-left, and exits the lower boundary near
  `32.84T`. The discriminating failure is terminal trajectory geometry, not
  missing thrust, instability, or visual wake breakdown.
- The inherited summaries report overlapping posterior and baseline action
  clipping, joint-speed residence, and force/moment envelopes. Combined with
  the completed miss, there is no evidence-backed secondary-metric benefit
  that compensates for the posterior residual's lost reliability. Retuning
  its scalar gain or intercept thresholds would be unsupported.

## One candidate hypothesis

Remove the posterior phase-dependent acceleration and restore the exact
`dogfish3d_intercept_guarded_speed_reserve_v1` policy represented by both
sampled baseline captures. Preserve its achieved-course route error,
intercept-release veto, state-feedback traveling bend, full additive steering,
and sparse relief of only outward carrier effort near the actuator envelopes.
This is one mechanism-level rollback from the prefilled candidate; no cadence,
route, drive, gate, or steering scalar is tuned.

Expected test: recover the repeat-backed capture topology while retaining the
coherent top-down and oblique wake, far-field closure, and existing
actuator/load envelope. The candidate is preferable to the prefill only as a
robustness restoration; it makes no claim of better score or saturation.

Falsification: distrust the purported baseline reliability if an exact repeat
misses, changes the long-turn topology, weakens either wake view, or exceeds
the established actuator/load envelope. In that case later work should test a
new terminal response observation or steering realization, not reinstate or
scalar-tune the already nonseparating posterior phase residual.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and two-joint phase-lag or wave-shape turning
source_mechanism: preserve rhythmic propulsion while a bounded posterior phase-dependent bias supplies subordinate steering
transferable_invariant: a steering residual may perturb posterior wave shape without replacing the active traveling bend
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact body envelopes, vortex phases, and task-specific coordinates or routes
policy_translation: evaluate the inherited normalized anterior-joint phase residual as one isolated mechanism; remove it rather than retuning it after its exact-byte repeat missed without a secondary-metric benefit
falsification: reconsider only if multiple exact repeats of the residual reliably capture and separate from the restored baseline in terminal path, arrival, loads, or actuator metrics while preserving both wake views
