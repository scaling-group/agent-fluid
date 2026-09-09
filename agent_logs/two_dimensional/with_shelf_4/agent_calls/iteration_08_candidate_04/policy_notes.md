# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common held-fish prewarm sheet shows the fish above and far to the right
  of the target while four fully developed vortex streets merge around the
  second-row capture region. This is the shared initial condition, so it does
  not support a memorized route or prescribed wake phase.
- The duplicated strongest sampled policy sustains a posterior-lagged
  alternating bend, travels about `-10.91L` upstream, and reaches the `0.75L`
  target after `137.357` released time units. Its decisive initial redirect
  and early wake-corridor entry produce `4.184L` mean distance, `90228` total
  command energy, `0.1296` RMS relative crossflow, and `14.75/303.02` RMS
  lateral force/yaw moment. Peak anterior acceleration is already
  `30.846 rad/time^2` against a `31.416` cap, so the next edit must not add
  gait authority or speed.
- The otherwise identical direct bearing-rate policy also captures, but later
  (`149.605`) and with worse mean distance (`4.358L`), total energy (`96933`),
  crossflow (`0.1321`), and force/moment (`15.49/308.48`). This supports
  preserving positive-closing-speed qualification of the rate term rather
  than reopening scalar gait or load-residual tuning.
- A sampled child changes only the persistent route observation to the
  circular mean of `bearing_history`. It still captures, but its released
  sheet shows a wider, slower redirect and wake entry: arrival regresses to
  `149.853`, mean distance to `4.423L`, total command energy to `100638`, RMS
  relative crossflow to `0.1339`, and RMS force/moment to `15.58/312.62`.
  This is a concrete negative result for unconditional bearing-history
  filtering: the short history can blur the large immediate redirect that the
  successful route needs.
- The informative inherited failure bundles a slower gait, larger moment
  residual, and route-headroom gate. Its keyframes close into an upper-right
  loop and top exit after `126.428` units with only `-1.116L` upstream motion,
  despite moderate RMS moment and feasible joint extrema. A separate
  whole-episode heading-rate damper remains successful but delays and widens
  the route. These boundaries argue for preserving the successful gait,
  direct moment residual, and instantaneous far-field bearing response.

## Policy hypothesis

Make one route-observation change while leaving all evidenced propulsion,
half-cycle steering, moment rejection, and progress-qualified bearing-rate
feedback unchanged. Compute the circular mean of the supplied short bearing
history, but blend it into the instantaneous bearing only when normalized
body-frame geometry places the target in front and positive window closing
speed corroborates translation. A target behind or abeam therefore retains
the full immediate redirect; a frontal, closing approach can use the short
history to suppress beat-scale bearing jitter without a clock, hidden mode,
coordinate, or assumed vortex phase.

The expected evaluation is retention of the `137.357`-unit capture and
upstream translation with fewer midcourse direction reversals and no increase
in mean distance, effort, load, or actuator-cap contact. Falsify this gated
history transfer if it blunts the initial redirect, regresses toward the
unconditional filter's `149.853`-unit/wider route, loses capture, raises loads
or effort, suppresses the posterior-lagged alternating bend, or recreates a
loop or boundary exit. The current candidate's CFD result occurs only after
this worker exits, so these are tests rather than claims.

bookshelf_consulted: true
source_domain: nonsteady fish redirect control, sensor-modulated robotic-fish direction tracking, and history-aware adaptive wake swimming
source_mechanism: retain immediate geometry-driven redirect authority, then admit short-history direction smoothing only after observed frontal alignment and targetward translation
transferable_invariant: persistent instantaneous body-frame target geometry must own large redirects, while bounded temporal smoothing may assist only in an observed aligned and progressing regime
nontransferable_details: published gains, dimensional beat settings, species-specific C-start kinematics, robot linkage geometry, recurrent-network weights, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the evidenced two-joint half-cycle traveling bend and direct normalized moment residual; blend circular bearing history into instantaneous bearing through continuous gates from positive normalized forward target geometry and positive normalized closing speed
falsification: reject if gating still weakens the initial redirect, loses or delays capture, raises distance integral, effort, load, or cap contact, destroys posterior lag, or recreates a sampled loop or boundary exit
