# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet is byte-identical across all four samples. It shows
  the fish held above and downstream of four fully developed, interacting
  vortex streets, so it is a common initial condition rather than evidence of
  candidate-specific wake selection or robustness to a changed release phase.
- The three code-identical planar-wrench samples reproduce the strongest
  result: each fish turns down and upstream, sustains a posterior-traveling
  bend and narrow body wake, clears every cylinder, enters the merged wakes
  only late, and captures nose first at `30.4865` release time. Mean velocity
  `(-0.35660,-0.14740)L/time` versus mean local flow
  `(-0.20216,-0.19779)` confirms active upstream propulsion rather than
  passive advection. Their matching mean distance is `1.56766L`, relative-
  crossflow RMS is `0.23534`, force/moment RMS is `65.80/872.96`, and peak
  anterior/posterior excursions are `0.50945/0.51897 rad`.
- The most informative sampled adverse comparison remains a target capture,
  because no released failure keyframe is present. Its opposing-load veto
  preserves the route but carries a visibly broader late posterior wake,
  delays capture to `31.3335`, raises mean distance to `1.59773L`, and raises
  peak excursions to `0.51690/0.54820 rad`. Its lower force/moment RMS
  (`62.68/845.71`) is therefore a navigation-for-load trade, not evidence that
  opposing load should restore optional actuation.
- Inherited logs provide a second adverse branch. Extending the successful
  lateral-force/yaw cue with instantaneous total-force projection onto
  `target_body_L` preserved the direct visual topology but slipped to
  `30.5580` and `1.56958L`, while force/moment RMS rose to
  `69.18/902.43`. Streamwise force projection is too broad to treat as useful
  assistance from this fixed-snapshot evidence. Earlier inherited downstream-
  exit evidence also forbids moving target-rate feedback into oscillator
  centers or weakening the base traveling wave.

## Candidate hypothesis

Preserve the reproduced planar-wrench controller and change only how its two
already evidenced positive assistance cues are combined. A plain maximum
retains either target-signed lateral translation or target-signed yaw rotation,
but discards the extra confidence when both measured body-frame components
agree. Combine them with a bounded complement product: it exactly retains a
single active cue, increases withdrawal smoothly only under concurrence, and
never exceeds unit assistance. Apply the result under the existing coherent-
closure supervisor and only to the optional `8%` posterior half-cycle residual.

The hypothesis is that joint lateral/yaw support identifies moments where the
incremental posterior turn is most redundant, permitting slightly cleaner
closure without the broad streamwise-force response that raised loads or the
opposing-load veto that restored actuation and delayed arrival. The filtered
bearing, distributed `12 deg` mean-curvature request, bearing-conditioned
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior lag
and damping, and unit-gain traveling wave remain unchanged.

bookshelf_consulted: true
source_domain: biological Karman-gait and adaptive wake-interaction studies
source_mechanism: swimmers may preserve useful vortex-induced translation and rotation by yielding optional active effort instead of cancelling every fluid load
transferable_invariant: preserve the propulsive wave and route steering while withdrawing only bounded incremental control when normalized measured body-frame loading agrees with task-directed motion
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase locking, dimensional frequencies, published gains, species morphology, exact vortex phases, and prescribed routes
policy_translation: combine positive target-signed `force_body_L[2]` and `moment_z_L2` with a bounded complement product at the sole optional posterior half-cycle residual, retaining either cue alone and adding withdrawal only when both agree during coherent closure
falsification: reject if target capture or the compact self-propelled diagonal is lost, arrival or mean distance regresses from `30.4865/1.56766L`, force or moment rises without navigation benefit, or a held-out wake exposes switching, propulsion loss, or phase sensitivity

## Scope

This candidate does not infer vortex phase, cancel crossflow, use streamwise
force, alter the mean-curvature path, or add controller authority. Its formal
CFD result is evaluated only after this worker exits, so no same-worker
improvement is claimed.
