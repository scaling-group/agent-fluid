# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. Its identical hash across all four
  samples confirms a common initial condition, not candidate-selected wake
  phase or held-out robustness.
- The three byte-identical progress-supervised candidates also have identical
  released sheets and metrics: target capture at `32.3400`, mean distance
  `1.63773L`, score `0.234663`, force/moment RMS `65.12/888.56`, and posterior
  excursion `0.57530 rad`. The sheet shows immediate targetward redirection, a
  persistent posterior-traveling bend, cylinder clearance, and nose-first
  entry into the `0.75L` target circle. Mean velocity
  `(-0.3362,-0.1404)` versus local flow `(-0.1961,-0.1918)` confirms active
  upstream self-propulsion rather than passive advection.
- The distinct stacked-gate sample follows the same visible route but captures
  later at `32.4555`, worsens mean distance to `1.64548L` and score to
  `0.226804`, raises force/moment RMS to `67.83/914.09`, and reaches a larger
  posterior excursion of `0.58180 rad`. Its relative-crossflow RMS
  (`0.24461`) is nearly the same as the selected branch (`0.24372`), so the
  regression is not evidence of a different wake corridor.
- No released failure sheet is present in the sampled workspace, so none is
  invented as a visual comparison. Inherited failures remain boundaries:
  unrestricted bearing-rate recentering erased the traveling wave, blanket
  physical-limit damping delayed capture, and an extra posterior burst raised
  loads while arriving later.
- Every sampled success touches both joint velocity and acceleration limits,
  so limit contact alone does not identify when withdrawing the optional
  residual is useful. Hydrodynamic yaw load is outcome-discriminative instead:
  the selected branch lowers moment RMS relative to both the stacked branch
  and the inherited ungated branch (`931.60`), while all retain the same route.
  This supports testing actual target-congruent yaw response as the sole
  withdrawal signal rather than adding another controller layer.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Karman-wake fish interaction and sensor-modulated robotic-fish CPG control interpreted through posterior reactive propulsion
source_mechanism: retain a persistent propulsive traveling wave while yielding optional steering only when observed hydrodynamic yaw already assists slow goal-directed motion
transferable_invariant: slow body-frame target geometry owns turn direction, actual normalized yaw response may share the load, and adverse or absent response must restore bounded steering authority without weakening the base gait
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, single-cylinder vortex phase, actuator ratings, prescribed wake synchronization, source-task routes, and fixed approach distances
policy_translation: replace the posterior speed/previous-acceleration headroom branch with one target-signed `moment_z_L2` response supervisor around only the optional posterior half-cycle residual; retain filtered bearing, distributed mean curvature, the anterior oscillator, posterior lag, and the unit-gain traveling wave
falsification: reject if direct capture or the compact diagonal topology is lost, arrival or mean distance regresses beyond `32.3400` and `1.63773L` without moment/load relief, moment RMS is not below `888.56`, the posterior excursion or saturation residence rises, or a held-out wake exposes switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate by replacing actuator-state headroom arbitration
with hydrodynamic yaw-response load sharing on the same optional residual. A
smooth target-signed moment activation is formed from normalized
`moment_z_L2`; it can withdraw the maximum `8%` target-helping posterior
half-cycle increment only while history-window target motion is coherent
closure. Opposing moment, incoherent motion, redirection, stall, recession, and
early padded history restore the evaluated ungated increment continuously.

The moment scale is policy-owned and set from the sampled `888.56-914.09`
raw RMS range normalized by `L^2=4096` (about `0.217-0.223`), not from a
published gain. The mechanism never changes the bounded `12 deg` mean
curvature, the `40/60 -> 35/65` allocation, the anterior oscillator, or the
unit-gain posterior wave. The downstream CFD rollout must decide whether the
same direct route can share steering with target-helping wake/body torque; no
same-worker improvement or wake-phase robustness is claimed.
