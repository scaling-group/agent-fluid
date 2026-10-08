# Phase 2 candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled diagnostics report `uniform_direct` initialization,
`U_infinity=(0,0,0)`, no cylinders, and moving-window transport. The combined
keyframe sheets were inspected in both their top-down vorticity and oblique
Lambda2 rows.

- The transferred traveling-wave seed is self-propelled and leaves a coherent
  alternating wake. It closes from `12.328L` to `4.780L`, then continues below
  the target and exits at `y=0.798L` after `27.49T`, at `9.709L` distance.
- The target-angle/observed-yaw response-gated redirect is the strongest
  sampled controller: it closes to `2.463L`, compared with `4.780L` for the
  seed, while preserving a coherent top-down and three-dimensional wake. It
  nevertheless sweeps past the target and exits at `x=0.795L` after `33.41T`.
  Near closest approach its speed is about `0.97L/T`, the reconstructed
  body-frame target is nearly lateral, and at least one raw acceleration
  command exceeds `1800 deg/T^2` in `95.7%` of trace rows (with a joint at the
  speed envelope in `21.2%`). This is evidence of excessive propulsive
  momentum and competing saturated actuation during the terminal turn, not a
  missing propulsive gait.
- Full planar velocity lead does not survive the evidence: its large curling
  trajectory reaches only `7.328L` before departing to the lower boundary at
  `15.024L`. Shared mean curvature is worse still, reaching only `12.281L` and
  exiting through the upper boundary at `7.71T`. Neither should replace the
  validated redirect/traveling-wave scaffold.

## Candidate hypothesis

Start from the sampled response-gated redirect, not the assigned velocity-lead
prefill. Add one continuous terminal maneuver gate based on normalized
distance, body-frame target angle, and measured closing speed. When the target
is close, substantially off-axis, and still closing, reduce only the carrier's
oscillation amplitude and frequency; retain the route and redirect curvature.
This separates thrust production from steering authority without a clock or a
memorized route. It should reduce overshoot and raw acceleration saturation
near the target while preserving the far-field closure already demonstrated
by the redirect policy. Falsify it if early closure degrades before the gate
becomes active, the wake loses its traveling-wave organization, closest
approach does not improve below `2.463L`, or the same left-boundary sweep
persists without materially lower terminal speed/effort.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: response-gated curvature redirect with a propulsion-to-maneuver transition
transferable_invariant: preserve a posterior-lag propulsive rhythm far from the target, but trade carrier thrust for bounded curvature while a large observed target error persists, then restore propulsion continuously as alignment or closure changes
nontransferable_details: published gains, species-specific C-start kinematics, dimensional beat frequencies, exact vortex phases, and prescribed routes
policy_translation: use distance_L, target_body_L, bearing/turn response, window_closing_speed_L, and joint state to reduce only the state-feedback carrier during a close off-axis maneuver while leaving target-signed redirect curvature active
falsification: reject if far-field progress changes before the terminal gate, the coherent wake collapses, action saturation or terminal speed is not reduced, or minimum distance and termination topology do not improve over the 2.463L left-domain sample
