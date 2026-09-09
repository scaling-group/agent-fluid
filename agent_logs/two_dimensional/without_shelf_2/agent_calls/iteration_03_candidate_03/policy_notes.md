# Multi-wake candidate diagnosis

## Evidence and visual diagnosis

The assigned parent guidance, all four sampled solver observations, their
compact metrics and diagnostics, and the inherited optimizer notes were read
before this note and before changing the policy. No omitted Bookshelf material,
neighboring configuration, repository history, clock, coordinate route, or
external research was used.

The shared prewarm sheet shows the common initial condition: a held fish near
the upper-right boundary, above and downstream of four developed interacting
vortex streets, with the target in the second-row wake overlap. It is identical
across candidates and is not policy-specific evidence.

The released sheets separate four control regimes:

- The target-blind seed visibly bends hard but sweeps down the right side and
  exits below after `50.13` release units. Its world velocity
  `(-0.0725,-0.2633)` nearly follows local flow `(-0.0414,-0.2414)`, both
  velocity and acceleration caps are reached, minimum distance rebounds from
  `8.615L` to `12.123L`, and progress is only `0.0243`. The fast oscillator is
  active but spends its authority on saturation and uncontrolled yaw rather
  than sustained target-relative propulsion.
- The finite slow positive-curvature sample leaves through the nearby right
  boundary in `16.73` units with only `0.0160` upstream velocity relative to
  local flow, `-0.1480` progress, and a maximum anterior acceleration of just
  `1.09 rad/time^2`. Its small visible bend and downstream displacement support
  the inherited diagnosis that this family was under-driven; they do not by
  themselves falsify the steering sign.
- The prefilled negative-curvature candidate does falsify the parent's proposed
  sign/amplitude combination under this common snapshot. By the second and
  final released keyframe at `4.45` units, the fish has coiled and spun near
  its start instead of beginning a navigational turn. RMS relative crossflow,
  lateral force, and moment jump to `3.139`, `5.50e4`, and `5.68e5`; anterior
  angle reaches `0.721 rad` and velocity reaches the hard `4.538 rad/time`
  limit before `unstable_dynamics`. The nominal soft acceleration bound alone
  therefore does not make the reversed `30 deg`, `0.82`-period controller safe.
- The positive-bearing, energy-regulated sample is the only evaluated success.
  Its sheet shows a decisive self-propelled down-left approach, a bounded
  correction from below, entry into the developed target wake, and first
  crossing at `130.23` units. It reaches `0.7496L` with `0.9397` progress and
  mean distance `3.516L`. Mean x velocity is `-0.0835` against local flow
  `-0.0455`, so it creates a material upstream component; mean y velocity
  `-0.0362` also differs from local `-0.0508`. Its maximum joint angles
  (`0.523/0.423 rad`) and speeds (`3.22/3.18 rad/time`) remain below the hard
  limits, while RMS force/moment stay finite at `26.34/427.54`, despite the
  candidate-owned `28 rad/time^2` guard being reached.

## One candidate hypothesis

Use the evaluated successful mechanism as a conservative anchor: positive
body-frame bearing maps to a small positive mean curvature, while a
state-phase, energy-regulated `0.75`-period, `22 deg` anterior oscillation and
opposed lagged posterior bend preserve enough propulsion to beat downstream
advection. Keep the sampled `8 deg` steering limit and `28 rad/time^2`
candidate-side action guard. Do not add rate, force, flow, moment, or position
feedback in this candidate because the evidence does not isolate a safe
improvement to the already successful loop, whereas the prefilled sign reversal
is catastrophically unstable.

The falsifiable expectation is reproduction of finite target capture with a
material negative-x velocity relative to local flow, no joint-angle or velocity
hard-limit contact, and force/moment loads remaining near the successful scale
rather than the prefill's blow-up. This same-snapshot replication should be
rejected as a robust anchor if it instead exits before `130.23`, persistently
bang-bangs at the candidate guard, loses positive-bearing correction, or shows
instability-scale relative crossflow and loads. No result for the unevaluated
workspace candidate is claimed here.
