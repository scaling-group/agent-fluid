# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The byte-identical shared prewarm sheets show the fish held at the common
  upper-right release pose while four staggered-cylinder streets develop and
  merge around the second-row target. This is a common initial condition, not
  evidence for a memorized coordinate, wake phase, route, or clock command.
- The prefilled `tail_steering_gain=0.65` rollout turns down-left, sustains a
  productive lateral beat through the developed wake, passes just below the
  target, and bends into the `0.75L` capture circle without collision, exit,
  looping, or instability. Mean fish/local-flow x velocities
  `-0.15180/-0.08448` give `0.06732` upstream-relative speed, confirming that
  the visible diagonal crossing is self-propelled rather than passive
  advection. It reaches in `72.160` release units with `2.4638L` mean distance,
  `51284` total command energy, and `25.32/420.32` RMS force/moment.
- Three current samples change only posterior steering share to `0.70`; their
  source comments differ, but their executable parameters, keyframe sheets,
  and physical metrics agree exactly. The fish retains the compact diagonal
  route and target turn. Mean distance improves to `2.4541L`, relative
  crossflow falls from `0.13603` to `0.13063`, peak joint speeds fall from
  `3.125/3.367` to `3.086/3.293`, and RMS force/moment fall to
  `23.85/408.89`. The tradeoff is a `0.297`-unit later arrival, slightly lower
  `0.06620` upstream-relative speed, and higher `51842` total command energy;
  both accelerations still contact the common `28/28` guard.
- No current sampled rollout is a semantic failure. The most informative
  inherited negative continuation is the isolated `tail_steering_gain=0.75`
  result from the assigned parent. Its sheet shows a deeper lower excursion
  before capture, consistent with center/head lateral displacement worsening
  to `-4.590/-4.372L`; mean distance regresses to `2.5093L`, score to
  `-0.610985`, and total energy to `52496`. Its lower `0.12785` crossflow and
  `22.60/394.40` loads therefore do not establish better targeting. This is a
  failed optimization step, not a semantic failure: it still reaches in
  `72.275` units with `0.06873` upstream-relative speed.
- The inherited reversed-sign, higher-amplitude controller remains the
  available semantic safety boundary: assigned-parent guidance reports that
  it visibly coiled and became unstable after `4.45` units with extreme
  crossflow and loads. No keyframe for that older result is present here, so I
  infer no additional visual detail from the summary.

## Single-candidate hypothesis

Adopt the exactly sampled `tail_steering_gain=0.70` controller. Preserve the
prefill's `0.75` period, `22 deg` oscillator, static `2.1` energy restoration,
bounded positive-bearing `0.75/10 deg` anterior steering, `0.55` posterior lag,
`0.65` damping, and common `28/28 rad/time^2` acceleration guard. This changes
only posterior sharing of the already bounded steering center and adds no new
observation, switch, global coordinate, route, time signal, or wake probe.

The falsifiable expectation is reproduction of finite compact capture with
mean distance below the `0.65` prefill's `2.4638L` and RMS force/moment no
higher than `25.32/420.32`, while accepting the sampled sub-unit arrival and
effort tradeoff. Reject the mechanism if evaluation selects a deeper route,
loses capture or meaningful upstream-relative propulsion, or raises effort or
load without the distance benefit. Do not extrapolate posterior share to
`0.75`: that exact inherited result already crossed the same-snapshot route
boundary. Even a positive reevaluation at `0.70` remains unproven under
held-out wake phase, inflow, geometry, and target position. No CFD result for
this new candidate is claimed here.
