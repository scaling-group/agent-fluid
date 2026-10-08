# Wake-policy candidate notes

## Visual and numerical diagnosis before the policy edit

- All sampled rollouts satisfy the released experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, finite `capture` termination, and no reported numerical
  instability. The strongest completed sample is the response-plus-anterior-
  stroke relief policy: it captures at `24.310009T` in 4,420 steps, with score
  mean distance `2.223959L`, crossing distance `0.749162L`, and peak normalized
  force/moment near `0.031649/0.016385`.
- Its complete top-down sheet shows a continuously self-propelled curved
  approach and an alternating red/blue caudal street through capture. The
  matching complete oblique sheet from `solver_43e27134a723` shows discrete
  three-dimensional Lambda2 structures at the developed `8T`, `16T`, `24T`,
  and terminal frames rather than wake collapse or inertial coasting. The
  assigned-parent numerical trajectory is byte-equivalent, but its sampled
  oblique row is blank; that is a render failure and is not additional 3D-wake
  evidence.
- The matched velocity-alignment regression is an informative failure despite
  retaining capture. Its complete top-down and oblique sheets preserve the
  same carrier and route topology, but it reaches capture only at
  `24.354012T`/4,428 steps and crosses at `0.749543L`. Thus replacing the
  beat-scale closing response with a smoother translation signal did not
  improve this approach; visually preserved propulsion alone did not recover
  the lost terminal progress.
- The newest inherited actuator-aware test supplies a sharper negative result.
  Adding a posterior carrier-reinforcement gate to the successful anterior-
  stroke relief delays capture to `24.326511T`, raises score mean distance to
  `2.224136L`, and worsens score to `-0.325361`. Its top-down route remains
  coherent but its oblique sheet is blank. Do not stack another posterior
  phase qualifier: the extra gate erased the three-control-step benefit rather
  than identifying a better tail-load interval.
- The assigned parent still exposes a distinct allocation boundary. Compared
  with symmetric posterior relief, its phase-qualified relief arrives three
  steps sooner, but mean action norm inside `1.5L` rises from about `42.934` to
  `43.000`, and full head-relative error at crossing rises from about `1.307`
  to `1.324 rad`. Near the crossing the closing-deficit gate is active, the
  target-side anterior stroke gate is near one, and the non-carrier anterior
  redirect remains at full authority. Earlier recent-yaw unloading caused
  carrier decay and coasting, so any new terminal unloading must leave the
  Van der Pol drive and lagged posterior carrier untouched.

## One candidate hypothesis

Preserve the assigned parent's joint-state traveling carrier, target geometry,
posterior reactive-rudder sign, distance/error recruitment, closing-deficit
sensor, target-side stroke allocation, and tested 20% posterior relief. Add one
actuator-allocation mechanism: use that same bounded terminal response-plus-
stroke gate to release at most 20% of the anterior redirect residual, while
leaving the anterior oscillator and the entire posterior carrier unchanged.
This tests whether excess near-target steering effort lies in a second
non-propulsive residual rather than in a still-narrower tail phase. It changes
no command while the established terminal gate is inactive and remains
reflection equivariant because target-side sign and anterior joint-rate sign
reverse together.

Falsify the candidate if capture is lost or later than `24.310009T`, score mean
distance exceeds `2.223959L`, behavior changes before the existing terminal
gate activates, or near-field action, rate-cap occupancy, peak force/moment,
terminal target error, top-down wake, or complete oblique wake worsens. A
fixed-pose improvement would still not establish robustness to pose or
hydrodynamic perturbations.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: preserve the rhythmic propulsive carrier while sensory feedback reallocates bounded steering residuals during approach
transferable_invariant: separate propulsion from steering and unload only a non-carrier steering residual when observed terminal response and joint phase indicate competing allocation
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, duty ratios, prescribed maneuver timing, exact vortex phases, and task-specific routes
policy_translation: retain the joint-state anterior oscillator and posterior traveling carrier; multiply only the anterior redirect residual by a bounded authority formed from normalized closing deficit and the reflection-equivariant target-side anterior stroke gate
falsification: reject on lost or later-than-24.310009T capture, mean distance above 2.223959L, any preterminal route change, or worse terminal error, effort, saturation, force, moment, or either wake view
