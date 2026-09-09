# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled summaries report `capture`, direct uniform initialization,
  `U_infinity=(0,0,0)`, no prewarm snapshot, and finite horizons of
  `18.6560--18.7330T`. Three samples share the actuator-consistent policy hash;
  the fourth is helpful-moment residual-amplitude relief.
- Both rows of every combined keyframe sheet were inspected. The top-down row
  shows body-led translation and a coherent alternating reverse-vortex street
  from release through capture. The oblique row shows compact alternating
  Lambda2 structures attached to the traveling body wave, with no visible
  wake collapse or instability before the head crosses the capture circle.
  Because the initialized and local flow are near zero, this is self-propelled
  motion rather than passive advection.
- The three exact actuator-consistent replicas span `18.6725--18.7330T`,
  `75.2--76.1%` posterior acceleration-limit occupancy, local-flow RMS
  `0.01804--0.01816U`, and force/moment RMS
  `0.01331--0.01350 / 0.00693--0.00703`. Helpful-moment relief reaches
  `18.6560T`, `75.8%`, and `0.01328 / 0.00691`, all inside or below the
  same-policy spread by too little to resolve. The assigned-parent guidance
  also records an exact helpful-moment repeat near `18.9915T` and an exact
  baseline recovery near `18.9970T`; inherited score-only logs include
  captures with substantially worse cost. Instantaneous physical-response
  allocation therefore has no robust advantage to extend.
- All sampled paths touch the `260 deg/T` joint-velocity envelope, while the
  posterior acceleration command is clipped for about three quarters of the
  rollout. The carrier and route are already successful, so the next test
  should change how route authority is expressed, not raise a gain or add
  another instantaneous moment allocator.

## Policy hypothesis

Preserve the proven normalized bearing-plus-LOS C-bend, recoil-conditioned yaw
error, persistent same-side phase recruitment, traveling posterior wave, and
explicit feasible-action projection. Add one bounded, response-directed duty
ratio to the anterior state-feedback oscillator: while geometry recruits a
redirect, reduce restoring stiffness on the joint-state half-cycle whose bend
agrees with the desired response and increase it on the opposite half-cycle.
This changes dwell rather than the amplitude setpoint, creating a new steering
channel without a clock or scalar-only retuning. The small symmetric bound
keeps the carrier restoring force positive and preserves reflection
equivariance.

Expected result: retain a coherent self-generated wake and capture in the
sampled `18.656--18.733T` band while making posterior clipping or load clearly
smaller than baseline replication spread. Reject the mechanism if capture is
lost, arrival exceeds `18.733T`, the wake weakens, acceleration/velocity
saturation grows, or force/moment RMS is not separated below
`0.01331 / 0.00693`.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: sensor feedback changes the relative duration of the two beat sides while retaining rhythmic propulsion
transferable_invariant: route-response feedback can redistribute half-cycle dwell without prescribing time, route, amplitude, or vortex phase
nontransferable_details: published CPG gains, hardware dynamics, species kinematics, dimensional frequency, exact duty ratios, and task routes
policy_translation: use normalized body-frame LOS/yaw response and observed anterior joint phase to apply a small reflection-equivariant stiffness asymmetry only during recruited redirects
falsification: reject if capture or wake coherence is lost, arrival leaves the sampled band, or clipping and load do not separate from exact-policy replication spread
