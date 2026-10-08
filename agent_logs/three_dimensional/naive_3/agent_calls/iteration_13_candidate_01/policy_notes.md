# Body-frame velocity-course steering candidate

## Visual diagnosis and inherited evidence

- Every sampled solver and inherited evaluated rollout used direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. The observed translation and wakes are therefore self-propelled,
  rather than artifacts of ambient advection or moving-window transport.
- The sampled `2.989L` response-released parent is the strongest broad
  approach among the four solver examples. Its top-down row shows a coherent
  alternating vorticity street through the approach, and its oblique row shows
  persistent three-dimensional Lambda2 structures. Near the `2.989L` pass the
  controller settles toward nearly fixed joints (about `0,-12 deg`), the wake
  weakens, distance begins increasing, and the trajectory hooks into the upper
  boundary. Peak swimming speed is `1.032U`, versus only `0.032U` peak local
  flow, confirming that the failure is active course control rather than
  passive drift.
- The sampled anterior half-cycle stiffness variant is the informative visual
  failure. Although both visual rows retain alternating shedding, closest
  approach worsens to `4.859L`, peak speed drops to `0.947U`, and raw
  acceleration-envelope exceedance rises to about `53/64%` for joints 1/2,
  versus `34/45%` in the `2.989L` parent. This rejects another anterior
  phase-stiffness edit as the next architecture.
- The assigned-parent guidance and inherited results add three more negative
  controls: posterior lag modulation reached `3.532L`, counterstroke relief
  reached `2.978L`, and a receding-gated distributed coil reached `2.959L`;
  all retained the upper-boundary termination. Detecting a large target error,
  a counterstroke, or receding motion did not itself create corrective course.
- In contrast, an inherited evaluated speed-gated velocity-course policy kept
  the same zero-centered traveling carrier, produced coherent alternating
  top-down and three-dimensional wakes, and reached `0.857L` before a distinct
  left-boundary exit. Its peak swimming speed was `1.052U` while peak local
  flow was `0.031U`. At the closest pass, measured velocity was almost tangent
  to the target circle and the wrapped target-course error was still about
  `-1.42 rad`; raw acceleration-envelope exceedance was high (`58/68%`) and
  final distance was `8.909L`. Thus course-angle feedback is strong evidence
  for a better broad trajectory, but not evidence of terminal capture or low
  effort.

## Policy hypothesis

Preserve the anterior Van der Pol oscillator, posterior lag, damping, and
bounded mean-curvature actuator exactly. Change only the observation-to-turn
mapping: compare the full-quadrant body-frame target-ray angle with the
measured body-frame velocity-course angle, wrap their difference, and blend
continuously to target bearing while speed is too low for a reliable course.
This makes lateral drift an angular course error without introducing time,
memory, a world route, or another actuator mode.

The evaluated inherited instance is used as the candidate because it is the
only sampled mechanism to produce a sub-`1L` trajectory and a new exit
topology; unvalidated terminal overlays are deliberately excluded. Falsify
the transfer if the new evaluation loses the alternating 3D wake, cannot
reproduce a sub-`1L` pass, returns to the upper hook, or materially exceeds the
already high acceleration-limit occupancy. Even if reproduced, later work
must treat the `0.857L` tangent miss and `8.909L` final distance as evidence
that a separate terminal-authority hypothesis remains unproven.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical posterior traveling-wave propulsion
source_mechanism: close slow steering feedback around measured motion direction while preserving the rhythmic propulsive carrier
transferable_invariant: compare the body-frame target ray with actual swimming course and map only their bounded angular mismatch into curvature while retaining posterior lag for thrust
nontransferable_details: published gains, robot linkage geometry, species-specific gait envelopes, dimensional speeds, clock phase, exact vortex phase, and task-specific routes
policy_translation: form full-quadrant target bearing from normalized target_body_L, form course bearing from normalized velocity_body_U, wrap their difference, blend to target bearing only below measurable translation, and apply the bounded result through posterior mean curvature with the anterior oscillator unchanged
falsification: reject if the alternating 3D wake or broad approach degrades, raw acceleration-limit occupancy rises materially, closest distance does not reproduce the inherited sub-1L trajectory, or the common upper-boundary hook returns
```
