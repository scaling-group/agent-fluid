# Wake-policy candidate notes

## Evidence diagnosis

- The assigned parent and prefill, `solver_a8af0d71b0de`, is a finite
  achieved-course controller with terminal opposing-half carrier attenuation.
  It reached `1.266947L` but terminated `left_domain` at `30.1180T` with final
  distance `9.656381L`. Its combined sheet shows a coherent alternating
  top-down and Lambda2 wake through the first pass near `18T`, followed by a
  nearly vertical lower-exit trajectory and little newly shed alternating wake
  at `24--30T`. The trace agrees: at minimum distance (`18.6945T`) speed was
  still about `0.777L/T`, but joint excursion and action subsequently
  collapsed. This is a loss of steering/locomotor authority after a useful
  route, not weak initial self-propulsion or passive advection.
- The strongest sampled finite comparison, `solver_29faa601686c`, changes the
  terminal realization while preserving the same achieved-course outer loop
  and traveling-bend drive. It captured at `0.749345L` and `18.6065T`, whereas
  the parent's closest pass occurred at `18.6945T`. Both image rows show
  self-propulsion and a coherent alternating wake before the pass, but only the
  successful policy retains that carrier through crossing. At `18T` its
  normalized signed LOS miss is about `0.67`, so its response release is
  correctly cancelled and the existing steering is restored. The success is
  tight and actuator-heavy: whole-trace acceleration clamping is about
  `68.8%/71.0%`, and both joints touch the `260 deg/T` speed limit.
- The two sampled yaw-rate cascades support the same separation: the bearing
  cascade reached only `3.0031L`, and adding achieved-course sensing ahead of
  it reached only `3.1135L`; both exited left. Thus achieved-course sensing is
  useful, but joint-compensated yaw rate is evidenced as a release condition,
  not as the primary steering actuator.
- Inherited optimizer scores also show that the assigned-parent line's later
  terminal variants remained `left_domain` (`1.4993L` and `1.4660L`), while
  the independent sampled LOS-guarded policy changed the termination class to
  capture. That semantic result outweighs another unevaluated terminal
  mechanism in this candidate.

## Policy hypothesis

Adopt the sampled LOS-guarded response-release architecture as the single
candidate. Preserve its joint-state oscillator, posterior lag, speed-gated
body-frame achieved-course command, cadence schedule, and steering magnitude.
Near the target, release only the pre-existing shared steering after a
joint-phase-compensated correct-sign yaw response; re-engage it when the
rotation-invariant LOS rate and current turn request indicate a growing miss.
Never attenuate the carrier. This should reproduce the evidenced capture-class
route rather than the prefill's carrier-collapse/lower-exit topology. It is
falsified if formal evaluation loses capture, changes early closure, weakens
the terminal wake, or worsens the already high saturation/load burden.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal fish turning
source_mechanism: sensor feedback modulates slow steering authority around a persistent propulsive rhythm
transferable_invariant: preserve the traveling-wave carrier and gate only the bounded steering residual from observed target-motion and turn-response signals
nontransferable_details: published gains, clocked oscillator phase, robot morphology, species kinematics, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target and velocity to form achieved-course error and inertial LOS rate; use joint state to remove beat-phase yaw before releasing existing two-joint steering; do not amplify steering or suppress either carrier half-cycle
falsification: reject if the candidate loses capture, alters the far route, collapses the alternating wake, increases saturation or loads, or repeats the lower left-domain exit
