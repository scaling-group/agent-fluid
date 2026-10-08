# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common prewarm sheet shows the held fish above and far to the right of
  the target while four developed wakes merge around the second-row capture
  region. This is a shared initial condition, not a candidate-specific route
  or reusable vortex phase.
- The duplicated current prefill sustains a posterior-lagged alternating bend,
  propels itself about `-10.93L` upstream, and reaches the target after
  `149.605` units. Its released sheets still show a broad initial redirect and
  repeated lateral kinks. Relative to the direct-moment baseline, its bounded
  bearing-rate term improves mean distance (`4.358L` versus `4.384L`), total
  command energy (`96933` versus `101995`), and RMS force/moment
  (`15.49/308.48` versus `16.22/314.99`) without shortening arrival.
- The strongest sampled child makes one structural change to that prefill: it
  applies bearing-rate damping only when positive normalized window closing
  speed confirms targetward translation. Its sheet shows a tighter initial
  redirect and earlier wake-corridor entry while retaining the alternating
  wave. It reaches the target in `137.357` units with `4.184L` mean distance,
  `90228` total command energy, `0.1296` RMS relative crossflow, and
  `14.75/303.02` RMS force/moment, improving every aggregate over the current
  prefill except mean command energy (`656.89` versus `647.93`) because the
  successful episode is shorter.
- The assigned parent's response-direction gate on the direct moment residual
  still reaches the target in `148.703` units and slightly lowers load, but its
  wider midcourse excursion raises mean distance to `4.578L` and worsens score
  to `-2.629`. Bearing convergence can be body rotation rather than translation,
  so it is not a reliable label for helpful instantaneous yaw load.
- The informative failure that combines a slower gait, larger moment gain, and
  route-headroom gating closes an upper-right loop and exits the top boundary
  after `126.428` units with only `-1.116L` upstream motion. A sampled
  whole-episode heading-rate residual remains successful and lowers RMS load,
  but delays capture to `150.832` and worsens mean distance to `4.387L`.
  Neither lower effort nor yaw damping alone justifies replacing the route
  mechanism, and neither mechanism is bundled into this candidate.

## Policy hypothesis

Make exactly one mechanism change from the prefill: qualify its bounded
`bearing_window_rate` damping by positive normalized
`window_closing_speed_L`. Persistent body-frame bearing remains the route
owner; the direct normalized moment residual, state-inferred zero-mean
half-cycle steering, and posterior-lagged traveling bend remain unchanged.
When bearing changes without targetward translation, the controller retains
the full bearing redirect instead of mistaking body spin for route progress;
once the distance window is closing, rate damping returns smoothly to limit
overshoot. The selected structure and scale are transferred from the strongest
completed sampled policy, not inferred from its scalar score alone.

The expected evaluation is replication of target capture near `137.36` units,
roughly `4.18L` mean distance, preserved upstream propulsion, and no increase
in load or actuator-cap contact. Falsify this transfer if capture or upstream
translation is lost, arrival or mean distance regresses toward the direct-rate
baseline, the alternating posterior wave is suppressed, or loads increase.
The new CFD evaluation occurs only after this worker exits, so those outcomes
are tests rather than claims about this candidate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and nonsteady fish redirect control
source_mechanism: release target-response damping only after measured response is corroborated by targetward translation
transferable_invariant: persistent body-frame target geometry owns the route, while response damping should depend on normalized observed progress rather than elapsed time or an assumed wake phase
nontransferable_details: published gains, dimensional beat settings, species-specific redirect kinematics, robot linkage geometry, exact vortex phase, cylinder layout, and source-task routes
policy_translation: preserve the evidenced two-joint half-cycle traveling bend and direct normalized moment residual, then gate only normalized bearing-rate damping with positive normalized window closing speed
falsification: reject if progress qualification loses or slows capture, raises distance integral or loads, destroys posterior lag, increases actuator-cap contact, or recreates a loop or boundary exit
