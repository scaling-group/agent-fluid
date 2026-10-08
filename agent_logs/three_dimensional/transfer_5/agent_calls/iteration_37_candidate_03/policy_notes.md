# Candidate diagnosis and hypothesis

## Rollout evidence before editing

- All four sampled rollouts are finite captures from direct-uniform still water
  with `U_infinity=(0,0,0)` and no prewarm. I inspected the combined sheets for
  the assigned-parent target-course observer (`solver_a95f7416a3de`) and the
  stabilization-envelope carrier (`solver_ba129a83ae98`) from release through
  termination. In both the top-down mid-plane-vorticity row and the oblique
  body/Lambda2 row, the fish self-propels along the same broad clockwise target
  arc and sheds a coherent alternating three-dimensional wake. Neither is
  passively advected, loses its wake, exits the domain, collides, or becomes
  unstable. The policy difference is visually subtle, so trajectory and load
  histories decide it.
- The assigned parent improves score and scoring mean distance over the
  stabilization-envelope sample from `-0.502603/2.400102L` to
  `-0.501691/2.399184L`. Inside `3L`, it also reduces mean absolute yaw,
  target-line cross-track speed, mean absolute moment, peak cross-track speed,
  and peak moment from `1.70656 rad/T`, `0.23432U`, `0.006564`, `0.62616U`,
  and `0.015118` to `1.68733 rad/T`, `0.22592U`, `0.006393`, `0.58298U`, and
  `0.013886`. Its joint-angle, joint-rate, and projected-command envelopes
  remain essentially unchanged.
- Those improvements do not make the global course residual a clean progress
  mechanism. The parent reaches `6L` `0.0605T` earlier, but reaches `3L`, `2L`,
  `1L`, and capture `0.0110T`, `0.0330T`, `0.0990T`, and `0.0660T` later. Its
  inside-`3L` radial closing speed falls from `0.69819U` to `0.67988U`, and
  peak yaw rises from `3.28817` to `3.34971 rad/T`. Signed normalized
  target-line motion changes from `-0.161/-0.033/+0.158/+0.350` to
  `-0.184/-0.085/+0.063/+0.388` across the `6--3`, `3--2`, `2--1`, and
  `<1L` bands: continuous course damping reduces the `2--1L` sign reversal but
  opposes necessary route curvature for too long in the preceding bands and
  leaves a stronger final reversal. The two independent demand-handoff samples are bit-identical,
  confirming that these comparisons are deterministic rather than visible
  initialization noise.

## Single candidate hypothesis

Preserve the assigned parent's successful traveling-wave carrier, C-bend,
split terminal observer, stabilization-envelope cadence handoff, smooth command
projection, and carrier-rejected target-course coordinate. Make one feedback-
architecture change: treat the course coordinate as velocity damping whose
authority falls continuously with the magnitude of the current body-frame
target-geometry request. Near a low-curvature collision course it remains
active; when bearing/vector error calls for a substantial turn, target geometry
takes priority. Use the existing normalized request scale, so this is a bounded
signal-role arbitration rather than scalar gain tuning or another distance
threshold.

The candidate should keep the parent's early distance-integral and terminal
cross-track/load benefit while recovering some of the stabilization carrier's
`23.375T` arrival by avoiding course-residual braking through the `6--2L`
turn. Falsify it if CFD loses capture or the coherent wake, does not improve
arrival over `23.441T`, gives back the parent's score/mean-distance benefit,
worsens terminal cross-track/yaw/moment together, or increases joint/command
envelope exposure.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and terminal approach control
source_mechanism: arbitrate bounded velocity damping against target-derived route curvature while preserving the rhythmic traveling-wave carrier
transferable_invariant: course damping may shape an already aligned approach, but a large observed target-geometry error must retain priority to generate corrective curvature
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, exact vortex phases, duty ratios, and prescribed routes
policy_translation: multiply the normalized carrier-rejected target-line course term by a smooth body-frame target-geometry alignment gate before it enters the two-joint route request; retain all sampled propulsion, terminal, and projection layers
falsification: reject if capture timing, score or mean progress, coherent alternating wake, terminal cross-track/yaw/moment balance, or actuator feasibility regresses against the assigned parent
