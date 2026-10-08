# Phase 2 candidate diagnosis and hypothesis

## Evidence diagnosis before editing

- The assigned prefill (`solver_aa78a1c20ec5`) and all four sampled solvers
  satisfy the direct-uniform still-water contract (`U_infinity=[0,0,0]`), have
  no cylinders or prewarm, remain stable, and terminate by capture. The
  prefill captures at `17.9740T` with score/mean distance
  `-0.073952/1.960279L`, center path `13.0672L`, and maximum head cross-track
  `0.6630L`.
- I inspected both rows of the combined keyframe sheets for the sampled score
  leader (`solver_378cb42ebf34`), its unguarded work-reserve comparator
  (`solver_dc881bcb1d49`), and the inherited response-qualified negative
  result (`solver_6945c9ce4a73`). From release, each fish self-propels rather
  than being advected, establishes a coherent alternating mid-plane wake by
  `4T`, and retains compact paired oblique Lambda2 structures through capture.
  There is no wake breakup, collision, or visible numerical instability. No
  sampled semantic-failure keyframe is available, so the inherited response
  regression is the most informative visual negative comparator; its wake is
  also coherent and therefore does not explain its worse score by itself.
- The score leader's one-sided tracking-error guard preserves the work
  reserve's first-`3T` distance/speed (`12.214593L/0.2519U`) and improves the
  unguarded reserve's score/mean distance from
  `-0.072146/1.958037L` to `-0.064599/1.950823L`. Peak planar force and yaw
  moment remain in the same class (`0.0391/0.0195`), and both wake views remain
  coherent. The gain is real, but its predicted route repair is falsified:
  capture slips from `17.8695T` to `18.0125T`, path/cross-track rise from
  `13.0071L/0.6102L` to `13.2330L/0.7417L`, and near-target course alignment
  falls from `0.787` to `0.664`.
- The inherited parent logs already reject a scalar response-magnitude
  release (`-0.082282`, mean distance `1.968655L`) and a body-translation
  replacement for head-range closure (`left_domain`, score `-11.5034` after
  only `0.9166L` closest approach). Those observations must not be retried as
  generic progress certificates. The remaining local defect is that the
  successful phase-consistency guard evaluates the sum of oscillatory wave
  target and mean steering curvature; extra propulsion can therefore be
  admitted because it follows a steering offset even while moving away from
  the posterior traveling-wave target.
- An offline replay of the sampled score leader with its logged joint and
  body-frame trajectory preserves all evaluated dynamics and changes only the
  guard equation. Using the oscillatory posterior target alone changes guard
  weight materially on about `7.1%` of samples, concentrated at mean absolute
  turn request about `0.97`, while retaining about `92.8%` of total and
  first-`3T` reserve-work magnitude. This is a policy-signal diagnostic, not a
  new CFD result.

## One policy hypothesis

Start from `solver_378cb42ebf34` and preserve its carrier, posterior lag and
amplitude, closure qualifier, bounded velocity-aligned work pump, steering
architecture, approach controller, and reversal-preserving output governor.
Change only the phase-consistency reference: compute posterior tracking work
against `tail_wave_target` rather than `mean_tail_tangent + tail_wave_target`.
This separates propulsive phase reinforcement from mean-curvature steering.
It uses normalized posterior angle/rate state and the existing body-frame
feedback, with no clock, world coordinate, route, target identity, or new gain.

Expected evidence is retention of the score leader's early closure and mean
distance advantage with less course imprint: shorter path, lower cross-track,
and better near-target alignment without higher actuator residence or loads.
Reject the mechanism if capture is lost, mean distance regresses toward the
`1.958037L` unguarded reserve, path/cross-track do not improve from
`13.2330L/0.7417L`, acceleration/load class worsens, reflection symmetry
fails, or either top-down or oblique wake loses coherence. This candidate has
not received CFD evaluation, so these are predictions rather than results.

bookshelf_consulted: true
source_domain: Lighthill posterior reactive propulsion combined with mean-curvature and sensor-modulated robotic-fish steering
source_mechanism: keep posterior traveling-wave reinforcement distinct from the slower mean bend used to turn
transferable_invariant: propulsive work should be phase-consistent with the oscillatory posterior target rather than admitted by a static steering offset
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body phase patterns, exact vortex phases, and task-specific routes
policy_translation: use normalized posterior target error times posterior joint rate, but form the error from the lagged tail-wave target without mean steering curvature
falsification: reject if early closure or mean-distance benefit is lost, route and approach metrics fail to improve, actuator or load class worsens, or either wake view deteriorates
