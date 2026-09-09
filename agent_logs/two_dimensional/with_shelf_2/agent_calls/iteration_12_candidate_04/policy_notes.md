# Multi-wake policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release while four mature cylinder streets merge around the target. It is
  common initial-condition evidence, not evidence for a controller difference.
- All sampled released sheets are finite `target_reached` episodes, so this
  workspace has no sampled failure keyframe. The strongest sampled score and
  its two exact replays visibly sustain a zero-centered traveling wake, swim
  diagonally upstream and downward, enter the merged wakes, and make a broad
  final correction into the capture circle. The diagnostic mean x velocity
  `-0.241` exceeds the local-flow contribution `-0.174`, confirming active
  propulsion rather than passive advection. The inherited collision at
  `58.93` is therefore used only as a nonvisual boundary against weakening
  steering or broadly reallocating the base wave.
- The prefilled course-convergence residual and its exact repeats reach at
  `45.61`, with score `0.158830`, `1.72215L` mean distance, `1028.6` mean
  command energy, and `453/4406` force/moment RMS. Reusing the yaw-moment
  steering gate on that course residual is a concrete regression: it reaches
  at `45.84`, with score `0.150759`, `1.72999L`, and higher `460/4433` loads.
  A gate based instead on joint-rate headroom preserves the same visible
  diagonal topology, reaches fastest at `45.10`, retains `1.72267L` mean
  distance, and lowers loads to `414/4104`; it also ends on a slightly higher,
  less-downward line (`-10.91/-4.38L` head displacement rather than
  `-11.06/-4.73L`). Its lower `0.157432` score reflects the combined scoring
  terms, so it is a semantic arrival/load improvement rather than a clean
  scalar win.
- The rate-headroom result still reaches both `4.538` rad/time joint-rate caps,
  while acceleration maxima remain near the candidate soft limit
  (`28.79/28.40`). The final sheets show that the largest route sweep occurs
  late, close to capture. This supports withdrawing only extra positive course
  amplification near the target, not reducing the base traveling bend,
  closure residual, negative course correction, or steering authority.

## Policy hypothesis

Start from the evaluated rate-headroom controller. Continue to apply worsening
course trend as full suppression of the small closure-earned posterior
residual, but multiply positive course-convergence amplification by both joint
rate headroom and a smooth normalized-distance gate. The distance gate is
effectively one far from the target and fades only within a candidate-owned
one-body-length approach scale. This separates broad-route correction from
terminal excess drive without a clock, coordinates, wake phase, or a hidden
mode.

The rollout falsifies the candidate if it loses `target_reached`, changes the
productive diagonal topology, arrives later than the prefill's `45.61`, raises
mean distance above the simpler positive-closure reference `1.724L`, or gives
back the rate-gated result's load reduction without an arrival/distance gain.
Even a positive fixed-snapshot result would not establish robustness to a
changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and terminal capture control
source_mechanism: preserve a low-dimensional propulsive rhythm while actuator headroom and target range schedule only an auxiliary route residual during final approach
transferable_invariant: retain the established traveling wave and necessary course suppression, but withdraw extra positive drive when normalized actuator use is high or normalized range is small
nontransferable_details: published gains, dimensional approach radii, species-specific envelopes, robot linkage limits, exact vortex phases, cylinder layouts, and task-specific routes
policy_translation: combine observed two-joint rate usage with `distance_L` to gate only positive bearing-convergence amplification of the closure-earned posterior residual; leave the base oscillator, lag, yaw-gated steering, negative course correction, and soft acceleration limit unchanged
falsification: reject if capture or diagonal self-propulsion is lost, arrival or mean distance regresses past the sampled references, or late load and cap symptoms remain without a compensating trajectory benefit
