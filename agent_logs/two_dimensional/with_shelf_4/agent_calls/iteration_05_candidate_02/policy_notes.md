# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared held-fish prewarm sheet shows the fish fixed above and far to the
  right of the target while four developed vortex streets interact and advect
  across the release corridor. This is the common initial flow for every
  candidate, so it supports neither a memorized route nor a prescribed vortex
  phase.
- All four current solver samples reach the target; there is no current sampled
  failure sheet. The informative failure boundary therefore comes from the
  assigned-parent and inherited optimizer notes: the confounded slower-period,
  higher-moment-gain, route-headroom-gated variant loops above the useful wake,
  exits the top boundary after `126.43` units, moves only `-1.12L` upstream,
  and regresses to `12.05L` final distance. This rules out reopening moment
  gain, gait period, or route-headroom gating in the present candidate.
- The repeated prefill/direct-residual rollout is a robust successful baseline.
  Its sheet shows self-propelled alternating bends, a broad targetward arc, and
  entry into the interacting wakes before capture at `149.572` units. It moves
  `-10.923L` upstream, has `4.384L` mean distance, RMS relative crossflow
  `0.1362`, RMS lateral force/moment `16.22/314.99`, total/mean command energy
  `101995/681.91`, and mean power proxy `49.63`. The route is useful, but its
  late trajectory has several sharp zigzags while closing through the wakes.
- The best finite sample changes only the slow route loop by adding bounded
  `bearing_window_rate` damping. Its keyframes retain the same broad route,
  alternating wave, and target capture at essentially the same time
  (`149.605`, only `0.033` later), while the late trajectory is visibly less
  jagged. Cross-checked metrics improve together: mean distance falls to
  `4.358L`, RMS relative crossflow to `0.1321`, RMS force/moment to
  `15.49/308.48`, total/mean command energy to `96933/647.93`, and mean power
  proxy to `46.94`. Peak joint angle, speed, and acceleration also fall
  slightly. This is positive evidence that target-error trend is a useful
  damping signal and that preserving the direct moment residual is safer than
  retuning fast load rejection.
- The remaining visible opportunity is local to final approach. The fish still
  crosses alternating structures and changes yaw several times in the last
  third of the route. Because far-field translation and capture already work,
  changing the gait or globally increasing damping would expose the proven
  route unnecessarily. A smooth distance-conditioned increase of the same
  rate damping is a narrower, falsifiable terminal-control mechanism.

## Candidate hypothesis

Materialize the best sampled bearing-rate controller, then add one approach
scheduler: a smoothly bounded function of normalized body-frame target
distance increases bearing-rate damping only near the target. When bearing is
converging, the added term releases excess turn authority; when it is diverging,
the same term restores correction. Far away, the candidate is effectively the
sampled best policy. The oscillator amplitude and period, state-inferred
half-cycle steering, zero-mean equilibrium, posterior lag, and small direct
`moment_z_L2` residual are unchanged.

The later formal rollout should preserve target reach, roughly `-10.93L`
upstream translation, and arrival near `149.6`, while reducing late zigzag,
mean distance, RMS force/moment, or actuation. Reject the scheduler if capture
is lost or materially delayed, far-field trajectory changes, the alternating
posterior wave is suppressed, load or actuator-cap contact rises, or any loop
or domain-exit topology returns. Since all current samples terminate on first
entry at `0.75L`, this rollout can establish approach scheduling but cannot
validate station holding after entry.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and adaptive wake swimming
source_mechanism: use observed target-direction error and its convergence trend to modulate bounded rhythmic steering while preserving the propulsive oscillator
transferable_invariant: persistent normalized body-frame target error should own the route, while its observed rate may release or restore steering authority more strongly during terminal approach
nontransferable_details: published CPG gains, dimensional frequencies, robot linkage or species kinematics, exact vortex phase, cylinder layout, recurrent-network state, and source-task trajectories
policy_translation: preserve the sampled joint-state half-cycle oscillator, posterior follower, direct normalized yaw-moment residual, and base bearing-rate damping; use only `distance_L` to schedule one additional bounded `bearing_window_rate` damping term near the target
falsification: reject if capture or upstream translation is lost, arrival materially worsens, late trajectory and load metrics do not improve, actuator clipping rises, or the distance scheduler changes the far-field route

## Pre-evaluation contract audit

- The static schema comparison is exact: every direct `params.FIELD` reference
  has a field returned by `target_policy_params()`, and the only observations
  used are the documented `bearing`, `bearing_window_rate`, `distance_L`,
  `moment_z_L2`, `phi`, and `phi_dot` fields.
- The approach term is negligible at `4L` (`0.000045` weight), reaches half
  authority at `2L`, and raises total rate damping smoothly from `0.2` toward
  `0.4` at the `0.75L` capture boundary. The existing final `[-1,1]` turn bound
  and gait envelope are unchanged. An independent calculation of the checker's
  zero-rate state gives finite acceleration `(-7.615435, 0.0)`.
- The configured Julia assertion could not run because this workspace image has
  no `julia` executable. Guidance semantics and solver-boundary checks pass;
  no CFD rollout was run.
