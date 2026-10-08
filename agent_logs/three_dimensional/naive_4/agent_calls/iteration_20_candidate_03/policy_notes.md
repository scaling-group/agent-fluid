# Alignment-escape candidate on the replicated terminal-release carrier

## Evidence and visual diagnosis recorded before the policy edit

- All four sampled evaluations and the assigned-parent evaluation satisfy the
  direct-uniform still-water contract: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, finite dynamics, and `capture` at `16.0544815T` after `2919` steps
  and `239` moving-window shifts.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the best finite sampled child (`solver_d198bc53b207`) and the
  structurally distinct earlier yaw-residual child (`solver_0b4f3f55c611`).
  Both rows show self-propelled target-directed motion:
  a coherent alternating wake grows behind the posterior body by `4T`, remains
  compact in the oblique view, and persists through the smooth approach. There
  is no passive advection, boundary interaction, collision, wake collapse, or
  numerical breakup. The oscillator, posterior traveling bend, base redirect,
  and approach carrier should therefore remain unchanged.
- The inherited yaw-opposition child `solver_0b4f3f55c611` captures at the same
  step with distance integral `1.931256928L`, final distance `0.747530460L`,
  score `-0.048654057`, and mean posterior command `24.6164 rad/T^2`. Releasing
  only its supplemental yaw-residual curvature when the existing closing
  corridor and measured target-signed yaw agree is independently reproduced by
  the assigned parent and two sampled solvers. Those three copies preserve all
  `8/6/4/2/1.75/1.25/1.0/0.9/0.8L` milestones and the same two-view wake, while
  improving the integral to `1.930772896L`, final distance to `0.746954501L`,
  score to `-0.048054833`, and mean posterior command to `24.5998 rad/T^2`.
  This is a small but replicated terminal-response effect, not a new route.
- The sampled alignment-escape extension `solver_d198bc53b207` is the only
  directionally better child of that parent: score `-0.048053160`, integral
  `1.930771544L`, and final distance `0.746952891L`. It changes only `17`
  posterior commands in closed loop, with maximum sampled difference
  `0.03745 rad/T^2`; milestones, capture time, angle extrema, speed/acceleration
  residence, and force/moment peaks remain unchanged. Its `1.61e-6 L` crossing
  improvement is therefore numerical-scale evidence for a narrowly scoped
  release, not evidence that another terminal gate will create useful physical
  trajectory diversity.
- A contemplated carrier-subtracted yaw-moment feedback was rejected before
  editing. A normalized anterior-phase fit explains `94.5%` of parent moment
  variance, but the residual correlates only `0.146` with measured yaw
  acceleration in this still-water self-wake. That is too weak to distinguish
  a corrective hydrodynamic disturbance from carrier/model noise.

## Sole policy hypothesis

Adopt the evaluated alignment-escape extension as the only candidate change.
Keep the assigned parent's oscillator, course/carrier residual redirect,
posterior mean-first allocation, one-sided wave relief, approach law, terminal
measured-yaw release, and exact speed-boundary projection intact. Inside the
already-valid closing capture corridor only, let a reflection-even positive
product of body-frame bearing and bearing rate also release the supplemental
yaw-residual curvature when target angular error is reopening. It cannot alter
the base target/course curvature, wave shaping, or anterior drive. The expected
outcome is deterministic reproduction of the sampled finite capture and its
slightly improved crossing, with no claim of a material new trajectory.

The mechanism is falsified if the new evaluation loses capture or wake
coherence, changes a pre-corridor milestone, increases limiting or loads, or
fails to reproduce the sampled non-regression. Even if reproduced exactly, its
numerical-scale delta is a stopping boundary: later workers should seek a new
feasible-action mechanism rather than add another instantaneous terminal veto.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal fish capture
source_mechanism: retain the rhythmic carrier and withdraw only supplemental steering when body-frame task geometry reports that the intended terminal response has been superseded
transferable_invariant: separate propulsion from residual navigation authority, and make residual authority contingent on normalized target geometry plus measured response
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phase, capture radius, and task-specific routes
policy_translation: preserve the two-joint state-feedback carrier; only inside the existing closing corridor, smoothstep positive bounded `bearing * (bearing_rate / carrier_frequency)` and combine it with measured target-signed yaw to release supplemental posterior yaw-residual curvature
falsification: reject on lost or delayed capture, changed pre-corridor milestones, degraded two-view wake, greater limiting or loads, or failure to reproduce the sampled terminal non-regression; do not infer a reusable trajectory gain from a numerical-scale delta

The bookshelf supplied only the residual-control and measured-response
invariant. The existing corridor, carrier predictor, normalization, scale, and
two-joint allocation come from completed L64 rollouts rather than published
gains or source-specific kinematics; this is not scalar-only tuning.
