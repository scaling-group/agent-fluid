# Multi-wake target-policy candidate

## Visual diagnosis and evidence

- The shared prewarm sheet shows the common held fish in the upper-right while
  the four staggered-cylinder wakes develop and merge around the target.  This
  is a certified common release condition, not evidence for a fixed route or
  transferable vortex phase.
- The current prefill and its duplicate sampled rollout sustain a zero-mean,
  posterior-lagged alternating bend and actively swim upstream into the wake
  corridor.  They reach the `0.75L` target after `137.357` released units with
  `4.18356L` mean distance, `90228` total command energy, and
  `0.12955/14.75/303.02` RMS relative crossflow/force/moment.  Mean body
  velocity in x (`-0.0791`) exceeds the magnitude of mean local-flow x
  (`-0.0542`), so the diagonal progress is not passive advection.  The
  released sheet nevertheless shows a broad redirect and several midcourse
  course reversals before the right-side target entry.
- A sampled one-change body-course controller preserves the alternating wave,
  upstream displacement, collision-free corridor entry, and target capture.
  It reaches after `137.247` units and improves mean distance to `4.07666L`
  and score from `-2.24176` to `-2.13504`.  Its `91401` energy and
  `0.13358/14.91/306.50` crossflow/force/moment are small regressions, so this
  is evidence for better route geometry, not an across-the-board efficiency
  claim.  Joint-1 acceleration remains close to the `31.416` cap (`30.926`),
  which rules out stacking extra gait authority on the mechanism.
- The sampled actuator-response filter has the highest scalar score and a
  faster `130.729` arrival, but its keyframes show sharper course corners and
  its `115750` command energy, `8465` power proxy, and
  `0.15435/18.30/359.97` crossflow/force/moment substantially exceed the
  prefill.  Both acceleration peaks approach the hard limit and the joint
  excursions grow.  This falsifies the filter's inherited effort/load
  hypothesis and makes it an unsuitable mechanism to combine here.
- The informative inherited posterior-steering regression retains an
  alternating bend but visibly loops above and below the useful corridor.  It
  delays capture to `279.439`, raises mean distance to `6.982L`, nearly doubles
  total energy to `182836`, and halves mean upstream speed to `-0.0389`.
  Therefore this candidate leaves the posterior traveling-wave target and the
  anterior/posterior steering distribution unchanged.

## Candidate hypothesis

Make one feedback-topology change from the prefill: use the sampled signed
angle between instantaneous body-frame target bearing and observed body-frame
velocity direction as a small course-alignment correction inside the route
loop.  Multiply it by the existing positive normalized closing-progress gate,
so instantaneous bearing remains the sole route owner when yaw or wake motion
does not produce targetward translation.  Preserve the direct normalized
moment residual, state-inferred anterior half-cycle asymmetry, regulated
oscillator, and unmodified posterior lag.

The same-snapshot sampled result supports this candidate as a modest route
improvement, but its slight effort/load cost remains a boundary rather than a
claimed universal gain.  Falsify it if a later held-out wake loses capture or
upstream translation, weakens the alternating wave, enlarges the midcourse
excursion, increases cap contact, or fails to reproduce the distance benefit
without material effort/load growth.  No new CFD result is claimed in this
worker; evaluation occurs after exit.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and adaptive wake swimming
source_mechanism: distinguish body heading from the target-relative direction of measured translation while preserving a low-dimensional propulsive rhythm
transferable_invariant: a bounded course correction should earn route authority only when normalized measured motion is already closing target distance
nontransferable_details: published gains, robot linkage geometry, dimensional beat settings, species-specific kinematics, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: preserve the two-joint state-feedback half-cycle traveling bend and direct moment residual; add the normalized bearing-minus-body-velocity-direction correction inside the route loop, gated by positive normalized window closing speed
falsification: reject if course qualification loses or slows capture, weakens upstream translation or alternating propulsion, enlarges the route excursion, or materially raises distance, effort, loads, or actuator-cap contact relative to the reproduced baseline
