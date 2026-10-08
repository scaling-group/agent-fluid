# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent and current prefill use instantaneous body-frame bearing
  to center the seed's `0.55`-period, `28 deg` posterior-lagged traveling bend
  on a bounded `12 deg` curvature request split `40/60`. Its sampled rollout
  (`solver_e3c2e0960563`) visibly turns into a compact self-propelled diagonal
  through the developed four-cylinder wakes and reaches the `0.75L` target in
  `37.955` release-time units with `1.858L` mean distance, `45.93` force RMS,
  and `670.16` moment RMS.
- The common prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. In the strongest released
  sheet, the fish makes an early targetward rotation, retains a visible
  posterior traveling wave, then traverses the wake region directly into the
  target. The head displacement `(-10.916,-4.202)L` and mean velocity
  `(-0.305,-0.126)` confirm active targetward propulsion rather than passive
  advection.
- `solver_db3b1525faff` and `solver_e6f7391fb8c3` are equation-identical
  deterministic replays of a `0.35`-gait-period circular bearing filter with
  the parent's `40/60` split. Both reach in `35.6895` units with `1.7619L`
  mean distance and score `0.112158`, so the combination is the strongest
  current trajectory mechanism. It also raises mean command energy from the
  instantaneous parent's `1295.37` to `1425.38` and force/moment RMS from
  `45.93/670.16` to `59.28/821.23`; filtering is not evidenced load rejection.
- The informative inherited failure adds an ungated bounded bearing-history
  trend to the same filtered architecture. Its keyframes show no developed
  body wave and downstream advection out of the domain after `16.956` units;
  metrics confirm displacement `(+2.175,-0.874)L`, minimum distance `12.424L`,
  only `8.64` mean command energy, `0.140/0.163 rad` peak joint angles, and
  negative progress. The term intended to release a converging turn instead
  suppressed the target bias that seeds this equilibrium-start oscillator.
  This is a propulsion-startup failure, not a wake-load improvement.
- The contrast bounds the edit: preserve the strongest sampled filter,
  curvature allocation, and traveling-bend parameters; do not use local flow,
  force, or moment because the keyframes and aggregates do not establish a
  repeatable signed disturbance event. Any route-response damping must remain
  inactive at zero joint activity and become continuous rather than clocked.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish CPG direction tracking and biological burst redirect
source_mechanism: modulate an established propulsive rhythm with observed directional response, while retaining excitation until locomotor activity is established
transferable_invariant: a response-dependent turn release must not cancel the target bias that starts the propulsive oscillator; admit it continuously according to normalized two-joint rhythm activity
nontransferable_details: published gains, dimensional frequencies, robot or species gait envelopes, C-start timing, exact vortex phases, and task-specific routes
policy_translation: retain the circular body-frame bearing estimate and bounded mean-curvature gait, then multiply the bounded bearing-window trend by a phase-robust joint angle/velocity activity gate normalized by the owned oscillator amplitude and frequency
falsification: reject the gate if the traveling wave fails to start, capture is lost or slower than `35.6895`, mean distance exceeds `1.7619L`, or command and force/moment loads fail to improve enough to justify the added trend path

## Candidate hypothesis

Use the strongest sampled filtered `40/60` controller as the reachability
scaffold and add one new feedback mechanism: joint-activity-gated route-trend
damping. The trend has the inherited bounded sign convention—converging
bearing releases mean curvature and diverging bearing restores it—but a smooth
gate computed from `phi1/oscillator_amplitude` and
`phi_dot1/(omega*oscillator_amplitude)` is zero at the equilibrium initial
state. It approaches one only after the target-signed center has excited the
oscillator, and because it combines angle and velocity it does not switch off
at each beat extremum or zero crossing.

The candidate owns the filter horizon, trend bound and share, and activity
scale in `target_policy_params`. It uses no elapsed time, coordinates, case
identity, wake phase, or mutable memory. Formal CFD occurs only after this
worker exits; later evidence must compare semantic capture, startup wave,
arrival, mean distance, saturation, effort, and lateral force/moment with both
the `35.6895` filtered best and the inherited ungated downstream exit.
