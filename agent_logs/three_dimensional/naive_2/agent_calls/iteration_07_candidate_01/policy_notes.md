# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled rollouts and the assigned parent's inherited rollouts use
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot. In both rows of their combined sheets, a compact
  body-connected alternating wake propels the fish leftward through roughly
  `10--16T`; the motion is self-generated rather than advection or numerical
  instability.
- The ungated phase-compensated shared-half-cycle scaffold
  `solver_77835bec7423` is still the clean propulsion control: it reaches
  `3.174L` at `18.095T`, keeps a coherent wake through `27.429T`, has no
  same-side two-joint angle-limit dwell, and limits peak planar force to about
  `0.031` in the logged normalization. It passes about `3.16L` high and exits
  left, so the remaining far-to-middle defect is course interception rather
  than absent thrust.
- Three sampled proximity/carrier-relief variants improve the first-pass
  geometry but repeat one adverse semantic transition. Full-circle relief
  reaches `2.319L`, distance/target-plane hold reaches `2.703L`, and
  bend-released relief reaches `2.664L`; all then form a broad attached or
  separated turning sheet, curl upward, and exit the upper boundary. The first
  two dwell with both joints on the same `45 deg` limit for `12.2%` and `19.3%`
  of logged samples, while the bend release removes that dwell but regresses
  the miss and still exits upward. Their peak planar loads rise to about
  `0.49--0.71`. This rules out another scalar carrier-relief or stronger-turn
  edit.
- Phase-separating the target angle alone is also a concrete negative result:
  `solver_ec81137f627b` makes the beat-scale bearing more consistent but
  worsens closest approach to `4.650L` and exits upward earlier at `20.034T`.
  The sampled trajectories explain why. The body-frame bearing is dominated
  by beat yaw, whereas the rotation-invariant angle between target vector and
  translational velocity remains coherently wrong-sided through the approach;
  it directly represents the lateral collision-course miss that the angle-only
  controller does not correct.

## Single candidate hypothesis

Restore the clean ungated traveling-bend carrier, phase-compensated yaw
response, and shared half-cycle actuation. Add one velocity-course interception
mechanism: once self-propelled speed is observable and the fish is still moving
toward the target plane, blend from the inherited instantaneous body-bearing
and slip request to the signed, normalized angle between `target_body_L` and
`velocity_body_U`. Because both vectors are in the same body frame, this angle
is invariant to beat-correlated yaw without a clock or world route. When the
velocity no longer has a closing projection, the blend releases continuously
to the ungated scaffold rather than recruiting another terminal U-turn.

The candidate should retain the compact leftward wake while applying a
consistent correct-side half-cycle bias earlier than the `6L` proximity gates,
so its first pass should beat `2.319L` without same-side joint pinning or the
large load increase. It is falsified if course feedback creates an early loop,
fails to improve the `2.319L` minimum, repeats an upper-boundary exit, loses the
ungated scaffold's coherent propulsion, or raises joint/load occupancy toward
the carrier-relief failures. Capture or a better termination class with
preserved wake and loads is the intended semantic evidence; score alone is not.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and terminal target interception
source_mechanism: sensor feedback modulates a propulsive CPG through target-course error while releasing terminal authority when closing geometry is lost
transferable_invariant: separate rhythmic body yaw from slower route error by comparing the observed target vector with observed translational course, and preserve the posteriorly lagged carrier while that closing-course error selects beat-side asymmetry
nontransferable_details: published gains, robot linkage geometry, clocked CPG phase, species kinematics, dimensional speeds, exact vortex phases, maneuver duration, and task-specific routes
policy_translation: compute a bounded rotation-invariant course error from normalized `target_body_L` and `velocity_body_U`, blend it into the existing body-frame half-cycle request only at resolved speed and positive closing projection, and leave the two-joint carrier unchanged
falsification: reject if closest distance does not beat `2.319L`, the upper-exit topology or same-side angle dwell returns, pre-approach wake and speed degrade, or force, moment, rate, and action occupancy approach the carrier-relief failures
