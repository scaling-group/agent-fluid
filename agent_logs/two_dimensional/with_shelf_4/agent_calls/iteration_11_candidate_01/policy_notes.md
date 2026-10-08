# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled solver examples terminate at `target_reached` after
  `137.357` released time units with the same released keyframe sheet and the
  same physical metrics: `4.184L` mean distance, `-10.914L/-4.371L` head
  displacement, `90228` total command energy, and
  `0.12955/14.75/303.02` RMS relative crossflow/force/moment. Their policy
  implementations are semantically identical; the two file hashes differ only
  in comments. These are replications of one trajectory, not four independent
  controller comparisons.
- The common prewarm sheet shows fully developed, interacting vortex streets
  from both staggered cylinder rows before release. In the released sheet the
  fish is visibly self-propelled: it redirects from the upper-right toward the
  target, retains an alternating traveling bend, crosses the mixed downstream
  wake without collision or domain exit, and reaches the target from the
  right. The recorded path has broad alternating lateral excursions between
  the initial redirect and final approach rather than passive streamwise
  advection alone.
- Diagnostics agree with that visual reading: the fish makes substantial
  upstream progress, while mean local flow is only `(-0.0542,-0.0521)` and
  mean body velocity is `(-0.0791,-0.0330)`. The first-joint acceleration
  reaches `30.846 rad/time^2`, close to the `31.416 rad/time^2` hard limit, so
  additional unconditioned steering authority is unattractive.
- No sampled solver provides a distinct failure keyframe sheet. The assigned
  parent and inherited score logs supply the comparison boundary: direct
  relative-crossflow and lateral-target additions delay otherwise successful
  capture to `154.110` and `159.302`; large-bearing posterior-lag relief delays
  it to `158.147`; another completed sibling takes `279.439`, with `6.982L`
  mean distance and `182836` energy. These results argue for preserving the
  route/propulsion scaffold and changing only how a disturbance term earns
  authority.

## Candidate hypothesis

Keep body-frame bearing as the slow route owner, the progress-qualified
bearing-rate term, half-cycle steering, and the posterior traveling bend.
Replace the continuously active yaw-moment residual with a response-conditioned
residual. The sign of `bearing_error * bearing_window_rate` is the derivative
signature of squared bearing magnitude: positive means target alignment is
worsening, while nonpositive means it is steady or improving. Softly gate the
normalized moment residual by only the positive part of this signature. This
should avoid spending anterior half-cycle authority against wake-induced yaw
that is already helping the route, while retaining load rejection when target
geometry shows an adverse response.

bookshelf_consulted: true
source_domain: wake interaction and adaptive fish swimming
source_mechanism: preserve useful passive wake motion and reject only disturbances that degrade controlled progress
transferable_invariant: separate persistent body-frame target geometry from fast load disturbances, and condition rejection on measured adverse route response
nontransferable_details: single-cylinder Karman-gait phase, trout muscle response, species kinematics, published gains, and exact vortex timing
policy_translation: gate the bounded normalized yaw-moment residual by positive growth of absolute body-frame bearing; retain the existing joint-state half-cycle oscillator and lagged posterior target
falsification: reject the transfer if target capture or the alternating upstream trajectory is lost, or if arrival, mean distance, command effort, and force/moment loads do not improve together relative to the replicated 137.357-unit scaffold

The new CFD result is not available in this workspace and is not claimed as
evidence here.
