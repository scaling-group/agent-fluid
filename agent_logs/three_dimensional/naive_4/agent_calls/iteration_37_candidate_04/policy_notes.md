# Target-line response hold for bounded posterior redirect

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase 2 release contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. There is no failed
  termination in this sample, so the weaker finite captures and inherited
  logged regressions are the informative negative controls.
- I inspected the assigned parent's combined keyframe sheet
  (`solver_1a8c73736b49`) and the weaker moment-only sheet
  (`solver_2acfcfa19ef8`) from release through termination. In both top-down
  rows, the fish moves from rest while a compact release transient develops
  into a coherent alternating caudal vortex train by about `4T`; the train
  remains organized through the target-directed arc. Their oblique rows show
  bounded alternating three-dimensional Lambda2 structures and a smooth body
  path, without advection, wake collapse, collision, boundary exit, or
  out-of-plane instability. The sheets are nearly indistinguishable at their
  sampling resolution, so route and actuator histories, not vortex prominence,
  distinguish the mechanisms.
- The assigned parent adds translational target-line opposition to the same
  bounded carrier-demodulated moment correction. Relative to moment-only, it
  advances the `8/6/4/2/1.25L` milestones from
  `9.0750/10.9560/12.8095/14.6025/15.2900T` to
  `9.0640/10.9175/12.7655/14.5695/15.2460T`, advances capture from
  `15.735508T` to `15.686007T`, lowers distance integral from `1.919818L` to
  `1.916135L`, reduces window shifts from `231` to `226`, and improves final
  distance from `0.744372L` to `0.743392L`. Posterior acceleration-limit
  residence also falls from `23.59%` to `22.34%` and posterior excursion from
  `35.15` to `34.17 deg`, although mean posterior demand rises from `25.01` to
  `25.20 rad/T^2` and peak yaw moment from `0.01920` to `0.02036`. The route
  gain therefore survives wake, limiting, and load cross-checks, while the
  moment increase remains a falsification boundary.
- The two alternative response releases sharpen the mechanism. Replacing net
  terminal line-of-sight damping with translation-only damping is exactly
  trajectory-equivalent to moment-only (`solver_883a064fe477`), so another
  terminal threshold is not useful support. Releasing anticipatory moment
  duty as soon as demodulated yaw becomes target-aiding
  (`solver_a3ebfdcbb7c5`) captures at `15.713508T` with integral `1.917987L`:
  better than moment-only but worse at every milestone than the assigned
  parent's direct translational persistence. Realized body yaw is therefore
  too early a release signal for the route benefit evidenced here.
- The inherited parent notes show that the current translational backstop
  changed 823 feasible posterior commands without adding an acceleration-limit
  hit, while the prior odd-cubic carrier veto and moment-plus-lateral-load
  consensus both lengthened the route. Preserve the linear carrier model and
  the single `2 deg` correction ceiling; do not add another load term or tune a
  classifier. The remaining structural mismatch is that current translational
  opposition is still multiplied by the instantaneous raw error-onset gate,
  even though it is itself the measured adverse response meant to control
  release.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a large target error opens a bounded curvature response, while measured route response governs continuous release back to rhythmic propulsion
transferable_invariant: preserve the traveling-bend carrier and target-defined turn sign, but retain a bounded supplemental mean bend while normalized target-line translation remains adverse and release it as soon as translation realigns
nontransferable_details: published gains, dimensional rates, species-specific burst shape, exact tail or vortex phase, clock-defined maneuver stages, world coordinates, and task-specific routes
policy_translation: leave moment rejection error-opened, but let reliable body-frame translational line-of-sight opposition independently hold duty within the existing shared 2 degree posterior-curvature envelope; retain the current redirect turn magnitude and approach fade so small error and proximity still return continuously to the carrier
falsification: reject if capture or any established milestone regresses, distance integral or final crossing worsens, the two-view coherent wake is lost, the yaw-moment/force envelope grows materially, posterior limiting increases without route benefit, or replay shows only clamp-equivalent action

## One candidate hypothesis

Produce exactly one candidate from the assigned parent. Preserve its anterior
oscillator, posterior traveling wave, axial-force response allocation,
target/course steering, phase residuals, linear moment observer, yaw correction,
approach and terminal shaping, mean-first allocation, and exact actuator
projection. Split the existing shared response gate into two roles:

- carrier-demodulated moment opposition remains multiplied by the reliable raw
  redirect-onset gate;
- translational target-line opposition receives course reliability directly,
  so it can hold rather than open supplemental redirect duty after pointwise
  target-versus-course error falls below the onset.

Smoothly union those roles before the unchanged approach fade and `2 deg`
curvature ceiling. The extra bend direction and magnitude remain the bounded
`redirect_turn`, so small course error cannot create a full static turn and
target-aiding slip receives zero added action. This is a response-release
mechanism, not a gain-only change. The falsifiable expectation is an earlier
middle/late route or lower distance integral without sacrificing capture, wake
coherence, or the parent's reduced posterior limiting. Formal CFD remains
post-exit evidence and no outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `ebbcc2fd4a3f33e25e13a22963617baf959b1856737066a8810d67cbea9ae559`.
  Static schema validation resolves exactly 57 direct `params.FIELD`
  references against the same 57 fields returned by
  `target_policy_params()`, with no missing or unused field.
- The prescribed lightweight Julia contract returns two finite accelerations.
  A deterministic 5,000-pair sweep across mirrored normalized body-frame
  target geometry, translation, force, moment, joint phase, bearing rate, and
  yaw response returns bounded finite actions with zero reflection error.
  Non-finite target, velocity, force, moment, bearing, bearing-rate, and yaw
  observations also select bounded finite fallbacks.
- Counterfactual evaluation on reconstructed assigned-parent trace states
  changes 873 posterior commands and no anterior command over
  `0.2255-15.6475T`. Mean and maximum changed-command magnitudes are `0.2860`
  and `2.9336 rad/T^2`, with no new acceleration-ceiling hit. This establishes
  broad feasible, non-clamp-equivalent support for the response-hold test but
  does not predict its closed-loop CFD result.
- Guidance materiality, the Julia contract, and the solver editable-boundary
  checks pass. The guidance check initially encountered the inherited duplicate
  assigned-parent marker in the rendered workspace `README.md`; removing only
  that duplicate repaired the comparison metadata. The configured
  `.codex/agents/check-runner.toml` was invoked as required, but its pinned
  `gpt-5.4-mini` model is unsupported for this account, matching the inherited
  parent log. Its three prescribed non-CFD checks were therefore run directly
  and pass. No formal CFD was run.
