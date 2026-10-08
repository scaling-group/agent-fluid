# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets.  The target corridor is already
  unsteady at release, but the identical prewarm hashes make this a common
  initial condition rather than a transferable wake phase or route.
- Every sampled policy is a finite `target_reached` success; there is no
  sampled failure sheet.  The useful contrast is therefore between three
  distinct successful trajectories (the fourth sample duplicates the
  course-alignment policy).  All actively self-propel upstream by about
  `10.9--11.1L`, far beyond their approximately `-0.057--0.066` mean local
  streamwise flow, and retain an alternating posterior-lagged bend through
  capture.
- The inherited anterior-only action-response candidate now has direct A/B
  evidence against its both-joint parent.  Removing history filtering from
  the posterior joint improves mean distance from `3.754L` to `3.685L`, score
  from `-1.8167` to `-1.7453`, total command energy from `115750` to `110448`,
  power-proxy mean from `64.75` to `59.95`, posterior bend from `0.439` to
  `0.411` rad, and posterior acceleration from `30.85` to `28.62`
  rad/time^2.  It gives back arrival time (`130.729` to `135.019`) and does not
  relieve wake loads: RMS force/moment rise slightly from `18.30/359.97` to
  `18.53/362.61`, while anterior acceleration still reaches the cap.  Thus
  direct posterior tracking is an evidenced distance/effort allocation, not a
  general load-rejection result.
- The sheets agree with that tradeoff.  Both history-response variants enter
  the wake corridor early but make visible midcourse yaw reversals.  In
  contrast, the duplicated direct-action course-alignment policy follows a
  smoother broad arc.  Against the inherited replicated direct-action
  calibration, its progress-gated body-course residual changes arrival only
  from `137.357` to `137.247` but lowers mean distance from `4.184L` to
  `4.077L`, at modest costs in energy (`90228` to `91401`) and RMS
  crossflow/force/moment (`0.1296/14.75/303.02` to
  `0.1336/14.91/306.50`).  This supports course correction as a route
  mechanism, not as a load trim.
- Because no sampled semantic failure exists, the inherited
  `279.439`-unit posterior half-cycle result remains the informative negative
  control: it preserves propulsion but loops repeatedly around the corridor,
  reaches `6.982L` mean distance, and expends `182836` energy.  The present
  edit therefore leaves posterior steering and lag unchanged.

## Policy hypothesis

Use the better-scoring anterior-only action-response controller as the
scaffold and add the separately evidenced course-alignment residual as the one
new feedback mechanism.  The residual compares instantaneous body-frame
target bearing with the measured body-translation direction and receives
authority only when positive normalized closing speed corroborates approach.
The route owner remains target bearing, the anterior oscillator retains its
zero-mean half-cycle steering and short action response, and the posterior
joint directly tracks the lagged propulsive target.

This combination should reduce the anterior-only controller's visible
course-slip excursions and lower mean distance below `3.685L` without losing
capture, upstream translation, or the alternating wave.  Reject it if mean
distance and score do not improve over `3.685L/-1.7453`, if arrival regresses
beyond the `137.357` direct-action calibration, or if its effort/load cost is
materially larger than the anterior-only reference
(`110448`, `0.1535/18.53/362.61`).  The current worker does not claim this
result; formal CFD occurs only after exit.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and elongated-body propulsion
source_mechanism: correct target-to-body course slip in the route loop while keeping posterior traveling-wave tracking direct
transferable_invariant: measured body-frame translation should corroborate a route correction, while route steering and posterior propulsion remain separately testable
nontransferable_details: published gains, hardware servo constants, species-specific envelopes, dimensional beat settings, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: add a bounded positive-closing-speed-gated angle between body-frame target bearing and normalized body velocity to the anterior turn request; retain direct posterior state-feedback tracking
falsification: reject if capture, upstream translation, or alternating propulsion is lost, or if distance and score fail to improve without disproportionate effort, load, or arrival regression
