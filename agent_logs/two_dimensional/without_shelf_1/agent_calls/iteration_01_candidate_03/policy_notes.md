# Wake-policy candidate notes

## Evidence reviewed

- The assigned optimizer parent is the current `guidance/` tree, byte-identical
  to `guidance_examples/optimizer_87ac4a8afe60/guidance/` before this worker's
  edits. No inherited `logs/optimize/` notes are present in the rendered
  workspace.
- The sole sampled solver is the finite naive-seed rollout
  `solver_8f63ea428aae`: score `-14.294201`, `left_domain` after `50.1269`, no
  capture, final/mean/minimum distance `12.1226/11.9031/8.61495 L`, and only
  `0.02425` net progress.
- The shared prewarm sheet shows the held fish above and to the right of a
  fully developed, overlapping four-cylinder vortex street. This is common
  initial-condition evidence, not evidence for the seed controller.
- From release to termination, the rollout sheet shows the fish remain outside
  the useful wake corridor, yaw from its initially sensible diagonal pose into
  a nearly vertical descent, and exit through the lower boundary. The path
  briefly approaches the target before diverging; it does not collide with a
  cylinder or become numerically unstable.
- The diagnostics support that reading: head displacement is
  `(-3.545,-13.300) L`, so lateral descent is almost four times upstream
  advance; mean velocity is `(-0.0725,-0.2633)` while net target progress is
  negligible. `RMS(moment_z)=541.7`, both acceleration commands reach the
  `31.416 rad/time^2` hard cap, and mean command energy is `1496.25`. The seed
  also runs at a tailbeat/shedding ratio of `32.83`. These values do not prove
  an optimal lower frequency, but they do falsify preserving the uncapped,
  target-blind high-rate response as a safe navigation baseline.

Only one sampled rollout exists, so the best available finite example and the
most informative failure are the same run; there is no positive sibling whose
mechanism can be claimed as validated.

## Candidate hypothesis

Replace the target-blind joint oscillator with one bounded feedback family:

1. Maintain a self-regulated joint-state oscillation whose phase remains
   encoded by joint angle and velocity. Use a longer period and an explicit
   candidate-owned acceleration cap to avoid the seed's persistent hard-cap
   commands while retaining propulsion.
2. Convert the exposed body-frame `bearing` into a smooth, saturated curvature
   bias, and subtract scaled normalized `heading_rate`. Positive bearing should
   request positive mean tail tangent; yaw-rate damping should arrest the
   visually observed turn before it becomes a lower-domain escape.
3. Track the biased tail tangent with the posterior joint while preserving a
   velocity-dependent phase lag. Use no world coordinates, cylinder identity,
   elapsed time, prescribed inflow, or remote wake probes.

The next CFD evaluation can falsify the candidate directly. It should survive
past `50.13`, make upstream displacement comparable to the required diagonal
route rather than accumulating a four-to-one downward/upstream displacement
ratio, reduce acceleration saturation and moment load, and lower both final
and mean target distance. A reversed or over-strong steering sign would instead
increase absolute bearing, downward exit, or lateral oscillation; later workers
should then reverse/test the curvature mapping rather than infer that target
feedback itself is ineffective.
