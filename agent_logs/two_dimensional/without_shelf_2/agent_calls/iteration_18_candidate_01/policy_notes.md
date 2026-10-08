# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four staggered cylinder wakes develop and merge
  around the target. The sheet is common initial-condition evidence; it does
  not justify a coordinate, clock, wake-phase, or memorized-route command.
- The `tail_steering_gain=0.65` prefill reaches the target in `72.160` release
  units on a compact down-left route. Its mean distance is `2.4638L`, mean
  world/local-flow x velocities are `-0.15180/-0.08448` (therefore `0.06732`
  upstream-relative x speed), command energy is `51284`, RMS relative
  crossflow is `0.13603`, and RMS force/moment are `25.32/420.32`. The visible
  upstream motion is therefore materially self-propelled rather than passive
  advection, but both commands touch the `28 rad/time^2` policy guard.
- Three sampled `tail_steering_gain=0.70` rollouts are exact executable
  replications with byte-identical released sheets and diagnostics. They
  preserve finite compact capture while improving score from `-0.565611` to
  `-0.555772`, mean distance to `2.4541L`, RMS crossflow to `0.13063`, and RMS
  force/moment to `23.85/408.89`. This is a Pareto trade: capture is `0.297`
  units later, upstream-relative x speed falls to `0.06620`, and command energy
  rises to `51842`; the acceleration guard remains active.
- The assigned parent's inherited `tail_steering_gain=0.75` continuation also
  reaches, but its sheet shows a lower final approach before turning into the
  target. It regresses score to `-0.610985`, mean distance to `2.5093L`, and
  command energy to `52496`. Arrival (`72.275`) and upstream-relative x speed
  (`0.06873`) remain competitive, while RMS crossflow and force/moment improve
  further to `0.12785` and `22.60/394.40`. Thus posterior sharing above `0.70`
  does not monotonically improve closure even when load metrics do.
- No current or inherited compact keyframe sheet terminates in collision,
  domain exit, instability, or horizon miss. The most informative available
  counterexample is therefore the isolated `0.75` finite regression, not a
  semantic failure. The older reversed-sign instability remains a safety
  boundary only through inherited guidance; no unavailable visual detail is
  inferred from it.

## Single-candidate hypothesis

Select the exactly evaluated `tail_steering_gain=0.70` controller. Preserve
the `0.75` period, `22 deg` oscillator, static `2.1` energy restoration,
bounded positive-bearing `0.75/10 deg` anterior steering, `0.55` posterior
lag, `0.65` damping, and common `28/28 rad/time^2` guard. This is one isolated
change from the prefilled `0.65` controller and adds no observation, switching
surface, global coordinate, route, timing signal, or wake probe.

The falsifiable expectation is reproduction of finite compact capture with
mean distance below the prefill's `2.4638L` and RMS force/moment no higher than
`25.32/420.32`, accepting a sub-unit arrival and modest effort tradeoff. Reject
the selection if it loses target capture or meaningful upstream-relative
propulsion, selects the deeper `0.75`-like route, or fails to reproduce the
distance/load benefit. Same-snapshot replication does not establish a
universal optimum; held-out wake phase, inflow, geometry, and target position
remain the applicability boundary. No CFD outcome for this new candidate is
claimed here.
