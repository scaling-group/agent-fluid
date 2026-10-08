# Speed-envelope-compatible capture candidate

## Visual and metric diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, finite dynamics, and
  `capture`. Three are byte-identical evaluations of the assigned
  mean-preserving yaw demodulator and capture at `0.747896L` and `16.631994T`
  with score `-0.118307`. The fourth is the one-line raw-`q1` demodulation
  control; it also captures, at `0.747714L` and `16.637493T`, with score
  `-0.119674`. There is no semantic failure in the assigned sample, so the
  raw-`q1` capture is the only informative controlled comparator rather than
  a fabricated failure case.
- I inspected both rows of the combined keyframe sheets for a best replicated
  mean-preserving capture and the distinct raw-`q1` control. Both top-down
  rows show self-propelled targetward translation and a coherent alternating
  vorticity street, while both oblique rows retain finite, tail-connected 3D
  Lambda2 structures through the target crossing. The nearly coincident arcs
  and wake class agree with the small metric difference: the route and
  traveling-wave carrier are already useful and should not be replaced.
- The trajectories and diagnostics preserve the assigned parent's narrow
  advantage. Relative to raw-`q1`, mean-preserving demodulation reduces the
  scored distance integral from `2.003406L` to `2.001992L`, maximum joint
  magnitudes from approximately `0.5500/0.5603 rad` to
  `0.5477/0.5557 rad`, and peak planar force/moment from
  `0.036873/0.018564` to `0.036777/0.018272`. The three exact replications
  make fixed-case capture deterministic evidence, not held-out robustness.
- A remaining actuator mismatch is repeated in both policies. In the best
  capture, at least one joint is exactly at the `260 deg/T` speed clamp while
  its returned acceleration points farther outward during `23.45%` of logged
  steps (`9.33%` for joint 1 and `14.12%` for joint 2). The raw-`q1` control
  has the same `23.40%` pattern. The released integrator clips the next joint
  speed, so those commands cannot change the feasible next speed. On an
  algebra-only replay of the incumbent trace, deleting only those commands
  lowers mean absolute requested acceleration from `22.77/25.43` to about
  `21.54/22.40 rad/T^2`; this establishes signal scale and redundancy only,
  not counterfactual CFD performance.
- Inherited logs rule out broader effort interventions: whole-wave relief,
  startup carrier recruitment, and added terminal mean curvature all lost the
  useful route or worsened joint/load behavior. The next test must therefore
  leave the full carrier, phase-selective steering, mean-preserving yaw
  response, and all evaluated gains unchanged.

## Single policy hypothesis

Preserve the evaluated mean-preserving capture policy exactly through its
smooth acceleration limiter. Add one state-feedback feasibility projection at
the public output: if a joint is already at its declared speed boundary,
return zero only for acceleration directed farther outside that boundary;
pass inward/reversal acceleration and every command inside the boundary
unchanged. Both the speed reference and acceleration limit remain owned by
`target_policy_params()`.

This is a two-joint, normalized joint-state mechanism with no time, route
memory, or case identity. Because the released actuator already clips outward
speed, the projected command should reproduce capture and the connected wake
while eliminating commands that the actuator cannot realize. Falsify the
candidate if capture, arrival, distance integral, target-crossing arc, joint
history, or wake topology changes materially, or if reversal is delayed,
joint-limit contact appears, or force/moment rises. Do not generalize this
test into lowering carrier acceleration before the speed boundary; inherited
wave-relief and startup results contradict that broader intervention.

bookshelf_consulted: true
source_domain: low-dimensional robotic-fish CPG control and traveling-wave reactive propulsion under bounded actuation
source_mechanism: retain the rhythmic traveling-bend carrier while applying feedback through a distinct bounded correction compatible with the actuator envelope
transferable_invariant: preserve feasible carrier and steering motion and remove only joint commands that point outward at an already-active speed constraint
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, waveform envelopes, exact vortex phases, maneuver timing, and task-specific routes
policy_translation: use normalized two-joint angle/velocity feedback and the parameter-owned speed boundary to project only outward acceleration at the active boundary, after the established body-frame route and carrier command is formed
falsification: reject if capture or the connected wake fails to repeat, the targetward arc or reversal timing changes materially, or joint contact, force, moment, speed residence, or feasible acceleration effort worsens

## Evaluation boundary

No CFD outcome is claimed for this child. Its later evaluation should compare
capture and arrival first, then scored and observed distance integral, exact
target-relative trajectory, time at each speed boundary, outward command
residence there, mean/RMS feasible acceleration, reversal timing, joint
contact, peak planar force/moment, and both wake rows against the three exact
completed mean-preserving captures. A changed actuator model or a held-out
pose/flow is outside the evidence currently available.
