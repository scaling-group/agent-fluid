# Wake-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. It is a common initial
  condition and does not distinguish candidates.
- All four sampled solver results reach the target; no sampled termination is
  a failure. The most informative contrast is therefore the best finite
  shared-history guard against the three identical slower per-joint guards.
  The shared guard reaches in `118.024` with `3.560L` mean distance and
  `89079` total command energy, versus `123.018`, `3.594L`, and `95084` for
  each per-joint result. It also lowers RMS relative crossflow/force/moment
  from `0.14287/17.03/334.45` to `0.13833/16.74/329.67`, and slightly lowers
  peak joint bends and velocities.
- Released keyframes show both policies self-propelling upstream rather than
  merely drifting with the wake. Both retain an alternating traveling bend,
  execute a broad targetward arc, enter the developed multi-wake region, and
  cross the capture circle. The shared guard's middle approach is visibly
  straighter; the per-joint guard makes a deeper cross-stream redirect before
  recovering. The metrics agree: the shared guard ends with `-4.196L` head
  cross-stream displacement versus `-3.872L` for the slower guard while
  preserving comparable upstream displacement (`-10.915L` versus
  `-11.041L`).
- Assigned-parent logs provide two additional successful references: the
  per-joint guarded result above and a `130.053`-unit result with `3.758L`
  mean distance and `99377` energy. Inherited guidance also records that
  unconditioned route/flow residuals and separate posterior authority produce
  longer detours. The useful remaining uncertainty is therefore how action
  history coordinates the two-joint wave, not another additive steering term.

## Candidate hypothesis

Preserve the successful target-bearing, direct yaw-moment residual,
half-cycle steering, oscillator, and posterior-lagged wave unchanged. Retain
one common actuator-history response weight, because the sampled common guard
outperforms three per-joint materializations. Change only the passivity
observer used by that common weight: rectify each joint's normalized
lag-added power before summing it. The inherited summed-signed observer can
miss positive injection at one joint when the other joint is simultaneously
dissipative. The proposed aggregation makes both histories yield together in
that case, so it protects joint-level braking without introducing unequal
weights that can shear the traveling-wave phase.

Expected result: preserve the `118.024`-unit target-reaching topology and
alternating propulsion while reducing acceleration-cap contact, load, or
distance through the middle approach. Falsify the mechanism if capture is
lost, arrival or mean distance regresses toward the direct-action scaffold,
the broad arc becomes deeper, or command effort and force/moment rise without
a compensating route improvement.

bookshelf_consulted: true
source_domain: coupled robotic-fish CPG control and reactive traveling-wave swimming
source_mechanism: coordinated inter-joint phase relationships sustain a propulsive posterior-lagged bend, while feedback should modulate the coupled gait rather than independently distort its joints
transferable_invariant: reject unwanted actuator-history energy at the joint where it appears while applying one coherent modulation to the complete two-joint traveling wave
nontransferable_details: published oscillator gains, dimensional beat frequencies, species-specific body envelopes, full-body joint counts, exact vortex phase, and task-specific routes
policy_translation: use normalized signed lag-added power from each observed joint state, sum only its positive parts, and use that scalar to blend both previous actions toward the raw two-joint state-feedback command with one shared weight
falsification: reject if target capture, upstream translation, or alternating posterior-lagged propulsion is lost, or if arrival, mean distance, cap contact, effort, and force/moment do not improve coherently against the shared summed-signed guard
