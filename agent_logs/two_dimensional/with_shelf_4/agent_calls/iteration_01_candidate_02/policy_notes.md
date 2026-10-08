# Wake-policy candidate notes

## Evidence read before editing

- Assigned parent guidance describes the common candidate as a deliberately
  target-blind state-feedback oscillator with a lagged posterior target. No
  inherited `logs/optimize/` evidence was present in this fresh workspace.
- The only sampled rollout (`solver_d75a6f27ac14`) is therefore both the best
  available finite trajectory and the informative failure; no successful or
  horizon-completing comparator is available. It terminated `left_domain`
  after only `50.1269` released time units.
- The shared prewarm sheet shows the held fish outside the developed
  four-street wake, initially pointing generally toward the target. In the
  released sheet it actively bends at high amplitude, rotates nose-down, and
  traces a steep path through the lower-right flow rather than entering the
  second-row target region. The motion is self-actuated rather than passive
  wake advection, but its lateral component is not productive.
- Metrics support that reading: head displacement was `(-3.545, -13.300)L`,
  mean velocity was `(-0.0725, -0.2633)`, closest distance improved to only
  `8.615L` before final distance regressed to `12.123L`, and both joint speed
  (`4.5379 rad/time`) and acceleration (`31.4159 rad/time^2`) reached the
  configured `260 deg/time` and `1800 deg/time^2` caps. RMS lateral force
  `21.943` and yaw moment `541.704` accompany the escape. Nonzero upstream
  displacement is therefore evidence that the oscillator moves the fish, not
  that it supplies navigation.

## Policy hypothesis

Preserve the autonomous traveling-bend scaffold, but center it on a bounded
mean-curvature request computed from body-frame target bearing. Centering the
head oscillator and lagged tail target at the position level gives steering a
meaningful setpoint even when raw accelerations clip, while keeping target
tracking separate from oscillator phase. Use only current bearing and joint
state: no wake phase, cylinder coordinate, target identity, elapsed time, or
route is encoded. The candidate is supported if it turns in the bearing's
correct sign, avoids the immediate lower-domain escape, preserves upstream
motion, and improves survival/target-distance topology. Falsify it if the turn
sign is wrong, the traveling bend loses propulsion, joint-cap occupancy stays
dominant, or the same lateral exit recurs.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and mean-bias turning layered on rhythmic CPG propulsion
source_mechanism: sensor-driven bounded mean-curvature bias superposed on a traveling body wave
transferable_invariant: persistent target-relative lateral error should shift the mean bend without replacing the propulsive rhythm
nontransferable_details: published gains, robot geometry, species kinematics, dimensional beat settings, exact vortex phase, and source-task routes
policy_translation: map dimensionless body-frame bearing through a bounded nonlinearity to first- and second-joint curvature centers while retaining joint-state oscillator phase and posterior lag
falsification: reject if correct-sign target turning, domain survival, and target progress do not improve together, or if thrust collapses or saturation remains the trajectory-defining behavior
