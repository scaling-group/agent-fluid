# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets; this is the common initial condition,
  not candidate-specific evidence. The released sheets for both distinct
  sampled mechanisms show immediate targetward redirection, a persistent
  body-generated traveling wake, and one compact diagonal crossing into the
  `0.75L` capture circle. Neither looks passively advected or approaches a
  cylinder, and no failed sampled sheet is present.
- The assigned parent adds a state-inferred, bearing-gated gain of at most `8%`
  only to the target-helping posterior half-cycle. Three sampled realizations
  reproduce exactly: capture at `32.472` release time, `1.64761L` mean distance,
  `1425.46` mean command energy, and `109.19` mean power proxy. Against the
  distinct scheduled-allocation controller, it preserves the direct topology
  while improving arrival from `35.0625` and mean distance from `1.73388L`.
  The duplicates establish deterministic repeatability at this common wake
  snapshot, not three independent confirmations across wake conditions.
- The navigation gain carries an unresolved actuation/load cost. Both the
  parent and the slower comparison touch the `260 deg/time` velocity and
  `1800 deg/time^2` acceleration limits on both joints, while the faster
  half-cycle policy raises lateral-force RMS from `56.57` to `68.70` and moment
  RMS from `793.76` to `931.60`. Lower total energy is chiefly the shorter
  episode because mean effort is almost unchanged. Maxima alone do not reveal
  saturation residence, but they support testing whether the incremental
  posterior boost can yield when joint state already has little headroom.
- The informative inherited failure remains the additive bearing-trend child:
  it did not sustain a traveling bend, moved downstream, made negative
  progress, and exited at `16.956` with only `0.140/0.163 rad` joint excursions
  and `12.424L` closest approach. The candidate therefore leaves target-rate,
  force, moment, crossflow, and oscillator-center paths unchanged.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation interpreted through elongated-body posterior reactive propulsion
source_mechanism: regulate a turn-congruent posterior half-cycle with observed joint-state headroom while retaining the underlying lagged propulsive wave
transferable_invariant: sensor feedback may release only the incremental rhythmic asymmetry when posterior motion already reinforces it at a large fraction of the gait's own speed or acceleration scale; the symmetric traveling wave and target-signed mean curvature must remain available
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator allocations, and source-task routes
policy_translation: normalize posterior speed and prior applied acceleration by the owned oscillator scales, infer whether each is aligned with the proposed posterior-wave increment, and smoothly gate only the extra bearing-conditioned half-cycle gain while leaving the evaluated base target untouched
falsification: reject the headroom gate if capture is lost or later than `32.472`, mean distance exceeds `1.64761L`, the direct diagonal topology changes adversely, or load and saturation residence fail to improve enough to justify any navigation loss

## Candidate hypothesis

Keep the completed filtered-bearing, bounded-curvature, `40/60 -> 35/65`
allocation, anterior oscillator, posterior lag, damping, and `8%` maximum
target-helping half-cycle mechanism. Add one structural feedback mechanism:
smoothly withdraw only that incremental posterior amplification when observed
posterior speed or the previous applied posterior acceleration is already large
relative to the policy's own `amplitude * frequency` or `amplitude *
frequency^2` scales and points with the proposed increment.

This state-based headroom gate has no external clock, configured actuator cap,
fixed route, or wake-phase input. When state does not press in the increment's
direction, the evaluated parent is recovered; under pressure the controller
falls continuously toward the still-successful symmetric posterior wave rather
than suppressing propulsion. The downstream test should preserve direct
capture near the parent's arrival while reducing posterior envelope residence
and the force/moment penalty. This translation is unevaluated here, so no new
CFD improvement is claimed by this worker.
