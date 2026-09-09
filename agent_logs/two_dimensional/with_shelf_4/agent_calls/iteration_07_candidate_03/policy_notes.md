# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and far to the right of
  the target while the four developed cylinder streets merge around the
  second-row capture region. This is a common initial condition; it supplies
  neither a reusable vortex phase nor a fixed route.
- The strongest sampled policy reaches the `0.75L` target after `137.357`
  released time units with `4.184L` mean distance and `-10.914L` upstream
  displacement. Its released sheet shows a decisive initial redirect, a
  persistent alternating posterior-lagged bend, and entry into the interacting
  wake corridor. It remains below the angle and speed caps; its anterior peak
  acceleration is `30.846 rad/time^2`, close to the `31.416` cap, so added
  actuation or a faster gait is not a credible next step.
- The otherwise identical bearing-rate policy without closing-progress
  qualification also captures, but later (`149.605`) and with worse mean
  distance (`4.358L`), RMS relative crossflow (`0.1321`), force (`15.49`), and
  moment (`308.48`) than the progress-qualified result (`0.1295`, `14.75`, and
  `303.02`). The latter uses higher mean command energy (`656.89` versus
  `647.93`) despite lower total energy from its shorter episode. This is causal
  evidence to preserve progress qualification as a route-response mechanism,
  but not evidence for more propulsion gain.
- The direct-moment baseline captures in `149.572` units with `4.384L` mean
  distance, `681.91` mean command energy, and RMS force/moment
  `16.22/314.99`. Together with the rate-damped samples, this supports keeping
  both the direct yaw-load residual and bearing-rate damping. An inherited
  response-direction gate on the moment residual worsens mean distance to
  `4.578L`, while a separate added heading-rate residual takes `150.832` units
  and scores `-2.437` despite reducing loads. Neither result supports another
  fast-yaw residual on this scaffold.
- The informative inherited failure changes gait period, moment gain, and
  route-headroom gating together. Its keyframes close into an upper-right loop
  and a top-boundary exit after `126.428` units; it moves only `-1.116L`
  upstream and regresses from `8.610L` minimum to `12.046L` final distance.
  Moderate RMS moment (`317.27`) and feasible joint extrema do not rescue lost
  targetward topology, so the current successful gait and residual remain
  fixed.
- In the strongest keyframes, the broad targetward route is successful but the
  polyline still contains sharp alternating direction changes between its
  main segments. The current controller feeds instantaneous bearing into the
  slow route request even though the observation already supplies a short
  body-frame bearing history. That makes temporal separation of persistent
  target direction from beat-scale body yaw a directly testable missing
  capability.

## Candidate hypothesis

Preserve the strongest sampled controller's oscillator, zero-mean half-cycle
steering, posterior lag, direct normalized moment residual, progress-qualified
bearing-rate damping, and all evidenced gains. Change only the persistent
route observation: compute the wrapped circular mean of
`state.bearing_history` and use it in place of instantaneous `state.bearing`.
This is a bounded, body-frame temporal filter, not a hidden controller state or
clock. The existing windowed bearing rate remains the response term, and the
existing positive closing-speed gate remains the evidence-backed test that
alignment change has become translation.

The expected test is retention of the `137.357`-unit capture and upstream
translation with fewer sharp route reversals, lower mean distance or command
effort, and no increase in load or actuator-cap contact. Falsify the temporal
separation if it delays or loses capture, blunts the initial redirect, raises
distance integral or loads, suppresses the alternating traveling bend, or
returns a loop or boundary exit. The formal CFD evaluation occurs only after
this worker exits, so these are tests rather than claimed outcomes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and history-aware adaptive wake swimming
source_mechanism: separate persistent target-direction feedback from rhythmic body-yaw fluctuations using a short observation history
transferable_invariant: slow body-frame target geometry should own route steering while beat-scale response and wake load remain separately bounded feedback signals
nontransferable_details: published gains, dimensional frequencies, robot linkage and species kinematics, recurrent-network weights, exact vortex phases, cylinder layout, and source-task routes
policy_translation: circularly average the supplied body-frame bearing history for the persistent route error while preserving the evidenced progress-qualified bearing-rate term, direct `moment_z_L2` residual, and two-joint traveling bend
falsification: reject if bearing-history filtering weakens the necessary initial redirect, loses or delays capture, raises distance integral, effort, loads, or cap contact, destroys posterior lag, or recreates a sampled loop or domain exit
