# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and capture. The two duplicate prefill samples use
  the unguarded soft-envelope carrier: `16.943T`, mean distance `2.08985L`,
  peak self-propelled speed `1.393U`, and exact `260 deg/T` occupancy of
  `3.73/3.54%` for the two joints.
- I inspected both rows of the combined keyframe sheets for the best finite
  sample (bidirectional phase-local allocation, score `-0.204764`) and the
  weakest sampled one-way transfer (score `-0.208655`). From release through
  capture, both top-down rows show a persistent alternating red/blue street,
  while both oblique rows show compact three-dimensional Lambda2 structures
  behind the body. This is productive self-propulsion rather than still-water
  advection: peak body speed is `1.374U` and `1.383U`, versus peak sampled
  local flow of only `0.0313U` and `0.0315U`.
- The one-way posterior-to-anterior transfer removes exact speed contact but
  reaches capture at `17.060T` with mean distance `2.09311L`. The bidirectional
  transfer is better at `16.988T`, `2.08931L`, and zero exact speed contact,
  but its peak force/moment (`0.03634/0.01804`) exceeds both the unguarded
  carrier (`0.03609/0.01766`) and the one-way sample
  (`0.03546/0.01767`). It also remains slower than the unguarded carrier.
  Thus coherent wake preservation is already solved; cross-joint recovery of
  rejected positive work is not evidenced as free propulsion.
- The assigned-parent log adds another capture at score `-0.207180` and
  minimum distance `0.74510L`, but provides no trajectory, policy, or load
  diagnostics in this workspace. It supports the robustness of the capture
  family but cannot identify a reusable actuator mechanism.

## Policy hypothesis

Preserve the full unguarded velocity-course carrier, acceleration reserve,
soft acceleration envelope, and posterior angle stopping barrier. Add the same
local speed-viability projection to each joint after softening and before the
posterior angle barrier. When a joint is doing positive work inside the
evidenced thin shell above `0.94` normalized speed, cap only that outward
acceleration by a control-barrier bound proportional to its remaining
normalized kinetic-speed margin. Braking and every command below the shell
remain identical, and no work moves to the other joint.

The bound is calibrated continuously to equal the existing soft acceleration
ceiling at shell entry and to reach zero at the physical speed boundary. This
is a new state-space viability mechanism, not a carrier-gain change. It should
retain the alternating two-view wake and capture, eliminate exact speed
contact, avoid the transfer-induced load increase, and recover more of the
unguarded `16.943T/2.08985L` route than the inherited direct guard at
`17.115T/2.09800L`.

Falsify the hypothesis if evaluation loses capture or either coherent wake
view, touches `260 deg/T`, exceeds the unguarded `0.03609/0.01766` force/moment
peaks or the `0.95` acceleration ceiling, or fails to beat the direct guard's
arrival and mean distance. Even a safe capture would be a negative result if
the barrier merely reproduces the broader-guard route penalty.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control
source_mechanism: sensed state modulates a low-dimensional rhythmic command without replacing its traveling-wave phase
transferable_invariant: preserve the useful rhythmic carrier and alter only the locally constraint-violating part of its command using normalized feedback
nontransferable_details: published oscillator gains, clock phase, species kinematics, actuator units, and task routes
policy_translation: use normalized joint speed and command-power sign to project only positive-work acceleration near each speed boundary; leave braking, lower-speed carrier work, target-course feedback, and cross-joint phase untouched
falsification: reject if the projection loses capture or alternating 3D shedding, retains exact speed contact, adds load, or costs at least as much arrival and mean-distance performance as the inherited direct guard
