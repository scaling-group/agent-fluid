# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled evaluations satisfy the direct-initialization contract:
  `initialization_mode=uniform_direct`, `direct_uniform_initial_condition=true`,
  and background velocity `[0,0,0]`. All terminate by capture with no angle,
  rate, or acceleration contacts in the logged traces.
- The combined top-down/oblique sheets show self-propulsion rather than
  advection. By `8T` the fish has an alternating near-body vorticity street and
  compact three-dimensional Lambda2 structures; by `16T` and `24T` the street
  remains coherent while the body follows the same broad shallow approach and
  late hook in every sample. There is no visible wake collapse, diffuse
  lateral thrashing, collision, or domain-exit precursor.
- The strongest finite sample, `solver_c65157fcb0b0`, changes the upstream
  route through a course-triggered, response-released redirect. It captures at
  `25.9710T`, has mean distance `2.498175L`, and reaches
  `10.430731/6.102331/1.726168L` at `8/16/24T`. The assigned parent
  `solver_fb7bddf12f80` captures at `26.1635T`, has mean distance `2.509866L`,
  and reaches `10.451165/6.188785/1.810235L`. The strongest sample therefore
  supplies a useful route comparison, but its visual topology is still the
  same shallow hook rather than a new terminal maneuver.
- The informative negative sample, `solver_3065fba218c6`, commutates the
  parent's course-slip tail shift with instantaneous normal-force response. It
  keeps the coherent wake and captures at `26.0920T`, but regresses mean
  distance to `2.512198L` and score to `-0.609997`, versus the parent's
  `-0.607211`. Its peak planar force/yaw moment (`0.018828/0.009854`) and zero
  contacts do not reveal a safety benefit that offsets the worse integral.
  This supports the inherited negative boundary against force gating.
- Across the parent trace and the sampled descendants, the inherited phase
  audit is the only response observation that separates within the active
  upstream course-slip interval: desired-course-normal force has helpful sign
  on target-side anterior-bend rows and adverse sign on opposite-bend rows.
  My independent trace reduction confirms the sign split in all four samples;
  the parent has 609 target-side rows with positive mean signed lateral force
  and 572 opposite-side rows with negative mean signed lateral force under an
  upstream, closing, slip-deficit filter. The current parent applies the
  posterior course shift on both halves.

## Policy hypothesis

Keep the assigned parent's productive carrier, target geometry, redirect,
line-of-sight response, posterior steering magnitude, terminal allocation, and
coordinated viability projection unchanged. Add one reflection-equivariant
joint-phase qualifier to the upstream posterior course-slip mechanism: pass
the shift exactly when `course_side*q1 >= 0`, and smoothly suppress it as the
normalized anterior bend moves to the opposite side. This is a one-way veto,
not added authority. It should retain the parent's coherent gait and capture
while avoiding posterior steering during the measured adverse-response
half-cycle, improving the upstream distance integral or producing a visibly
different useful course. It is falsified if capture is lost, the
`8/16/24T` distances or mean distance regress, the wake loses coherence, peak
loads rise, or actuator contacts return.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and classical asymmetric flapping
source_mechanism: use sensed locomotor phase to apply turning asymmetry on the useful half-cycle
transferable_invariant: preserve the propulsive rhythm and qualify bounded steering by observed joint phase and current body-frame turn request
nontransferable_details: published gains, robot geometry, prescribed oscillator timing, species kinematics, exact vortex phase, and task-specific routes
policy_translation: use normalized `q1/oscillator_amplitude` and the body-frame `course_side` to suppress only the opposite-bend share of the existing posterior course-slip target shift
falsification: reject if fixed-condition capture or upstream progress regresses, wake coherence is lost, loads rise, or any joint limit contact returns

## Post-edit contract audit

- The two new active thresholds are owned by `target_policy_params`; no state,
  time, route, flow-field, or case identity was added.
- On an upstream closing mock state with positive course error and an
  opposite-side anterior bend, the parent and candidate anterior commands are
  identical (`-7.11165`), while the candidate reduces only the posterior
  steering share (`-2.44178` to `-1.66769`). The mirrored state produces the
  exact sign-reversed candidate action, confirming reflection equivariance for
  the new gate.
- The prescribed lightweight policy, guidance-semantic, and editable-boundary
  checks pass. No CFD result is claimed here; the candidate hypothesis remains
  pending downstream evaluation.
