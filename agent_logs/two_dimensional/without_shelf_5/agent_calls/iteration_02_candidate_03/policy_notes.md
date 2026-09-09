# Multi-Wake Policy Candidate Notes

## Visual and numerical diagnosis

- The shared prewarm sheet shows the common upper-right release pose above four
  developed, interacting vortex streets. The target is inside the merged wake
  behind the second cylinder row. Because this sheet is identical across
  candidates, it establishes the difficult initial flow and geometry but does
  not distinguish controllers.
- The target-blind seed is visibly active but not usefully directed. It first
  moves slightly upstream, then rotates nose-down and leaves through the lower
  boundary at release time `50.1269` without entering the target corridor.
  Its mean fish and local-flow velocities are nearly the same in y
  (`-0.2633` versus `-0.2414`), consistent with mostly advected lateral
  escape; distance only briefly falls to `8.615L` and rebounds to
  `12.123L`. Both joint-rate and acceleration caps are reached.
- The strongest finite sampled policy retains that seed gait but adds a smooth
  positive body-frame bearing bias across both joint targets. Its keyframes
  show an immediate controlled turn followed by a coherent upstream-left path
  through the interacting wake and a first crossing of the `0.75L` target
  radius at `41.316`. Metrics agree: progress is `0.9397`, mean/final
  distances are `1.919L` / `0.7497L`, and head displacement is
  `(-10.910,-4.251)L`. Its mean upstream velocity `-0.2629` exceeds the
  local-flow contribution `-0.1600`, so the approach is self-propelled, not
  just carried into the target. The oscillatory wake is visually strong but
  does not cause wasteful trajectory meandering. Loads remain finite
  (RMS force/moment `42.0` / `660`), although both actuator caps are still
  touched.
- Three contrasting variants reject the opposite curvature convention. The
  assigned parent's inherited `0.60`-period, 24-degree controller applies a
  negative bearing bias to both joints; it hooks down/right in the keyframes,
  leaves after `11.335`, and worsens to `14.830L` with cap contact and RMS
  moment `7297`. A slower posterior-only negative bias never improves on the
  initial distance, displaces `(+2.371,-11.073)L`, and exits after
  `76.692`. A negative multi-signal moving-center controller folds at release
  and becomes unstable after `2.807`, with RMS force/moment
  `5.33e4` / `6.88e5`. These failures do not support adding lateral-flow or
  moment feedback to the only successful bearing mechanism.

## Candidate hypothesis

Use the evidence-backed successful architecture without an unevaluated
wake-response term: preserve the `0.55`-period, 28-degree state-encoded gait,
limit bearing to `pi/2`, map it through a 12-degree positive `tanh` steering
angle, place 40% of that center on the anterior oscillator, and center the
total posterior tangent on the same command. This retains the observed
self-propulsion while applying the curvature sign and two-joint distribution
that alone produced capture under the shared prewarm.

The next CFD rollout should falsify the candidate if it fails to reproduce the
coherent upstream-left approach and target crossing, or if cap contact develops
into instability. Because the successful comparator still reaches both
actuator caps, a later worker may test a one-at-a-time cadence or amplitude
reduction only after preserving the positive bearing sign and distributed
steering baseline; the current evidence cannot establish that a slower gait
would retain capture.
