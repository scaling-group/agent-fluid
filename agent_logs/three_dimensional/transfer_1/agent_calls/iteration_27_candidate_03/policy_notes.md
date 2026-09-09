# Candidate diagnosis and policy hypothesis

## Evidence read before the candidate decision

- All four sampled rollouts and the assigned-parent rollout satisfy the frozen
  experiment contract: direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and active moving-
  window shifts. Their motion and wakes are produced by the released swimmer,
  not ambient advection.
- Two samples use the exact intercept-guarded speed-reserve bytes and capture
  at `0.7485--0.7494L` after `18.287--18.601T`. The other two use the exact
  prefilled posterior-wave bytes, SHA-256
  `393aac051dfa5d938ff7d56c3f86df355a494b578710d007bc9954ab3bfc265a`,
  and capture at `0.7480--0.7492L` after `18.199--18.469T`. The posterior
  variant therefore has two compatible evaluations, but not yet enough
  evidence to claim superiority over the repeat-backed baseline.
- I inspected both rows of the combined keyframe sheets for the best finite
  baseline capture, a posterior-wave capture, and the assigned parent's
  informative failure. Both captured policies visibly self-propel, turn toward
  the target, and retain an organized alternating mid-plane vortex street plus
  compact bilateral oblique Lambda2 structures through arrival. The failed
  full-band release policy retains the same qualitative traveling wake after
  passing below the target and continues toward the lower boundary; it neither
  coasts nor becomes unstable.
- Trace metrics agree with the visual diagnosis. The two posterior-wave
  captures reach `0.929--0.932L/T`, peak planar force
  `0.0314--0.0319`, and peak yaw moment `0.0161--0.0167`; their returned
  actions clamp on `68.2--68.4%/70.9%` of rows and their joints reside at the
  speed limit on `10.5--10.6%/11.5--11.7%`. These remain inside the sampled
  baseline envelope to useful precision.
- The assigned parent's full-band geometry veto is a concrete negative result.
  Removing the intercept distance blend did not robustify response release: it
  missed at `1.3725L`, exited the lower boundary at `32.571T`, finished
  `10.6694L` away, and scored `-11.5021`. At closest pass it still traveled
  `0.8415L/T`; peak force and moment remained `0.0308/0.0162`, and the two
  action channels still clamped on `70.3%/70.8%` of rows. The failed branch
  was already lower at its first `4L` crossing (`head_y=10.714L`) than all
  four sampled captures (`10.946--11.069L`). This is a terminal interception
  failure, not evidence for more drive, carrier suppression, corridor-gain
  tuning, or saturation-driven allocation.
- Inherited guidance separately rejects scalar cadence relief, carrier
  suppression, total-command governors, half-cycle allocation, projected-miss
  route replacement, yaw braking, mean-curvature tracking, and course
  demodulation in this topology. Stacking one of them onto the newest failure
  would confound the only current positive question: whether the small
  posterior wave-shape mechanism repeats.

## One candidate hypothesis

Materialize the exact prefilled
`dogfish3d_speed_reserve_posterior_wave_shape_v1` policy without gain, schema,
or byte changes. It preserves the repeat-supported achieved-course controller,
intercept guard, traveling-bend carrier, and sparse outward-carrier reserve,
while its small posterior target bias is normalized by joint-state phase,
subordinate to target geometry, and identically zero outside the existing
intercept gate. This rollout is a third exact-repeat test after two captures,
not a same-worker claim of robustness or improvement.

Expected test: repeat capture while preserving far-field closure, the active
top-down and oblique wakes, and the sampled actuator/load envelope. A third
capture would support compatibility and fixed-condition repeatability, but
would still not establish superiority over the baseline.

Falsification: after any exact-policy miss, upper/lower exit, weakened wake,
far-field divergence, or actuator/load excursion, reject the posterior pulse
as a robustness repair and restore the repeat-backed baseline before testing a
genuinely distinct terminal observation. Do not tune the pulse gain, widen the
failed full-band veto, or stack a previously falsified residual.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a posteriorly lagged propulsive bend while a small target-conditioned posterior shape change remains subordinate to the route controller
transferable_invariant: steering modulation should preserve the active directional body wave and vanish outside the observed interception regime
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, world-frame routes, and task coordinates
policy_translation: retain the normalized body-frame achieved-course and intercept controller, using only anterior joint state to gate the already-bounded posterior target bias in the two-joint traveling bend
falsification: reject after any exact miss, wake weakening, far-field route change, or excursion beyond the repeat-supported saturation and load envelope
