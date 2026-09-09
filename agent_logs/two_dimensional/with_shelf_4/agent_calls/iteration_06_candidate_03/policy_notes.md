# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared held-fish prewarm sheet shows the released fish above and far to
  the right of the target after four interacting cylinder streets have fully
  developed. This is a common initial condition; it does not identify a fixed
  route or reusable vortex phase.
- The strongest sampled finite policy reaches the `0.75L` target in `149.605`
  units with `4.358L` mean distance, `-10.930L` upstream displacement,
  `647.93` mean command energy, `0.1321` RMS relative crossflow, `15.49` RMS
  lateral force, and `308.48` RMS yaw moment. Its keyframes show self-propelled
  upstream passage through the merged wake corridor and a persistent
  posterior-lagged alternating wave. The targetward polyline nevertheless has
  several sharp yaw reversals between broad route segments.
- The otherwise identical direct-moment policy without bearing-rate damping
  also captures in `149.572` units, but has worse mean distance (`4.384L`),
  command energy (`681.91`), relative crossflow (`0.1362`), force (`16.22`),
  and moment (`314.99`). The duplicated strong rollout reproduces the improved
  metrics, so bounded `bearing_window_rate` feedback is the evidence-backed
  route scaffold rather than a speculative speed mechanism.
- The inherited headroom-residual failure is an informative topology
  contrast. Its keyframes close into an upper-right loop before a top-boundary
  exit at `126.43` units; it moves only `-1.12L` upstream and regresses from an
  `8.61L` closest approach to `12.05L`, despite lower mean command energy and
  moderate RMS moment. This rules out using effort, feasible joint extrema,
  or scalar gain relaxation as substitutes for target-directed translation.
- An inherited one-mechanism descendant gates the direct moment residual by
  the sign of bearing response. It retains capture and is slightly faster
  (`148.703` units) with marginally lower command energy and loads, but its
  keyframes show a wider midcourse excursion and the mean distance worsens to
  `4.578L`, reducing score from `-2.408` to `-2.629`. Bearing convergence mixes
  route translation with body rotation; it is therefore not validated as a
  gate for fast yaw-load rejection.

## Candidate hypothesis

Start from the strongest sampled controller without changing its oscillator,
zero-mean half-cycle asymmetry, posterior lag, bearing-rate route damping, or
direct normalized moment residual. Add one separately bounded response term:
normalized body heading rate. With the evidenced bend/yaw convention, a
positive heading rate requests positive mean bend, whose negative-yaw response
opposes that rotation. Persistent body-frame bearing still owns the route;
moment remains the fast load feedforward; heading rate supplies a small
dissipative response rather than an external phase or route.

The mechanism should preserve capture and upstream translation while reducing
the visible route kinks, distance integral, and yaw/load effort. Reject it if
capture is lost or materially delayed, mean distance or load rises, the
alternating posterior wave is suppressed, actuator-cap contact increases, or
a loop/domain-exit topology returns. The new CFD evaluation happens only after
this worker exits, so these are falsification tests rather than outcome claims.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and adaptive wake swimming
source_mechanism: separate persistent target routing, fast measured load feedforward, and a small bounded damping response to observed body yaw rate
transferable_invariant: body-frame target geometry should own route steering while measured angular response may dissipate yaw excursions without replacing the state-feedback propulsive rhythm
nontransferable_details: published gains, dimensional beat frequencies, robot linkage and species kinematics, exact vortex phase, cylinder layout, recurrent state, and source-task routes
policy_translation: preserve the successful bearing-and-bearing-rate half-cycle controller and direct `moment_z_L2` residual, then add a softly saturated `heading_rate` damping residual before the unchanged turn and amplitude bounds
falsification: reject if yaw-rate damping loses or slows capture, weakens upstream translation, raises distance integral or loads, increases cap contact, destroys posterior lag, or recreates a loop or boundary exit
