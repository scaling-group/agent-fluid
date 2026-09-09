# Candidate diagnosis and hypothesis

## Prior evidence

- All four sampled evaluations report `uniform_direct` initialization with
  background velocity `[0,0,0]`; the evidence is the intended still-water
  contract, not a prewarm artifact.
- In both rows of the combined sheets, every policy self-propels and sheds an
  alternating wake. The parent (`solver_d282288428b4`) keeps the narrowest,
  longest coherent top-down street and persistent oblique Lambda2 loops. It is
  therefore a finite propulsive reference, not an advection result.
- That parent has the best score (`-10.6247`) and closest approach (`4.9765L`),
  but the closest row occurs at `t=21.934T`, head `(9.427,14.458)L`: it reaches
  the target's streamwise station while still about `5L` high. It then leaves
  at center `(2.225,15.201)L`, with final distance `9.2490L`. Its differential
  turn-rate servo touches the velocity limit on `35.9%` of rows and exceeds
  the raw acceleration envelope on `99.0%`, so its long coherent wake does not
  establish usable lateral tracking.
- The anterior-centered sample (`solver_f0a5c173df3d`) visibly rolls its wake
  through a broad downward redirect and reaches `8.1745L`, but it never
  releases that turn and exits the lower boundary. The posterior-only samples
  (`solver_c24e37740d95`, `solver_4d290a0c05f4`) turn in the opposite, calibrated
  yaw direction but sweep into the upper boundary in about `10T`. Together
  these runs show that joint allocation and turn release, not more propulsion,
  are the unresolved mechanisms.

## Candidate policy hypothesis

Preserve the seed's anterior joint-state oscillator and posterior lag. Use
normalized body-frame bearing to request posterior mean curvature, whose yaw
sign is established by both posterior-only samples. Gate—not reverse—that
curvature when the measured turn rate already has the bearing-correcting sign.
This differs from the parent servo: beat-scale yaw can reduce a correct route
request but cannot flip it into a wrong-way request. Apply a smooth output
limit at the known acceleration envelope so the controller does not depend on
the downstream hard clip for nearly every row.

Expected result: retain an alternating propulsive wake, avoid the parent's
rapid sign chatter and upper-lane straight-through topology, and move the
closest-approach head position materially toward the target's `y` station
without repeating the anterior-biased lower exit. The mechanism is falsified
if posterior steering still exits high before improving the `4.9765L` minimum,
if release produces the lower-boundary sweep, if wake coherence/streamwise
progress collapses, or if velocity contact remains comparable to the parent's
`35.9%` despite bounded raw commands.

bookshelf_consulted: true
source_domain: biological fast-start turning and robotic-fish mean-curvature control
source_mechanism: a large geometry error requests bounded curvature, then observed correct turn response releases the redirect into the traveling gait
transferable_invariant: preserve the propulsive rhythm while target geometry selects turn sign and sensed response monotonically releases rather than reverses the steering bend
nontransferable_details: species kinematics, published gains, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: normalized body-frame bearing drives a bounded posterior bias; the product of bearing sign and recent body turn rate supplies a one-way release gate, with joint-state phase and lag unchanged
falsification: reject if the same upper exit and lateral miss persist, if the controller sweeps through into the lower exit, if the coherent wake or distance progress collapses, or if actuator contact remains persistent
