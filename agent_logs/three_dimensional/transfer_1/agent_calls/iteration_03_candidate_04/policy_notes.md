# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite termination.
  Motion in both visual rows is therefore self-propulsion rather than ambient
  advection.
- The transferred seed produces a coherent alternating wake in the top-down
  vorticity row and organized three-dimensional Lambda2 structures in the
  oblique row, but it closes only to `4.7800 L` at `17.853 T`, continues below
  the target, and exits the lower boundary.  The response-gated redirect keeps
  the wake coherent and improves closest approach to `2.4625 L`, but passes
  above and left of the target before exiting the left boundary.
- Geometric completion gating is the sampled semantic improvement.  Its
  top-down sheet shows a slower, sustained target-signed arc rather than the
  response-gated upper miss, and its oblique sheet retains a compact,
  alternating posterior wake through capture.  It reaches `0.7496 L` at
  `26.411 T` with score `-0.7105`; maximum speed is `0.667 L/T`, maximum force
  magnitude is `0.0297`, and maximum yaw-moment magnitude is `0.0148`.  This
  is a controlled capture rather than a wake collapse or numerical event.
- Completion gating also improves the actuation history relative to the
  response-gated near-miss: rows with either raw acceleration above the
  `1800 deg/T^2` envelope fall from `95.7%` to `82.5%`, and rows with a joint
  at the `260 deg/T` speed bound fall from `22.2%` to `11.7%`.  The remaining
  rates are still persistent: `52.2%` of successful-rollout joint samples
  exceed the acceleration envelope, and the largest raw command is
  `85.64 rad/T^2` versus the `31.42 rad/T^2` limit.
- The sampled terminal carrier-relief policy is an informative negative
  comparison.  It improves closest approach to `1.2329 L` but misses capture,
  later accelerates to `1.472 L/T`, reaches larger force and moment magnitudes
  (`0.2127` and `0.0963`), and exits the domain.  Broad range/angle-based
  carrier relief is therefore not a safe successor to the captured trajectory.
- Inherited notes predicted that response release should require contraction
  of macroscopic geometric error rather than beat-scale correct-sign yaw.  The
  sampled capture validates that prediction for this initial pose.  The new
  CFD result will be produced only after this worker exits and is not claimed
  here.

## Policy hypothesis

Use the sampled completion-gated redirect unchanged as the route and carrier
parent.  Add one actuator-envelope feedback mechanism at the final command
boundary.  First clip each raw joint acceleration to the known acceleration
envelope.  Then, only when an observed joint speed enters a narrow guard band
near its speed limit, smoothly remove the component of acceleration that has
the same sign as that speed.  Acceleration that brakes or reverses the joint is
left available, as are all target-geometry and yaw-response terms.

This is a state-dependent feasibility projection, not a carrier gain change:
it targets effort that the downstream actuator would discard at the speed or
acceleration bounds.  Expected result: retain the successful target-signed arc
and capture while reducing the `82.5%` raw acceleration-over-limit and `11.7%`
speed-bound row rates.  Falsify it if capture is lost, arrival or early closing
materially worsens, the coherent alternating wake deteriorates, or the two
saturation rates do not fall.  Do not respond to failure by adding broader
terminal carrier relief; the sampled `1.2329 L` miss already rejects that
combination in this evidence regime.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded two-joint rhythmic locomotion
source_mechanism: observed actuator state modulates a rhythmic command while preserving the posterior-lag carrier and target-directed steering structure
transferable_invariant: feedback should withhold effort that pushes a joint farther into its motion envelope while preserving braking, reversal, and the geometric completion condition for a burst turn
nontransferable_details: published CPG gains, dimensional frequencies, robot geometry, species-specific joint envelopes, exact vortex phases, and prescribed routes
policy_translation: normalize each observed joint speed by policy-owned limits, smoothly attenuate only same-sign outward acceleration near the limit, and clamp the final two-joint command to a policy-owned acceleration envelope
falsification: reject if capture or early closing is lost, wake coherence degrades, or acceleration and speed saturation do not improve relative to the `82.5%` and `11.7%` successful-rollout baselines
