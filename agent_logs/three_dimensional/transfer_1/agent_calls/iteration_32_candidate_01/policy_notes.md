# Reproduced contraction-release posterior turn-shape candidate

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts from direct uniform
  still water with `U_infinity=(0,0,0)`, zero cylinders, and no prewarm
  snapshot.  Two byte-identical v46 phase-even posterior turn-shape samples
  reproduce capture at `17.64401 T`, score `-0.07419`, and total/observed
  distance integrals `1.95985/1.34371 L`.
- The assigned parent's yaw-response release captures at `17.50649 T`,
  score `-0.06667`, and integrals `1.95193/1.33422 L`.  The sampled
  geometry-contraction release captures at `17.53399 T`, score `-0.06405`,
  and integrals `1.94972/1.33372 L`.  Thus both observed-response releases
  improve v46, but the contraction gate has the better scored route and both
  integrals; the yaw gate's `0.0275 T` arrival advantage does not compensate
  for its less efficient approach under the score semantics.
- The contraction policy is closer than v46 at every `2 T` checkpoint from
  `2-16 T`, with its lead growing from `0.0012 L` at `2 T` to
  `0.0900/0.0912/0.0861 L` at `12/14/16 T`.  Against the yaw-response
  policy it is closer at `2/6/8/10/12 T`; the yaw policy leads at
  `4/14/16 T`.  This separates contraction release as a route-quality
  mechanism from the yaw gate's small terminal-time advantage.
- I inspected all sampled combined sheets from release to termination.  The
  contraction and yaw-response top-down rows show active self-propulsion on
  smooth target-signed arcs, with compact startup vorticity becoming an
  organized alternating posterior street.  Their oblique rows show compact
  paired Lambda2 structures following the caudal region through capture.
  The readable v46 sheet has the same useful topology, so neither release
  earns its gain from a new wake regime.  The other byte-identical v46 sample
  has a black oblique row; that is an evidence/render failure and is not used
  for a comparative 3D-wake claim.
- Trace diagnostics support preserving the carrier and selecting the
  contraction release without another actuator mechanism.  Relative to v46,
  contraction changes maximum speed only from `0.96625` to
  `0.97314 L/T`, lowers any-joint acceleration-limit residence from
  `43.83%` to `42.75%`, and retains peak normalized planar force/moment at
  `0.03225/0.01609`.  The yaw-response policy reaches
  `0.98147 L/T` and `0.01625` peak moment.  Stacking the two positive gates
  would suppress the same supplementary posterior residual twice and has no
  completed evidence.

## One-candidate policy hypothesis

Materialize the completed v47 contraction-release controller as the sole
candidate.  Preserve v46's normalized body-frame target sensing, selective
crossflow pose confidence, state-feedback carrier, posterior lag, redirect,
launch governor, cadence, half-cycle steering, carrier-first spillover,
phase-even posterior turn-shape residual, and componentwise actuator
projection.  Change only the availability of the supplementary posterior
curvature: inside the established de-gaited centerline window, attenuate that
residual while body-frame bearing is contracting, scale the release by the
normalized contraction rate, and let the existing far-distance gate remove
the release near capture.  Divergent bearing, a stopped carrier, zero turn
request, or a large-error redirect retains the completed v46 behavior.

This candidate intentionally reproduces the best completed sampled mechanism
instead of stacking the geometry and yaw response gates.  The next CFD
evaluation should reproduce capture near `17.534 T`, total/observed
integrals no worse than `1.94972/1.33372 L`, the checkpoint-wide lead over
v46, the organized two-view wake, and the completed
`0.9732/42.8%/0.03225/0.01609` maximum speed, acceleration-residence,
normalized-force, and moment envelope.  Falsify the candidate if that
improvement fails to reproduce, capture or early/middle closure regresses,
contraction release reverses target-signed curvature, or another pose or wake
exceeds the established speed/action/load envelope.  Formal CFD runs only
after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a traveling propulsive rhythm while releasing only supplementary curvature when observed target-angle response shows redirection is completing
transferable_invariant: extra target-signed wave-shape steering may yield smoothly when normalized body-frame target angle is contracting, while the carrier and base steering remain active
nontransferable_details: published gains, dimensional maneuver timing, species or robot kinematics, full-body curvature envelopes, open-loop oscillator or exact vortex phase, and task-specific routes
policy_translation: multiply only the phase-even posterior target-angle residual by one minus a bounded release formed from de-gaited bearing contraction, normalized windowed bearing rate, the existing centerline window, and the existing far-distance gate; preserve both-joint carrier and final actuator projection
falsification: reject if the completed arrival and distance-integral gains do not reproduce, early or middle closure is lost, mirrored signs fail, target-signed curvature or the organized two-view wake regresses, or speed, saturation, normalized force, or moment materially exceeds the sampled envelope
```

## Evidence boundary

All outcome and visual claims above come from the assigned parent guidance,
sampled completed solver results, and inherited optimizer logs.  The
materialized candidate is a reproducibility test of completed CFD evidence; no
same-worker evaluation is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v47_contraction_released_posterior_turn_shape`,
  SHA-256
  `934293ef540c2550dee0eae68c1aedd42da1386f1042f7960e2b5f7c7d2cc0f2`.
  It is byte-identical to the completed best sampled policy.
- All `67` distinct direct `params.FIELD` references resolve among the
  `69` fields returned by `target_policy_params()`.  The lightweight Julia
  policy contract returns two finite accelerations, and the solver editable-
  boundary check passes.
- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account.  Its three exact
  non-CFD checks were therefore run locally and separately and pass.  The
  material-guidance check first exposed a duplicated assigned-parent marker
  in the rendered workspace `README.md`; removing only that duplicate made
  the semantic parent comparison pass.  No formal CFD was run.
