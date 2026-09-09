# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets. It is the certified common initial
  condition and does not establish wake-phase robustness for any candidate.
- Every sampled released sheet shows a compact diagonal target capture with an
  immediate redirect, cylinder clearance, a persistent posterior-traveling
  body wake, and nose-first entry into the `0.75L` circle. The assigned parent
  is actively self-propelled: its mean velocity `(-0.3362,-0.1404)` exceeds
  mean local-flow advection `(-0.1961,-0.1918)` in the upstream direction, and
  its head travels `(-10.9149,-4.2375)L`. Thus the base oscillator, lagged
  posterior wave, filtered bearing curvature, and direct route should remain.
- The assigned parent's trajectory-supervised posterior residual reaches the
  target at `32.340`, with `1.63773L` mean distance, score `0.234663`, and
  force/moment RMS `65.12/888.56`. The independent response-confirmed release
  of distributed mean curvature reaches faster at `32.136`, with `1.63696L`
  mean distance, score `0.234607`, and loads `67.22/907.46`. Both retain the
  same narrow, productive traveling-wake topology and both still touch joint
  velocity and acceleration ceilings.
- Three independently materialized, code-equivalent compositions of those two
  mechanisms (two sampled solvers plus the inherited completed parent log)
  reproduce exactly at `32.4555`, `1.64548L` mean distance, score `0.226804`,
  and force/moment RMS `67.83/914.09`. Posterior excursion also rises to
  `0.58180 rad` from about `0.5753 rad` in either component. The composed sheet
  still captures directly but shows a visibly wider late body wake. This is a
  reproducible negative interaction on the fixed snapshot: simultaneous
  optional withdrawals are worse than either component in navigation and
  worse than the assigned parent in loads.
- No failed released keyframe is available inside this workspace. The most
  informative adverse visual contrast is therefore the successful but
  regressed three-way-repeated composition. Inherited textual evidence still
  rules out unrestricted bearing-rate recentering, anterior-heavy curvature,
  blanket physical-limit damping, and an extra response-triggered burst; those
  unavailable failure sheets are not claimed as new visual evidence.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation combined with biological redirect-and-release turning
source_mechanism: state-dependent arbitration of optional maneuver residuals around a persistent propulsive traveling rhythm
transferable_invariant: slow body-frame target geometry owns turn direction, verified targetward response may select one optional withdrawal, and competing withdrawals must not compound while the base traveling wave remains intact
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator ratings, source-task routes, and prescribed maneuver timing
policy_translation: compute the evaluated response confidence from normalized anterior gait activity, recent turn rate, bearing rate, and persistent bearing; use it as a continuous priority that enables bounded mean-curvature release while complementarily disabling trajectory-supervised posterior-residual withdrawal
falsification: reject if capture or the compact diagonal route is lost, arrival or mean distance exceeds the repeated simultaneous composition, loads exceed both component branches without better navigation, posterior excursion grows, the traveling bend weakens, or a held-out wake exposes switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate with a response-priority arbitration layer. Start
from the assigned parent's evaluated trajectory-supervised posterior-headroom
controller. Add the independently evaluated response-confirmed release of at
most `18%` of distributed mean curvature, but use its dimensionless response
confidence as a convex selector: when targetward heading response and shrinking
bearing are verified on an established gait, curvature release receives
priority and the posterior half-cycle residual is restored; otherwise curvature
release disappears and the assigned parent's trajectory supervisor may yield
only that optional posterior residual.

This is not a scalar interpolation between scores. It changes the command
architecture so the two previously destructive withdrawals cannot both reach
full authority together. It preserves the filtered body-frame bearing,
`12 deg` total-curvature ceiling, `40/60 -> 35/65` allocation, anterior
state-feedback oscillator, posterior lag and damping, maximum `8%` helpful
half-cycle increment, and the unit-gain traveling wave. Missing observations,
redirection, incoherent target-vector motion, or lost response continuously
restore the assigned parent's proven command. Downstream CFD must determine
whether arbitration retains capture and avoids the repeated composition's
navigation/load regression; no same-worker improvement is claimed.
