# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four developed vortex streets merge across the target
  corridor. The three sampled copies of the yaw-load-gated policy then produce
  the same direct diagonal trajectory and exactly the same finite metrics
  (apart from wall time), so the released behavior is reproducible for this
  certified snapshot rather than a favorable one-off flow realization.
- The gated distributed half-cycle policy is the only sampled semantic
  success: it self-propels `-11.28L/-4.94L`, reaches the `0.75L` target in
  `51.47`, and has mean/minimum distance `1.82L/0.748L`. Its final keyframes
  show entry into the interacting second-row wake without the fold and lateral
  escape seen in the failure. It nevertheless reaches the joint-rate cap,
  commands about `28.8` acceleration units, and carries force/moment RMS
  `426/4085`; the successful route therefore does not establish efficient or
  low-load posterior actuation.
- The posterior mean-curvature parent remains an informative failure. It
  swims upstream `-10.51L`, but its broad arc misses at `2.43L`, reverses into
  a near-vertical posture, and exits laterally at `84.22`. Its lower aggregate
  force/moment RMS (`116/1278`) confirms that low load alone is not sufficient;
  the anterior target-responsive half-cycle mechanism must be preserved.
- The incumbent directly adds the gated steering residual to both joint
  accelerations even though the posterior target already follows the steered
  anterior state with velocity lag. The sampled records do not isolate whether
  that second direct injection helps capture or redundantly distorts the thrust
  wave. They also lack sign-resolved event evidence needed to justify a new
  signed crossflow or moment residual.

## Candidate hypothesis

Retain the reproduced body-frame bearing/heading-response request, smooth
yaw-magnitude gate, anterior half-cycle asymmetry, zero-centered oscillator,
and candidate-owned soft limit. Test one new controller mechanism: actuator-
role separation. Remove the direct posterior half-cycle steering residual and
let joint 2 only track the already-steered anterior joint with velocity lag and
damping. Steering still propagates through `q1`, while posterior acceleration
is reserved for the traveling bend that produces upstream thrust.

The next CFD rollout falsifies this translation if target capture is lost,
arrival or mean distance regresses materially from `51.47`/`1.82L`, the broad
lateral-exit topology returns, or force/moment and cap histories fail to
improve despite removing the redundant posterior residual. Identical-snapshot
reproducibility must not be claimed as changed-wake-phase robustness.

bookshelf_consulted: true
source_domain: elongated-body propulsion theory and sensor-modulated robotic-fish direction control
source_mechanism: separate anterior rhythm steering from posteriorly lagged thrust production
transferable_invariant: preserve a target-modulated anterior wave while the posterior joint follows with lag and damping instead of receiving an additional direct steering bias
nontransferable_details: published gains, dimensional frequencies, full-body amplitude envelopes, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: keep normalized body-frame bearing, heading response, and yaw-load gating on anterior half-cycle acceleration; make posterior acceleration only the damped lag tracker of the steered anterior state
falsification: reject if capture, upstream propulsion, arrival, or distance history regresses, or if load and saturation evidence does not improve relative to the reproduced two-joint-residual incumbent
