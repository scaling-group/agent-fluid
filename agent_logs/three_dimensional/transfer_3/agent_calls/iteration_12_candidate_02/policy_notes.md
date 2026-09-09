# Evidence-selected LOS-response distributed C-bend candidate

## Visual diagnosis recorded before the policy edit

- All four sampled evaluations are finite, direct-uniform still-water rollouts
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their translation
  and wakes are self-generated, not imposed advection or moving-window motion.
- Both rows of the combined keyframe sheets were inspected for the strongest
  completed rollout (`solver_d2c490cfb432`), its successful collision-course
  sibling (`solver_dca1b5640cb9`), and the informative LOS-only miss
  (`solver_3b6bd84298a5`). The LOS-only policy leaves a long coherent
  alternating top-down street and compact oblique Lambda2 structures but
  crosses the target station at `y=12.994L`, misses by `3.369L`, and exits
  left at `30.12T`. Both distributed-C-bend children retain coherent wakes and
  instead terminate by capture, so the semantic improvement is sustained
  anterior route curvature rather than wake advection or propulsion recovery.
- The response-demand gate captures at `19.585T` and the collision-course gate
  at `19.784T`, with respective mean-distance terms `2.0934L` and `2.0982L`.
  It also has lower local-flow RMS (`0.01825U` versus `0.01842U`), force RMS
  (`0.01261` versus `0.01314`), moment RMS (`0.00661` versus `0.00690`), and
  raw acceleration-envelope occupancy (`39.5%/71.6%` versus `41.5%/72.9%`).
  Thus the simpler observed route-demand gate is supported across outcome,
  route, and load evidence; the extra constant-velocity intercept thresholds
  do not buy a better completed trajectory.
- The response-gated route progresses from head `(14.728,12.342)L` at `12T`
  to `(11.782,11.293)L` at `16T` and captures from above at
  `(9.422,10.119)L`. The prefilled intercept gate remains about `0.23L` higher
  at `16T` and captures later from `(9.242,10.208)L`. Both remain bounded and
  finite; this is a small but consistent route advantage, not a scalar-only
  preference.

## Policy hypothesis recorded before editing

Replace the prefilled collision-course gate with the completed response-demand
distributed C-bend. Preserve the evaluated `28 degree`, `0.55T` joint-state
traveling wave, body-frame bearing plus rotation-invariant LOS-rate request,
phase-conditioned posterior residual, and bounded `6 degree` anterior center.
Recruit the anterior branch whenever either normalized bearing or the already
bounded route-response demand is large, and release it continuously when both
subside. This removes unsupported range, closing-speed, and predicted-miss
thresholds while selecting the sampled policy that already captures earlier
with lower load and envelope occupancy.

Expected evidence is the inherited response-gated capture topology: a coherent
alternating wake, capture near `19.6T`, finite loads, and no upper/lower curl.
Falsify this selection if formal reevaluation loses capture, materially raises
loads or clipping, or fails to reproduce the response-gated approach. Future
improvements should establish repeatable capture first and only then test a
new terminal mechanism; another range-only drive schedule or scalar threshold
retune is not supported by the current samples.

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish closed-loop CPG direction tracking
source_mechanism: observed route demand recruits bounded mean curvature on a persistent rhythmic carrier and releases it when target-directed response is restored
transferable_invariant: preserve a traveling propulsive bend while using normalized sensory route demand to sustain reversible distributed curvature until the response no longer calls for redirect
nontransferable_details: published gains, species-specific C-start kinematics and timing, robot linkage geometry, dimensional frequencies, exact vortex phases, world-frame routes, and task-specific coordinates
policy_translation: use normalized body-frame bearing and rotation-invariant LOS rate to form a bounded yaw demand, gate a bounded anterior oscillator-center shift from that observed demand, and retain the phase-conditioned posterior response in the two-joint state-feedback contract
falsification: reject if capture is lost, the route curls to a boundary, the coherent wake weakens, or acceleration/load evidence materially worsens relative to the two completed captures
