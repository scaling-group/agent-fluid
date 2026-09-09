# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization, `U_infinity=(0,0,0)`, no cylinders, no prewarm, and
  finite capture termination. Their translation and wakes are released-fish
  self-propulsion rather than ambient advection.
- I inspected both rows of every sampled combined keyframe sheet. From about
  `4T` through capture, the top-down views show a coherent alternating signed
  street and the oblique Lambda2 views show compact alternating three-
  dimensional structures. The fish keeps a traveling bend and turns toward
  the target without collision, wake collapse, coasting, or instability.
- The two exact speed-reserve samples capture at `0.7480--0.7494L` after
  `18.205--18.601T`; the two posterior-pulse samples capture at
  `0.7480--0.7492L` after `18.199--18.469T`. The inherited record still favors
  the phase-independent baseline because the pulse has two exact lower exits
  without a distinct wake, load, actuator, or arrival benefit.
- I also inspected the assigned parent's informative failure. Its opening-
  pass burst-redirect candidate remains self-propelled and continues laying
  down an active alternating wake in both views, but turns into a persistent
  lower arc, reaches only `1.7572L`, and exits at `31.433T`. The prior terminal
  mean-curvature servo similarly exits after a `1.8818L` pass. Together these
  results reject adding more same-sign curvature before or after the pass;
  propulsion and available route gain are not the missing capability.
- The trace-level distinction is carrier contamination of achieved course.
  Instantaneous body-frame course swings by roughly `+-0.5 rad` with the beat
  and repeatedly flips the steering request even on captures. A centered one-
  period audit over three baseline captures and the exact-baseline
  `1.7276L` failure finds that `qdot1` and `qdot2` explain about `99%` of the
  beat-scale lateral-velocity component. The evidence-fitted relation
  `v_lateral,beat = -0.0688*qdot1 + 0.0206*qdot2` reduces its RMS from about
  `0.233` to `0.030L/T`.
- This is more than a quieter scalar. At the first `3.5L` and `3.0L` crossings
  of the exact-baseline failure, raw course error is approximately `0.00` and
  `0.05 rad`, whereas carrier-compensated error is `0.39` and `0.45 rad`.
  Thus the raw servo briefly reads a beat-induced lateral velocity as route
  acquisition just before the lower branch. On prior traces, compensation
  also lowers terminal turn-command total variation by about `20--40%` while
  leaving all distances outside the terminal gate unchanged.

## Architecture proposal written before the policy edit

Retain the exact evaluated traveling-bend carrier, achieved-course/intercept
servo, additive phase-independent steering, and conditional outward-carrier
reserve. Add one observation-side carrier-rejection mechanism: between
`4.5L` and `3.5L`, smoothly replace only the lateral component used to compute
achieved course with its joint-state-compensated value. Keep actual speed,
closing speed, projected miss, alignment, response gates, steering authority,
and actuator allocation unchanged. This uses the oscillator's observable
joint state, not a clock or mutable phase, and introduces no new curvature
command.

Expected result: preserve the far-field approach and active wake, reduce
beat-driven steering reversals, and reveal persistent lower drift early enough
for the already evaluated steering realization to act. Falsify the mechanism
if it loses capture, changes closure outside `4.5L`, weakens either wake view,
increases clipping, joint-speed residence, force or yaw-moment loads, or keeps
the same `1.7--1.9L` lower-exit topology. A single threshold capture would show
compatibility only; robustness requires exact repeats.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-control separation of slow route error from fast lateral oscillation
source_mechanism: use observable oscillator state to separate locomotor-period lateral motion from the persistent course signal while preserving the propulsive traveling wave
transferable_invariant: steering feedback should react to the mean achieved course rather than treating carrier-synchronous sway as a persistent route error
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, explicit oscillator clocks, exact vortex phases, full-body splines, and task-specific routes
policy_translation: subtract the evidence-fitted joint-velocity carrier component from normalized body-frame lateral velocity only for terminal course estimation, then feed the compensated course to the unchanged two-joint steering and carrier contract
falsification: reject if capture or far-field closure is lost, steering variation or actuator use rises, the alternating top-down or oblique wake weakens, or the same lower-pass exit remains
