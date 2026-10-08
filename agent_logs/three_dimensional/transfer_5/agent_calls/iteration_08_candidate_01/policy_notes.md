# Dissipative terminal-yaw direction candidate

## Visual and quantitative diagnosis before editing

- All four sampled rollouts are valid direct-uniform still-water evaluations:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, stable dynamics,
  and capture. In the combined sheets, the top-down rows show self-propelled
  broad target-directed arcs with strong alternating wakes, while the oblique
  rows confirm coherent three-dimensional paired structures through capture.
  The v24 phase-demodulated controller and the v25 direction-consensus
  controller preserve the same useful visual topology; their terminal change
  is below keyframe resolution.
- The strongest progress sample is phase-demodulated v24
  (`solver_8ce1bc88a53c`): capture at `23.8315T` and mean scoring distance
  `2.434073L`. The assigned-parent v25 consensus candidate
  (`solver_3b3fa6c1a86f`) still captures, but is later at `23.8590T` with mean
  distance `2.434115L`. Its peak absolute yaw falls only from `3.208` to
  `3.176 rad/T`; inside `3L`, mean absolute yaw (`1.683` versus `1.684 rad/T`),
  target-transverse speed (`0.238` versus `0.239U`), lateral load (`0.01177`
  versus `0.01180`), and yaw moment (`0.00638` versus `0.00640`) are effectively
  unchanged. Suppressing the small counter-bend whenever course and yaw cues
  disagree therefore did not deliver the predicted joint terminal cleanup.
- The informative mechanism-level failure comparator is the v23 approach
  allocator (`solver_8c3d920cc8a5`). Its two visual rows also retain a coherent
  carrier and capture, and it has lower peak/inside-`3L` yaw
  (`2.967/1.585 rad/T`), but it arrives later (`23.9250T`) with worse mean
  distance (`2.435081L`). Reserving acceleration authority is a genuine
  speed-versus-control trade, not evidence for replacing or weakening the
  carrier. The inherited semantic failure boundary remains stronger:
  opposite-sign static-posture replacements produced weak-wake upper exits,
  so the successful carrier and C-bend polarity must be preserved.
- The current comparison isolates the unresolved issue as direction selection,
  not terminal-residual magnitude. V24 used carrier-rejected yaw only as an
  unsigned magnitude and could reinforce yaw during cue conflict; v25 avoided
  reinforcement by setting the residual to zero, but consequently supplied no
  damping during those same near-capture conflicts.

## Policy hypothesis

Use the evaluated v24 phase-demodulated controller as the sole carrier and
retain its traveling-wave oscillator, same-sign redirect, response release,
carrier rejection, terminal residual magnitude, and smooth acceleration
projection. Change only the residual's direction arbitration: target-relative
course error supplies a bounded urgency magnitude, while signed
carrier-rejected excess yaw supplies the direction that opposes rotation. Thus
the residual preserves v24 exactly when cues agree and becomes a yaw-dissipating
counter-bend, rather than zero or yaw-reinforcing curvature, when they conflict.

Expect capture and coherent wake topology to survive, with peak and near-target
yaw/load below v24/v25 while retaining arrival near `23.83T` and mean distance
near `2.4341L`. Falsify the mechanism if capture is lost, arrival exceeds
`23.9T` or mean distance exceeds `2.435L` without a material yaw/load benefit,
or if wake coherence, target-transverse motion, joint-speed exposure, or command
exposure regresses.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: terminal fish capture control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a stable propulsive rhythm while bounded near-field feedback damps route-scale yaw and slip rather than beat-synchronous motion
transferable_invariant: separate the propulsive carrier from terminal feedback and require the terminal curvature residual to oppose observed excess yaw without removing course sensitivity
nontransferable_details: published gains, dimensional cadence, robot linkage kinematics, species-specific envelopes, exact vortex phase, and prescribed source-task routes
policy_translation: carrier-rejected target-transverse speed sets bounded terminal-correction magnitude, while signed carrier-rejected yaw sets its dissipative direction before the existing two-joint C-bend and smooth command projection
falsification: reject if capture or alternating-wake coherence is lost, or if arrival, distance integral, terminal yaw/course, loads, joint speed, or command exposure do not jointly justify the yaw-dissipating branch
```
