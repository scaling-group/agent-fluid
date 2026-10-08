# Response-opposed intercept-posture allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. The
  assigned prefill `v39_geometry_agreed_course_allocation` captures at
  `19.783508 T`, scores `-0.262179959`, and has mean/final distance
  `2.151933490 L`/`0.749067426 L`.
- The sampled `v40_intercept_supported_terminal_posture` is the only current
  mechanism with a clear semantic improvement. It preserves the parent's
  identical `4 L` crossing at `15.444014 T`, captures at `19.684490 T`, raises
  score to `-0.261384287`, and improves mean/final distance to
  `2.151092787 L`/`0.748302400 L`. Its actual-distance, closure, and
  center-intercept gates therefore convert a small damped-posture handoff into
  useful terminal course shaping rather than premature coasting.
- The posture handoff also reduces below-`4 L` high-command incidence from
  `318/373` to `229/302` anterior/posterior samples and reduces terminal joint
  rate-cap contact from `44/56` to `40/57`, without a joint-angle stop. The
  terminal force/moment envelope remains close: lateral-force maximum changes
  from about `0.02724` to `0.02753` and yaw-moment maximum from `0.01564` to
  `0.01567`. This supports selective posture allocation but not a broad gain or
  force-cancellation change.
- The two alternative terminal carrier-recovery policies do not survive as
  useful positive mechanisms. Both retain the parent's `19.783508 T` capture
  step and nearly identical crossings, loads, and saturation counts; their
  scores move only to `-0.262141399` and `-0.262163153`. Inherited logs show
  that the intercept-unsupported branch changed only `80` same-state commands
  with at most `0.073 rad/T^2`, explaining why a nominally active carrier
  rescue did not materially change the coupled rollout.
- I inspected the complete combined sheets for the best `v40` result and the
  informative lower-quality `v39` parent, including every top-down
  mid-plane-vorticity and oblique body/Lambda2 keyframe from release through
  capture. Both fish visibly self-propel from quiescent water along the same
  compact target-directed arc, form a coherent alternating posterior wake,
  and retain finite localized three-dimensional structures. Neither shows
  passive advection, a loop, collision, boundary-exit precursor, wake collapse,
  instability, or out-of-plane motion. The useful difference is terminal
  trajectory shaping: at the `1 L` crossing, `v40` reaches head position
  `(9.9973,9.4407)L` with heading `0.6337 rad`, compared with
  `(9.9939,9.3990)L` and `0.6830 rad` for `v39`, consistent with the earlier
  capture and not with extra propulsion.
- Reconstructing the directly observed center-intercept and target-angle gates
  on the two stored trajectories places the successful posture-over-redirect
  branch on about `165` `v40` states between `15.89` and `18.30 T`, with mean
  support about `0.080` and the declared `0.12` maximum. Terminal high-command
  and rate contacts remain despite the improvement, so the unresolved locus is
  how that handoff interacts with the realized two-joint response, not whether
  to widen its distance gate or recover cadence after intercept support is
  lost.

## Policy hypothesis

Start from the evaluated `v40_intercept_supported_terminal_posture`, preserving
its oscillator, target guidance, geometry-agreed outer allocator, center-course
intercept, mean-bend equilibrium, closure preview, carrier floor, and command
limit. Add one response-opposed posture allocation inside the existing
intercept-supported branch. For each joint, project its measured angular
velocity onto its error from the already computed damped-posture target; only
motion away from that target contributes. Normalize the maximum outward error
rate by the declared oscillator amplitude squared times its state-dependent
angular frequency, and use a smooth bounded gate to add at most four percentage
points to the existing `12%` posture support. Combine the resulting support
with large-angle redirect by `max`, exactly as in `v40`, so it cannot stack on
an already stronger redirect.

This tests a response-gated handoff rather than a scalar-only hold increase:
the extra posture is zero for joint motion already converging toward the same
equilibrium, zero without a supported center intercept, and zero outside the
actual terminal band. The expected benefit is to arrest the outward portions
of the remaining terminal carrier response while leaving naturally convergent
motion and all outer propulsion intact, reducing high-command/rate contact and
preserving or advancing capture. Falsify the candidate if the branch is
dormant or effectively constant, changes any state at or beyond `4 L`, acts
without closure and intercept support, increases an already stronger redirect,
delays or loses capture, worsens mean/final distance, erases the compact outer
trajectory, creates joint-stop dwell, materially raises loads, becomes
unstable, or degrades either wake view. The new CFD evaluation occurs only
after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop CPG robotic-fish direction tracking and continuous terminal approach-hold control
source_mechanism: use measured oscillator response to hand off selectively from rhythmic propulsion toward a bounded posture equilibrium near a target
transferable_invariant: a low-frequency terminal posture correction sharing rhythmic actuators should receive extra allocation only when observed joint motion opposes that posture, while motion already converging toward it should retain the established allocation
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: inside the existing normalized closure- and center-intercept-supported band, project each joint velocity against its current two-joint posture error, normalize outward error rate by declared oscillator amplitude and frequency, and smoothly raise the same coupled posture handoff without changing its target or outer law
falsification: reject on dormancy or near-constant activation, action outside the terminal intercept regime, slower or lost capture, worse distance integral, renewed joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Loading evaluated `v40` and the candidate in separate Julia modules and
  replaying reconstructed body-frame states from all four current trajectories
  changes `158/151/151/151` stored states, respectively. Every changed state is
  below `4 L`, has positive closure and nonzero center-intercept support, and
  the maximum equal-state two-joint command difference is about
  `1.3522 rad/T^2`. On the evaluated `v40` trace the new response support spans
  approximately `0.00006--0.99998` with mean `0.631`, so it is active and
  materially response-varying rather than an effectively constant gain.
- A deterministic `303750`-state grid spanning distance, target angle, course
  error, translation speed, both joint positions and rates, and closure finds
  `5862` active differences from evaluated `v40`. All outputs are finite and
  within the declared command limit. No state at or beyond `4 L`, with zero
  intercept support, without positive closure, or with both joint rates zero
  changes. These checks establish boundedness, activity, response selectivity,
  and equal-state outer noninterference, not coupled-flow improvement.
- The prescribed `check-runner` was invoked after all material edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and failed
  before executing a command. Its three configured non-CFD checks were then
  run directly and separately. The guidance check initially found the same
  duplicate assigned-parent marker in the rendered root `README.md` documented
  by inherited workers; removing only the duplicate marker repaired parent
  resolution. The material-guidance check, lightweight Julia two-output
  contract, and solver edit-boundary check all pass. The deterministic schema
  audit resolves all `90` direct `params.FIELD` references in the `91`-field
  object returned by `target_policy_params()`; only the version label is
  intentionally unused. No formal CFD was run in this workspace.
