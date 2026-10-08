# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the certified common release: the fish is
  held above and downstream of four developed, interacting vortex streets.
  This anchors the flow comparison but supplies neither a transferable vortex
  phase nor a route to encode.
- All four sampled rollouts reach the `0.75L` target, so there is no sampled
  failure termination to contrast.  The strongest finite score is the
  anterior-only previous-action filter at `-1.74531`: it captures after
  `135.019` released units with `3.685L` mean distance and `-11.081L` upstream
  displacement.  Mean body velocity x (`-0.08171`) exceeds the magnitude of
  mean local-flow x (`-0.06314`), confirming active propulsion rather than
  passive advection.  Its released sheet retains the alternating bend and
  enters the interacting wake, but the targetward trace still contains broad
  direction reversals.
- Filtering both joint commands captures faster (`130.729`) but its released
  sheet has a sharper near-vertical wake-course reversal.  It raises total
  command energy to `115750`, RMS crossflow/force/moment to
  `0.15435/18.30/359.97`, anterior bend to `0.469` rad, and anterior
  acceleration to the `31.416` cap.  Removing the posterior filter in the
  prefill lowers energy to `110448` and posterior bend/acceleration from
  `0.439/30.85` to `0.411/28.62`, but does not resolve the high anterior bend,
  cap contact, or load (`0.15352/18.53/362.61`).  Fixed previous-action
  filtering is therefore an evidenced phase/amplitude mechanism, not load
  relief.
- The duplicated unfiltered course-alignment policy provides the informative
  low-load comparison.  Its sheet is visibly smoother and it captures after
  `137.247` units with `4.077L` mean distance, `91401` energy, and
  `0.13358/14.91/306.50` RMS crossflow/force/moment.  Relative to the
  inherited direct-action calibration in the parent logs (`137.357`,
  `4.184L`, `90228`, `0.12955/14.75/303.02`), this supports course geometry
  but only with small effort/load regressions.  It also shows that direct
  oscillator action can remain successful when fixed servo lag is removed.
- Inherited logs rule out stacking posterior steering or an unconditioned
  crossflow residual: same-sign posterior modulation loops for `279.439`
  units with `182836` energy, while direct crossflow rejection delays capture
  without reducing RMS crossflow.  The candidate therefore keeps the route
  owner, moment residual, half-cycle asymmetry, and posterior target intact.

## Candidate hypothesis

Keep the prefilled anterior command-continuity mechanism when normalized yaw
load is small, but release it smoothly toward the current oscillator command
as `abs(moment_z_L2)` grows.  The direct-action and filtered samples bracket
the intended behavior: low-load continuity may retain the filter's useful
trajectory change, while high-load release avoids carrying a fixed command
phase lag through the strong wake/turn events that coincide with cap contact
and high aggregate force/moment.  The gate uses the same body-frame measured
load already accepted by the controller and introduces no clock, wake phase,
hidden mode, posterior modification, or scalar gait increase.

The evaluation should retain target capture, upstream self-propulsion, and the
zero-mean posterior-lagged bend, while reducing anterior cap contact, command
energy, crossflow, force, and moment relative to the anterior-only filtered
prefill without regressing arrival and mean distance all the way to the direct
baseline.  Falsify the mechanism if load-conditioned release loses capture,
creates a loop or sharper command switching, destroys the alternating wave,
or fails to improve effort/load together while retaining a material part of
the filtered trajectory benefit.  The new CFD evaluation occurs only after
this worker exits; these are testable expectations, not current results.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and adaptive swimming in organized wakes
source_mechanism: preserve a low-dimensional propulsive rhythm while sensor feedback changes how a residual actuator command is admitted under hydrodynamic disturbance
transferable_invariant: rhythmic propulsion should remain state-defined, while bounded normalized load feedback may reduce command-memory authority during strong wake interactions
nontransferable_details: published CPG gains, hardware servo constants, dimensional frequencies, species kinematics, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: retain the two-joint state-feedback traveling bend, route loop, and direct posterior tracking; blend only the anterior previous-action filter continuously toward direct raw action as absolute normalized yaw moment grows
falsification: reject if capture, upstream translation, or alternating propulsion is lost, or if arrival, mean distance, command effort, force, moment, and cap contact do not improve jointly over the anterior-only filtered prefill and direct-action calibration
