# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the held fish downstream and above the four
  cylinders while the common interacting streets develop around the target.
  It is a common initial condition, not candidate-specific performance.
- All four sampled released sheets are finite target reaches. The assigned
  parent and its two duplicates turn sharply from the release pose and then
  sustain a coherent leftward/downward traverse through the merged wake. The
  regular posterior wake and `-10.922L` head displacement in x show that the
  transport is actively propelled rather than passive advection. No failed
  released sheet is sampled; the inherited slower/smaller carrier instability
  (`121.517` release time, RMS force/moment `16749.8/290421`) is retained as
  the informative failure boundary against changing the propulsive scaffold.
- The raw-bearing reservation predecessor reaches in `46.035`, with mean
  distance `2.0695L`, mean command energy `1237.06`, and RMS force/moment
  `51.40/761.46`. Adding course-slip correction only to the steering residual
  (the assigned parent) improves arrival to `45.727`, mean distance to
  `2.0543L`, and force RMS to `49.36`, but raises mean command energy to
  `1264.65` and moment RMS to `799.31`.
- Both candidates reach the `30.0` policy acceleration envelope and the joint
  speed limit on both joints. Their sheets show nearly identical route
  topology, including the demanding initial redirect. The parent's inherited
  notes also show that feeding course slip into both the residual and the
  reservation regressed arrival, distance, effort, force, and moment. Thus the
  successful observation paths should stay separated, while the remaining
  testable issue is how redirect authority is distributed between joints.

## Candidate hypothesis

Preserve the successful joint-state carrier, posterior phase lag, separated
course-slip residual, raw-bearing reservation schedule, same-sign joint
steering, and `30.0` envelope. Apply the bearing-scheduled increment in
reservation only to the anterior joint; keep the posterior joint at the
already validated base reservation. This is a structural joint-role split:
the anterior joint retains finite redirect authority while the posterior joint
keeps more of the opposing carrier half-cycle available for the traveling bend
during large target errors. It does not change the carrier gains or add a
world-frame route, elapsed phase, or wake-phase command.

Expected test: preserve target reach and the visible early redirect while
maintaining stronger posterior propulsion through that redirect, ideally
improving arrival or mean distance without worsening the parent's effort and
load tradeoff. Falsify the mechanism if target reach is lost, arrival exceeds
the `49.142` constant-reserve baseline, mean effort exceeds `1299.7` without a
force/moment benefit, loads exceed the fully coupled boundary
`59.04/923.45`, or the fish no longer sustains coherent leftward propulsion.
This candidate is not evaluated until after the worker exits.

bookshelf_consulted: true
source_domain: elongated-body swimming and robotic-fish asymmetric turning
source_mechanism: anterior steering around a posterior-emphasized traveling bend
transferable_invariant: separate directional authority from propulsive-wave preservation by steering primarily with the anterior joint while retaining posterior phase-lagged thrust
nontransferable_details: published gains, species envelopes, robot actuator geometry, dimensional frequencies, clocked phases, exact vortex phases, and source-task routes
policy_translation: raw body-frame bearing schedules extra finite reserve on joint one, while joint two keeps the validated base reserve around the unchanged phase-lagged carrier and bounded same-sign residual
falsification: reject if capture or coherent leftward propulsion is lost, or if the split fails to improve arrival, distance, effort, or force/moment relative to the evaluated shared-reserve parent
