# Candidate diagnosis and hypothesis

## Sampled rollout diagnosis

- All four sampled rollouts report direct uniform initialization at
  `U_infinity=0`, reach the `100T` horizon, and show self-propelled motion with
  a coherent three-dimensional wake in both the top-down vorticity and oblique
  Lambda2 rows. The moving window is not visibly advecting an inert fish.
- The terminal course-hold scaffold (`solver_6eb170b0d70a`) is the strongest
  finite trajectory mechanism despite its lower scalar score: it contracts the
  repeated return loop to `1.241L`, finishes at `2.082L`, and remains actively
  undulatory at closest approach (`qdot1=-0.260`, `qdot2=0.108`, commands
  `0.747/0.923`). Its visible wake remains coherent through the close loop.
- The prefilled low-activity restart (`solver_2cc56ad90762`) regresses to
  `2.369L` minimum and `3.455L` final distance. The joint-state bend release
  (`solver_a6820a0af3d7`) and rear selector (`solver_b5de8ff4a388`) likewise
  reach only `2.215L` and `2.366L`. At their minima all three are nearly parked
  in a common negative C-bend (`qdot1` between about `-4e-5` and `0.0027`) with
  near-zero joint commands, even though translational speed remains about
  `0.677U`. Their images show larger, repeated powered arcs rather than the
  useful close return. This closes one-sided kicks, equilibrium release, and
  rear-side direction selection as repairs for this scaffold.
- Clamp residence does not explain the terminal stall: the failed restart is
  clamped for about `0.134/0.099` of anterior/posterior samples, while the
  useful course hold has greater anterior residence (`0.329`) and comparable
  posterior residence (`0.102`). The discriminating state is rhythmic
  phase-plane activity near the target, not unused global acceleration gain.

## Policy hypothesis

Replace the failed signed low-activity nudge with a bounded symmetric
activity-recovery term on the anterior joint. Under the already evidenced
target-behind terminal-course gate, reinforce whichever measured anterior
velocity half-cycle is present; leave both steering equilibria and the entire
posterior target unchanged. Fade the term out continuously when normalized
anterior phase-plane activity recovers. This is a distinct feedback mechanism,
not a global oscillator-gain retune: outside the target-behind terminal stall
its command is identically negligible.

Expected result: preserve the scaffold's first pass and posterior traveling
wave, prevent the near-stationary common C-bend seen in three descendants, and
recover the active close-return topology needed to improve near-target
residence or cross `0.75L`.

Reject the mechanism if it changes the ahead-side first return, leaves both
joints parked, enlarges the orbit through excess speed or wake curvature,
raises clamp/load residence materially, degrades wake coherence, or fails to
improve minimum/final distance and residence below `1.25L` relative to the
`1.241/2.082L` course-hold scaffold.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and biological nonsteady turn recovery
source_mechanism: sensor-modulated rhythmic activity with response-based release
transferable_invariant: restore a weakened locomotor rhythm with bounded state feedback that reinforces either measured half-cycle and releases when rhythmic activity returns
nontransferable_details: published oscillator gains, clock phase, species-specific amplitudes, multi-joint body waves, exact turn timing, and task-specific routes
policy_translation: use normalized anterior joint position and velocity about the existing body-frame steering equilibrium; gate symmetric velocity reinforcement by target-behind terminal course geometry and propagate the recovered wave through the unchanged posterior lag
falsification: reject if the first return changes, the common quiet C-bend persists, propulsion or wake coherence degrades, orbit size or clamp/load residence grows, or terminal distance statistics do not improve
