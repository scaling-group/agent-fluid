# Axial-response allocation with kinematic terminal slip

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics,
  and capture. I inspected both rows of every combined sheet from release to
  termination. The top-down rows show self-propelled target-directed arcs and
  coherent alternating wakes; the oblique body/Lambda2 rows show persistent
  compact caudal structures without collision, domain exit, wake collapse, or
  out-of-plane instability. Visual differences are below sheet resolution, so
  the trace and response metrics—not vortex intensity—separate the policies.
- The assigned parent guidance and inherited logs establish the speed-deficit
  posterior-wave carrier as a replicated baseline, not a scalar-tuning target.
  Its sampled copy captures at `15.977511T`, final distance `0.744403L`,
  distance integral `1.928581L`, and score `-0.045506`, with 238 moving-window
  shifts. Two terminal-slip variants preserve its arrival step and both-view
  wake: direct body-frame target/velocity kinematics improve the crossing to
  `0.744039L`, integral to `1.928275L`, and score to `-0.045128`; subtracting
  windowed recent turn from bearing rate improves less, to `0.744325L`,
  `1.928515L`, and `-0.045425`. The direct kinematic decomposition is therefore
  the stronger terminal input in this sample, though still only terminal
  shaping rather than a new route.
- The axial-force response allocation is the strongest sampled finite rollout.
  Relative to the speed-only baseline, it captures `0.209002T` earlier at
  `15.768509T`, lowers distance integral to `1.924071L`, uses 232 rather than
  238 shifts, and improves score to `-0.041679`. It is not uniformly faster:
  the `10L/8L` crossings are delayed by `0.0440/0.0110T`, while the
  `6/4/2/1.25/0.9L` crossings advance by about
  `0.0660/0.0935/0.1540/0.1650/0.1650T`. Mean posterior demand falls from
  `25.4727` to `25.2206 rad/T^2`, posterior speed-limit residence falls from
  `6.30%` to `5.72%`, and peak lateral force and yaw moment fall slightly,
  although posterior acceleration-limit residence rises from `22.58%` to
  `23.58%` and peak excursion rises from `33.12` to `34.73 deg`. This is a
  route-rephasing response result, not evidence for more amplitude or another
  force threshold.
- The sampled axial allocator and direct terminal kinematic damper are
  independently evaluated children of the same speed-gated carrier. Their
  evidenced action support is separated: the axial branch changes feasible
  posterior action during low-speed response, while the kinematic damper acts
  only in the reliable closing corridor below `0.9L`. A factorial combination
  can therefore test compatibility without changing carrier gains, navigation,
  approach geometry, actuator limits, or either mechanism's parameter values.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion, sensor-modulated robotic-fish CPG control, and terminal approach/holding control
source_mechanism: preserve the rhythmic traveling carrier, allocate only supplemental posterior action from measured axial response, and damp target-relative translational reopening separately from body yaw near capture
transferable_invariant: use bounded normalized body-frame response feedback to reinforce an existing posterior traveling wave only where it produces propulsive response, then use a distinct target-relative kinematic signal to correct terminal slip without suppressing useful body rotation
nontransferable_details: published thrust laws or gains, species-specific envelopes, dimensional frequencies, exact Strouhal values, exact vortex phases, clock-defined bursts, source force scales, and task-specific coordinates or routes
policy_translation: promote the sampled feasible-action axial allocator unchanged outside approach; preserve its base carrier under adverse force; in the existing closing capture corridor use the sampled direct target-body/velocity cross product as the oscillator-normalized translational line-of-sight rate; keep all established route, yaw-residual, approach, allocation, and hard-limit roles unchanged
falsification: reject if the coherent two-view wake, capture, distance integral, or post-6L milestone gain regresses; if terminal crossing worsens; if the branches interact outside their evidenced support; or if acceleration limiting, posterior excursion, lateral force, or yaw moment grows without target-progress benefit

## One candidate hypothesis

Produce exactly one candidate by combining the evaluated axial-response
allocation with the evaluated direct-kinematic terminal line-of-sight input on
their shared speed-gated traveling-bend carrier. The axial branch computes the
already bounded base and boosted posterior commands and smoothly selects only
their feasible difference from nonnegative normalized body-forward force,
while always retaining an unloading boosted endpoint. The base posterior wave
remains active at zero or adverse force. Near capture, the terminal damper uses
the target-body/velocity cross product divided by target distance squared and
carrier frequency, acting only when translation reopens absolute bearing.

This is one factorial candidate with a small compatible mechanism pair, not a
gain sweep. The falsifiable expectation is to retain the axial allocator's
earlier post-6L progress and approximately `15.77T` capture while obtaining at
least the direct kinematic sibling's terminal crossing benefit, without losing
the coherent wake or materially worsening limiting and loads. Formal CFD runs
only after exit; no same-worker hydrodynamic result is claimed.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `c47eba92d75748d07bdc9be731511ac1d390edbab9a2b9a174b8d8bbe4700ff1`.
  Its source differs from the evaluated axial allocator only by substituting
  the independently evaluated direct-kinematic terminal line-of-sight input;
  all controller parameter values are inherited unchanged.
- Static schema validation resolves all `52` direct `params.FIELD` references
  against exactly the `52` fields returned by `target_policy_params()`, with
  no missing or unused field. Lightweight probes return two finite bounded
  accelerations, remain finite when target and axial-force observations are
  non-finite, and preserve lateral reflection equivariance to `1e-12`.
- A far-field synthetic state matches the evaluated axial-response controller
  exactly, while a near-capture state matches the evaluated direct-kinematic
  terminal controller exactly. This confirms that the two inherited endpoints
  remain intact in their disjoint regimes; it is not a hydrodynamic result.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Its three prescribed
  non-CFD commands were therefore run directly and separately: guidance
  materiality, the lightweight Julia policy contract, and solver editable-
  boundary enforcement all pass. No CFD was run.
