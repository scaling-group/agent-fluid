# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis before the policy edit

- The shared prewarm sheets are byte-identical and show the held fish above and
  downstream of four developed, interacting cylinder streets whose merged wake
  crosses the target. This is common initial-condition evidence, not support
  for a fixed route or inferred vortex phase.
- All four sampled released sheets terminate by target capture; no sampled
  failure keyframe exists. The inherited naive seed is therefore used only as
  metric-backed failure context: it exited the lower boundary after `50.127`
  released time while largely advected and saturating both joint-rate and
  acceleration limits. No unseen failure trajectory is inferred.
- The assigned parent and all sampled successes visibly share the useful
  behavior absent from that seed: a decisive downward-left redirect, a strong
  alternating self-generated wake, and a compact upstream-left transit into the
  `0.75L` circle. For the assigned parent, mean world velocity
  `(-0.2781,-0.1162)` versus mean local flow `(-0.1531,-0.1687)` includes
  `0.1250` mean relative upstream motion, confirming self-propulsion rather
  than passive advection.
- The assigned parent releases both lagged route-history curvature and extra
  posterior half-cycle steering after measured bearing convergence. It is the
  score/arrival leader at `-0.037619`, `39.0499` capture, and `1.91369L` mean
  distance, but carries RMS force/moment `57.05/783.02`; both joint-rate and
  acceleration caps remain active.
- The sampled route-history-only release is the missing factorial contrast. It
  retains posterior half-cycle steering and reaches at `39.1159` with
  `1.91432L` mean distance, while RMS force/moment fall to `51.63/734.35`.
  Relative to the assigned parent this is only `0.0660` later with `0.00064L`
  higher mean distance, but `9.5%` lower RMS lateral force and `6.2%` lower RMS
  yaw moment. Relative to the no-release carrier, it has essentially the same
  arrival (`39.1159` versus `39.1104`) and improves mean distance, relative
  crossflow, force, and moment. Joint excursions are essentially unchanged and
  the hard caps remain active, so the supported benefit is load reduction from
  feedback-role allocation, not relief of saturation or effort.
- The inherited amplitude-relief and total-action rate-guard results are
  completed negatives: weakening propulsion worsened arrival, effort, and load,
  while blanket guards delayed the direct route. Aggregate evidence also lacks
  the time-resolved sign/scale calibration required for a new flow, force, or
  moment residual. Those mechanisms are not added merely because caps remain.

## Policy hypothesis before the edit

Adopt the evaluated route-history-only completion scope: after current
body-frame bearing has become small and its windowed magnitude has converged,
withdraw only the lagged circular-history offset from anterior mean curvature.
Retain current-bearing steering, the oscillator envelope and posterior lag, and
the target-favored posterior half-cycle throughout. Padded release history and
large, stationary, or diverging error leave the decisive redirect unchanged.

This is one controller-allocation change, not a scalar gain edit. The sampled
result predicts the same direct, self-propelled capture topology with arrival in
the `39.12` class and lower force/moment than the assigned parent. The tradeoff
is explicit: the score leader arrives about `0.066` sooner and uses about
`0.25%` less command energy, while the selected candidate has materially lower
hydrodynamic loads. Falsify this selection if evaluation does not reproduce
target capture and the `51.6/734` load class, if route metrics regress beyond
the `39.12`/`1.915L` class, or if its exact sampled implementation cannot pass
the current policy contract.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and biological burst redirects
source_mechanism: release stale mean-curvature memory after observed directional response while preserving target-favored posterior rhythmic steering
transferable_invariant: slow body-frame target history may initiate persistent route curvature, but completing that redirect need not withdraw a posterior rhythm whose interaction can reduce rather than increase hydrodynamic load
nontransferable_details: published gains, robot duty ratios, species-specific burst kinematics, dimensional frequencies, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: use normalized current and circular-history bearing to fade only the lagged route offset after convergence; keep the state-feedback oscillator, current-bearing command, posterior lag, and joint-state half-cycle term intact
falsification: reject if direct capture is lost, route metrics leave the sampled class, or force and moment fail to reproduce the evaluated reduction relative to releasing both route memory and posterior half-cycle steering

## Pre-evaluation verification

- The mandated guidance checker passes after removing one duplicate rendered
  marker for the same assigned optimizer parent from `README.md`.
- The solver editable-boundary check passes, leaving the 2D target policy as the
  only changed solver surface and preserving one nonempty candidate.
- Static schema comparison finds the same `14` direct `params.FIELD` references
  as the `14` fields returned by `target_policy_params()`. The policy reads only
  normalized distance, body-frame bearing/history, and two-joint state; it has
  no prohibited inflow, cylinder-probe, station, time, step, or route input.
- Candidate SHA-256
  `8451c95aaabe5874e9ae10eb40e5507c4e5c0aa954d3933920f432d0d34d75d8`
  is byte-identical to the completed `solver_a7d11ae4462d` sample, so the exact
  implementation—not merely a similar hypothesis—has the cited CFD evidence.
- The prescribed lightweight Julia contract command was invoked but could not
  start because `julia` is absent from this image (`command not found`, exit
  `127`). No formal CFD was run; EvE evaluates the handed-off candidate after
  this worker exits.
