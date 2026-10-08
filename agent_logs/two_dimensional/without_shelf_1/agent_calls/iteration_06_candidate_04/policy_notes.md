# Multi-wake target-policy diagnosis

## Evidence read before policy editing

- The shared prewarm sheet shows the fish held in the upper-right while four
  mature, interacting cylinder wakes fill the route to the second-row target.
  This is the common initial condition for every sampled controller, not a
  candidate-specific advantage.
- The undamped positive-bearing, posterior-only anchor (`0.90` period,
  `28 deg` anterior oscillator, `10 deg` posterior bias) visibly self-propels
  diagonally toward the developed wake before curling through the upper
  boundary. Its metrics agree: mean head velocity is more upstream than mean
  local flow (`-0.0447` versus `-0.0293`), it reaches `6.34L`, and it survives
  `73.39` release units. The approach is not controlled capture, however: the
  head finishes `+1.75L` higher, the posterior joint reaches `45 deg`, both
  joint rates and both acceleration commands reach their caps, and RMS
  force/moment are `196/2014`.
- Direct normalized heading-rate damping supplies a useful gain sweep without
  changing the propulsion oscillator. Gain `0.35` improves progress from
  `0.132` to `0.255` and head-x displacement from `-2.73L` to `-4.69L`; gain
  `0.70` further improves them to `0.380` and `-6.93L`, gives the best sampled
  score (`-9.53`), and reaches `5.33L`. At gain `0.70`, mean head velocity
  remains self-propelled relative to local flow (`-0.130` versus `-0.091`).
  The released sheets and diagnostics nevertheless falsify heading damping as
  a loop repair: all three gains exit upward with about `+1.8L` head-y travel
  and about `6.09L` maximum lateral target offset. The strongest gain exits at
  `55.38`, still reaches both rate and command caps, and raises RMS
  force/moment to `325/3331`; its posterior peak only falls from the hard
  `45 deg` limit to `44.1 deg`.
- Adding a bounded body-lateral-velocity damper of `0.20` to the `0.35`
  heading-damped controller is a concrete negative result. It reduces progress
  from `0.255` to `0.174`, worsens closest approach from `7.30L` to `7.73L`,
  and preserves the same upper exit, lateral offset, saturation, and high
  loads. Inherited bearing-window-rate and closing-bearing-rate brakes also
  worsened approach or removed upstream authority. Those rate channels should
  not be revived as stronger brakes.

## Single candidate hypothesis

Use the complete best sampled gain-`0.70` heading-damped policy and vary only
the static posterior steering ceiling from `10 deg` to `8 deg`. This preserves
the strongest measured upstream gait, positive bearing sign, body-rotation
damping, posterior servo, and command limit while reducing the persistent mean
bend that remains near the posterior angle limit. The `8 deg` value was
previously confounded with target-bearing-rate feedback; it has not been
isolated with the successful direct-heading-rate mechanism.

The evaluation should retain negative mean head-x velocity and approach within
the gain-`0.70` result's `5.33L`, while surviving beyond `55.38` release units,
reducing the roughly `6.09L` lateral excursion, or lowering posterior/rate
saturation and RMS load. The hypothesis is falsified if upstream progress
falls materially toward the undamped anchor or the same upper exit persists
without desaturation. In that case later workers should restore the `10 deg`
ceiling and isolate posterior-servo bandwidth or a soft joint-limit mechanism,
not add lateral/bearing-rate damping or weaken propulsion wholesale.
