# Posterior-priority drive with line-of-sight drift guidance

## Visual and quantitative diagnosis before the policy edit

- All sampled and inherited comparison rollouts use direct uniform still water
  with `U_infinity=(0,0,0)`, no prewarm snapshot, and no cylinders. The two
  `002a5b...` samples are exact repeats of the rate-governed baseline: capture
  at `23.3640T`, mean score-distance `2.409486L`, and score `-0.51274776`.
- I inspected both the top-down mid-plane row and oblique Lambda2 row of the
  combined sheets for the strongest sampled policy, the assigned parent, and
  the inherited shared-load-gate failure. All three are self-propelled from
  quiescent water and retain a coherent alternating, posteriorly lagged wake;
  none shows passive advection, a prewarm artifact, collision, wake breakup,
  or out-of-plane instability. The shared gate visibly delays the closing
  bend and captures at `24.8380T`, consistent with its worse `2.521632L` mean
  distance and `-0.62156406` score. The useful difference is therefore route
  and closure performance rather than wake existence.
- The sampled posterior-priority phase-plane envelope is a strong positive
  result relative to that common baseline: capture advances to `17.8585T`,
  mean distance falls to `1.980025L`, center path falls from `13.3177L` to
  `12.8148L`, and maximum head cross-track falls from `2.0139L` to `0.5347L`.
  The top-down row shows the resulting much straighter target approach, while
  the oblique row retains compact three-dimensional posterior wake structures.
  This rejects the inherited assumption that any state-dependent carrier
  regulation must slow closure: the failed gate reduced shared cadence, while
  the successful envelope preserved cadence and posterior excursion.
- The assigned line-of-sight-drift parent is a smaller independent positive
  result against the same baseline. It captures at `23.1715T`, lowers mean
  distance to `2.390366L`, center path to `13.3035L`, and maximum cross-track
  to `1.9626L`. Its RMS yaw and force rise slightly (`1.5815 rad/T` and
  `0.01258`, versus `1.5537 rad/T` and `0.01234`), so it is useful only as a
  bounded route residual, not a reason to increase steering authority.
- The posterior-priority result also raises speed, yaw/load RMS, and posterior
  acceleration-ceiling residence: mean speed is `0.7178U`, RMS yaw is
  `2.0285 rad/T`, RMS force coefficient is `0.01557`, and joint-2 acceleration
  resides at `99.9%` of the envelope for `65.17%` of samples. Those costs did
  not prevent the demonstrated direct capture, and inherited cadence/shared
  damping tests worsened score. They are therefore interaction falsification
  boundaries for the combined candidate, not justification for scalar-only
  attenuation.

## One policy hypothesis

Use one small compatible combination with independent evidence: transplant the
posterior-priority phase-plane drive into the assigned line-of-sight-drift
parent while leaving its normalized body-frame guidance, bounded odd steering,
terminal release, and direction-selective rate governor unchanged. The drive
layer regulates anterior oscillator energy from observed joint angle/rate and
preserves a lagged, amplified posterior wave for thrust. The route layer uses
only the co-windowed difference between body turn rate and target-bearing rate,
so it should be nearly inactive when the faster posterior drive already holds
a straight line and provide a bounded correction when line-of-sight drift
accumulates.

Expected signature: retain capture, the `17.9T` arrival scale, sub-`1L`
cross-track behavior, and the coherent two-view posterior wake, with no
material increase over the sampled posterior policy's yaw, force/moment, or
joint-limit statistics. The combination is falsified if the line-of-sight
residual over-corrects the already straight posterior-priority route, increases
cross-track/path/mean distance or arrival, loses capture, worsens load or
saturation materially, or changes the traveling wake into standing,
disorganized, or weak posterior motion. The new CFD result is not available in
this worker and is not claimed here.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and sensor-modulated robotic-fish CPG direction control
source_mechanism: preserve a lagged posterior-emphasized traveling bend for thrust while keeping target-route correction in a separate bounded feedback layer
transferable_invariant: regulate rhythmic energy from normalized joint phase-plane state, retain posterior lag and excursion, and apply only target-relative route feedback without disturbing the propulsive carrier
nontransferable_details: published gains, dimensional cadence, species-specific envelopes and kinematics, exact vortex phases, task routes, and the evidence-specific line-of-sight scale
policy_translation: combine the sampled anterior phase-plane envelope and whole posterior-wave gain with the assigned parent's normalized body-frame line-of-sight residual, then pass both through the existing two-joint steering and reversal-preserving rate governor
falsification: reject if capture, directness, distance integral, arrival, loads, actuator residence, reflection symmetry, or top-down and oblique traveling-wake coherence worsen relative to the sampled posterior-priority controller
