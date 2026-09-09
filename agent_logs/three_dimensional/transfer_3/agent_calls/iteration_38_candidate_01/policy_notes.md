# Replicated-route residual-removal candidate

## Visual and metric diagnosis recorded before the policy edit

- All four current samples satisfy the experiment contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  dynamics, and capture at `18.6725--18.7440T`. I inspected both rows of the
  combined sheets for the best-score exact route, the prefilled moment-residual
  variant, and the inherited closing-speed carrier contraction from release
  through capture. Their top-down views show body-led translation and a
  coherent alternating caudal-vorticity street by `4T`; their oblique views
  show compact body-attached and shed Lambda2 structures behind the tail.
  None shows passive advection, wake breakup, growing lateral waste, boundary
  contact, collision, or instability. Local-flow RMS is only
  `0.01804--0.01822U` for the current and closing-speed comparisons, consistent
  with self-propulsion in quiescent water rather than an external wake effect.
- The exact actuator-consistent policy has three current same-hash captures at
  `18.6725T`, `18.6725T`, and `18.7330T`; score spans
  `-0.13362-- -0.13142`, mean distance `2.01959--2.02129L`, posterior action
  RMS `28.72--28.85 rad/T^2`, posterior acceleration-limit occupancy
  `75.19--76.11%`, and force/moment RMS
  `0.01331--0.01350 / 0.00693--0.00703`. This repeat envelope is the relevant
  baseline, not any single fastest sample.
- The prefilled stress-gated moment residual captures at `18.7440T`, scores
  `-0.13364`, and has mean distance `2.02198L`. Its posterior action RMS
  `28.77`, posterior occupancy `75.44%`, and force/moment RMS
  `0.01343/0.00699` all overlap the exact-route envelope. Its top-down and
  oblique wakes are visually indistinguishable from the exact route. The edit
  therefore adds instantaneous self-wake moment dependence without a resolved
  route, effort, load, or wake benefit.
- The inherited logs make actuator cleanup an informative negative rather than
  a missing candidate. Three completed exact-hash hard rate anti-windup runs
  span `18.7000--19.0905T`, scores `-0.13320-- -0.16317`, and mean distance
  `2.02103--2.05157L`; the initially favorable effort result does not replicate
  as a route advantage. Anticipatory rate guards capture at
  `18.9365--19.1235T` with mean distance `2.04236--2.05212L`, while radial
  damping and closing-speed carrier contraction capture at `18.8320T` and
  `18.8705T` with mean distance `2.04018L` and `2.04281L`. All retain coherent
  wakes and overlapping low-flow loads. Suppressing infeasible or terminal
  carrier work has repeatedly traded route progress for effort rather than
  improving control semantics.

## Policy hypothesis recorded before the policy edit

Produce exactly one candidate by removing only the unsupported instantaneous
moment-residual allocation from the prefilled policy. Restore the currently
replicated `dogfish3d_actuator_consistent_tail_phase_v1` controller: preserve
its normalized body-frame bearing plus LOS-rate route, distributed C-bend,
traveling two-joint carrier, response-reversing half-cycle scale, persistent
same-side posterior phase recruitment, and componentwise acceleration
projection. Do not add a replacement scalar, terminal gate, rate guard, or
fluid-response channel.

This candidate is an evidence-backed rollback of a non-separating mechanism,
not a claim that the new CFD result is already known. Later support requires
capture with coherent wakes in both views, arrival within the inherited
`18.6725--19.0520T` robust route band, mean distance no greater than the
current exact-route upper bound `2.02129L`, and force/moment RMS no greater
than `0.01350/0.00703`. Falsify the rollback if it loses capture, breaks the
alternating wake, or consistently lies outside that route/load envelope; only
replicated evidence, not a single score delta, should then justify restoring a
physical-response residual.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction control
source_mechanism: preserve a coordinated posterior-lagged rhythmic carrier while admitting a fluid-response residual only when its disturbance signature and repeated route benefit are separable from the carrier
transferable_invariant: slow target geometry should own route control and the directed traveling bend should remain primary; fast self-generated moment must not modulate that carrier without replicated evidence of a distinct disturbance-response benefit
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, external-wake timing, hardware, and task-specific routes
policy_translation: remove the `moment_z_L2` residual from the prefilled policy and retain the normalized body-frame LOS feedback plus observed-joint-state two-joint phase controller and physical acceleration projection
falsification: reject if the restored route loses capture, weakens either wake, leaves the inherited route band, or exceeds the sampled load envelope; reconsider fluid response only after a repeatable disturbance signature exists
