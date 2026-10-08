# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed interacting vortex streets. It is the certified common
  initial condition, not evidence that any candidate selected a favorable wake.
- All four sampled solver examples reproduce the assigned parent's compact
  direct capture at `32.472` release time with `1.64761L` mean distance and
  score `0.224538`. Their released sheets show immediate targetward
  redirection, a sustained posterior-traveling bend, cylinder clearance, and
  first entry into the `0.75L` target circle. Head motion
  `(-10.912,-4.332)L` against mean local flow `(-0.197,-0.189)` and mean fish
  velocity `(-0.334,-0.140)` confirms self-propulsion rather than passive
  advection. The exact metrics establish deterministic fixed-snapshot
  reproducibility, not wake-phase robustness.
- That navigation result is load-intensive: both joints touch the
  `260 deg/time` speed and `1800 deg/time^2` acceleration ceilings, with
  `68.70/931.60` lateral-force/yaw-moment RMS and `0.5834 rad` posterior peak
  excursion. The keyframes show a productive narrow traveling wake through the
  approach, so changing the oscillator center, cancelling crossflow, or
  damping the whole gait is not supported.
- Two code-equivalent inherited direction-selective headroom rollouts preserve
  the same visible diagonal topology and reproduce exactly at `32.7305`
  release time, `1.64927L` mean distance, and score `0.223211`. Relative to the
  ungated parent, their `0.80%` arrival cost accompanies reductions of `18.1%`
  in force RMS (`56.29`) and `14.1%` in moment RMS (`800.58`), plus lower
  posterior peak excursion (`0.5684 rad`). Nearly unchanged local and relative
  crossflow RMS rules out simple wake avoidance as the aggregate explanation.
- The most adverse available visual contrast is the physical-limit blanket
  gate, because no sampled failure keyframe exists. It follows the same route
  but delays capture to `33.9405`, raises mean distance to `1.69143L`, and
  scores `0.181716`; a response-triggered extra burst likewise arrived later
  with higher loads. Inherited downstream-exit notes further rule out
  unrestricted bearing-rate feedback and anterior-heavy recentering. The
  candidate therefore promotes only the direction-selective residual gate and
  leaves the successful bearing filter, distributed mean curvature, and unit-
  gain posterior traveling wave intact.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation interpreted through elongated-body posterior reactive propulsion
source_mechanism: regulate a bounded turn-congruent residual around a persistent posteriorly lagged propulsive rhythm using observed actuator state
transferable_invariant: preserve the traveling base gait and yield only incremental steering authority when posterior motion already reinforces it near the gait-owned speed or acceleration scale
nontransferable_details: published gains, duty ratios, dimensional frequencies, robot or species kinematics, exact actuator limits, prescribed vortex phases, and source-task routes
policy_translation: normalize posterior speed and previous applied acceleration by oscillator amplitude-frequency scales, infer directional reinforcement from joint state, and smoothly gate only the extra target-helping half-cycle gain
falsification: reject if direct capture or the compact diagonal topology is lost, arrival regresses materially beyond the evidenced 0.80 percent trade, or repeated force and moment reductions do not survive a held-out wake or do not correspond to reduced saturation residence

## Candidate hypothesis

Produce exactly one candidate by promoting the evidence-backed direction-
selective posterior headroom gate. Preserve the filtered body-frame bearing,
bounded `12 deg` total-curvature request, `40/60 -> 35/65` allocation, anterior
state-feedback oscillator, posterior lag and damping, and maximum `8%`
target-helping half-cycle asymmetry.

The gate reads only posterior velocity and the previous applied posterior
acceleration. Each is normalized by the policy-owned oscillator scale and
suppresses the optional half-cycle increment only when its direction already
reinforces the proposed posterior wave. At full suppression, target-signed mean
curvature and the unit-gain lagged wave remain active, avoiding the propulsion
collapse seen with center-level bearing-trend feedback. The downstream CFD
evaluation must test the inherited load/navigation trade again; this worker
does not claim new wake-phase robustness or reduced saturation residence.
