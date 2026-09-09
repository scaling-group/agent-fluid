# Wake-policy candidate diagnosis

## Evidence read before editing

- The assigned parent guidance is the fresh-lineage control contract. Its
  reusable starting point is to preserve behavior supported by multimodal
  evidence, use bounded normalized body-frame feedback, and treat observations
  as hypotheses rather than hard-code a world route. The inherited score logs
  contain only finite `left_domain` episodes; there is no prior success to
  preserve or claim.
- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Both the top-down
  vorticity and oblique Lambda2 rows show self-propelled swimmers laying down
  coherent alternating three-dimensional wakes. Local-flow components remain
  only a few hundredths of `U`, so wake rejection and added propulsion are not
  supported as the next mechanisms.
- The scalar-best sampled rate-loop policy reaches `3.0031L` and exits through
  the left boundary near `y=11.16L`; its visible route is nearly horizontal and
  passes above the target. The other rate cascade is nearly identical, reaching
  `3.1135L` and exiting left near `y=11.19L`. These are useful finite carriers
  but insufficient route controllers.
- The assigned prefill, terminal opposing-half carrier reallocation, makes the
  strongest sampled pass: `1.2669L` at about `18.69T`. The combined sheet then
  shows a near-vertical below-target path, fading terminal Lambda2 structure,
  and a lower-boundary exit. Its trace agrees: speed remains about `0.78L/T` at
  closest approach while mean joint excursion, velocity, and acceleration
  collapse, so it coasts rather than actively recovering.
- Carrier-preserving posterior mean curvature is a concrete negative result:
  `solver_213717a6b100` restores strong alternating terminal wake and joint
  motion but worsens closest approach to `1.5454L` and retains the same lower
  exit. The inherited energy-guarded half-cycle result likewise reaches only
  `1.7708L` with the same termination class, while the compatible smooth
  half-cycle candidate reaches `2.7390L`. Preserving rhythm is necessary but
  is not by itself a terminal guidance mechanism.
- The inherited notes identify the direct achieved-course shared-acceleration
  parent as the strongest historical route at `1.0435L`, but cadence relief
  regressed that pass to about `1.542L`. Thus another scalar course gain,
  cadence change, mean-curvature offset, or carrier-energy gate would repeat a
  completed test rather than add a semantic mechanism.
- Reconstructing the prefill's inertial target line from the trace shows why
  the instantaneous course residual is incomplete near capture. Around `17T`,
  at about `1.96L`, the beat-scale target-versus-course residual briefly falls
  to roughly `0.06 rad` even though the inertial line of sight is rotating at
  about `-0.31 rad/T` toward a developing below-target miss. By `18T` the route
  request is saturated, too late to prevent the pass. The observation already
  exposes a reflection-odd, history-smoothed estimate of that inertial rate as
  `turn_rate_recent - bearing_window_rate`.

## One candidate mechanism

Retain the normalized body-frame target-versus-achieved-course servo, its
far-field shared-acceleration steering, and the full joint-state traveling
carrier. Remove terminal carrier attenuation. Inside the evidenced `4L`
approach region, add a bounded look-ahead term from the inertial line-of-sight
rate to the course residual before the existing turn saturation. This is a new
feedback signal, not scalar tuning: it asks the propulsive steering actuator to
follow the moving target line through beat-scale course oscillations, while
leaving behavior exactly unchanged outside the terminal gate.

Expected test: reproduce the parent's broad approach outside `4L`, retain a
coherent alternating terminal wake, and sustain the corrective turn through
the small-residual interval near `17T` rather than waiting for the saturated
post-miss request. A semantic improvement is capture, a pass below the
historical `1.0435L` course-servo miss, or a better termination topology.

Falsification: reject the line-of-sight feedforward if early closure changes,
the terminal wake collapses, acceleration or joint-speed saturation grows, the
route returns to the upper/left class, or closest approach and the lower-exit
class fail to improve. Later work should then test a separately bounded
terminal slip/yaw actuator, not more cadence relief, course gain, carrier
attenuation, energy gating, or posterior mean curvature.

bookshelf_consulted: true
source_domain: biological burst redirect/release and sensor-modulated robotic-fish direction tracking
source_mechanism: retain rhythmic propulsion while observed approach response sustains or releases bounded steering
transferable_invariant: terminal steering must respond to the evolving target line and measured motion without suppressing the traveling propulsive bend
nontransferable_details: published gains, species or robot kinematics, dimensional cadence, CPG clocks, exact vortex phases, and task-specific routes
policy_translation: combine normalized body-frame target-versus-course error with the reflection-odd rate `turn_rate_recent - bearing_window_rate` inside a distance gate, map it through the existing bounded two-joint steering acceleration, and leave the carrier intact
falsification: reject if the coherent terminal wake or early closure degrades, saturation grows, the pass does not beat 1.0435L, or the same below-target left_domain topology survives

## Non-CFD verification

- The lightweight Julia 1.10.9 contract call returns two finite accelerations
  inside the owned `1800 deg/T^2` envelope, and every direct `params.FIELD`
  reference resolves to a field returned by `target_policy_params()`.
- A paired synthetic-state audit gives exactly the prefill action outside `4L`.
  Mirroring target lateral position, lateral velocity, bearing/turn rates, joint
  angles, and joint velocities gives sign-mirrored actions to numerical
  tolerance. A terminal probe changes the base route residual from about
  `0.038` to `0.221 rad` for the expected negative line-of-sight rate while
  remaining bounded.
- The required guidance-materiality and editable-boundary checks pass. These
  checks validate schema, symmetry, gating, and scope only; they are not CFD
  evidence of capture, wake quality, or improved score.
