# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The current sampled shared-prewarm sheets are byte-identical. They show the
  fish held high and downstream/right of the target while the four staggered
  cylinder streets develop into an interacting corridor through the target.
  This is common initial-condition evidence and cannot rank controllers.
- All four current released sheets are also byte-identical even though their
  policy source files differ cosmetically. The demonstrated `20.25 deg`,
  `0.67`-period controller first makes a broad down/up correction on the right,
  then enters the interacting central wake and closes nearly horizontally on
  the target. It reaches `0.7498L` at `244.547` with mean distance `6.452L`,
  head travel `(-10.916,-4.187)L`, and no collision, domain exit, rebound, or
  instability. Mean x velocity `-0.04443` versus mean local-flow x `-0.03649`
  shows wake-assisted upstream travel with a smaller controller-produced
  component; this is neither passive advection nor high-speed swimming through
  still water.
- The current actuation/load diagnostics rule out another amplitude increase:
  maximum anterior acceleration is already `31.055 rad/time^2` against the
  `31.2` policy guard and `31.416` episode cap, while RMS relative crossflow,
  lateral force, and moment are `0.13437`, `18.263`, and `362.214`. The broad
  correction remains a steering/retention inefficiency, not missing drive.
- No current sampled sheet is a hard failure. The assigned-parent and inherited
  notes provide that boundary: `14 deg` at period `0.80` was advected
  `+2.172L` downstream and exited at `16.747`; `19 deg` at period `0.67`
  self-propelled upstream but remained right of the central corridor and ended
  the horizon at its `5.812L` minimum. The matched `20 deg` controller captured
  at `266.255`, and the isolated `20.25 deg` shell improved this to `244.547`.
  This brackets a narrow corridor-acquisition threshold and does not support
  more propulsion.
- Two inherited step-7 evaluations isolate harmful steering changes at the
  demonstrated gait. Softening bearing scale from `0.30` toward `0.32` only
  during positive rolling-window closure retained capture but delayed it to
  `256.663`, raised mean distance to `7.394L`, RMS relative crossflow to
  `0.13733`, and RMS lateral force to `18.426`; its sheet shows a longer lower
  excursion before final wake entry. Increasing only bearing-rate lookahead
  from `0.25` to `0.30` was worse: the sheet develops sharp repeated reversals
  on the right before corridor alignment, capture moves to `270.446`, mean
  distance rises to `8.499L`, and RMS lateral force rises to `18.958`. Its
  slightly lower RMS moment (`359.258` versus `362.214`) does not compensate
  for the slower, longer, more laterally loaded route. Together with the older
  negative static-scale test (`0.30` to `0.28` at `20 deg` worsened mean
  distance `7.218L` to `8.112L`), this evidence says to preserve static bearing
  gain and test rate timing alone.

## Candidate hypothesis

Preserve the evaluated `20.25 deg` propulsion shell, `0.67` period,
`0.65/0.80` posterior lag/damping, `10 deg` steering limit, `0.30` bearing
scale, `0.30 rad/time` bearing-rate clamp, and `31.2 rad/time^2` acceleration
guard. Change exactly one control parameter: reduce bearing-rate lookahead from
`0.25` to `0.20` time units. The isolated `0.30` result shows that earlier rate
anticipation creates premature alternating reversals and loses the useful
route; the one-sided opposite probe tests whether relying slightly longer on
the bounded body-frame bearing reduces that zig-zag without sharpening static
gain or changing propulsion.

This is an unverified local hypothesis, not a claimed improvement. Under the
certified fixed prewarm, the next CFD rollout should retain target capture and
central-wake entry while reducing the visible alternating correction width,
mean distance below `6.452L`, release time below `244.547`, or lateral load
without contacting the acceleration guard. Falsify it if capture is lost or
later, mean distance/load rises, the route makes a wider late correction, or
reduced anticipation delays steering unwind. If falsified, treat `0.25` as the
supported local rate-lookahead anchor over the tested `0.20--0.30` interval and
stop tuning bearing scale/lookahead at this wake phase; test a distinct bounded
body-frame corridor-retention observation instead.
