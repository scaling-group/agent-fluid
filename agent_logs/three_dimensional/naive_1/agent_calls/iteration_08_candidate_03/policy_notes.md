# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no
  numerical instability. In both rows of the combined sheets the fish moves
  under its own actuation, leaves a coherent alternating top-down wake, and
  retains discrete three-dimensional caudal Lambda2 structures through the
  approach. The common failure is route control, not advection or absent
  propulsion.
- The assigned prefill (`solver_5f29dca2aca2`) combines an anterior
  phase-selective redirect with posterior relief. It reaches `4.018L`, but its
  full target error is still `1.333 rad` at closest approach and it exits the
  lower boundary at `31.94T`. Symmetric posterior relief
  (`solver_c039fddba4d9`) is weaker at `4.233L` and has the same visible
  trajectory.
- Whole-body half-cycle selection (`solver_24724bc7bb0b`) is a real but narrow
  improvement: it gives the best sampled minimum distance, `3.691L` at
  `20.46T`, and survives to `33.27T`. It does not meet its orientation
  prediction. Full target error is still `1.364 rad` at the minimum, increases
  past `2 rad` after the fish passes below the target, and the fish exits low
  at `9.294L`. Joint rate-cap occupancy is about `13.7/5.5%`, while anterior
  acceleration is already clipped for about `68%` of samples, so another
  phase-residual magnitude increase would mainly add saturation rather than a
  distinct maneuver.
- The full-target-vector semantic correction (`solver_dac1edc233b4`) keeps
  steering active after the target passes abeam, but still reaches only
  `3.909L` and exits low at `33.23T`. Its top-down and oblique rows remain
  almost indistinguishable from the other long southwest tracks. Thus
  repairing folded bearing alone is insufficient: the existing bounded
  anterior center and tail unloading do not generate enough net target-side
  yaw to exploit the corrected error.
- Near the best sample's minimum the body-frame forward speed remains about
  `0.62L/T` while target error is large. The fish therefore carries a coherent
  propulsive gait rapidly through a near-target miss. The inherited results
  rule out another shared/tail-biased static center, scalar relief change, or
  direct recent-yaw unloading; the latter previously quenched the gait without
  producing a redirect.

## One candidate hypothesis

Preserve the sampled whole-body half-cycle gait outside the approach region.
Use the full signed head-relative target angle so a target behind the head is
not mistaken for alignment. When normalized distance falls below `6L` while
that error is large, smoothly blend the anterior self-excited oscillator into
a damped one-sided curvature maneuver and deepen posterior unloading. At true
alignment or outside the approach region, release continuously back to the
evidenced propulsive gait. Joint state remains the only beat-phase signal.

This is a state-triggered terminal burst redirect, not a larger global
curvature gain: before the sampled `6L` approach it is exactly inactive, and
inside it changes the controller from sustained cyclic propulsion to a
temporary curvature-capture mode. The falsifiable expectation is to retain the
early alternating wake and roughly the `3.691L` approach, then produce visible
target-side yaw before the lower pass. Reject it if the pre-approach track or
wake changes materially, minimum distance does not improve, full target error
does not fall below `1 rad` during the maneuver, the fish merely coasts with a
collapsed wake to the same lower exit, joint saturation materially exceeds the
sampled `13.7/5.5%` rate-cap envelope, or force/moment peaks exceed the sampled
approximately `0.03/0.016` normalized envelope.

bookshelf_consulted: true
source_domain: biological C-start or burst redirection combined with terminal capture control
source_mechanism: large observed heading error temporarily recruits strong one-sided body curvature and yields cyclic propulsion, then geometric realignment releases the swimmer back into a traveling propulsive bend
transferable_invariant: near a fast miss, trade some periodic thrust for a bounded target-signed curvature impulse only while body-frame target geometry demands it, and restore the gait continuously on alignment
nontransferable_details: species-specific C-start shapes, published gains, dimensional timing, exact joint envelopes, clocked maneuver stages, exact vortex phases, and task-specific routes
policy_translation: normalized distance and the full body-frame target angle gate a smooth blend from the joint-state oscillator to a damped anterior curvature center while the existing posterior half-cycle carrier is unloaded; no time or hidden state is used
falsification: reject if early propulsion changes, the near-target maneuver fails to reduce full error below 1 rad or improve the 3.691L minimum, the wake collapses into inertial coasting, the same lower exit persists without earlier target-side yaw, or saturation and loads materially worsen
