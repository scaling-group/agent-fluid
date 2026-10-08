# Terminal yaw-response release candidate

## Prior evidence and visual diagnosis

- All four sampled episodes are valid direct-uniform still-water rollouts and
  terminate in capture at `16.0544815T` after `2919` steps and `239` moving-
  window shifts. There is no sampled failure in this workspace, so the useful
  contrast is the one structurally distinct capture against the three
  byte-identical assigned-parent captures.
- In both combined sheets, the top-down row shows self-propelled translation
  along a finite target-directed arc with a coherent alternating vorticity
  street; it does not look like passive advection. The oblique row shows
  repeatable compact three-dimensional Lambda2 structures shed behind the
  caudal region, with no visible loss of wake coherence or instability before
  capture. The distinct terminal-release sheet is visually indistinguishable
  at keyframe scale from the assigned parent, consistent with a localized
  terminal control change rather than a new cruise route.
- The three assigned-parent copies reproduce score `-0.048654057`, final
  distance `0.747530460L`, and distance integral `1.931256928L`. The sampled
  terminal response release changes posterior action from about `1.51L`, keeps
  every `8/6/4/2/1.25/1.0/0.9/0.8L` milestone and capture time unchanged, and
  improves score to `-0.048054833`, final distance to `0.746954501L`, and
  distance integral to `1.930772896L`. Mean absolute posterior acceleration
  falls slightly from `24.6164` to `24.5998 rad/T^2`; acceleration- and speed-
  limit residence are unchanged. The improvement is therefore a small but
  measured terminal-geometry effect, not evidence for broad gain escalation.

## Policy hypothesis

Adopt the sampled response-conditioned release as the sole controller change.
Preserve the route-improving carrier-residual yaw correction in cruise, but
continuously release only its supplemental posterior mean curvature when the
fish is closing inside the predicted capture corridor and measured normalized
yaw is already target-signed. Keep base redirect curvature, posterior wave
relief, anterior corridor release, oscillator, and exact-limit projection
unchanged. This should retain the replicated carrier and all approach
milestones while avoiding a small amount of redundant terminal oversteer.

Falsify the candidate if formal evaluation loses capture or coherent wake,
changes any pre-approach milestone, worsens distance integral/final crossing,
or increases joint/load limiting enough to outweigh the terminal benefit. The
new candidate's outcome is not available to this worker and is not claimed as
evidence here.

## Bookshelf transfer

The later-iteration mandatory re-consultation trigger is not present: the
sampled terminal response release is a new controller mechanism with a
measurable useful trajectory change. The shelf was nevertheless consulted as
required by the task protocol, after reading the current visual and numeric
evidence, and its closed-loop modulation invariant supports the selected edit.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and terminal capture control
source_mechanism: sensor feedback modulates a residual steering command while retaining the rhythmic locomotor carrier
transferable_invariant: release only supplemental steering when body-frame target geometry and measured response agree that the commanded turn is already being achieved
nontransferable_details: published gains, oscillator frequencies, robot morphology, species kinematics, exact wake phase, and source-task routes
policy_translation: multiply only the yaw-residual posterior-curvature branch by a smooth closing-corridor and target-signed-yaw release; leave the two-joint carrier and evidenced base steering intact
falsification: reject if capture, pre-approach milestones, or two-view wake coherence regress, or if distance integral, final crossing, saturation, or loads worsen
```
