# Wake-policy candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet is the common held-fish initial condition. It shows
  four developed and interacting vortex streets already extending through the
  release region; it is not candidate-specific evidence.
- The prefilled centered-curvature controller does not establish sustained
  targetward propulsion. Its released keyframes show a small looping path on
  the right side of the domain followed by a large local vortex/body-load
  blow-up. That visual failure agrees with `unstable_dynamics` at `121.52`,
  only `0.227` progress, `9.238L` closest approach, RMS relative crossflow
  `1.138`, RMS lateral force `1.67e4`, and RMS yaw moment `2.90e5`.
- The inherited parent policy instead adds a positive bounded body-frame
  bearing residual to the joint-state oscillator and reaches the `0.75L`
  target boundary in `62.30`. Its keyframes show active left/down traversal,
  a broad below-target correction, and curved capture; metrics confirm
  `(-10.922,-4.153)L` head displacement, `2.460L` mean distance, and finite
  force/moment loads (`27.3`/`525.8`). This establishes the empirical steering
  sign and the useful carrier, but both joint accelerations reach the episode
  limit (`31.416`).
- The strongest sampled child preserves that carrier and bearing residual but
  mixes them inside a `30.0` acceleration envelope while reserving a small
  steering share. Its keyframes retain the coherent target-directed route and
  enter the capture circle sooner, at `49.14`; mean distance improves to
  `2.156L`, total command energy falls from `89.5k` to `62.5k`, and maximum
  joint acceleration stays at the candidate envelope. Its higher RMS lateral
  force/moment (`39.0`/`617.1`) and unchanged speed-limit contact bound the
  result: allocation improves this fixed wake rollout, but does not prove load
  reduction or robustness to other wake phases.
- The available summaries do not calibrate the sign or instantaneous scale of
  force, moment, bearing-rate, or relative-crossflow feedback. Adding one of
  those residuals would confound the evaluated allocation mechanism.

## Candidate policy hypothesis

Replace the prefilled centered-curvature failure with the strongest sampled
architecture: the successful `0.55`-period joint-state carrier, posterior lag,
positive bounded bearing-to-acceleration residual, and direction-prioritized
sub-limit allocation. This is a feedback-structure transfer, not scalar-only
gain tuning. It should reproduce semantic target capture while retaining the
sampled improvement in arrival and distance integral over the unallocated
parent. The current candidate receives no formal CFD result until this worker
exits, so reproducibility is an expectation rather than a claimed new result.

Falsification: reject the candidate if it loses capture or coherent leftward
propulsion, arrives materially later than `62.30`, repeats the centered-bias
loop/blow-up, exceeds its `30.0` command envelope, or fails to preserve a
useful bearing residual when the carrier saturates. Treat persistent joint
speed saturation or worse force/moment loads as evidence that acceleration
allocation alone is insufficient and that a later worker should test one
separately calibrated damping or approach mechanism.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and residual path-following control
source_mechanism: sensor-conditioned bounded steering residual layered on a rhythmic locomotor carrier
transferable_invariant: persistent body-frame direction error needs finite actuation authority while a state-feedback traveling bend retains the remaining propulsion budget
nontransferable_details: published gains, robot actuator ratings, dimensional beat rates, clocked phases, species kinematics, exact vortex phases, and source-task routes
policy_translation: map normalized body-frame bearing through tanh to the empirically signed two-joint residual, reserve a small share of a candidate-owned sub-limit acceleration envelope for it, and fit the joint-state carrier into the remaining budget
falsification: reject if target capture, targetward displacement, or coherent propulsion is lost, or if the reserved envelope fails to bound commands and preserve direction during carrier saturation
