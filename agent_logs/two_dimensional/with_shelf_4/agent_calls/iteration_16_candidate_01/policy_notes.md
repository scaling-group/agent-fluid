# Multi-wake target-policy candidate

## Visual diagnosis and prior evidence

- The common prewarm sheet shows the held fish above and downstream of four
  developed staggered-cylinder streets. The streets merge near the target and
  fill the approach corridor before release, so their exact phase is a shared
  initial condition rather than a transferable route signal.
- All four sampled policies reach the target with active upstream swimming and
  an alternating posterior-lagged bend. The strongest finite sheet
  (`solver_7593a852e2ba`) crosses after `130.729` released units with `3.754L`
  mean distance, versus `137.357` and `4.184L` for the replicated direct-action
  scaffold. Its trajectory makes a firmer early redirect and enters the wake
  corridor sooner; `-10.922L` upstream displacement against only `-0.0659`
  mean local streamwise flow confirms that this is not passive advection.
- That result falsifies its inherited interpretation as actuator smoothing.
  Filtering both joint accelerations through the previous action raises total
  command energy from `90228` to `115750`, RMS relative crossflow/force/moment
  from `0.1296/14.75/303.02` to `0.1543/18.30/359.97`, anterior bend from
  `0.404` to `0.469` rad, and anterior acceleration from `30.846` to the
  `31.416` rad/time^2 cap. The filter is a useful phase/amplitude-altering
  trajectory mechanism under this snapshot, but not an evidenced load trim.
- The course-alignment prefill also captures and slightly improves mean
  distance to `4.077L`, but arrival changes by only `0.110` units and energy
  and loads rise modestly. It does not explain the filtered policy's distinct
  faster path and is removed so this rollout isolates one mechanism.
- No sampled rollout is a semantic failure. The most informative inherited
  mechanism failure is the `279.439`-unit posterior half-cycle steering result:
  its inspected sheet retains propulsion but repeatedly loops above and below
  the corridor, with `6.982L` mean distance and `182836` total energy. Together
  with other inherited posterior and load-gating regressions, this argues for
  preserving direct posterior traveling-wave tracking while testing where the
  useful action-history effect belongs.

## Policy hypothesis

Retain the replicated target-bearing route loop, progress-qualified bearing-rate
damping, direct normalized moment residual, zero-mean anterior half-cycle
steering, and posterior-lagged traveling bend. Apply the sampled short
timestep-aware previous-action response only to the route-owning anterior
acceleration; send the posterior tracking acceleration directly. This tests
whether anterior action continuity retains the earlier redirect and corridor
entry while avoiding the extra phase lag imposed on the propulsive posterior
joint. The mechanism is rejected if target capture, upstream translation, or
alternating propulsion is lost; if arrival and mean distance regress to or
beyond `137.357/4.184L`; or if energy and crossflow/force/moment do not fall
materially below the both-joint filter's `115750` and
`0.1543/18.30/359.97` without sacrificing its useful trajectory.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: separate anterior rhythm steering from direct posterior tracking of the thrust-producing traveling wave
transferable_invariant: route-shaping feedback and posterior propulsive tracking should remain separately testable, with stateful command shaping applied only where rollout evidence locates useful redirect authority
nontransferable_details: published gains, servo response constants, species-specific curvature envelopes, dimensional beat settings, exact vortex phase, cylinder layout, and task-specific routes
policy_translation: preserve normalized body-frame bearing and moment feedback plus joint-state phase; apply the sampled previous-action response only to raw joint-1 acceleration and leave the lagged joint-2 target acceleration direct
falsification: reject if capture, upstream translation, or the alternating wave is lost, if arrival and mean distance lose the filtered trajectory advantage, or if effort and load fail to improve materially over the both-joint filter
