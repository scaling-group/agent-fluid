# Candidate visual diagnosis and policy hypothesis

## Evidence diagnosis

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and no prewarm, so their early motion is generated
  by the fish rather than background advection.
- In both the top-down vorticity and oblique Lambda2 rows, the naive seed and
  the posterior mean-curvature and posterior half-cycle variants form a wake
  but rapidly curl upward. They leave the upper boundary at `8.55--8.92T`,
  never improving beyond `12.078--12.263L`. The mean-curvature example stays
  below the sampled speed and acceleration limits, so saturation is not the
  sole cause of that failure topology.
- The anterior half-cycle variant is physically and semantically different:
  its top-down row shows a long, coherent alternating wake and a nearly
  horizontal leftward trajectory, while the oblique row shows persistent
  caudal vortex structure without numerical breakup. It survives to `39.09T`
  and reaches `5.156L`, but passes almost directly above the target: at closest
  approach the head is about `(8.91,14.66)L`, leaving approximately `5.16L` of
  lateral error. It then exits the left boundary at `y=14.96L`.
- That useful long trajectory is not a sub-limit carrier. Its joint angles and
  speeds reach `45 deg` and `260 deg/T`; the `30 rad/T^2` policy clamp is active
  on thousands of samples. Its instantaneous heading-rate feedback is also
  beat-dominated (sampled magnitudes reach about `2.62 rad/T`), even while the
  beat-mean course changes only slowly. Thus the controller expends its reserve
  reacting to oscillatory yaw and cannot sustain the target-directed redirect
  after the body-frame target lateral error changes sign.

## Policy hypothesis

Retain the evidenced `0.90T`, `18 deg` traveling-bend scale and the anterior
half-cycle steering location, but make the controller response-based in a
different way: infer phase and oscillator energy only from `(phi1,phi_dot1)`,
regulate that energy around the carrier orbit, and drive the useful half-cycle
from normalized body-frame lateral target error. Steering authority fades
before excess joint energy consumes the angle/speed envelope. The posterior
joint remains a damped lagged follower, preserving the coherent propulsive
wave. This tests whether the best child's missing capability is a persistent,
non-aliased redirect rather than more steering gain.

Expected evidence is a coherent wake with no persistent angle/speed clipping,
an initial small clockwise correction followed by a sustained counterclockwise
redirect as the target moves to the other body side, and a trajectory whose
head descends materially below the `y≈14.6L` corridor. Falsify the mechanism if
the upper curl returns, if the fish repeats the long above-target pass, if
propulsion collapses before meaningful distance progress, or if energy gating
still permits persistent joint-envelope contact.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and asymmetric flapping
source_mechanism: sensor-modulated half-cycle asymmetry with regulated rhythmic amplitude
transferable_invariant: persistent direction error should strengthen only the useful observed half-cycle while a bounded carrier preserves propulsive wave energy
nontransferable_details: published gains, clock phases, robot geometry, species kinematics, dimensional frequencies, and prescribed routes
policy_translation: normalized target_body_L lateral component selects turn sign; joint angle and velocity provide phase and energy; bounded anterior half-cycle drive steers while a lagged posterior target supplies thrust
falsification: reject if the wake loses coherence or progress, either joint persistently reaches its envelope, or the same upward curl or above-target left exit remains
