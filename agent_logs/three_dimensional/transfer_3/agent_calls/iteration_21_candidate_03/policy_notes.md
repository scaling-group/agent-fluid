# Independent reproduction of outer traveling-bend limiter coupling

## Evidence and visual diagnosis before the policy edit

- Three sampled evaluations reproduce the inherited `v29` center-intercept
  policy exactly: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, capture at `25.118523 T`,
  score `-0.5280772274`, mean distance `2.429087214 L`, and final distance
  `0.746135294 L`. The fourth sample evaluates `v33`, whose only controller
  change is a `12%` blend from independently clipped outer commands toward a
  common-scale two-joint limit. It captures at `23.435516 T`, improves score to
  `-0.4079736071` and mean distance to `2.305032573 L`, and ends at
  `0.749060333 L`.
- I inspected both combined sheets from release through termination. In both
  the reproduced `v29` baseline and the best finite `v33` sample, the fish is
  self-propelled from quiescent flow, turns along a compact target-directed
  path, sheds a coherent alternating top-down wake, and retains finite oblique
  three-dimensional Lambda2 structures. Neither shows passive advection,
  collision, a loop, a boundary-exit precursor, wake collapse, or out-of-plane
  instability. The coupled limiter produces a visibly different, more direct
  outer trajectory with a denser advancing wake, then retains the quiet held-
  bend terminal glide into capture.
- Telemetry agrees with the visual difference. At `12 T`, `v33` is at
  `7.2001 L` with speed about `0.805 L/T`, versus `7.7792 L` and `0.615 L/T`
  for `v29`. The anterior/posterior acceleration-cap incidence changes from
  about `39.2%/31.5%` to `26.7%/33.0%`; neither policy clips inside `4 L` or
  dwells at a joint stop. The faster path is not load-free: global force/moment
  maxima rise slightly from about `0.02834/0.01499` to `0.02858/0.01520`, and
  below-`4 L` maxima from `0.01548/0.00800` to `0.01623/0.00833`. Those small
  increases, the different outer topology, and the single available `v33`
  rollout make exact reproduction more informative than stacking a new
  response or changing the coupling amount.
- The inherited optimizer note proposed partial common scaling specifically to
  preserve the requested anterior-to-posterior command direction where
  independent clipping flattened it, while remaining algebraically dormant in
  the validated terminal band. Its subsequent CFD result is a positive
  semantic improvement, not merely a smaller command or a threshold-step
  artifact, because capture advances by `1.6830 T` and the distance integral
  improves by `0.12405 L` while coherent propulsion and finite dynamics remain.

## Policy hypothesis

Promote the sampled `v33` policy unchanged as this workspace's one candidate.
Preserve the state-feedback oscillator, posterior lag, target-angle redirect,
closure preview, shared terminal mean bend, helpful-crossflow and settled-
response gates, center-velocity intercept corridor, and paired terminal
release. Outside `4 L` only, reproduce the parameter-owned `12%` blend from
componentwise clipping toward a common scale of the raw two-joint carrier;
inside `4 L`, retain the inherited command algebra exactly.

This is an independent reproduction of one actuator-coordination mechanism,
not scalar-only gain tuning and not a same-regime terminal stack. Falsify the
positive result if the new CFD rollout fails to reproduce the earlier capture,
meaningful arrival/mean-distance improvement, coherent two-view wake, and
finite no-joint-stop behavior, or if the small observed load increase grows.
Because the new evaluation occurs only after this worker exits, it is not
claimed as evidence here.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body swimming together with coupled-oscillator robotic-fish control
source_mechanism: preserve coordinated anterior-to-posterior traveling-bend structure and posterior lag while enforcing a bounded actuator envelope
transferable_invariant: common bounded scaling preserves the direction of an over-limit coordinated two-joint rhythmic command better than unrelated component flattening
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and actuator envelopes, full-body waves, exact phase lags, vortex phase, capture geometry, and task-specific routes
policy_translation: reproduce a small parameter-owned blend toward common-scale limiting only for the outer raw carrier while preserving normalized body-frame guidance and making the mechanism dormant throughout the terminal reallocation band
falsification: reject on non-reproduction of the faster capture and lower distance integral, terminal-command interference, changed terminal mean bend, lost capture, joint-stop dwell, material load growth, instability, or degradation of either wake view

## Non-CFD implementation audit

- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account. Its three configured checks were therefore
  run directly and separately: the material-guidance check, finite two-output
  Julia contract check, and solver-boundary check all pass. The rendered
  `README.md` initially listed the same assigned parent twice; removing only
  that duplicate marker repaired the guidance check without changing the
  assigned parent.
- The candidate is byte-identical to the evaluated `v33` sample. A separate
  deterministic schema audit finds all 79 direct `params.FIELD` references in
  the 80-field object returned by `target_policy_params()`; only the version
  label is intentionally unreferenced. These are contract and reproduction
  checks only, not new CFD evidence.
