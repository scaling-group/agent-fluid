# Candidate wake-policy notes

## Evidence diagnosis

- All four sampled direct-uniform still-water rollouts capture on the same
  `22.154001T` control step with mean distance `2.105583L`, score `-0.210952`,
  finite `11.49/6.41%` anterior/posterior exact-rate-cap occupancy, and peak
  normalized force/moment `0.030897/0.015839`. Three execute the assigned
  parent policy; the fourth adds proximity preview to posterior recovery but
  is trajectory-identical, so recovery prediction has no authority on the
  encountered route.
- The complete top-down row shows self-propelled progress along a shallow
  S-route and an attached alternating vorticity street through capture. The
  complete oblique row shows discrete three-dimensional Lambda2 structures
  through `22.15T`; two other sampled oblique rows are blank render artifacts,
  not evidence of wake loss. Direct initialization and zero background flow
  rule out passive advection as the source of progress.
- The numerical trace agrees with the images: distance decreases from
  `12.328L` to `8.629/3.975/1.859/0.748L` at approximately
  `0/8/16/20/22.154T`, while the full body-frame target error grows on the
  same side late in the route. The capped de-yawed target-line rate is also
  target-divergent throughout the established `12--22T` approach, increasing
  from roughly `0.06` to `0.26 rad/T` in successive `4T`/terminal windows.
  Thus the remaining visible inefficiency is persistent lateral route
  divergence, not failed propulsion, instability, or an inactive recovery
  gate.
- Six available inherited score-only records remain captures but score only
  `-0.211397` to `-0.212304`, below the complete-evidence parent. Because they
  have no sampled trajectory or two-view wake evidence, they do not establish
  a safer replacement mechanism.

## Policy hypothesis

Keep the assigned parent's carrier, through-water speed recovery, predictive
course/rudder paths, reactive-rudder sign and ceiling, and anterior-qualified
terminal relief. Add one bounded posterior stroke-reallocation path: only when
normalized proximity is active and the measured de-yawed target line is
diverging on the instantaneous target side, move a small fixed share of the
posterior carrier from the cancelling return half-cycle to the useful
half-cycle. This changes neither the posterior mean-rudder ceiling nor the
far-field/launch carrier and never raises posterior carrier scale above the
unsteered unit envelope. It should provide target-side yaw without stacking
more mean tail load or retuning the already saturated error gates.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish CPG turning and asymmetric flapping
source_mechanism: modulate the rhythmic actuator envelope or duty allocation with measured direction error while retaining the locomotor oscillator
transferable_invariant: preserve the traveling carrier and redirect a bounded portion of rhythmic authority toward the turn-useful half-cycle only while measured route error is worsening
nontransferable_details: published gains, clock phase, robot geometry, species kinematics, dimensional frequencies, and prescribed routes
policy_translation: use instantaneous body-frame target side, capped de-yawed target-line rate, normalized target proximity, and anterior joint state to redistribute a fixed posterior carrier share between half-cycles
falsification: reject if capture is later than 22.154001T, mean distance exceeds 2.105583L, launch or route changes adversely, either wake view loses the coherent carrier, or action, rate-cap occupancy, peak force, or peak moment exceeds the inherited envelope
