# Wake-policy diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations use direct uniform still water with
  `U_infinity=0` and terminate in capture. The three water-relative policies
  reproduce the exact `23.864521T`, `0.749310L`, `2.192138L` mean-distance
  trajectory. The matched inertial-lateral-speed policy captures later at
  `23.985519T`, crosses at `0.749542L`, and has `2.202000L` mean distance.
  Replacing inertial sway by body-minus-local-water sideslip is therefore a
  composed semantic improvement over the assigned parent's speed-recovery
  controller, not evidence for a scalar gain change.
- In the top-down sheets, both variants self-propel along the established
  S-route and retain an alternating mid-plane vortex street from release to
  capture. The weaker inertial-sway example's oblique sheet shows discrete
  three-dimensional Lambda2 structures through capture. The three stronger
  examples have identical blank oblique sheets, so their numerical/top-down
  replication is a render artifact boundary and not new 3D-wake evidence.
- The stronger trace improves mean action slightly (`57.572` versus `57.594`)
  and near-`1.5L` mean action materially (`41.557` versus `43.334`), with peak
  normalized force `0.02948`, peak moment `0.01534`, and anterior/posterior
  rate-cap occupancy about `14.70/7.44%`. This preserves the inherited load and
  saturation envelope.
- The assigned-parent terminal response release had already falsified another
  near-field scalar gate. In the new strongest trace, the remaining useful
  intervention window is earlier: while full target error is below the
  redirect threshold, beat-scale water-relative sideslip can oppose the slow
  bearing command by order one and the top-down route still contains broad
  lateral S-bends. The successful posterior rudder establishes that the
  opposite posterior offset is the target-signed reactive-load direction.

## Candidate hypothesis

Preserve the reproduced speed-recovery carrier, water-relative anterior
curvature, phase-selective tail carrier, reactive rudder, and terminal relief.
Add one bounded `3 deg` posterior target residual equal to the difference
between the fluid-relative route request and the bearing-only request. Apply it
only while the existing full-angle redirect gate says the target is aligned,
then fade it out continuously before the proven large-error/near-target rudder
dominates. This separates fast translation disturbance rejection from slow
route geometry and changes an actuator pathway rather than retuning a scalar.
The recorded trace implies a maximum residual of about `3 deg`, mean absolute
offset about `0.62 deg`, and no activation after roughly `10.4T`.

Falsify the mechanism if evaluation loses capture; captures later than
`23.864521T`; raises mean distance above `2.192138L`; changes the established
preterminal route without shortening it; erases the alternating or 3D wake;
or worsens the `14.70/7.44%`, `57.572`, `0.02948/0.01534` saturation, action,
and peak force/moment reference envelope. A blank oblique sheet cannot verify
the wake criterion.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering and wake-disturbance rejection
source_mechanism: retain the propulsive rhythm while separating slow target-directed steering from a small bounded fast water-relative residual
transferable_invariant: a persistent body-frame route request and an alternating fluid-relative disturbance should enter distinct bounded feedback paths without suppressing the traveling carrier
nontransferable_details: published CPG gains, species kinematics, dimensional frequencies, exact vortex phases, and source-task routes
policy_translation: subtract the bearing-only turn from the water-relative turn, send only that residual through a small opposite-sign posterior target offset, and fade it out with the existing full-angle alignment gate
falsification: reject if it misses or delays the reproduced capture, worsens mean distance or the action/load/saturation envelope, changes the useful route adversely, or weakens the two-view wake
