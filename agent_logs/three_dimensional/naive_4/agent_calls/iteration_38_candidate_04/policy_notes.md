# Target-line observer handoff for anticipatory moment correction

## Evidence diagnosis before the policy edit

- All sampled and inherited rollouts satisfy the released Phase 2 contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. The informative failures
  are therefore weaker finite captures rather than failed termination classes.
- I inspected the assigned parent (`solver_1a8c73736b49`), the weaker
  moment-only control (`solver_2acfcfa19ef8`), and the inherited
  error-independent response hold (`solver_9174fd7e4c02`) from release through
  termination in their combined sheets. In every top-down row a compact
  release transient becomes a coherent alternating caudal vortex train by
  about `4T`, and that train remains organized along a smooth target-directed
  arc. The oblique rows show bounded alternating three-dimensional Lambda2
  structures without advection, wake collapse, collision, boundary exit, or
  out-of-plane instability. The sheets are effectively indistinguishable at
  their sampling resolution, so route, response, and actuator histories—not
  vortex prominence—separate the policies.
- Adding target-line translational opposition inside the moment-only policy's
  already-open raw-error gate is the strongest sampled result. It advances the
  `8/6/4/2/1.25L` milestones from
  `9.0750/10.9560/12.8095/14.6025/15.2900T` to
  `9.0640/10.9175/12.7655/14.5695/15.2460T`, advances capture from
  `15.735508T` to `15.686007T`, lowers distance integral from `1.919818L` to
  `1.916135L`, reduces shifts from `231` to `226`, and lowers posterior
  acceleration-limit residence from `23.59%` to `22.34%`. The coherent wake
  survives, although peak yaw moment rises from `0.01920` to `0.02036`; this
  load increase remains a falsification boundary.
- The completed variants define both sides of the useful response window.
  Releasing the shared supplement as soon as carrier-demodulated body yaw is
  target-aiding (`solver_5346e761db5a`) delays every milestone and captures at
  `15.697008T` with distance integral `1.919504L`. Conversely, allowing adverse
  translation to hold the supplement after raw error closes
  (`solver_9174fd7e4c02`) delays every milestone, captures at `15.730008T`,
  worsens the integral to `1.920874L`, and restores `231` shifts. Its lower
  posterior limit residence (`20.59%`) does not compensate for the longer
  route. Both retain the same visible wake, so neither early yaw-based release
  nor error-independent persistence is a semantic improvement.
- The untested structural question is narrower: once the raw-error gate is
  open, can measurable direct target-line translation—not carrier-demodulated
  body yaw—supersede the anticipatory moment estimate? Adverse translation
  would keep the proven direct backstop, aiding translation would hand the
  moment contribution back to the unchanged base redirect, and near-zero
  translation would retain anticipation. Translation still cannot create duty
  after target/course error closes.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: target error opens a bounded curvature maneuver and measured route response continuously hands control back to the propulsive rhythm
transferable_invariant: preserve the traveling-bend carrier and target-defined turn sign, use an anticipatory response only until a direct route response is observable, then let adverse motion retain correction and aiding motion release it continuously
nontransferable_details: published gains, dimensional rates, species-specific burst shapes, exact tail or vortex phase, clock-defined maneuver stages, world coordinates, and task-specific routes
policy_translation: keep the parent's raw-error gate, direct translational-opposition backstop, linear moment residual, approach fade, and shared 2 degree ceiling; smoothly fade only moment-opposition duty as the magnitude of normalized body-frame translational bearing rate becomes observable, so the existing signed translation branch retains adverse response and aiding response releases to base steering
falsification: reject if capture or any established milestone regresses, distance integral or final crossing worsens, the coherent two-view wake is lost, the force or yaw-moment envelope grows materially, posterior limiting increases without route benefit, or replay shows only clamp-equivalent action

## One candidate hypothesis

Produce exactly one candidate from the assigned parent. Preserve its anterior
oscillator, posterior traveling wave, axial-force response allocation,
target/course steering, carrier phase residuals, linear moment observer, yaw
correction, approach and terminal shaping, mean-first allocation, and exact
actuator projection. Add a smooth response-observability gate from the
magnitude of the existing normalized translational bearing-rate signal. Apply
it only to the anticipatory moment-opposition branch before that branch is
unioned with the unchanged signed translational-opposition branch. Thus:

- measurable adverse translation invokes the parent's evidenced backstop and
  supersedes the moment estimate;
- near-zero translation retains anticipatory moment correction;
- measurable aiding translation releases only moment correction;
- raw target/course error still opens all supplemental duty, and the existing
  approach fade and `2 deg` ceiling remain unchanged.

This is a response-governed handoff within one established steering envelope,
not a scalar gain edit. The falsifiable expectation is fewer unproductive
moment-only corrections and an earlier or shorter route than the assigned
parent without reproducing the too-early yaw handoff or the too-long
error-independent hold. Formal CFD remains post-exit evidence; no outcome for
this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `09e466c5122332e703aa261152b0117f97fb77d00f012ec4d10eec9962b713ff`.
  Static schema validation resolves exactly 57 direct `params.FIELD`
  references against the same 57 fields returned by
  `target_policy_params()`, with no missing or unused field.
- The prescribed Julia contract returns two finite accelerations. A
  deterministic 5,000-pair sweep over mirrored normalized target geometry,
  translation, force, moment, bearing, bearing rate, heading rate, and joint
  state returns bounded finite actions with zero reflection error. Seven
  separate non-finite observation cases also return bounded finite fallbacks.
- A preliminary sign-only aiding handoff changed just 16 parent-trace outputs
  by at most `5.46e-8 rad/T^2`; it was rejected as numerically nominal before
  the final candidate was materialized. The final observability handoff changes
  242 posterior and zero anterior actions on reconstructed assigned-parent
  states over `0.2695-13.7500T`, with mean/max changed-command magnitudes
  `0.1732/2.0265 rad/T^2`. It also changes `227-238` posterior actions on each
  of the four informative alternate traces, establishing repeatable feasible
  support rather than a single-state or clamp-only edit.
- Parent-trace replay creates three new posterior acceleration-ceiling outputs;
  alternate-trace replay creates zero or one. This is not claimed as an
  improvement: the formal rollout must reject the mechanism if that limiting
  grows without milestone or distance-integral benefit.
- Guidance materiality, the lightweight policy contract, and solver editable-
  boundary checks pass. The guidance check initially encountered the inherited
  duplicate assigned-parent marker in the rendered `README.md`; removing only
  that duplicate repaired the comparison metadata. The configured
  `.codex/agents/check-runner.toml` was invoked as required, but its pinned
  `gpt-5.4-mini` model is unsupported for this account, matching the inherited
  logs. Its three prescribed commands were therefore rerun directly against
  the final candidate and all pass. No formal CFD was run.
