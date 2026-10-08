# Yaw-separated closing-intercept candidate

## Evidence diagnosis before the policy edit

- All four current solver samples are exact replicas of the prefilled policy:
  they have the same source hash, direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, capture at `16.0544T` after 2,919 steps, final and
  minimum distance `0.745846L`, score `-0.046900`, and 239 moving-window
  shifts. Their motion is self-propelled rather than background advection, but
  the repeated scalar outcome is replication rather than controller diversity.
- I inspected the combined current sheet from release through capture. The
  top-down row shows a small release disturbance developing into a coherent
  alternating lateral wake while the fish follows a smooth target-directed
  arc. The oblique body/Lambda2 row shows compact three-dimensional caudal
  structures persisting along the same arc. There is no visible wake collapse,
  reciprocal standing wiggle, collision, boundary approach, or out-of-plane
  instability. Because all four current sheets and metrics are identical, the
  inherited route-wide residual-rate rollout is the informative failure
  contrast: it kept a coherent wake but missed at `0.785816L`, curled away, and
  exited at `29.293T` with final distance `9.122L` and score `-10.1782`.
- The current four-way replication confirms that carrier-demodulated terminal
  damping is finite and deterministic, but its advantage over the preceding
  aggregate line-of-sight damper remains trace-scale: `0.745846L` versus
  `0.745854L`, with the same capture step and wake topology. Another fitted
  carrier-gain edit or clone would not test a new control mechanism.
- Reconstruction of the current body-frame observations supplies a sharper
  feedback distinction. In the reliable closing corridor, normalized measured
  bearing rate minus the fitted joint-phase yaw carrier and normalized bearing
  rate minus measured body yaw sometimes disagree in sign. Near the final
  reopening, the measured translational target-ray component remains positive
  while the fitted residual becomes negative. The aggregate measured bearing
  rate is still the strongest sampled signal in the tight terminal band, so it
  should not be replaced there.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve rhythmic propulsion while sensor feedback separates repeatable carrier motion from a bounded target-relative response correction
transferable_invariant: isolate the response component associated with target-ray translation during the middle approach, admit it only under validated closing and intercept conditions, and hand continuously to measured net response near capture without suppressing the traveling-wave carrier
nontransferable_details: published gains, clock-defined phase, dimensional frequency, species-specific kinematics and envelopes, exact vortex phase, morphology, and task-specific routes
policy_translation: retain the evaluated two-joint carrier, redirect, wave shaping, approach roles, and tight terminal net-rate damper; for the shared-envelope middle branch only, subtract normalized measured body yaw from normalized body-frame bearing rate so posterior mean curvature responds to translational target-ray reopening rather than a fitted yaw-carrier estimate
falsification: reject if the branch changes pre-corridor milestones, delays or loses capture, disrupts the coherent two-view wake, materially increases limiting or loads, repeats the inherited curl-and-exit topology, or fails to differ from the replicated parent in feasible posterior action

## One candidate hypothesis

Produce exactly one yaw-separated closing-intercept policy. Preserve every
sampled carrier, redirect, wave-relief, approach, terminal handoff, and actuator
projection role. Change only the middle line-of-sight response decomposition:
use normalized measured `bearing_rate - heading_rate` to represent translation
of the target ray in the body frame. Admit its reflection-odd posterior mean
correction only through the existing positive-closing, course-reliable,
predicted-intercept corridor, and fade it into the sampled aggregate
`bearing_rate` damper over the existing shared three-degree envelope near
capture. No clock, world route, new gain, or broad response branch is added.

The candidate is expected to leave the established cruise path and coherent
three-dimensional wake unchanged while correcting the final translational
reopening that the fitted carrier residual does not represent consistently.
The first useful test is retained capture with a non-identical terminal action
trace and no earlier milestone change; a better crossing or distance integral
would support the mechanism. No unevaluated CFD result is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256:
  `aedbb81826468d10f13bce15c261a271377ddd1caf5357d217711a50083b866c`.
  Static schema validation resolves all 48 direct `params.FIELD` references
  against the 48 fields returned by `target_policy_params()`.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  commands were therefore run directly and separately: the material
  guidance/notes check, lightweight Julia policy contract, and solver
  editable-boundary check all pass. The material checker required removal of
  one duplicate assigned-parent marker from the rendered workspace `README.md`;
  this metadata repair does not change the solver or experiment.
- A deterministic sweep of 78,732 paired normalized body-frame states remains
  finite, stays within the acceleration envelope, projects exact outward
  speed-boundary demand, and is exactly lateral-reflection-equivariant. The
  non-finite task-observation fallback is also finite.
- Counterfactual evaluation on reconstructed parent rollout states changes
  only posterior acceleration on 18 samples, by at most
  `1.135179 rad/T^2`. Every changed sample satisfies the intended proximity,
  positive-closing, and safe predicted-intercept conditions; support runs from
  approximately `15.2790T`/`1.5176L` to `16.0489T`/`0.7518L`. This confirms a
  feasible non-clone action difference, not its unevaluated closed-loop CFD
  outcome.
