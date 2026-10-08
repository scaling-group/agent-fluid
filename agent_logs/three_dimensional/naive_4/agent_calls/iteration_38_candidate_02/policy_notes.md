# Realized-response handoff from redirect relief to propulsion

## Evidence diagnosis before the policy edit

- All sampled and assigned-parent rollouts satisfy the frozen Phase 2
  contract: direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture.
  There is no failed termination in this allocation, so the assigned-parent
  regression and weaker finite captures are the informative negative controls.
- I inspected the combined sheets for the sampled-best translational-response
  controller (`solver_1a8c73736b49`) and the assigned-parent response-hold
  controller (`solver_9174fd7e4c02`) from release through termination. In both
  top-down rows the fish moves from rest, develops a compact release transient
  into a coherent alternating caudal vortex train by about `4T`, and maintains
  that train along a smooth target-directed arc. Both oblique rows show bounded
  alternating three-dimensional Lambda2 structures without advection, wake
  collapse, collision, boundary exit, or out-of-plane instability. The sheets
  are effectively indistinguishable at their sampling resolution, so route,
  action, and load histories rather than vortex prominence distinguish them.
- The sampled-best controller keeps translational target-line opposition
  inside the raw-error-opened `2 deg` moment-correction envelope. It captures
  at `15.686007T`, has distance integral `1.916135L`, crosses at `0.743392L`,
  and reaches the `8/6/4/2/1.25L` milestones at
  `9.063996/10.917495/12.765504/14.569510/15.246011T`. This remains the best
  sampled route and is the candidate base.
- The assigned parent let the same adverse-translation signal hold correction
  duty independently after instantaneous target-versus-course error released.
  It regressed every milestone to
  `9.091496/10.983503/12.831505/14.624511/15.301012T`, delayed capture to
  `15.730008T`, and worsened distance integral to `1.920874L` and score to
  `-0.038132`, despite reducing posterior acceleration-limit residence from
  `22.34%` to `20.59%`, posterior excursion from `34.17` to `33.19 deg`, and
  peak body-lateral force from about `0.03395` to `0.03195`. A response signal
  that is useful for release inside an error-opened envelope is therefore not
  evidence for an independent steering hold, and lower limiting/load does not
  rescue a longer route.
- The sampled realized-yaw handoff (`solver_5346e761db5a`) also shows why the
  next test should not release mean curvature. It preserves capture and the
  coherent wake but reaches `15.697008T`, integral `1.919504L`, and score
  `-0.036840`: better than moment-only but worse than the sampled-best direct
  translational persistence. Carrier-demodulated aiding yaw is a supported
  response selector, but removing the best controller's supplemental mean bend
  sacrifices its route gain.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG direction control
source_mechanism: large error opens bounded curvature with temporary wave relief, then measured target-aiding yaw hands control back to a stronger traveling beat
transferable_invariant: preserve the target-directed mean bend while response is established, but continuously restore posterior traveling-wave authority when normalized carrier-demodulated yaw becomes target-aiding
nontransferable_details: published gains, dimensional rates, species-specific burst shape, exact tail or vortex phase, clock-defined maneuver stages, world coordinates, and task-specific routes
policy_translation: start from the sampled-best body-frame translational-response controller; use the existing normalized joint-phase yaw residual and reliable raw redirect gate to reduce only the extra redirect wave-relief increment when yaw is target-aiding, while leaving mean curvature, base steering relief, acceleration reserve, approach law, and terminal shaping unchanged
falsification: reject if capture or an established milestone regresses, distance integral worsens, the coherent two-view wake is lost, posterior limiting or force and moment loads grow without target-progress benefit, or replay shows only clamp-equivalent or negligible action support

## One candidate hypothesis

Produce exactly one candidate from the sampled-best translational-response
policy, not the regressed assigned-parent hold. Preserve its anterior
state-feedback oscillator, posterior traveling bend, target/course steering,
raw-error-opened moment/translation correction, yaw opposition correction,
approach and terminal roles, force-response propulsion allocator, mean-first
allocation, and exact actuator projection.

Add one small response handoff: while reliable raw redirect duty is active,
carrier-demodulated target-aiding yaw continuously returns the wave-relief
coefficient from the strong redirect value toward the already evaluated cruise
value. The handoff changes only attenuation of the opposing posterior
half-cycle; it neither removes the sampled-best mean bend nor strengthens the
aiding lobe beyond the base traveling wave. Loss of aiding response restores
the stronger redirect relief without time, memory, a fixed route, or a new
gain. This translates the shelf's response-triggered return to rhythmic
propulsion rather than repeating the negative scalar/onset and mean-curvature
handoff tests. The falsifiable expectation is earlier target-distance
milestones or a lower distance integral with capture and wake coherence
preserved. Formal CFD remains post-exit evidence, so no result for this
candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `5986c38004f992396074db56de0b772d49120c8df1ef549585bc971e19bf7058`.
  Static schema validation resolves exactly 57 direct `params.FIELD`
  references against the same 57 fields returned by
  `target_policy_params()`, with no missing or unused field.
- The prescribed lightweight Julia contract returns two finite accelerations,
  and non-finite target, velocity, force, moment, bearing, bearing-rate, and
  yaw observations all select finite bounded fallbacks.
- A deterministic 5,000-pair sweep across mirrored normalized body-frame
  target geometry, translation, loads, joint phase, bearing rate, and yaw
  response returns actions inside the declared acceleration envelope with
  exactly zero reflection error. The candidate differs from the sampled-best
  controller on 428 pairs and introduces no additional posterior
  acceleration-ceiling output.
- Counterfactual replay on reconstructed sampled-best trace states changes
  239 posterior commands and no anterior command over `0.4620-15.2680T`.
  Mean and maximum changed-command magnitudes are `0.0886` and
  `1.9439 rad/T^2`, with the same 640 replayed posterior acceleration-ceiling
  outputs as the sampled best. This establishes feasible, non-clamp-equivalent
  support without predicting the unevaluated closed-loop CFD result.
- Guidance materiality, the Julia contract, parameter schema, and solver
  editable-boundary checks pass. No sibling candidate or formal CFD rollout
  was created. The configured `.codex/agents/check-runner.toml` was invoked as
  required, but its pinned `gpt-5.4-mini` model is unsupported for this
  account, matching the inherited parent limitation; its three prescribed
  commands were therefore run separately and all pass.
