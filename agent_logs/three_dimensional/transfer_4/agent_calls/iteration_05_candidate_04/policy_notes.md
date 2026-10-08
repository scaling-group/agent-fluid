# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled evaluations satisfy the Phase-2 contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
prewarm, and complete combined top-down vorticity and oblique Lambda2 sheets.
No sampled rollout is a semantic failure, so the lower-scoring captured
`solver_ee4561476853` is the finite contrast for the strongest captured
`solver_3e8ee72bb918`; the inherited iteration-1 lower-boundary exit supplies
the informative route failure.

- In both visual rows the two current policies visibly self-propel, shed a
  compact alternating three-dimensional caudal wake, and follow essentially
  the same continuously closing late turn through capture. Neither wake
  collapse, passive advection, terminal overshoot, nor out-of-plane motion is
  visible. The inherited failed seed retained propulsion but passed below the
  target and exited, so the successful same-sign odd mean-curvature map and
  body-frame guidance must remain unchanged.
- The lower-scoring clamped controller captures at `23.3585T`, score
  `-0.51527750`, mean score-distance `2.412601L`, and path length `13.4189L`.
  Its joint rates reach `260/260 deg/T`, with at least `99.9%` rate-limit
  residence in `9.09%/1.62%` of samples.
- The sampled directional rate governor is the strongest result: it captures
  at `23.3640T`, score `-0.51274776`, mean score-distance `2.409486L`, and path
  length `13.3177L`. It removes all sampled `99.9%` rate-limit residence,
  lowers peak speed from `0.7515` to `0.7428 L/T`, and slightly lowers joint
  angle and yaw-rate excursions while preserving the visual wake and load
  scale. This supports retaining its state-conditioned rule that withdraws
  only speed-increasing effort near the rate boundary.
- Acceleration remains at least `99.9%` of the fixed envelope for
  `69.61%/50.68%` of samples. An inherited sibling result shows that gating
  only the extra carrier cadence from maximum joint-rate utilization is not a
  sufficient desaturation mechanism: it still leaves about `70%` anterior
  acceleration-ceiling residence, increases anterior `96%` rate residence
  from `15.68%` to `17.07%`, delays capture by `0.3795T`, and worsens mean
  score-distance from `2.409486L` to `2.421103L`. The next test should therefore
  shape the acceleration response itself without globally slowing cadence.

## Policy hypothesis

Preserve the sampled winner's normalized body-frame guidance, odd bounded
posterior mean curvature, course-aligned terminal cadence, half-cycle
steering, state-feedback traveling wave, and directional rate governor. Add
one compatible actuator-response mechanism: pass only commands that would
increase the currently observed signed joint speed through an odd smooth
acceleration envelope before applying the existing rate-proximity withdrawal.
Commands that brake or reverse the observed joint velocity retain the full
hard-bounded episode authority.

This should reduce speed-increasing acceleration-ceiling residence and soften
energy injection without erasing posterior lag, steering recovery, or the
captured route. Falsify it if capture is lost, arrival or distance integral
worsens materially, acceleration/rate residence does not fall, loads rise, or
either visual row loses the compact alternating wake. The candidate has not
yet been evaluated and is not evidence of improvement.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and actuator-aware undulatory control
source_mechanism: preserve a traveling propulsive rhythm while observed joint state smoothly gates energy-increasing effort at an actuator boundary
transferable_invariant: continuously bound speed-increasing oscillator effort from normalized joint state while retaining braking and reversal authority
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, full-body waveforms, exact vortex phase, and task routes
policy_translation: apply an odd smooth envelope to two-joint acceleration only when command and observed joint rate have matching sign, then retain the sampled normalized rate governor
falsification: reject if capture, integrated distance, load scale, or wake coherence degrades, or if acceleration and rate boundary residence do not decrease
