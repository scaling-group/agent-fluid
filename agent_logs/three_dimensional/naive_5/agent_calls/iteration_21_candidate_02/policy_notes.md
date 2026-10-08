# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the direct-uniform quiescent-water
  contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and terminate in
  capture. Three executions have the same combined visual sheet and reproduce
  the rate-guard policy at `0.7493656L` and `27.5770T`; the non-duplicate
  angle-guard parent captures at `0.7499920L` and `27.7695T`. The duplicate
  results establish deterministic fixed-pose behavior, not trajectory or
  geometric diversity.
- In both distinct combined sheets, the top-down vorticity row shows
  self-propelled translation from rest, an organized alternating wake, and a
  late correct-sign hook into the capture circle. The oblique body/Lambda2 row
  remains coherent along the same broad route. The wake trails the body through
  `255--264` inertial window shifts, so the visible translation is not storage
  advection. No sampled failure sheet is available; the inherited logs supply
  the informative failures, where terminal waveform, recoil, damping,
  deeper-curvature, and instantaneous intercept variants kept coherent wakes
  but missed at `0.828--1.096L` or diverged earlier.
- The rate guard is a supported improvement over the angle-only parent: it
  retains capture and zero angle contacts, removes all exact `260 deg/T`
  speed-cap samples (from `1124/10098`), slightly reduces acceleration-clamp
  exposure (`1686/10028` versus `1700/10098`), and leaves peak planar
  force/yaw-moment coefficients essentially unchanged
  (`0.02218/0.01034` versus `0.02212/0.01041`). It is therefore retained; the
  small endpoint and score differences are not treated as robustness.
- The three repeated rate-guard captures expose a separate geometric defect.
  At termination, the body-center velocity and head-to-target vector imply a
  projected miss of `0.74933L`, effectively the `0.75L` capture radius, while
  inertial target-line rotation is about `0.8445 rad/T` and yaw response is
  only `0.5457 rad/T`. The course has become nearly tangent: the policy's
  finite-difference head closing speed falls below its full-response threshold
  over the final approach even as the target-line rate and response deficit
  grow. Thus repeat first-crossing success remains a grazing, low-clearance
  interception rather than evidence of a robust capture funnel.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, posterior allocation,
body-frame target/course selector, redirect and terminal release veto,
positive-only line-of-sight response deficit, and both viability guards. Make
one semantic change to the navigation activation: use a smooth union of the
existing positive-closing gate and the existing capture-neighborhood
projected-miss gate. Outside the terminal miss corridor this is exactly the
sampled controller. Inside it, a course still predicted to graze or miss can
keep the positive response residual active as radial closing decays; adequate
yaw still cannot be cancelled because the response-deficit structure is
unchanged.

The falsifiable expectation is repeat capture with a visibly less tangent
terminal approach or greater margin, while retaining the coherent wake, zero
angle/rate contacts, and comparable clamp and load exposure. Reject the
mechanism if it changes the far route, over-turns before capture, loses
propulsion or capture, restores actuator contact, or materially increases
acceleration-clamp residence, planar force, or yaw moment. The new CFD result
is produced only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and continuous terminal capture control
source_mechanism: preserve an effective coupled traveling-wave rhythm while observed target geometry continuously gates a bounded residual steering correction
transferable_invariant: a productive rhythm should remain intact, while a normalized target-line miss condition may sustain only the positive steering-response deficit when radial closing alone ceases to represent interception quality
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain the two-joint body-frame carrier and response-deficit law; smoothly unite its positive-closing activation with the already normalized near-target projected-miss gate so the latter is inactive outside the capture corridor
falsification: reject if the far route changes, target-line rotation was already converging, the terminal path over-turns or still grazes, capture is lost, or wake coherence, actuator viability, clamp residence, force, or yaw moment worsens materially

## Non-CFD implementation audit

- Replaying the two activation formulas on the completed rate-guard trace
  changes only the final `44` samples, from `27.3405T` through capture at
  `27.5770T`. At the final sample, the positive-closing gate is about `0.678`,
  the capture-neighborhood projected-miss gate is about `0.840`, and their
  smooth union is about `0.948`; no far-corridor sample changes.
- On a representative reflected pair of terminal grazing states, both
  two-joint commands negate to floating-point tolerance. The new and sampled
  policies match exactly on a far state. On the near state the change is only
  the anterior positive-deficit channel (`-0.6484` to
  `-1.1280 rad/T^2`), while the posterior command remains
  `2.3280 rad/T^2`; all outputs remain finite and bounded.
- The mandated checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this ChatGPT account. Its exact three checks were run
  directly and separately: the guidance semantic-delta check, finite two-joint
  Julia policy contract, and solver editable-boundary check pass. The guidance
  checker initially exposed two identical assigned-parent markers in the
  rendered workspace `README.md`; the repeated listing is now labeled as a
  duplicate sample while one authoritative prefill marker remains. All `41`
  direct `params.FIELD` references are owned by `target_policy_params()`, and
  the required main candidate is present and non-empty. No CFD was run in this
  workspace.
