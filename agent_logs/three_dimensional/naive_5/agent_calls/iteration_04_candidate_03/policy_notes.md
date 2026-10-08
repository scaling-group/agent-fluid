# Candidate diagnosis and hypothesis

## Inherited evidence

- All four sampled episodes report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`; there is no prewarm artifact.
- The naive `0.55T/28 deg` seed and the course-error and low-authority
  descendants all form a visibly self-propelled, alternating three-dimensional
  wake, but their top-down and oblique sheets show the same tight upward curl.
  They leave the upper boundary at `8.55--9.30T`, with minimum distances only
  `11.95--12.19L`.
- The inherited anterior half-cycle policy is the only sampled topology change:
  it survives `39.088T`, moves from `x=21.0L` to the left boundary, and reaches
  `5.156L`. Its top-down row shows a strong alternating wake and nearly
  horizontal transit, while the oblique row confirms a coherent physical wake
  rather than moving-window advection. It nevertheless stays in
  `y=13.780--14.961L`, passes the target's x station roughly `5L` high, and
  exits with distance `10.235L`.
- That apparent steering success is substantially a propulsion effect. Across
  the long rollout, instantaneous heading rate is strongly beat-correlated
  with anterior joint speed (`corr=-0.933`), and the fitted relation is about
  `heading_rate = -0.450 phi_dot1 + slow residual`. The other three sampled
  policies show the same slope (`-0.417` to `-0.452`). Consequently the
  inherited yaw-closed selector mostly follows joint phase and reinforces both
  half-strokes. This explains the longer, straighter trajectory but also its
  weak target correction and its excursions to the `45 deg` angle and
  `260 deg/T` speed limits.
- Directly replacing that selector with low-authority bearing steering or
  instantaneous target-versus-course steering removes the useful symmetric
  phase injection and repeats the early curl. Therefore course error alone is
  not an evidenced slow directional signal in this carrier, and another
  scalar-only gain edit is not supported.

## Policy hypothesis

Test one phase-separated feedback architecture. Preserve the evidenced
traveling-bend scaffold and make its formerly implicit symmetric anterior
phase injection explicit. In parallel, subtract the robust beat-correlated
component from normalized yaw rate using observed `phi_dot1`, then use the
residual yaw and body-frame bearing to select a bounded target-directed
half-cycle asymmetry. Fade both extra channels near conservative angle and
speed envelopes so steering cannot rely on persistent hard-limit clipping.
The expected semantic improvement is sustained leftward propulsion plus a
negative-y correction after the initial small positive bearing, rather than
either the `~9T` upward curl or the `39T` horizontal overshoot.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and asymmetric-flapping control
source_mechanism: separate rhythmic amplitude support from target-driven half-cycle asymmetry
transferable_invariant: preserve the traveling wave while slow directional error modulates only the useful half-cycle; reject beat-synchronous yaw before treating it as turn response
nontransferable_details: published gains, duty ratios, oscillator clocks, species kinematics, exact wake phase, and task routes
policy_translation: infer phase from normalized joint velocity, retain the posterior lagged follower, add bounded symmetric phase support, and close bearing feedback around yaw with the sampled joint-speed-correlated component removed
falsification: reject if the fish repeats the near-9T upper exit, fails to move below the inherited y corridor, loses the coherent alternating wake, or again spends substantial time on angle, speed, or acceleration limits
