# Wake-policy candidate notes

## Evidence diagnosis before editing

- The shared prewarm sheet shows the fish held at the common upper-right release
  while four developed cylinder streets merge around the target. It is common
  initial-condition evidence, not a candidate difference.
- All four sampled solver examples reach the target, so there is no sampled
  failure sheet to compare visually. Their released sheets show the same useful
  control topology: an immediate zero-centered traveling wake, active diagonal
  upstream/downward swimming, a broad late correction within the merged wake,
  and first crossing of the capture circle. Diagnostics confirm self-propulsion
  rather than passive advection: the strongest example has mean x velocity
  `-0.241` while its mean local flow is only `-0.174`.
- Three sampled policies are functionally identical to the prefill and repeat
  `target_reached` at `45.61`, `1.722L` mean distance, score `0.158830`, and
  `453/4406` force/moment RMS. The simpler body-speed-normalized positive-closure
  policy reaches slightly earlier at `45.48` with `1.724L` mean distance and
  substantially lower `405/4029` RMS load. Both touch the joint-rate caps. The
  prefill's course-trend multiplier therefore has a small mean-distance benefit
  but no arrival benefit and a measurable load cost.
- The most informative failure boundary is inherited log evidence, because its
  keyframe is unavailable here: broad propulsive-priority reallocation passed
  below capture and collided at `58.93`, with `1.872L` closest approach and
  `537/4995` force/moment RMS. I use it only to reject changes to the base wave
  or broad propulsion allocation. A separate sampled inherited result shows
  that aligned closure-gated posterior phase-lag shifting still reached the
  target but regressed the normalized-closure baseline to `46.22`, `1.735L`,
  and score `0.146573`, so another timing edit is also poorly supported.

## Policy hypothesis

Preserve the successful oscillator, lagged posterior target, predicted-bearing
half-cycle steering, normalized positive-closure residual, and existing
yaw-moment steering gate. Apply that already normalized yaw-load gate to only
the deviation of the course-consistency multiplier from one. Under low yaw
load the prefilled course residual is retained; when the wake/body interaction
is already producing a strong yaw moment, the course residual continuously
falls back toward the simpler positive-closure controller rather than adding
another turn-correlated posterior reallocation. This is a new feedback
separation mechanism, not a scalar gain sweep.

The next CFD rollout falsifies the candidate if it loses `target_reached`,
meaningfully worsens the `1.722L` mean-distance topology, recreates a lower
collision/exit, or fails to reduce the prefill's `453/4406` load without an
arrival or distance benefit. Even a positive fixed-snapshot result would not
establish robustness to changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish rhythmic control
source_mechanism: separate slow target-route modulation from fast wake/body yaw response while preserving the low-dimensional propulsive rhythm
transferable_invariant: when measured yaw load already indicates strong turning, reduce only an auxiliary route residual rather than cancelling the wake response or weakening the base traveling wave
nontransferable_details: published gains, dimensional moment scales, species-specific kinematics, exact vortex phases, cylinder layouts, and task-specific routes
policy_translation: use the existing absolute body-normalized yaw moment gate to attenuate only the bounded bearing-trend deviation applied to the small positive-closure posterior residual, leaving the two-joint base wave and steering floor unchanged
falsification: reject if capture or diagonal topology is lost, mean distance regresses materially, or force/moment and limit contact do not fall without a compensating arrival benefit
