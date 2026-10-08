# Terminal course-to-yaw-rate reference

## Visual and quantitative diagnosis before editing

- I read the assigned guidance, sampled policies and rollout files, and the
  inherited optimizer notes/results before editing. I also inspected both the
  top-down vorticity and oblique Lambda2 rows of the combined keyframe sheets
  for the sampled-best posterior envelope and the two informative follow-up
  failures. Every rollout is a stable capture from direct uniform still water
  with `U_infinity=(0,0,0)`, no prewarm, and no cylinders. The fish visibly
  self-propel from rest; all three top-down rows retain a coherent alternating
  wake, and all three oblique rows retain compact posterior three-dimensional
  structures through capture. There is no passive advection, collision, wake
  breakup, domain exit, or out-of-plane instability. Route and terminal state,
  rather than gross wake existence, therefore discriminate these controllers.
- Three sampled policies reproduce the phase-consistent trajectory exactly at
  score/mean distance `-0.064599/1.950823L`, capture `18.0125T`, center path
  `13.2330L`, and head cross-track `0.7417L`; this includes a terminal
  phase-reference partition with no realized authority. The sampled-best
  alignment-qualified posterior-wave envelope keeps the far/middle trajectory
  and coherent wake, improves score/mean distance to
  `-0.064545/1.950801L`, shortens path/cross-track to
  `13.2111L/0.7232L`, and reduces near/final absolute yaw to
  `1.8883/0.4200 rad/T`. It retains capture at `18.0235T`, but mean/final
  target-course alignment is still only `0.6722/0.1818`; mean/final signed
  course error is `0.5951/0.9833` while near speed remains `0.8866U`.
- The assigned parent's direct signed target-course residual is a concrete
  negative result. It preserves capture and the same two-view wake, and makes
  only tiny mean/path changes, but worsens score/mean distance to
  `-0.064645/1.950875L`, final alignment from `0.1818` to `0.1640`, and final
  absolute yaw from `0.4200` to `0.5884 rad/T`; posterior near acceleration-
  ceiling residence also rises from `72.47%` to `72.66%`. Adding the signed
  residual directly to curvature therefore reinforces late yaw before the
  velocity course can respond. The sibling direction-selective posterior
  half-cycle test is the second informative failure: it captures at
  `18.0015T`, but regresses to `-0.065358/1.951413L`, restores final absolute
  yaw to `1.3862 rad/T`, and drops final alignment to `0.0428`. Selective
  relief discarded the symmetric envelope's damping, despite preserving the
  visible wake and near speed.

## Single policy hypothesis

Start from the evaluated-best alignment-qualified posterior-wave envelope,
preserving its odd body-frame target-to-curvature map, anterior state-feedback
carrier, posterior lag/emphasis, phase-consistent reserve, far/middle route
observer, mean steering, half-cycle steering, and reversal-preserving rate
governor. Add one terminal course-to-yaw-rate mechanism. Compute the normalized
body-frame target/velocity cross product used by the failed direct residual,
but map it to a bounded desired turn rate rather than directly to curvature.
Blend that reference with the existing geometry-derived target turn rate only
inside the normalized approach region and only when measured speed makes the
course direction observable. The existing turn-rate feedback then supplies
signed correction from desired minus measured yaw, so an already excessive
correct-side turn is braked rather than reinforced.

The mechanism is exactly inactive outside `2.10L` and at rest. On the sampled-
best trajectory its smooth approach/speed blend averages `0.3274` below
`2.10L` and reaches `0.7072` at capture. At capture it changes the desired
rate from `-0.7477` to `-0.7290 rad/T` while measured recent yaw is about
`-0.8136 rad/T`, increasing corrective braking instead of adding the failed
direct negative bend. Expected evidence is unchanged far/middle closure and
wake, preserved capture and sampled-best mean distance, and lower terminal yaw
and signed course error with higher final alignment. Falsify if behavior moves
before approach, capture or score regresses, final alignment/yaw does not beat
the posterior-envelope parent, load merely migrates between joints, reflection
fails, or either visual wake view deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal capture staging
source_mechanism: modulate a rhythmic propulsive controller through closed-loop direction-rate tracking so course error requests a bounded turn rate and measured yaw supplies damping
transferable_invariant: a course correction should specify the desired rotational response and close feedback around measured turn rate; directly biasing curvature can reinforce an already excessive turn before translational course responds
nontransferable_details: published gains, dimensional cadence, species-specific duty ratios or kinematics, full-body oscillator networks, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: normalize the body-frame target/velocity cross product, map it oddly to a bounded terminal yaw-rate reference, blend it with the existing geometric rate reference using normalized approach and speed gates, and retain the two-joint rate-error feedback and traveling wave
falsification: reject if pre-approach behavior changes, capture or sampled-best mean distance is lost, terminal yaw/course/path does not improve, actuator pressure migrates without benefit, reflection fails, or either coherent wake view deteriorates

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account, so the checker could not
  start. Running its immutable checks directly gives PASS for the material
  guidance update and repository boundary. The rendered workspace initially
  contained the same assigned-parent marker twice; removing the duplicate made
  the parent selection unambiguous without changing which parent is assigned.
- No Julia executable is installed, so the exact Julia include/action probe
  cannot run in this shell. The deterministic schema guard passes: all `64`
  direct `params.FIELD` references resolve among the `66` unique fields returned
  by `target_policy_params`; the two unreferenced fields are metadata/adapter
  compatibility (`version` and `control_period`). Delimiter balance is zero,
  the candidate is non-empty, and no clock, step, random, mutable global,
  cylinder coordinate, or world-target route source appears in the policy.
- Focused algebraic probes make the new rate-reference gate exactly zero
  outside approach and at rest. A mirrored body-frame target/velocity/rate
  probe preserves gate magnitude `0.670025`, flips course error
  `+0.675725 -> -0.675725`, and flips desired rate and resulting rate error
  with unchanged magnitude. These are contract and mechanism checks, not CFD
  evidence; EvE must evaluate the trajectory hypothesis after this worker exits.
