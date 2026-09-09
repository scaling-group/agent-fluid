# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- The assigned parent guidance and inherited optimizer logs preserve the
  common `0.55T`, joint-state Van der Pol carrier and identify bounded
  half-cycle asymmetry as the first steering mechanism that improves target
  progress without erasing the traveling bend.  They also record a concrete
  negative result: static/mean-curvature variants, especially equal bias on
  both joints or a slower carrier, weakened translation or made a large
  wrong-way loop, so longer survival alone is not evidence of useful control.
- All four current sampled rollouts satisfy the direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no prewarm, no cylinders).  The top-down
  sheets show self-propelled leftward motion, increasingly curved alternating
  wakes, and an upper-boundary exit while the target remains below-left.  The
  oblique sheets confirm body-connected three-dimensional Lambda2 structures
  behind the posterior body and tail; none of the apparent translation is
  background advection.
- The strongest finite sample, `solver_77089a0404da`, uses bearing/slip-driven
  half-cycle asymmetry on both joints.  It moves the center `2.041L` left,
  improves distance from `12.328L` to `11.347L`, and limits logged joint
  acceleration to about `30 rad/T^2`.  This materially beats the prefilled
  posterior mean-curvature failure `solver_4b909c5b2efc`, which moves only
  `1.056L` left and reaches `12.056L`.  The other tail-only half-cycle samples
  lie between them at `11.670L` and `11.867L`, so the reusable signal is the
  mechanism/ranking rather than a scalar score alone.
- No sampled controller changes the termination class: all drift about
  `1.20L` upward and exit the upper virtual boundary near `9T`, and all still
  reach the `260 deg/T` joint-rate limit.  In the best trace, body-frame
  bearing changes from `+0.155` initially to about `-0.157` at `4T` and
  `-0.586` at `8T`; at `8T` body-frame lateral velocity has the opposite sign
  (`+0.364U`).  Thus the controller can reverse its route request after the
  line of sight crosses, but its fixed `0.35` half-cycle authority cannot
  arrest a later wrong-way lateral response before exit.

## Single candidate hypothesis

Start from the evidenced two-joint half-cycle controller, retaining its
carrier, posterior emphasis, slip damping, and smooth acceleration envelope.
Add one response-gated redirect mechanism: use the reflection-invariant
product `-bearing * lateral_velocity` to detect motion away from the current
body-frame target side, and continuously raise the half-cycle asymmetry limit
only during that condition.  Correct-side motion retains the sampled
`0.35` cruise authority; wrong-side slip can approach a stronger but still
sub-unity redirect authority, so the opposite half-cycle and traveling wake
remain present.  This is falsified if the same upper-boundary exit persists
without a meaningful horizon or closest-approach gain, if the redirect raises
joint-limit occupancy or loads, or if leftward propulsion and the coherent
alternating wake collapse.

```text
bookshelf_consulted: true
source_domain: biological burst redirect and robotic-fish CPG asymmetric flapping with sensor feedback
source_mechanism: preserve a propulsive rhythm at normal authority, but temporarily strengthen its turn-producing half-cycle when observed motion diverges from the requested target side
transferable_invariant: normalized body-frame target error and measured lateral response can gate stronger bounded steering without a clock, route, or prescribed vortex phase
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific C-start kinematics, duty ratios, exact vortex phases, and task-specific routes
policy_translation: retain the sampled bearing-minus-slip half-cycle law and smoothly schedule its asymmetry ceiling from cruise to redirect using positive normalized wrong-side slip `max(-bearing*lateral_velocity, 0)`
falsification: reject if termination topology and closest approach do not improve together, or if propulsion, wake coherence, actuator occupancy, or load histories deteriorate
```

## Dry validation (not rollout evidence)

The mandated guidance, policy-contract, parameter-schema, and editable-boundary
checks pass.  A grid over joint state, bearing, and lateral velocity gives
exact left/right reflection to floating-point precision (`max_error=0.0`),
finite outputs, and a maximum returned acceleration below the configured
`30 rad/T^2` smooth envelope.  For bearing `+0.6`, the redirect gate is zero
for correct-side velocity `+0.4U` and rises monotonically through
`0.635/0.905/0.995` for wrong-side velocities `-0.1/-0.2/-0.4U`; the maximum
asymmetry remains `0.65 < 1`, preserving a nonzero opposite half-cycle.  These
checks cannot establish hydrodynamic improvement; the next CFD evaluation
decides every trajectory and wake falsifier above.
