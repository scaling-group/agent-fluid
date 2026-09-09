# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting cylinder streets.  The merged wake already
  fills the target approach at release, so its particular vortex phase is a
  common initial condition rather than a controller clock or route cue.
- No sampled rollout has a failed termination.  All four fish actively swim
  upstream into the wake corridor with alternating bends and reach the tight
  `0.75L` target.  Upstream head displacement is `-10.92L` to `-11.08L`
  despite only `-0.057` to `-0.066` mean local streamwise flow, ruling out
  passive advection as the explanation for capture.
- The assigned-parent prefill reaches the target in `135.019` units with
  `3.685L` mean distance, the best sampled scalar score.  Its sheet retains a
  broad targetward arc, but its anterior-only previous-action response still
  reaches the acceleration cap and produces `110447` command energy and
  `0.1535/18.53/362.61` RMS crossflow/force/moment.
- Filtering both joints reaches sooner (`130.729`) but visibly makes a sharp,
  near-vertical mid-route yaw excursion.  It raises energy to `115750` and
  crossflow/force/moment to `0.1543/18.30/359.97`.  Keeping the posterior joint
  direct lowers posterior peak bend/acceleration from `0.439/30.851` to
  `0.411/28.624` and improves mean distance, yet it does not lower force or
  moment.  Thus action history is an evidenced phase/trajectory mechanism,
  not an evidenced load-smoothing mechanism.
- The two duplicate direct-action course-alignment samples take `137.247`
  units with `4.077L` mean distance.  Their visibly smoother approach costs
  only `91401` energy and `0.1336/14.91/306.50` RMS crossflow/force/moment.
  The inherited logs put the direct scaffold at `137.357/4.184L` and also
  document a posterior-steering regression with repeated large loops.  The
  useful comparison therefore supports preserving direct posterior tracking
  and limiting the duration of the costly anterior history effect, rather
  than moving steering aft or tuning oscillator gains from the score.

## Policy hypothesis

Preserve the assigned parent's target-bearing route loop, progress-qualified
bearing-rate damping, normalized moment residual, zero-mean half-cycle
steering, and direct posterior traveling-wave tracking.  Make one architectural
change: continuously gate the anterior previous-action response by the product
of normalized body-frame bearing magnitude and the absence of positive
windowed closing progress.  Large target misalignment without translation
retains the sampled history-shaped redirect; established closing motion or
small bearing releases joint 1 to its direct state-feedback acceleration.

This should preserve the incumbent's early redirect and low mean distance
without carrying its high-amplitude history effect through the whole approach.
Reject the mechanism if capture, upstream translation, or alternating bends
are lost; if arrival/mean distance regress beyond the direct scaffold's
`137.357/4.184L`; or if energy and crossflow/force/moment do not move materially
below the incumbent's `110447` and `0.1535/18.53/362.61` while retaining its
route advantage.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological burst redirects
source_mechanism: geometry-triggered nonsteady redirect that releases to cruise when feedback confirms useful response
transferable_invariant: a costly redirect should be invoked by large route error and removed continuously once targetward translation is established so it does not burden the full propulsive cycle
nontransferable_details: published CPG gains, hardware time constants, species-specific fast-start kinematics, dimensional beat settings, exact vortex phase, cylinder layout, and task-specific routes
policy_translation: gate only the sampled anterior previous-action response by normalized body-frame bearing magnitude and absence of positive normalized windowed closing speed, while posterior tracking remains direct
falsification: reject if capture, upstream translation, or the alternating wave is lost, if route metrics regress to the direct scaffold, or if effort and wake-load metrics fail to improve materially from the anterior-filter incumbent
