# Carrier-rejected terminal-course candidate

## Evidence read before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no cylinders or prewarm snapshot, and capture. Their
  combined sheets show self-propulsion from rest, a coherent alternating
  top-down wake by `4T`, and compact three-dimensional Lambda2 shedding that
  persists through the target-directed arc. None shows advection, wake collapse,
  collision, or a boundary exit. The weakest available comparator is therefore
  the lowest-scoring capture rather than a failed termination.
- The sampled terminal-course residual (`solver_e08e4373a646`) is the best
  finite scalar result: relative to terminal amplitude relief alone
  (`solver_f2d961b95010`), it preserves the identical `23.8810T` capture while
  improving score by `0.001476`, mean scoring distance by `0.001177L`, and final
  crossing distance by `0.001496L`. The two wake sheets are visually
  indistinguishable at their sampling resolution, and peak lateral load/yaw
  moment remain `0.02400/0.01409`.
- That scalar improvement does not validate the residual's intended course
  mechanism. Relative to amplitude relief alone, its mean absolute
  velocity-to-line-of-sight angle rises from `0.3160` to `0.3186 rad` inside
  `3L` and from `0.4814` to `0.5091 rad` inside `1L`; mean absolute transverse
  speed likewise rises from `0.2231` to `0.2250 U` and from `0.3432` to
  `0.3595 U`. Peak yaw also rises from `2.9486` to `2.9748 rad/T`. Retain it as
  the best carrier, but do not treat the raw instantaneous course observation
  as a solved direction-tracking signal.
- The assigned-parent phase-compensated counter-curvature
  (`solver_74436c6ae2ba`) reaches capture `0.121T` earlier than the best sample
  and nearly matches its mean distance, but worsens the terminal course angle
  to `0.7096 rad`, peak yaw to `3.4715 rad/T`, peak lateral load to `0.02556`,
  and peak yaw moment to `0.01482`. Its large posture brake is therefore a
  concrete dynamic regression despite earlier capture; it should not be
  composed with another terminal residual.
- The likely defect in the raw course observation is beat contamination. Inside
  `3L`, target-transverse center speed correlates with anterior joint rate at
  `0.841–0.867` across the four sampled candidates. Using the dimensionless
  oscillator phase velocity `phi_dot1/(A*omega)` to remove its sampled carrier
  component reduces mean absolute transverse residual from `0.223–0.260 U` to
  `0.119–0.134 U`, while a persistent positive mean remains (`0.069–0.078 U`
  in the three non-parent samples). This is an offline observation diagnostic,
  not a same-worker rollout claim.

## Policy hypothesis

Start from the best sampled terminal-course controller, preserving its
traveling-wave oscillator, same-sign response-released C-bend, terminal
amplitude relief, and smooth physical-command projection. Change only the
terminal course observation: estimate beat-synchronous lateral carrier motion
from normalized anterior joint velocity, subtract it from target-relative
transverse speed, and feed the bounded residual through the existing proximity
and swimmer-speed gates. This makes direction tracking act on the slow course
offset rather than on the lateral component of every propulsive half-cycle,
without adding a clock, route, world coordinate, target identity, or another
terminal posture mode.

Falsify the mechanism if capture is lost; score/mean distance do not improve
materially over `solver_e08e4373a646`; the inside-`3L` and inside-`1L` course
angle or transverse speed fail to fall; or wake coherence, posterior speed-limit
exposure, peak yaw, commands, lateral load, or yaw moment regress. In
particular, reject rather than retune the carrier estimate if the new response
recreates the assigned parent's high-yaw/high-load terminal arc.

bookshelf_consulted: true
source_domain: sensor-feedback direction tracking in robotic-fish CPG control and separation of slow route error from beat-synchronous motion
source_mechanism: preserve a stable rhythmic carrier while a bounded sensory residual corrects persistent direction error instead of reacting to each gait half-cycle
transferable_invariant: separate carrier-synchronous lateral motion from target-relative course error before modulating the propulsive controller
nontransferable_details: published CPG gains, clock phase, linkage or species kinematics, dimensional beat settings, exact vortex phases, and prescribed routes
policy_translation: form target-transverse speed from normalized body-frame target and velocity, subtract an anterior-joint-rate carrier estimate normalized by the owned oscillator amplitude and frequency, and apply only the bounded terminal residual through the existing two-joint target request
falsification: reject if capture/directness does not improve or if the residual loses the alternating wake, increases speed-limit exposure, yaw, commands, or loads, or remains strongly correlated with anterior joint rate
