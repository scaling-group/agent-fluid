# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three raw lateral-sideslip
  route policies reproduce exactly `23.424515T`, `0.749902L`, score-metric
  mean distance `2.184349L`, and score `-0.287480`. The prefilled course-angle
  policy instead captures at `23.369514T`, reaches `0.748821L`, lowers mean
  distance to `2.152884L`, and improves score to `-0.255909`. It is already
  closer at `2T`, `14T`, and `18T` (`12.198925/5.292502/3.203252L` versus
  `12.222539/5.478463/3.402670L`), so the benefit is distributed along the
  route rather than confined to the crossing step.
- The prefilled combined sheet supplies complete visual evidence. Its top-down
  row shows continuous self-propelled translation along the established
  S-shaped approach and an attached alternating red/blue caudal street from
  formation through capture. Its oblique row shows discrete three-dimensional
  Lambda2 structures at `4T`, `12T`, `20T`, and capture. The three slower
  sampled controls retain the same useful top-down route and mid-plane wake,
  but their oblique rows are black render artifacts and cannot support an
  independent 3D-wake claim. Trace recomputation also finds slightly lower
  mean/near-target action for the course loop (`58.179/44.396` versus
  `58.289/45.013`) and no material load increase (`0.029468/0.015365` peak
  normalized force/moment versus `0.029780/0.015287`).
- The assigned-parent posterior-recovery experiment is an independently
  positive actuator-allocation result. On the raw-sideslip route it scales
  only the lagged posterior carrier by up to `1.12` under the existing smooth
  through-water speed-deficit gate and advances capture from `23.424515T` to
  `23.347515T`; its mean distance improves from `2.184349L` to `2.161137L`,
  score improves from `-0.287480` to `-0.263925`, and peak normalized
  force/moment remain near `0.029827/0.015516`. Its top-down sheet retains the
  alternating carrier wake, while its blank oblique row limits the claim to
  compatibility with the inherited complete 3D envelope. The inherited
  counterfactual replay confines the added response to the early measured
  deficit through about `4.83T`, with a bounded `12.02 rad/T^2` maximum
  posterior acceleration change.
- The inherited adverse-yaw-moment residual is the informative negative
  control: it preserves capture and the visible top-down street but delays it
  to `23.853519T`, raises mean distance to `2.194872L`, and worsens score to
  `-0.297049`. Do not compose that fast load residual merely because it was
  independently plausible; current evidence favors the measured locomotor
  deficit path.

## One candidate hypothesis

Preserve the prefilled course-angle route feedback, anterior oscillator
recovery, full target geometry, phase-selective carrier, reactive-rudder sign,
and terminal stroke-qualified relief. Add only the assigned parent's bounded
posterior carrier allocation under the same normalized body-water axial-speed
deficit gate. The course loop and posterior recovery act on distinct roles:
the former compares target bearing with measured through-water travel
direction, while the latter recruits a small additional lagged tail bend only
when actual locomotor advance is deficient. No clock, coordinate, route
memory, global gain increase, exact vortex phase, or new terminal schedule is
introduced.

Falsify the composition if capture is lost or later than `23.369514T`,
score-metric mean distance exceeds `2.152884L`, score is below `-0.255909`, or
the established S-route, complete alternating 3D wake, action, near-cap
occupancy, `0.029468` peak-force, or `0.015365` peak-moment envelope materially
worsens. A better fixed-pose still-water result establishes compatibility of
the two mechanisms, not robustness to a changed pose, inflow, or wake.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming theory and sensor-modulated robotic-fish locomotion
source_mechanism: posterior traveling-wave kinematics generate reactive thrust, while measured locomotor deficit can recruit a rhythmic carrier without prescribing time
transferable_invariant: preserve the joint-state traveling bend and allocate a bounded share of normalized through-water speed recovery to the lagged posterior actuator
nontransferable_details: published gains, distributed-body envelopes, species-specific amplitude and frequency, robot sensor calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain the evidenced body-water course loop and multiply only the lagged posterior carrier by `1 + posterior_propulsion_recovery_gain * propulsion_recovery_gate`, using the existing normalized axial-speed gate
falsification: reject if capture is later than 23.369514T, mean distance exceeds 2.152884L, score falls below -0.255909, or route, complete wake, action, saturation, force, or moment envelopes worsen
