# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm, and an active inertial moving window. Their translation and wake
  formation are therefore released-swimmer behavior rather than advection.
- The assigned parent asked for an exact replay of
  `dogfish3d_speed_reserve_posterior_wave_shape_v1` after its first sampled
  capture. The two current exact-policy samples now capture at `0.7480L` and
  `0.7492L` after `18.1995T` and `18.4690T`, so the small posterior pulse is
  compatible and repeatable for this fixed initial condition.
- Compatibility did not become an improvement. The posterior scores
  (`-0.15678`, `-0.15855`) and mean distances (`2.0436L`, `2.0456L`) overlap
  but do not beat the two sampled exact speed-reserve baselines, whose scores
  are `-0.15828` and the population-best `-0.15140` and whose mean distances
  are `2.0456L` and `2.0387L`. Inherited trace summaries also place the
  posterior action-clamp, joint-speed residence, and force/moment peaks inside
  rather than below the baseline ranges. There is no evidenced actuator or
  load benefit to justify tuning the posterior gain.
- I inspected both rows of the combined sheets for the highest-scoring
  baseline and both posterior repeats. All show self-propulsion through
  capture, a persistent alternating mid-plane vortex street, and compact
  bilateral three-dimensional Lambda2 structures. The posterior pulse neither
  visibly damages nor improves the carrier. The inherited geometry-gated yaw
  brake is the informative contrast: its sheet retains the active wake, but
  the fish passes below the target, reaches only `1.5097L`, and exits the lower
  boundary. This makes terminal path topology—not weak propulsion, advection,
  carrier collapse, or instability—the live risk.

## One candidate hypothesis

Remove only the unbeneficial posterior wave-shape pulse and restore the exact
`dogfish3d_intercept_guarded_speed_reserve_v1` controller. This preserves the
repeat-backed achieved-course route error, projected-corridor release veto,
state-feedback traveling bend, additive steering, and sparse outward-carrier
reserve. It is a mechanism-level evidence reversion, not scalar gain tuning.

Expected test: recover the repeated baseline capture class and its observed
score/mean-distance envelope while retaining both coherent wake views and the
sampled actuator/load envelope. This candidate does not claim that its new CFD
outcome is already known; formal evaluation occurs after this worker exits.

Falsification: reject the restored baseline if a new exact evaluation misses,
weakens the traveling wake, changes far-field closure, or moves saturation or
force/moment peaks outside the sampled baseline envelope. Future workers
should not re-add or scalar-tune the posterior pulse unless a distinct
observation-conditioned translation predicts and demonstrates a repeatable
path, arrival, load, or actuator benefit.

bookshelf_consulted: true
source_domain: classical undulatory propulsion and robotic-fish closed-loop turning
source_mechanism: separate a posterior-lagged propulsive traveling bend from bounded target-geometry steering
transferable_invariant: preserve an active directional body wave while a subordinate normalized body-frame feedback loop corrects route error
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact vortex phase, prescribed paths, and task coordinates
policy_translation: retain the joint-state traveling bend, body-frame achieved-course/intercept guard, and sparse actuator-state carrier reserve; remove the unsupported extra posterior pulse rather than tuning it
falsification: reject if exact replay loses capture or wake coherence, changes far-field closure, or exceeds the repeat-supported saturation and load envelope
