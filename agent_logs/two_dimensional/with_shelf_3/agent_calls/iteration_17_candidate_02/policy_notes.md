# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. This is the certified common
  initial condition, not evidence that any policy chose a favorable wake
  phase.
- All four sampled released sheets terminate by first crossing of the target
  circle. They show active upstream self-propulsion on one compact diagonal:
  an immediate targetward redirect, a persistent posterior-traveling body
  wake, cylinder clearance, and no visible route reversal, coasting, or
  collision precursor. The sampled set contains no failure keyframe, so the
  adverse visual comparison is the slower successful branch; inherited
  downstream exits remain textual boundaries rather than invented visual
  evidence.
- The assigned prefill's response-supervised residual captures at `32.31796`
  release time with `1.63741L` mean distance, score `0.234705`, posterior peak
  excursion `0.57481 rad`, and force/moment RMS `65.52/881.45`. Its exact
  repeat in another sampled solver establishes fixed-snapshot reproducibility,
  not held-out wake robustness.
- The progress-only sibling also reproduces across inherited evaluations. It
  captures at `32.33997`, with `1.63773L` mean distance, score `0.234663`,
  posterior peak excursion `0.57530 rad`, and force/moment RMS `65.12/888.56`.
  The assigned prefill therefore makes only a marginal navigation change on
  the same trajectory and does not establish that target-response supervision
  is the useful next mechanism.
- The strongest sampled policy changes that progress-only sibling at one
  residual locus: during coherent closure, a target-signed assisting yaw
  moment participates in withdrawing the optional posterior half-cycle
  increment. It preserves the visible route and reaches at `31.56447`, lowers
  mean distance to `1.60525L`, raises score to `0.266663`, and reduces
  posterior peak excursion to `0.55553 rad`. Mean velocity becomes more
  targetward (`-0.34460/-0.14334` body lengths per time versus
  `-0.33618/-0.14039` for progress-only), while relative-crossflow RMS remains
  nearly unchanged (`0.24105` versus `0.24372`). This is not evidence of wake
  avoidance.
- The assisting-load branch does not establish broad load relief: force RMS
  rises to `66.32`, moment RMS is only slightly lower than progress-only at
  `887.63` and higher than the assigned prefill, and both joints still touch
  the velocity and acceleration ceilings. Its lower total command energy is
  largely episode-duration dependent, although mean command energy and power
  are also slightly lower than progress-only (`1420.86/108.30` versus
  `1423.42/108.78`). The supported claim is faster compact capture with a
  smaller posterior excursion, not efficiency or robustness.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological Karman-gait and wake-exploitation studies interpreted through closed-loop robotic-fish residual modulation
source_mechanism: yield optional active turning when an observed hydrodynamic yaw load already assists the current goal-directed turn
transferable_invariant: preserve the persistent propulsive wave and use signed body-frame load feedback only to withdraw redundant incremental steering during coherent target closure
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder vortex phase, dimensional frequencies, published gains, species or robot morphology, and prescribed wake routes
policy_translation: sign normalized moment_z_L2 by the bounded body-frame target-turn request, soften it at a policy-owned load scale, and combine it with the existing normalized progress and actuator-state gate only at the optional posterior half-cycle residual
falsification: reject if direct capture or the compact traveling-wave route is lost, arrival and mean distance regress to the progress-only branch, force or moment rises without navigation benefit, or a held-out wake reveals load-sign switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate by promoting the best sampled assisting-yaw-load
branch. Preserve the filtered body-frame bearing, bounded `12 deg` total
curvature, bearing-conditioned `40/60 -> 35/65` allocation, anterior
state-feedback oscillator, posterior lag and damping, maximum `8%`
target-helping half-cycle residual, trajectory-efficiency supervisor, and
direction-selective posterior speed/previous-acceleration pressures.

Replace the assigned prefill's response-confidence path with one bounded
assisting-load pressure at the same optional residual. Opposing or absent yaw
moment recovers the repeatedly evaluated progress-only controller; even full
pressure cannot weaken target-signed mean curvature or the unit-gain lagged
wave. The downstream CFD evaluation must reproduce the earlier arrival,
distance integral, and smaller posterior excursion before the mechanism is
treated as durable. This worker does not claim a same-worker CFD result,
efficiency improvement, or wake-phase robustness.
