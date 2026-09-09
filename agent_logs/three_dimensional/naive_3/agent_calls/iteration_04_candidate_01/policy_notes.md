# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance, both inherited worker notes, all four sampled
  solver evaluations, and the inherited parent rollout were read before this
  proposal. Each evaluated episode reports direct uniform quiescent
  initialization, `U_infinity=(0,0,0)`, zero cylinders, finite dynamics, and a
  lower virtual-domain exit. Their controller differences are therefore usable
  evidence rather than prewarm, advection, cylinder-wake, or moving-window
  differences.
- Both the top-down vorticity and oblique body/Lambda2 rows were inspected for
  every sampled combined keyframe sheet and for the inherited parent rollout.
  The strongest finite sample `solver_2e1178a92e4c` visibly self-propels
  left/down with a long alternating 3D wake, reaches `2.443L`, and then crosses
  below the target before exiting at `31.097T`. Near its closest approach the
  head speed remains about `0.68U`, whereas local flow is about `0.019U`; this
  is powered overshoot with a coherent wake, not passive transport or wake
  collapse. The other sheets retain the same broad topology and coherent wake.
- The latest architecture variants did not improve that topology. Full signed
  target direction (`solver_68aa0ab11610`) reaches `2.494L` and exits at
  `30.866T`; distance-conditioned carrier relief
  (`solver_f87cffca0d2b`) worsens the minimum to `2.845L`; inherited
  return-half-cycle braking (`solver_5f30fa72ea58`) reaches `2.501L` and exits
  earlier at `29.326T`. The toward-half-cycle boost comparator
  `solver_c48783322a44` is still worse at `3.587L`. Thus neither behind-target
  bearing disambiguation, blanket near-target energy reduction, nor either
  tested state-phased asymmetry resolves the lower-exit miss.
- The reusable defect is semantic. The fish head is aligned with body `-x`, so
  a positive body-frame bearing requires decreasing `theta`; negative measured
  heading rate is the response that reduces this error. At closest approach,
  however, all five relevant rollouts have positive bearing (`0.947--1.421`
  rad) and positive heading rate (`0.562--2.322` rad/T), meaning yaw is moving
  away from the target. The inherited expression
  `bearing - heading_rate_damping * heading_rate` reduces positive curvature
  during precisely that wrong-way response and reinforces it during a
  correct negative-rate response. This phase-correlated anti-damping is a
  stronger explanation for the large yaw oscillation and persistent overshoot
  than insufficient static curvature; prior `10--14 deg` variants already
  showed that more static bend can destroy the useful carrier.

## Policy hypothesis

Preserve the best sample's `7 deg` body-frame mean-curvature ceiling, anterior
state-feedback oscillator, alignment-gated posterior traveling wave, tail
lag, command reserve, and all active gains. Change one semantic mechanism:
form the steering error as `bearing + yaw_response_damping * heading_rate`.
With this coordinate-correct sign, negative yaw toward a positive-bearing
target releases the bend, while positive wrong-way yaw strengthens it. This is
rate feedback in target-error coordinates, not an increase in static curvature
or a scalar carrier retune.

Expected evidence is the same early self-propelled left/down route and coherent
alternating 3D wake, but smaller beat-scale yaw excursions, decreasing bearing
before the target passes abeam, and a minimum below `2.443L` without the prior
lower-boundary overshoot. Falsify the mechanism if the initial route or wake
collapses, yaw oscillation grows, correct negative heading rate is not released,
the minimum does not improve, or a tight-turn/actuator-residence failure
replaces the powered miss.

```text
bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG direction tracking
source_mechanism: use measured yaw response to modulate a target-driven rhythmic turning offset, releasing the turn only when the response reduces direction error
transferable_invariant: rate feedback must be signed in body-frame error coordinates and the actuator's observed yaw direction so that it damps, rather than reinforces, wrong-way rotation
nontransferable_details: published gains, robot geometry, clocked CPG phase, dimensional beat settings, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: retain the evidenced joint-state carrier and bounded bearing curvature, but combine body-frame bearing with heading rate using the head-along-minus-body-x sign convention; keep the posterior alignment gate and all authority limits unchanged
falsification: reject if beat-scale yaw grows, coherent propulsion or early target progress collapses, correct-sign yaw is not released, or the closest approach and lower-exit topology fail to improve
```
