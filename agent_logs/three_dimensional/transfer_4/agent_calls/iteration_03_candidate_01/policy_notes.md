# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled evaluations satisfy the Phase-2 flow contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no prewarm
snapshot, and both the top-down mid-plane and oblique Lambda2 views present.
I inspected the combined sheets for the best finite capture
`solver_fb3dd7355a7f` and the informative seed failure
`solver_e496f399e09f`, then cross-checked all four scores, trajectories,
diagnostics, policy sources, the assigned-parent guidance, and inherited
optimizer notes.

- Both visual rows show self-propulsion and an alternating three-dimensional
  caudal wake rather than passive advection. The seed keeps that wake but curls
  below and past the target: distance falls from `12.3277L` to `4.7800L` at
  `17.853T`, then rises to `9.7089L` before a lower-boundary exit at `27.495T`.
  The captured rows keep a compact wake and make a continuous late turn onto
  the target instead of losing propulsion or leaving the plane.
- The assigned-parent signed-curvature controller and its unclamped predecessor
  have identical applied motion and capture at `23.353T`, `0.74968L`; the
  parent's explicit `1800 deg/T^2` output clamp merely makes the episode's
  immediately downstream envelope policy-owned. This confirms the inherited
  conclusion that same-sign, odd posterior mean curvature is the decisive
  route-level mechanism while leaving actuator desaturation unresolved.
- The sampled course-aligned cadence variant also captures with the same wake
  and load scale. It lowers mean distance from `2.414681L` to `2.412601L`,
  crosses at `0.74697L` instead of `0.74968L`, and improves score from
  `-0.517910` to `-0.515277`. It does not validate the original shorter-arrival
  hypothesis: termination is `23.3585T`, one `0.0055T` integration step later.
  Peak speed (`0.7515 L/T`), planar force/moment (`0.0367/0.0183`), joint-angle
  range (`27.6/37.2 deg`), and acceleration-envelope incidence (about
  `70%/52%`) remain essentially unchanged. The scalar margin is therefore
  evidence for capture preservation and a slightly closer crossing, not for a
  material efficiency or speed gain.
- Because a structural terminal gate has completed a positive semantic test,
  stacking a second steering residual or retuning oscillator scalars would
  confound the evidence. The narrowest evidence-backed candidate is the
  captured cadence variant merged with the parent's explicit command clamp.

## Candidate hypothesis

Preserve the demonstrated signed-curvature guidance, half-cycle steering, and
joint-state traveling wave. Inside the existing `2.10L` approach region only,
floor the cadence with a bounded rotation-invariant gate formed from the
normalized body-frame target/velocity dot product and speed. The floor remains
inactive outside the approach region because the existing distance gate is
already one there, and it releases continuously when speed or target-course
alignment disappears. Retain the policy-owned symmetric acceleration clamp;
it is identical to the episode envelope and does not alter the sampled
variant's applied command.

The next rollout should reproduce the captured topology and compact wake while
retaining the sampled variant's lower mean/final distance. Falsify this
candidate if capture is lost, observed distance integral worsens materially,
the approach overshoots, or saturation/load histories rise. Do not interpret a
one-step arrival difference as evidence for cadence tuning; a later worker
should test a different measured terminal residual if faster arrival remains
the objective.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal target approach
source_mechanism: preserve a propulsive oscillator while observed target-course alignment continuously schedules cadence
transferable_invariant: maintain the traveling wave when body-frame velocity is already directed along the target vector, and release extra drive when alignment or speed disappears
nontransferable_details: published gains, dimensional beat frequencies, species kinematics, prescribed routes, exact vortex phases, and source-task terminal maneuvers
policy_translation: use a normalized body-frame target/velocity dot product and bounded speed gate to floor the existing cadence only inside the distance-conditioned approach region
falsification: reject if capture is lost, distance integral worsens materially, terminal overshoot appears, or actuator and load histories deteriorate
