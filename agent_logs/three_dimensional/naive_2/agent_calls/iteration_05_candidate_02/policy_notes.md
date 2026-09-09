# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- All four sampled solver evaluations and the assigned parent's inherited
  `solver_216823542249` evaluation report direct uniform still water
  (`U_infinity=(0,0,0)`), no cylinders, and no prewarm. The combined
  top-down/oblique sheets show body-connected alternating wakes, so the motion
  is self-propulsion rather than advection; none of the runs is numerically
  unstable.
- The prefilled fixed-authority body-slip policy `solver_77089a0404da` forms a
  coherent but increasingly broad wake while turning toward the upper
  boundary. It reaches only `11.347L` and exits there at `9.25T`. The inherited
  course-divergence policy is a stronger negative control: its top-down row
  shows an early wrong-way loop with little useful translation, and metrics
  agree (`12.071L` closest, `12.419L` final, upper exit at `8.69T`). Course
  residual reinforcement is therefore not retained.
- The strongest sample `solver_77835bec7423` visibly preserves a compact,
  coherent alternating top-down wake and body-connected oblique Lambda2
  structures for `27.43T`. Its phase-compensated response steering moves from
  `(21,14)L` to the target's x station, reaching `3.174L` at `18.09T`, a large
  improvement over every other sample and a boundary-topology improvement
  from upper exit to left exit. At closest approach the head is
  `(8.680,12.658)L`, still about `3.16L` above the target, while translational
  speed is about `0.98L/T`. It then continues past the target corridor and
  exits the left boundary at `27.43T` with distance back at `9.415L`. The wake
  and finite load trace remain coherent, so the immediate defect is approach
  overshoot with full carrier drive, not lost propulsion or instability.
- Broad carrier braking is not generally beneficial: the inherited
  rate-barrier experiment removed near-rate-limit occupancy but worsened
  closest approach from `9.759L` to `11.643L` and retained the upper exit.
  Any drive relief must therefore be confined to the already demonstrated
  approach region and must leave directional half-cycle authority intact.

## Single candidate hypothesis

Start from `solver_77835bec7423`, preserving its evidenced `0.55T`
traveling-bend carrier, posterior lag, phase-compensated yaw residual,
wrong-side-slip redirect, and smooth acceleration envelope. Add one continuous
approach-hold mechanism: use normalized distance and signed body-frame
longitudinal target projection to reduce only the symmetric carrier as the
fish enters the target region or has passed the target plane. Compute the
half-cycle steering term from the unrelieved carrier so directional authority
does not vanish with propulsion. The far-field policy is exactly the strong
sample, while near the target the lower carrier-to-steering ratio should slow
crossing and permit the sustained lateral correction that its `3.174L` miss
lacked.

Falsify this mechanism if closest approach does not improve below `3.174L`, if
the fish loses coherent targetward translation before the approach gate, if it
still crosses the target x station at high speed and exits left, or if the
relative steering term causes persistent hard-limit occupancy, load growth,
or wake collapse. Because this worker's CFD runs only after exit, these are
prospective tests rather than claimed outcomes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal target approach
source_mechanism: retain a rhythmic propulsive scaffold while observed approach state continuously relieves drive without removing the residual steering channel
transferable_invariant: after broad target-directed propulsion is established, proximity or target-plane overshoot should lower carrier-to-steering authority so inertia does not carry the swimmer through a narrow capture corridor
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, exact maneuver timing, vortex phase, and task-specific routes
policy_translation: use normalized distance and signed body-frame target x to schedule only the symmetric two-joint carrier while retaining phase-compensated body-frame half-cycle steering
falsification: reject if pre-approach translation degrades, closest approach fails to beat 3.174L, termination does not improve, or actuator and wake diagnostics worsen

## Dry validation only

The mandated guidance, lightweight Julia contract, and editable-boundary
checks pass; no CFD was run. All 23 direct `params.FIELD` references resolve
to fields returned by `target_policy_params()`. A 54,675-state grid spanning
joint state, target side, distance, lateral velocity, and yaw response produced
finite actions strictly inside the smooth `30 rad/T^2` envelope and exact
left/right reflection (maximum error `0.0`). The carrier scale is effectively
unchanged far away (`0.999999995` at `12L`), falls continuously to `0.675` at
the `5L` approach threshold and `0.355` at the prior `3.174L` closest state,
and remains `0.362` for a target one body length behind. These checks establish
schema, boundedness, symmetry, and gate semantics only; later CFD evidence must
decide the physical falsifiers above.
