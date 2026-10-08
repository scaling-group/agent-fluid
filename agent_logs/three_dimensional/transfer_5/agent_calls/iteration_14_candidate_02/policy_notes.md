# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts report `uniform_direct`, zero background velocity,
  no cylinders, and `capture`; there is no failed termination in this sample.
  The best finite score (`solver_28bce98206ce`, `-0.535298`) and the least
  favorable sampled capture (`solver_ceb6585a8076`, `-0.535919`) are therefore
  used as the primary visual comparison rather than mislabeling either as a
  failure.
- In both combined sheets, the top-down row shows self-propelled progress from
  release to the target along the same shallow curving route. A compact
  alternating red/blue wake is established by about `4T`, lengthens without a
  visible breakup through `20T`, and remains coherent immediately before
  capture. The oblique Lambda2 row independently shows linked three-dimensional
  alternating structures behind the posterior body, not passive advection or a
  planar rendering artifact. The amplitude-relief sheet
  (`solver_3b8f345c391b`) preserves this same useful wake and route topology.
  The compressed views do not visually separate the terminal controllers, so
  the trajectory diagnostics must decide among them.
- The inherited v24 prefill (`solver_8ce1bc88a53c`) captures at `23.8315T` with
  mean distance `2.434073L`. Inside `3L`, it has mean/peak absolute yaw
  `1.684/3.208 rad/T`, mean target-transverse speed `0.2393U`, mean absolute
  world-y force `0.011795`, and mean/peak absolute yaw moment
  `0.006402/0.014062`. Its coherent carrier and continuous target-course bend
  should be preserved.
- Posterior half-cycle amplitude relief (`solver_3b8f345c391b`) preserves
  capture and the visible wake while reducing the corresponding terminal means
  to `1.606 rad/T`, `0.2335U`, `0.011351`, and `0.006137`; peak yaw falls to
  `3.063 rad/T`. It captures slightly later at `23.8755T`, so indiscriminate
  relief suppresses some useful posterior impulse.
- A reinforcing-moment-gated posterior counter-tangent
  (`solver_28bce98206ce`) retains v24 arrival and improves mean distance to
  `2.433642L`, but raises terminal transverse speed to `0.2449U`, peak yaw to
  `3.264 rad/T`, and peak moment to `0.014385`. The evidence supports its load
  gate as a selectivity signal, not its added-tangent actuator. The signed-yaw
  curvature variant (`solver_ceb6585a8076`) arrives later at `23.8535T` and has
  worse mean distance `2.434214L`, so another direction/arbitration change is
  not indicated.
- Assigned-parent guidance and inherited optimizer scores agree on this
  boundary. Repeated captured variants at steps 8--13 remain in the narrow
  `-0.5353` to `-0.5379` band; the parent explicitly rejects more cue gates,
  moment lead, lag damping, and counter-tangent strengthening, and proposes
  load-selective amplitude relief as the next mechanism test.

## Policy hypothesis

Start from the evaluated posterior half-cycle amplitude-relief policy, retain
v24's anterior carrier, continuous target-course bend, posterior lag, and
smooth command projection, and multiply only the relief demand by a soft gate
for normalized yaw moment that has the same sign as carrier-rejected yaw. This
leaves naturally braking load phases and the opposite posterior stroke intact.
It should preserve capture and v24-scale progress while keeping most of the
unconditional-relief reductions in terminal yaw, target-transverse speed, and
mean load. Falsify it if the alternating wake weakens, capture/mean distance
regresses beyond the unconditional-relief result, or terminal yaw/load and
joint/command exposure fail to improve over v24.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping combined with load-aware wake-disturbance rejection
source_mechanism: infer beat side from joint state and modulate posterior half-cycle amplitude only when measured fluid load reinforces unwanted yaw
transferable_invariant: preserve the route-producing mean bend and propulsive carrier while selectively reducing the posterior impulse that reinforces an observed disturbance
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, clock phase, exact vortex phase, and source-task routes
policy_translation: use normalized carrier-rejected yaw, normalized yaw moment, target/body-frame geometry, and observed two-joint tail side to softly gate the already sampled posterior amplitude relief
falsification: reject if capture or v24-scale progress is lost, if yaw/slip/load reductions do not survive, if the coherent alternating wake weakens, or if joint-speed and acceleration-limit exposure increases
