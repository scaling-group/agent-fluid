# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is a certified common initial
  condition, not evidence that any policy selected a favorable wake phase.
- All four sampled released sheets show the same useful topology: immediate
  targetward redirection, a persistent posterior-traveling bend, active
  upstream propulsion, cylinder clearance, and nose-first capture. The best
  sample's mean velocity `(-0.3446,-0.1433)` exceeds the local upstream-flow
  component `(-0.1978,-0.1941)`, and its head moves
  `(-10.9169,-4.2166)L`, so it is not passively advected. No sampled release
  is a semantic failure; the dominated successful branches are the only visual
  adverse comparisons, while inherited downstream exits remain textual
  falsification boundaries.
- The assigned guidance parent selected progress-supervised yielding of only
  the optional posterior half-cycle residual. The prefilled response-extended
  controller captures at `32.318`, scores `0.234705`, has mean distance
  `1.63741L`, and records force/moment RMS `65.52/881.45`. Inherited logs show
  that putting an additional withdrawal on mean curvature instead regressed to
  `32.4555`, `1.64548L`, and `67.83/914.09`, with no visible route benefit.
- The distinct hydrodynamic-assistance sample keeps mean curvature and the
  unit-gain traveling wave intact, but uses correct-sign body yaw moment as an
  additional reason to yield at that same optional residual. It preserves the
  compact route and improves capture to `31.5645`, score to `0.266663`, and
  mean distance to `1.60525L`. Versus the prefill, total command energy falls
  from `45988` to `44849` mainly because the episode is shorter; mean command
  energy is nearly unchanged (`1423.00` versus `1420.86`). Force/moment RMS is
  also essentially a trade (`65.52/881.45` versus `66.32/887.63`), so the
  evidence supports earlier navigation, not load relief or efficiency.
- Peak anterior/posterior excursions fall from `0.5244/0.5748` to
  `0.5191/0.5555 rad`, but both candidates still touch the velocity and
  acceleration ceilings. The evidence therefore favors promoting the sampled
  mechanism unchanged and does not support more authority, another residual,
  or scalar gain tuning.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological Karman-gait and organized-wake interaction studies
source_mechanism: yield to useful vortex-induced loading instead of reflexively cancelling every lateral or yaw disturbance
transferable_invariant: preserve hydrodynamic assistance by withdrawing only optional active steering when a measured body-frame load agrees with the current target-directed turn
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder vortex phase, species gains, dimensional frequencies, published routes, and exact load thresholds
policy_translation: sign normalized `moment_z_L2` by filtered body-frame target curvature and let positive assistance join the existing coherent-closure headroom gate only at the optional posterior half-cycle residual; preserve distributed mean curvature and the base lagged wave
falsification: reject if direct capture or the traveling bend is lost, arrival and distance integral regress, force or moment rises without navigation benefit, or a held-out wake reveals phase-sensitive switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate by materializing the strongest sampled policy.
Relative to the prefill, remove the marginal response-rate confidence branch
and restore the single target-window trajectory-efficiency supervisor. Add the
sampled, bounded correct-sign yaw-moment assistance signal to its existing
posterior pressure arbitration. During coherent closure it may withdraw only
the optional `8%` target-helping half-cycle residual; opposing moment, absent
observations, inefficient target-vector motion, redirection, or recession
recover the established controller continuously.

Retain filtered bearing, the `12 deg` distributed curvature budget,
bearing-conditioned `40/60 -> 35/65` allocation, anterior state-feedback
oscillator, posterior lag and damping, and unit-gain traveling wave. This is an
evidence-backed promotion from the sampled solver set. The new downstream CFD
evaluation must still test reproducibility and cannot be claimed here.
