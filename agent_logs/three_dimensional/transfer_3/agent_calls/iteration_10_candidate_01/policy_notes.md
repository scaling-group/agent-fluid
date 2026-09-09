# Bearing-triggered distributed C-bend candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations are finite, direct-uniform still-water rollouts
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their translation
  and wakes are self-generated, not imposed advection or moving-window motion.
- Both rows of the combined sheets were inspected. The best-score short run
  (`solver_adc862529891`) carries a coherent alternating top-down street and
  compact oblique Lambda2 structures but rises to `y=15.20L`, reaches only
  `5.658L`, and exits left at `16.77T`. The closest sampled run
  (`solver_3b6bd84298a5`) preserves the same productive wake to `30.12T` and
  reaches `3.369L`, yet crosses the target station near `y=12.89L` and exits
  left. This is a lateral route-authority failure, not lost propulsion.
- The assigned parent (`solver_cf44a7c3b1a7`) is a direct negative test of
  range-only approach damping. Its wake visibly narrows after the range
  transition, but relative to the otherwise identical LOS-rate release its
  minimum distance worsens from `3.369L` to `3.392L`, final distance worsens
  from `8.689L` to `8.979L`, score worsens from `-9.996` to `-10.237`, and the
  same left-exit topology remains. At closest approach it is still moving at
  about `0.82U` near `y=12.93L`; slower propulsion alone did not redirect it.
- The parent and its LOS-rate predecessor already saturate their bounded
  `+0.50 rad/T` route demand from roughly `12T` onward while the target bearing
  grows beyond `40 deg`, yet steering enters only as a posterior mean offset.
  A prior half-cycle-strength candidate turned strongly but curled upward near
  the start and lost the long wake. The useful next test is therefore a
  large-bearing actuator redistribution, not more posterior gain, range
  damping, or half-cycle tuning.
- Local flow remains small near closest approach (about `0.018--0.021U` axial
  and `0.003--0.004U` lateral), and the force/moment histories remain finite.
  The candidate should not add a wake-rejection term in this still-water
  evidence regime.

## Policy hypothesis recorded before editing

Revert the failed range damping while preserving the evaluated `28 degree`,
`0.55T` state-feedback traveling bend and LOS-rate release. Add one bounded
actuator mechanism: when normalized body-frame bearing exceeds a smooth
large-error threshold, shift the anterior oscillator equilibrium in the sign
of the bounded route-yaw request. Express the posterior traveling-wave target
relative to that shifted equilibrium so its propulsive oscillation remains,
while retaining the existing separately bounded posterior mean curvature.
This distributes a slow C-bend across both joints only after the high-pass is
observable; small bearing returns continuously to the original carrier.

Expected evidence is unchanged early wake formation, a materially stronger
downward redirect once the bearing grows, target-station crossing below the
parent's `y=12.93L`, and closest approach below `3.369L` or a better
termination class. Reject the mechanism if it recreates the short upper curl,
causes persistent joint/acceleration clipping or wake collapse, or retains the
more-than-`3L` high left pass despite activating the anterior bend.

bookshelf_consulted: true
source_domain: biological burst turning and robotic-fish CPG mean-offset steering
source_mechanism: a large sensory direction error recruits a bounded whole-body mean bend while rhythmic propulsion persists and releases as alignment returns
transferable_invariant: recruit additional distributed curvature only for a large observed body-frame route error, preserve the traveling wave, and release continuously from observed geometry
nontransferable_details: published gains, species-specific C-start shape and timing, robot linkage geometry, clock phase, dimensional rates, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame bearing and the bounded LOS-rate yaw request to shift the anterior state-feedback oscillator equilibrium, while the second joint retains relative lag and separately bounded posterior curvature
falsification: reject if the early upper-turn failure returns, the coherent carrier collapses, clipping or loads materially worsen, or the target-station pass remains more than 3L high without a better termination

## Dry validation after editing

- The mandated policy-contract check loads the candidate and returns two
  finite accelerations for the full observation schema.
- A mirrored synthetic large-bearing state returns exactly sign-mirrored joint
  accelerations. The anterior redirect remains below its `6 deg` bound and is
  exactly zero for aligned target geometry; the tested large-bearing state
  recruits `5.58 deg`.
- The repository boundary check passes with only
  `candidate_target_policy.jl` editable inside `solver/`. No CFD rollout was
  run, and no outcome for this candidate is claimed here.
