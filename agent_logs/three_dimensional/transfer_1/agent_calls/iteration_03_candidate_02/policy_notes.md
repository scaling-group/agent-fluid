# Completion-gated redirect candidate

## Evidence and visual diagnosis

- Every sampled rollout reports direct uniform quiescent initialization,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The displacement and
  wakes in both visual rows are therefore self-propelled rather than imposed
  advection.
- The transferred seed and assigned response-gated parent both form a coherent
  alternating mid-plane street and discrete three-dimensional Lambda2 wake.
  The seed closes from `12.3277 L` to `4.7800 L` before continuing downward.
  The parent preserves propulsion and improves to `2.4625 L` at `24.228 T`,
  but the top-down sheet shows it passing above and left of the target before
  exiting the left boundary. At closest approach its speed is `0.941 L/T`,
  while local-flow, force, and moment magnitudes remain small; this is a
  target-relative steering miss, not passive transport, wake collapse, or
  numerical instability.
- The completion-gated redirect sample differs from that parent only in the
  release semantics. It keeps the bounded redirect active until body-frame
  angular error contracts, rather than letting a correct-sign tail-beat yaw
  excursion stand in for completed redirection. Both visual rows retain the
  posterior wake, and the top-down row shows a smoother terminal arc into the
  capture circle. It captures at `26.411 T` and `0.7496 L`, with mean/max body
  speed `0.501/0.667 L/T` and peak raw joint accelerations about `74.2/85.6
  rad/T^2`, versus the parent's `0.733/1.265 L/T` and `109.4/175.1 rad/T^2`.
- The sampled terminal carrier-relief alternative improves minimum range to
  `1.2329 L`, but remains outside capture and later reaches `1.432 L/T` before
  a lower-boundary exit. Inherited logs likewise report that velocity lead,
  shared whole-wave curvature, and global drive relief regress early closing
  or useful wake formation. None is combined with the successful gate here.

## Policy hypothesis

Use the evaluated completion-gated redirect unchanged as the one candidate.
Preserve the posterior-lag state-feedback carrier, curvature magnitude, route
feedback, and half-cycle steering from the assigned parent. Multiply yaw-based
redirect release by geometric completion, defined continuously as the
complement of the normalized large-error gate. A large body-frame target angle
therefore sustains the target-signed C-bend; correct-sign yaw earns release only
as that angle contracts. This is one feedback-semantic mechanism, with no
clock, world coordinate, memorized route, or scalar-only tuning.

The formal rollout should reproduce the sampled capture topology while
retaining the coherent wake. Falsify this selection if it fails to capture,
loses early closing or wake coherence, reverses the target-signed arc, or
materially exceeds the sampled completion-gated speed/action envelope.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG steering
source_mechanism: large observed direction error sustains bounded curvature, followed by feedback-based release into the propulsive rhythm
transferable_invariant: release of a burst turn should require contraction of macroscopic target-relative error rather than an instantaneous correct-sign yaw excursion within an oscillatory gait
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat timing, robot geometry, exact vortex phases, and prescribed routes
policy_translation: use normalized body-frame target angle to withhold observed-yaw release while the redirect error gate is large, then continuously restore release authority as geometric error contracts in the two-joint posterior-lag controller
falsification: reject if capture is lost, early propulsion or wake coherence degrades, the turn sign reverses, or speed and raw action materially exceed the sampled completion-gated envelope
