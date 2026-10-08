# Axial-response-gated posterior phase-lag candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the additional inherited step-38 rollout
  satisfy the frozen Phase 2 contract: direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics,
  and capture. I inspected their combined sheets from release through
  termination. The top-down rows show each fish moving from rest, growing a
  compact release transient into a coherent alternating caudal vortex street,
  and following a smooth target-directed arc. The oblique rows show bounded
  alternating three-dimensional Lambda2 structures without passive advection,
  wake collapse, collision, virtual-boundary exit, or out-of-plane
  instability. The sheets are effectively indistinguishable at their sampled
  resolution, so route, action, and load histories—not vortex prominence—are
  the discriminating evidence.
- `solver_1a8c73736b49`, which keeps target-opposing translational response
  inside the raw-error-opened moment-correction envelope, is the sampled base.
  It captures at `15.686007T`, has distance integral `1.916135L`, final
  distance `0.743392L`, and reaches the `8/6/4/2/1.25L` milestones at
  `9.063996/10.917495/12.765504/14.569510/15.246011T`. Its coherent wake,
  `22.34%` posterior acceleration-limit residence, `34.17 deg` posterior
  excursion, `0.03250` peak body-lateral force, and `0.02036` peak yaw moment
  define the behavior and envelope to preserve.
- The assigned parent releases redirect wave relief when carrier-demodulated
  yaw becomes target-aiding. It retains capture and the same visible wake, but
  delays every milestone, captures at `15.708008T`, raises distance integral
  to `1.918172L`, and scores `-0.035505` versus the base's `-0.033442`.
  Releasing mean correction to the same yaw response is also negative:
  `solver_5346e761db5a` reaches `15.697008T`, integral `1.919504L`, while
  `solver_a3ebfdcbb7c5` reaches `15.713508T`, integral `1.917987L`. The
  inherited component-matched handoff preserves the base arrival step but
  worsens integral to `1.920285L`, final distance to `0.747417L`, and score to
  `-0.038396`. Target-aiding yaw is therefore not permission to hand either
  proven mean curvature or redirect wave relief back on this route.
- The inherited evidence instead supports changing the propulsion primitive.
  Positive body-forward force allocation of the low-speed posterior supplement
  previously advanced capture from `15.977511T` to `15.768509T` while
  preserving the two-view wake. In the sampled-best policy, however, that
  supplement scales the entire posterior target, so it increases the
  in-phase position component and the quadrature lag component together. The
  current sample gives no positive evidence for more whole-wave amplitude,
  while the anterior carrier and target-directed steering are already
  reliable.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion, traveling-wave swimming, and sensor-modulated robotic-fish CPG control
source_mechanism: posterior phase lag supplies direction to a traveling bend, while measured propulsive response gates a bounded sensory modulation of that lag
transferable_invariant: preserve the anterior state-feedback rhythm and the proven base posterior wave, then allocate only a posterior quadrature/lag supplement when normalized axial force confirms a propulsive response
nontransferable_details: published gains, dimensional frequencies, Strouhal targets, species-specific amplitude envelopes, exact tail or vortex phase, open-loop clocks, source morphology, and task-specific routes
policy_translation: start from the sampled-best body-frame controller; retain its positive-force and low-speed gates, but replace whole-wave multiplication by a supplement proportional only to normalized anterior joint velocity, leaving the in-phase posterior position component, steering, approach, and actuator projection unchanged
falsification: reject if an established distance milestone or capture regresses, distance integral rises, the coherent two-view wake changes adversely, posterior excursion or limiting grows without target-progress benefit, or replay shows only clamp-equivalent/negligible feasible action support

## One candidate hypothesis

Produce exactly one candidate from `solver_1a8c73736b49`, not from the
regressed assigned-parent handoff. Preserve its anterior oscillator, base
posterior traveling bend, target/course steering, carrier-demodulated moment
and yaw response, translational persistence, approach and terminal roles,
mean-first allocation, and exact velocity-limit projection.

Change only the existing low-speed response boost. The proven base posterior
wave remains active for every force sign. Within the existing low-speed
eligibility envelope, positive normalized body-forward force opens a bounded
supplement to the velocity-derived posterior lag term; it no longer scales the
in-phase `-q1` component. Thus zero/adverse force returns the evaluated base
wave, positive response produces a more directional lagged bend rather than a
larger geometrically similar oscillation, and non-finite force removes the
supplement. The existing gain and gates own the full mechanism, so this is not
scalar-only tuning and adds no clock, route memory, or world-coordinate cue.

The falsifiable expectation is earlier target-distance milestones or a lower
distance integral while retaining capture, the coherent alternating wake, and
the sampled force/moment and joint-limit envelope. Lower action or limiting
alone is not success. Formal CFD remains post-exit evidence, so no result for
this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `b2b08190b58167ea5d8100783adc79f957e892b09e4c1d81da5aca67beb5b35f`.
  Static schema validation resolves exactly 57 direct `params.FIELD`
  references against the same 57 fields returned by
  `target_policy_params()`, with no missing or unused field.
- The prescribed lightweight Julia contract returns two finite accelerations,
  and a probe with non-finite target, bearing, velocity, force, moment,
  bearing-rate, and heading-rate observations selects a finite fallback. A
  paired reflection check across all 2,852 reconstructed sampled-best states
  has exactly zero lateral-reflection error, and every action stays inside the
  declared acceleration envelope.
- Counterfactual replay on reconstructed sampled-best states changes 462
  posterior commands and no anterior command over `0.0055-3.6520T`. Mean and
  maximum changed-command magnitudes are `1.6721` and `5.7790 rad/T^2`. The
  early support includes zero/adverse-force states where the old absolute-
  magnitude selector could leak its whole-wave endpoint despite a closed
  response gate; the new controller returns the base endpoint there. It adds
  one replayed posterior acceleration-ceiling output (`2035` total two-joint
  ceiling outputs versus `2034` for the sampled best), so CFD must reject the
  candidate if this structural phase-lag test raises limiting without route
  benefit. Replay establishes feasible, non-clamp-equivalent support but does
  not predict closed-loop hydrodynamic performance.
- Guidance materiality, the Julia contract, parameter schema, and solver
  editable-boundary checks pass. The first guidance run exposed the inherited
  duplicate assigned-parent marker in the rendered `README.md`; removing only
  that duplicate repaired the metadata check without changing the assigned
  parent. The configured `.codex/agents/check-runner.toml` was invoked after
  the files were complete, but its pinned `gpt-5.4-mini` model is unsupported
  for this ChatGPT account, matching the inherited infrastructure limitation;
  its three prescribed commands were run separately and pass. No sibling
  candidate or formal CFD rollout was created.
