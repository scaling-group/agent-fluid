# Multi-wake target-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet shows the fish held at the upper-right release
  point, outside the interacting four-cylinder wake core, with the target
  diagonally upstream and below. This is common initial-condition evidence.
- The target-blind seed is the only sampled policy that visibly self-propels
  upstream: it moves its head `-3.545L` in x and `-13.300L` in y over
  `50.127` release-time units. Its active traveling bend nevertheless curls
  into a near-vertical descent, reaches only `8.615L` minimum target distance,
  and exits through the lower boundary. Both joint speed and acceleration hit
  their hard caps, so its propulsion is useful but inefficient and
  directionally uncontrolled.
- Three independently proposed body-frame mean-curvature variants all replace
  that upstream motion with the same early downstream-exit topology. They last
  only `17.04--18.11`, move about `+2.17L` in x, never improve on the initial
  `12.424L` distance, and have mean x velocity `0.122--0.129`, close to their
  mean local x flow `0.130--0.145`. Their much lower command-energy means
  (`12.8--75.2`, versus the seed's `1496.2`) and released sheets indicate
  advection with weak gait authority, not target-directed swimming. This
  falsifies the inherited assumption that shifting both joint equilibria is a
  safe way to preserve the seed's traveling bend in this lane.
- The inherited worker notes all anticipated that static recentering might
  destroy propulsion and required a different primitive if that occurred.
  The completed results now meet that boundary. There is no evidence yet for
  a calibrated flow-, force-, or moment-rejection sign, so this candidate does
  not add a wake residual.

## Policy hypothesis

Restore the seed's demonstrated state-feedback propulsive scaffold unchanged,
but steer with bounded posterior half-cycle asymmetry instead of static joint
curvature. Body-frame bearing selects left/right turn direction; joint-1 angle
and velocity retain the autonomous oscillator phase; and the lag-generated
total tail-tangent wave supplies the observed beat side. Strengthening one
posterior half-cycle while weakening the other creates a target-dependent mean
turn without moving the oscillator equilibrium or erasing its traveling wave.

The lane's body convention points forward along local `-x`, so positive
`bearing` places the target on the swimmer's right; the diagnostic turning
convention labels a positive tail-half-cycle bias as left. The translation
therefore negates bearing when forming turn direction. It uses no world
coordinate, route, clock, cylinder identity, or external vortex phase.

Expected evidence after evaluation is retained upstream x displacement plus a
shallower, target-directed descent that survives beyond the seed's `50.127`
and improves its `8.615L` closest approach. Falsify this transfer if x motion
again follows the downstream flow, the lower-boundary exit is unchanged, the
turn goes away from decreasing bearing, or the asymmetric tail merely raises
cap occupancy/load without changing trajectory topology.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: target-error-dependent half-cycle amplitude asymmetry on a propulsive tail beat
transferable_invariant: preserve the zero-centered anterior rhythm and posterior phase lag while bounded directional error strengthens one observed posterior half-cycle and weakens the other
nontransferable_details: published gains, robot or species kinematics, dimensional beat frequency, prescribed CPG phase, exact vortex phase, and task-specific routes
policy_translation: map dimensionless body-frame bearing to signed turn demand, infer beat side from the normalized lag-generated tail tangent, and smoothly modulate that tail tangent before converting it back to the second incremental-joint target
falsification: reject if upstream propulsion disappears, turn direction is wrong, closest approach does not beat `8.615L`, lower-boundary exit persists without a useful trajectory change, or load and saturation increase without target progress
