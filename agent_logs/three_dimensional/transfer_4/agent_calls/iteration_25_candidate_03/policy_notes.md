# Candidate wake-policy reasoning

## Evidence diagnosis

- The assigned `v12` parent and its exact repeat capture at `18.0125T` with
  score `-0.064599` and mean distance `1.950823L`. The sampled `v15`
  reserve-phase partition is episode-equivalent, so changing only the phase
  reference of conditional extra posterior work is a concrete null result.
- The sampled finite leader, `v16`, preserves far/middle motion exactly and
  gates only posterior oscillatory excursion during simultaneous near-target
  misalignment and yaw. It captures at `18.0235T`, improves score slightly to
  `-0.064545` and mean distance to `1.950801L`, shortens center path from
  `13.2330L` to `13.2111L`, and improves final alignment/yaw from
  `0.0678/1.0891 rad/T` to `0.1818/0.4200 rad/T`.
- In both the parent and `v16` keyframe sheets, the fish is self-propelled from
  direct-uniform still water. The top-down row shows an organized alternating
  wake and monotone target approach; the oblique row shows coherent caudal
  structures without visible out-of-plane instability. The useful transit
  wake is therefore something to preserve, not a failure to overpower.
- The assigned parent guidance proposed a bounded course residual, but the
  inherited completed tests supply the needed falsification: direct
  course-to-curvature feedback and three desired-yaw-rate translations all
  retained capture and a coherent two-view wake yet regressed score, final
  alignment, or final yaw. Extending posterior relief also improved alignment
  only by delaying and widening capture. The missing degree of freedom is
  therefore terminal steering allocation, not another error signal or longer
  relief window.
- The raw inherited worker logs contain only capture scores (`-0.064645`,
  `-0.064995`, `-0.064888`, and `-0.064778`) and final radii. They corroborate
  non-improvement but cannot identify a controller mechanism without the
  policy/trajectory evidence preserved in the sampled guidance, so they are
  not used to tune a scalar or rank terminal dynamics.

## Policy hypothesis

Start from sampled `v16`. Reuse its approach/misalignment/yaw gate to move a
small bounded fraction of the already validated odd mean-tangent target from
the posterior joint to the anterior joint. Subtract the same mean component
from the posterior target and form the posterior traveling wave from the
mean-free anterior state. This keeps total requested mean tangent, posterior
lag, the far/middle controller, and the `v16` posterior envelope unchanged.
The expected effect is a more forward steering moment during only the poorly
aligned terminal turn, without injecting another delayed course-error loop.

bookshelf_consulted: true
source_domain: classical and robotic-fish mean-curvature turning
source_mechanism: distribute a bounded average bend across propulsive joints while retaining the traveling rhythm
transferable_invariant: steering authority can be changed by moving an existing mean bend along the body without changing its sign or total requested tangent
nontransferable_details: published gains, species-specific envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: use the normalized body-frame v16 approach, course-alignment, and recent-yaw gate to shift a bounded share of the odd mean tangent from joint 2 to joint 1; keep the mean-free lagged wave and two-joint state oscillator intact
falsification: reject if any pre-approach trajectory changes, capture or mean distance regresses materially, terminal path/alignment/yaw fails to improve, acceleration or rate residence migrates forward without benefit, reflection symmetry fails, or either wake view loses coherence

## Candidate-specific test boundary

This rollout cannot establish robustness beyond the fixed still-water pose.
The mechanism is useful only if it is exactly inactive before the established
approach region and improves terminal semantics without trading away the
sampled leader's transit closure or merely moving actuator saturation from the
posterior to the anterior joint.
