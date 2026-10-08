# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent guidance is the completed phase-even posterior
  wave-shape controller.  It preserves the state-feedback carrier and adds a
  small target-signed posterior curvature residual gated by absolute anterior
  joint motion.  No inherited optimizer log exists under `logs/optimize/` in
  this rendered workspace, so the available inherited record is the parent
  guidance plus the sampled rollout artifacts.
- All four sampled evaluations use direct uniform still-water initialization,
  terminate in capture, and begin at `12.3277 L`.  Two byte-identical v46
  samples reproduce `17.6440 T`, score `-0.07419`, and total/observed distance
  integrals `1.95985/1.34371 L`.  The response-gated v47 captures at
  `17.5065 T`, score `-0.06667`, and `1.95193/1.33422 L`; the prefilled
  contraction-released v47 captures at `17.5340 T`, score `-0.06405`, and
  `1.94972/1.33372 L`.
- The contraction-released rollout is closer than the response-gated rollout
  by about `0.006-0.026 L` at the `4-12 T` checkpoints.  The response-gated
  rollout becomes closer by `0.018/0.028/0.032 L` at `14/16/17 T` and arrives
  `0.0275 T` earlier.  Thus the scalar-score winner and the fastest arrival
  expose a real early-versus-late tradeoff rather than a terminal-sample
  artifact.
- Top-down rows for the three distinct controllers show self-propelled,
  target-directed motion with a coherent alternating posterior street rather
  than advection or a wake-topology change.  The best contraction-released and
  response-gated combined sheets also have readable oblique Lambda2 rows with
  compact alternating structures persisting from release through capture.
  The two reproduced v46 sheets have black oblique panels; that is an
  evaluation-evidence failure, not evidence of absent 3D vortices.  The
  readable variants and the top-down rows do not show collision, gross lateral
  waste, or wake collapse before capture.
- Trace cross-checks bound the tradeoff.  Mean/max speed is
  `0.7199/0.9662`, `0.7258/0.9815`, and `0.7235/0.9731 L/T` for v46,
  response-gated, and contraction-released respectively; any-joint
  acceleration-limit residence is `43.83%`, `42.66%`, and `42.75%`.
  Peak normalized force remains `0.03225`; peak moment is `0.01609` for v46
  and contraction release and `0.01625` for response release.  The completed
  gains therefore come from steering-response allocation, not more drive or a
  new wake/load envelope.
- Reconstructing the two release observations from each completed state trace
  separates their useful regimes.  On the contraction-released trace, mean
  geometric release is about `0.227/0.215` over `0-6/6-12 T` and about
  `0.009/0.001` after `12/15 T`.  Correct-sign requested yaw is active in about
  `32%` of `12-15 T` samples and `51%` thereafter, while post-`12 T` overlap
  with geometric contraction is below `1%`.  Small-error bearing contraction
  and out-of-band correct-sign yaw are therefore complementary observations
  of completion, not redundant multipliers.

## Policy hypothesis

Keep every carrier, sensing, route, launch, redirect, and allocation term from
the prefilled contraction-released v47.  Change only the scale of the small
phase-even posterior turn-shape residual.  Inside the established centerline
window, retain the validated bounded contraction release.  As de-gaited
bearing moves out of that window, continuously hand release authority to the
validated correct-sign yaw response.  Combine the two mutually weighted
completion modes by their maximum so they cannot stack above a full release.

This should preserve the contraction controller's early/middle integral lead
while removing supplementary curvature during the late target-signed yaw
episodes where the response-gated comparator closed sooner.  It is falsified
if capture or the `4-12 T` lead is lost, the `14-17 T` response advantage is
not approached, the alternating two-view wake decoheres, or max speed,
acceleration-limit residence, normalized force, or normalized moment exceeds
the completed response-gated envelope materially.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and fish burst-redirect control
source_mechanism: preserve a propulsive rhythm while releasing only added turning curvature when observed directional response appears
transferable_invariant: rhythmic propulsion and transient steering authority should be separated, and supplementary curvature should yield continuously to measured geometric or yaw completion
nontransferable_details: published oscillator gains, species-specific body envelopes, dimensional cadence, exact beat or vortex phase, and task-specific routes
policy_translation: use normalized body-frame de-gaited bearing, its windowed trend, requested turn sign, and de-gaited yaw rate to partition release of only the posterior turn-shape residual under the two-joint state-feedback contract
falsification: reject if early or late closure regresses, capture or coherent propulsion is lost, response signs fail under reflection, or the established speed, saturation, force, and moment envelope is materially exceeded
