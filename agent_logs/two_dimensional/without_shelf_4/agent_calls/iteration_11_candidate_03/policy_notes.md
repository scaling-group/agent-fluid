# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four current shared-prewarm sheets are byte-identical. They show the
  fish held high and downstream/right while the four asymmetric cylinder
  streets develop and overlap through the target corridor. This is the common
  initial condition, not candidate-ranking evidence.
- The four current released sheets, scores, and diagnostics also reproduce one
  controller exactly despite cosmetic source differences. The `20.25 deg`,
  `0.67`-period, `0.25` bearing-rate-lead anchor makes a large down/up zig-zag
  on the right, enters the interacting wake, then closes almost horizontally
  without collision, exit, instability, or rebound. It captures at `244.547`,
  with mean/final distance `6.452/0.750L`, maximum lateral target offset
  `4.293L`, and head travel `(-10.916,-4.187)L`.
- The anchor is self-propelled as well as wake-assisted: mean upstream head
  velocity is `-0.04443` versus mean local-flow x `-0.03649`, leaving `0.00793`
  controller-relative upstream transport. Maximum anterior acceleration is
  already `31.055 rad/time^2` against the `31.2` policy guard and `31.416` hard
  cap. RMS relative crossflow, lateral force, and moment are finite at
  `0.13437`, `18.263`, and `362.214`. More oscillator amplitude is unsupported.
- The inherited sign-asymmetric bearing-rate controller is the informative
  failure. Its sheet keeps making wide, jagged turns instead of retaining the
  final corridor and misses at the horizon, with minimum/final/mean distance
  `3.290/3.632/8.447L`, maximum lateral offset `4.703L`, and upstream head
  velocity reduced to `-0.02667`. The identical `31.055` anterior maximum and
  absence of collision, exit, or instability identify a route/steering
  failure, not loss of propulsion feasibility.
- The assigned parent's turn-away heading-rate gate is a subtler negative
  result. It captures `5.990` earlier at `238.557`, but its keyframes show a
  wider far-field loop before the aligned approach and mean distance worsens
  by `0.625L` to `7.077L`; score falls from `-4.439` to `-5.068`, upstream
  margin falls to `0.00476`, and RMS force rises to `18.354`. Its small moment
  reduction to `360.851` does not offset the route-integral regression. The
  inherited global `0.05` heading-rate correction also regressed mean distance
  and arrival despite lower loads. Thus heading-rate damping is not safe as a
  global or turn-away-only correction, but its earlier gated capture motivates
  separating large-error acquisition from aligned corridor retention.

## Single candidate hypothesis

Preserve the demonstrated propulsion shell, posterior lag/damping, `10 deg`
steering limit, `0.30` bearing scale, `0.25` bearing-rate lead, rate bound, and
acceleration guard. Reuse the inherited bounded `0.05` heading-rate correction
only while the body rotates away from the target, and multiply it by
`exp(-(bearing / 0.30)^2)`. The alignment scale deliberately reuses the
evaluated static-bearing scale: at large bearing error the candidate approaches
the anchor rapidly, while within the supported steering band it can damp an
away-turn before another late reversal. The correction is zero for stationary
or targetward body rotation and remains bounded by `0.015 rad` before the
steering nonlinearity. It uses only normalized body-frame task feedback and no
coordinate, route, clock, prescribed inflow, or remote wake probe.

This should preserve the anchor's far-field wake acquisition while retaining
only the potentially useful, earlier-arrival part of the inherited heading
gate near alignment. The next fixed-prewarm CFD evaluation must retain target
capture and upstream transport while improving score/mean distance below
`-4.439/6.452L`, or produce a material load reduction without later capture;
arrival no later than `244.547` is the secondary timing boundary. Falsify the
mechanism on a miss, later capture, higher mean/lateral distance, lower upstream
margin, higher crossflow/load, or visible switching near zero bearing. If it is
falsified, restore the plain anchor and treat heading-rate feedback as exhausted
until time-resolved evidence supports a different body-frame corridor signal.
