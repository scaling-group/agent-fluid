# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets, with the target inside the merged
  second-row wake. This is common initial-condition evidence rather than a
  controller difference.
- The prefilled raw-bearing reserve scheduler is the strongest sampled
  candidate. Its released sheet shows an early redirect followed by a
  coherent, actively propelled leftward traverse; the regular posterior wake,
  head displacement `(-10.912,-4.327)L`, and mean local flow
  `(-0.145,-0.145)` contradict passive advection as the main transport. It
  reaches the target after `46.035`, with mean distance `2.0695L` and
  total/mean command energy `56948/1237.1`.
- That speed/effort benefit carries a load cost: RMS relative crossflow,
  force, and moment are `0.2290/51.40/761.46`; both joint commands touch the
  candidate-owned `30.0` acceleration envelope and both joint speeds touch
  the episode limit. Since the observation normalizes moment by `L^2`, the
  reported moment corresponds to an RMS `moment_z_L2` of about `0.186` at
  `L=64`, which provides a scale for bounded feedback rather than a copied
  gain.
- The course-slip sibling also reaches the target, in `48.032`, with lower
  force/moment `37.92/605.38`, but higher total/mean energy `62427/1299.7`.
  Feeding course-slip into both steering and reserve scheduling is not
  additive: that combined sibling reaches in `46.761` but worsens the score to
  `-0.2271`, raises force/moment to `59.04/923.45`, and follows a visibly lower
  upstream traverse than the raw-bearing scheduler. This argues against
  reusing slip at another control interface in the present candidate.
- No failed keyframe sheet is present among the sampled examples. The
  inherited logs provide only a textual failure boundary: replacing the
  proven carrier with a slower/smaller curvature-equilibrium gait became
  unstable after `121.517`, stayed at least `9.238L` from the target, and
  produced RMS crossflow/force/moment `1.138/16749.8/290421`. The current
  carrier, steering sign, and bounded allocator therefore remain intact.

## Candidate policy hypothesis

Preserve the evaluated joint-state oscillator, posterior lag, positive
body-frame bearing residual, raw-bearing reserve schedule, joint split, and
`30.0` envelope. Add one assist-aware unloading mechanism at the steering
residual: form a bounded turn request from bearing and reduce its magnitude
only when normalized body-frame hydrodynamic moment has the same sign and is
therefore already supplying the requested yaw. Opposing moment receives the
unchanged proven command, and the relief vanishes with either target alignment
or negligible moment. The mechanism cannot reverse the steering sign or add a
route, phase, or hidden stage.

Expected test: preserve `target_reached`, coherent leftward propulsion, and an
arrival no worse than the `49.142` constant-reserve baseline while reducing
command effort or the `51.40/761.46` force/moment load of the raw-bearing
scheduler. Falsify the transfer if capture is lost, arrival exceeds that
baseline, the lower-exit or unstable topology returns, or measured effort and
loads fail to improve without a compensating distance/arrival benefit. The
new candidate is not CFD evidence until evaluated after this worker exits.

bookshelf_consulted: true
source_domain: biological Karman-gait load reduction and wake-adaptive robotic-fish control
source_mechanism: reduce active steering effort when an organized wake supplies useful body motion instead of cancelling every wake-induced motion
transferable_invariant: preserve the propulsive rhythm and unload only when a normalized body-frame hydrodynamic moment already acts in the current target-directed turn
nontransferable_details: species muscle measurements, published gains, body geometry, dimensional frequencies, exact vortex phase, single-cylinder organization, and source-task routes
policy_translation: multiply the validated bounded bearing residual by a smooth finite relief driven only by same-sign `moment_z_L2`; keep opposing-load response, carrier, scheduler, joint split, and envelope unchanged
falsification: reject if target reach or coherent upstream propulsion is lost, arrival is worse than the constant-reserve baseline, or effort and force/moment loads do not improve without another measurable route benefit
