# Wake-policy candidate notes

## Inherited and sampled evidence

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm.
  Their translation and wakes are self-generated rather than ambient
  advection.
- The assigned parent expected bounded body-frame lateral-slip feedback to
  prevent the static-curvature carrier's early upper hook. Its evaluated child
  (`solver_fc78cfbb9251`) is the first sampled mechanism to produce a
  materially different useful trajectory. The top-down row shows a long,
  alternating signed-vorticity street and the oblique row retains coherent
  three-dimensional Lambda2 structures through the approach. Mean distance
  improves from `9.417L` for the strongest static-curvature sample to
  `7.684L`, closest distance improves from `9.141L` to `2.960L`, and survival
  extends from `13.129T` to `26.637T`.
- The same rollout exposes the remaining failure. At closest approach
  (`17.699T`) the head is `(9.737,12.367)L`, still about `2.87L` above the
  target, while world speed is about `0.82U`, closing speed is approximately
  zero, body-frame bearing is about `-0.97 rad`, and the bounded posterior
  mean-curvature request is effectively saturated. The fish then passes the
  target in x, distance grows to `7.786L`, the trajectory and wake turn upward,
  and the center exits at `y=15.200L`. Increasing the same bearing or slip
  gains cannot create additional posterior authority in this regime.
- The phase-referenced yaw-rate sample (`solver_311802a10433`) provides a
  useful boundary. It also survives about `26.3T` and retains a coherent wake,
  but holds the path near `y=14L`, passes the target with a `4.361L` closest
  distance, and exits the left boundary. Broad yaw suppression alone therefore
  removes too much target-normal response. The inherited half-cycle-relief
  prefill is the contrasting failure: it hooks upward by `12.551T` and reaches
  only `9.855L`, despite a visible alternating 3D wake.

## Policy hypothesis

Preserve the evaluated lateral-slip controller exactly in the far and middle
field, including its zero-centered anterior oscillator, posterior lag, and
bounded posterior mean curvature. Add one continuous approach-hold mechanism:
as normalized target distance falls below roughly `5L`, smoothly damp the
anterior carrier and reduce only the oscillatory part of the posterior target
toward a nonzero floor, while leaving the target-relative mean curvature
undiminished. This changes steering-to-propulsion authority instead of tuning
an already saturated steering scalar. It uses only current body-frame state
and distance; it has no clock, route, or hidden stage.

The next rollout should reproduce the parent's coherent far-field wake and
left/down progress, then shed enough excess carrier speed for the saturated
target-directed bend to turn before the x crossing. Retain the mechanism only
if it beats `2.960L` or achieves capture without early coasting, destructive
joint transients, or loss of the alternating 3D wake. Falsify it if distance
stalls outside the capture neighborhood, the same upper exit persists, or
approach damping destroys propulsion before target-normal error decreases.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG path following and terminal target acquisition
source_mechanism: sensor-conditioned modulation of a rhythmic carrier so propulsion is retained far away but yields relative authority to directional feedback during approach
transferable_invariant: when broad target-directed locomotion works but a fast swimmer passes a nearby target with saturated steering, continuously reduce carrier authority from normalized target state while preserving the corrective feedback channel
nontransferable_details: published gains, clock phase, species-specific amplitude envelopes, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: keep body-frame bearing-minus-lateral-slip posterior curvature, and use normalized distance only to add bounded anterior damping and attenuate the oscillatory posterior carrier toward a nonzero floor
falsification: reject if far-field wake or progress changes materially, propulsion collapses outside capture, closest distance does not beat 2.960L, or the trajectory repeats the upper exit without reducing target-normal miss
