# Course-conditioned approach energy candidate

## Visual and trace diagnosis before the edit

- All sampled rollouts and the inherited step-8/9 evaluations report the
  contract-valid direct-uniform still-water initialization
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm). In every combined sheet,
  the top-down row shows a body-attached alternating vorticity street and the
  oblique row shows a three-dimensional Lambda2 trail. Translation is therefore
  self-propelled behavior, not background advection or moving-window transport.
- The assigned parent, `solver_b6ed3f84ab58`, preserves propulsion but its
  posterior half-cycle redistribution makes visibly large wake structures,
  reaches only `5.386L`, and exits through the upper margin at `26.043T`.
  Inherited diagnostics place its peak planar force/yaw moment near
  `0.211/0.0968`, about ten times the long redirect class, with roughly
  `50.6%/47.1%` speed/acceleration-cap residence and an angle-boundary touch.
  Instantaneous posterior headroom is therefore not a safe route to more
  approach authority; that mechanism is discarded.
- `solver_8097d423c0eb` is the strongest sampled semantic trajectory. Its two
  visual rows retain a coherent wake for `40.029T`, visibly descend through the
  target corridor, and then depart left. It reaches `0.829828L`, just
  `0.079828L` outside capture, but crosses the target's `x` station at
  `(8.998,11.047)L`, about `1.55L` high. From `5L` through closest approach its
  planar speed stays about `0.64--0.67L/T`; at the minimum, speed is
  `0.659L/T`, projected miss is `0.807L`, and body-frame lateral slip is about
  `0.60` of speed while the target lies on the opposite lateral side. Thus the
  remaining failure is a fast oblique skim, not loss of wake or wrong broad
  turn sign.
- The inherited completed variants bound steering-only changes. Terminal
  redirect-frequency scheduling reached `0.870123L`, middle-range posterior
  counterstroke recovery reached `0.895724L`, and predictive redirect entry
  reached `0.926872L`; the terminal release veto itself was indistinguishable
  in topology from the `0.8307L` bend-attainment baseline. All still approach
  near `0.65L/T` and leave left. These negative results reject another
  redirect-strength, entry, release, frequency, or posterior phase-stroke edit
  as the next isolated mechanism.

## Policy hypothesis

Recover the evidenced bend-attainment controller: its state-feedback traveling
carrier, posterior lag, calibrated body-frame steering side, bounded same-sign
redirect, and union of phase-rejected yaw and two-joint bend release. Remove the
ineffective terminal release veto. Add one separate approach-energy semantic:
while the target is in a smooth middle/near body-length band, measured closing
speed is positive, and the body-frame velocity/target projection remains
outside a capture-width corridor, continuously reduce only the anterior
phase-pump energy. The underlying Van der Pol restoring carrier, posterior
traveling-wave follower, half-cycle steering, and redirect branch remain
active, so this is drive relief rather than a stop, coast, or additional bend.

The expected evidence is an unchanged far-field wake and downward corridor,
followed before `2.25L` by lower planar speed and smaller carrier oscillations
that give the established redirect more translational time to cross within
`0.75L`. Success is capture. A useful partial result must beat `0.829828L`,
lower the approximately `1.55L` high crossing, or materially reduce approach
speed without restoring the high-corridor latch. Falsify the mechanism if the
same `0.83--0.93L` skim remains, propulsion collapses, the approach rises,
joint-angle contact appears, or wake coherence, load scale, and actuator-limit
residence worsen relative to the long redirect class.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and fish-inspired terminal capture scheduling
source_mechanism: modulate rhythmic propulsion energy from sensed approach outcome independently of the target-directed turning channel
transferable_invariant: when broad steering is correct but a closing swimmer retains a projected miss and excessive translational speed, approach feedback may reduce propulsive excitation while preserving the state-feedback rhythm and existing redirect authority
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species-specific cadence and amplitude, exact vortex phases, world coordinates, capture route, and numerical distance thresholds
policy_translation: use normalized body-frame target and velocity to form projected miss, combine it continuously with normalized range and positive observed closing speed, and apply the bounded gate only to anterior phase-pump excitation while leaving two-joint steering and redirect feedback unchanged
falsification: reject if the pre-target crossing does not move toward capture, if speed does not fall during the gated approach, or if the carrier, wake coherence, load exposure, angle clearance, or actuator-limit residence deteriorates

## Non-CFD implementation audit

Direct zero-speed and mirrored-state calls are finite, bounded, and exactly
reflection-equivariant. Replaying this candidate and the bend-attainment
baseline on frozen `solver_8097d423c0eb` observations gives exactly zero
command difference at and beyond `5L`. The course-conditioned drive relief is
active from about `19.008T` through `26.884T`, changes one acceleration
component by at most `1.925 rad/T^2`, and leaves frozen-state acceleration-clamp
incidence unchanged (`2938` component samples for each controller). These
checks establish locality, activity, boundedness, and symmetry only; they do
not predict the unevaluated fluid response or claim improvement.
