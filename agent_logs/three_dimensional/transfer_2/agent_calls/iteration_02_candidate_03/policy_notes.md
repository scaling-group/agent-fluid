# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled episodes are valid direct-uniform still-water rollouts with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion and wakes
  therefore diagnose self-propulsion and closed-loop steering rather than
  ambient advection.
- The assigned parent's compact bearing/turn-rate controller is the strongest
  finite sample: score `-7.6367`, coherent alternating top-down and oblique
  Lambda2 wakes, minimum distance `5.3570 L` at about `19.05 T`, and final
  distance `5.8935 L`. It changes the inherited lower-boundary failure into an
  upper-boundary exit at `21.79 T`, so its posterior-lag propulsion and compact
  target feedback are worth preserving, but it does not settle on the target
  line.
- Reconstructing the evaluator's normalized body-frame bearing shows why the
  scalar improvement is incomplete. The parent crosses from `+8.9 deg` at
  release to negative bearing near `4 T`, then spends the later approach near
  `-40` to `-80 deg`; it passes roughly `5 L` above the target. Its gait also
  produces roughly `+/-2.5 rad/T` instantaneous yaw swings. Feeding that raw
  response into a saturated rate brake makes steering change with tailbeat
  phase instead of representing slow route rotation.
- The parent's final soft-bounded actions still exceed `95%` of its
  `31 rad/T^2` command limit on `24.3%/48.7%` of rows, and joint speed exceeds
  `250 deg/T` on `15.4%/20.4%` of rows. More importantly, its actuator map is
  internally opposed: positive bearing makes the anterior steering
  acceleration negative but requests a positive mean tail tangent. The
  sign-corrected layered 2D transfer reached a lower `4.1281 L` minimum before
  exiting left, which supports the positive-bearing/negative-curvature 3D sign
  calibration, although its branch stack exceeded the acceleration envelope
  on about `72%/70%` of rows and is not suitable to restore wholesale.
- The response-gated distributed-curvature sample is the counterexample to
  adding more rate logic: it remains actuator-feasible but barely develops a
  propulsive wake, reaches only `12.3038 L`, and curls into an upper exit by
  `9.87 T`. The inherited lower-exit sample likewise confirms that a coherent
  wake alone is insufficient when signed route control is wrong.
- The inherited optimizer note predicted that the compact controller should
  arrest the initially correct turn near zero bearing. Its evaluated child did
  avoid the old lower exit and improved distance, but failed that settling
  test. The next test should therefore repair the semantic opposition and
  remove gait-rate contamination, not add terminal-capture or wake-rejection
  branches; no sampled fish reached the `0.75 L` neighborhood or encountered an
  external wake.

## Policy hypothesis

Preserve the assigned parent's joint-state Van der Pol drive, posterior lag,
and smooth controller-owned acceleration bound. Use one reflection-symmetric
route mechanism: normalized body-frame bearing requests a bounded signed mean
bend, and apply that same sign to the small anterior steering acceleration and
the posterior total-tangent target. Do not feed instantaneous yaw rate into the
route request because the sampled signal is dominated by propulsive tailbeat
yaw. This is a semantic coordination change, not a scalar gain sweep.

The candidate is falsified if negative bearing does not produce positive
cycle-mean heading recovery early enough to avoid the upper/left pass, if the
minimum distance does not improve on `5.3570 L`, if the coherent wake or
closing progress collapses, or if command/rate limit residence increases.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning superposed on undulatory propulsion
source_mechanism: target-conditioned bounded mean-curvature bias on a posterior-lagged traveling bend
transferable_invariant: preserve the propulsive phase lag while persistent body-frame target error requests one coordinated signed average bend across the available joints
nontransferable_details: published gains, species-specific kinematics, dimensional cadence, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: map normalized body-frame bearing to one bounded turn command; give anterior acceleration and posterior mean tangent the same calibrated sign while retaining joint-state gait phase and soft acceleration bounds
falsification: reject if cycle-mean bearing does not recenter, the same high/left exit remains, closest distance fails to improve, wake coherence collapses, or actuator-limit residence worsens
