# Wake-policy candidate notes

## Visual and metric diagnosis

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion and
  wakes are policy-generated rather than ambient advection.
- The strongest sampled finite approach, `solver_e496ee6f6139`, reaches
  `2.989L`. Its top-down row shows a strong alternating signed-vorticity street
  through the broad approach, and its oblique row confirms persistent 3D
  Lambda2 structures through about `12T`. It then passes high, loses the
  organized wake, rotates nearly vertical, and exits the upper boundary at
  `23.43T`. The trace agrees: center y never falls below about `12.40L`, and
  joint rates have fallen to roughly `0.10/0.07 rad/T` by `20T`.
- The informative approach-hold failure, `solver_53a6ee05b4ed`, has the same
  early coherent wake but visibly weaker late shedding and an earlier inertial
  upper hook. It reaches only `3.592L`; by `20T` joint rates are about
  `0.004/0.010 rad/T`, while the body still coasts at about `0.75U`. This
  rejects added damping or carrier attenuation as a redirect mechanism.
- The continuously beating sampled allocation reaches `3.162L` and retains
  large joint rates at exit, showing that cycling alone is necessary but not
  sufficient. The assigned-parent logs sharpen the actuator boundary:
  close-pass tail half-cycle relief reaches `3.013L`, and a posterior
  target-side C-blend reaches `2.976L`; both retain rhythm but neither beats
  the unrelieved bearing/slip benchmark at `2.960L` or changes the
  `left_domain` class. Tail-only phase selection therefore changes effort or
  wave shape without supplying enough target-normal redirect.
- Instantaneous yaw response is not a reliable release signal here. On the
  unrelieved trace it is about `+2.8 rad/T` at `14T`, even though beat-scale
  mean heading falls from about `0.461` at `12T` to `0.233 rad` at `14T`, the
  wrong net direction for the then-negative full-quadrant error. A gate driven
  by raw heading rate can therefore release during the wrong mean turn.

## Policy hypothesis

Keep the evidenced bearing-minus-body-slip posterior curvature and the full
lagged carrier, but recover full-quadrant target direction from normalized
`target_body_L`. When full-quadrant error is material, use joint-state phase to
reduce anterior restoring stiffness only on the target-supporting half-cycle.
This lengthens that half-cycle and sends a directional asymmetry into the
unchanged posterior lag without shifting either equilibrium, adding damping,
amplifying raw acceleration, using a clock, or relying on noisy instantaneous
yaw response. Alignment itself releases the maneuver.

An offline algebra replay on the unrelieved recorded states makes the proposed
relief greater than `0.01` in about `54.7%` of samples after `12T`, first at
about `12.32T`. On those fixed states the anterior raw-acceleration
over-envelope fraction after `12T` projects from `67.7%` to `62.9%`; this is a
bounded command audit, not a closed-loop trajectory prediction.

The rollout should retain the early alternating 3D wake, sustain nonzero joint
cycling through the redirect, and create more downward target-normal motion
before or after the high pass. Falsify the mechanism if motion changes before
the full-quadrant error gate, either joint converges to a static posture,
actuator-limit occupancy rises materially, or it fails to beat the `2.960L`
reference or improve the repeated upper-exit topology.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: observed direction error changes the relative duration or strength of the two beat half-cycles while the propulsive oscillator continues
transferable_invariant: preserve the traveling carrier, use signed body-frame target error to favor only the target-supporting half-cycle, and release the asymmetry on recovered alignment
nontransferable_details: published gains, duty ratios, dimensional cadence, species-specific amplitudes, exact vortex phases, and task-specific routes
policy_translation: derive a bounded full-quadrant bearing/slip turn request from normalized target geometry and body velocity, then reduce zero-centered anterior restoring stiffness only when joint-state phase is on the requested side; leave the posterior lag target unattenuated
falsification: reject if the far-field carrier changes before material error, alternating wake or joint cycling collapses, acceleration-limit demand increases, or closest approach and the upper-boundary exit fail to improve on the unrelieved reference
