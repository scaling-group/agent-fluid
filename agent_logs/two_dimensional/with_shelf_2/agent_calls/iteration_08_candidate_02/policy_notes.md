# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common upper-right held release while the
  four developed cylinder streets merge around the target. The released sheets
  therefore compare controller behavior from the same wake maturity and phase.
- Three sampled policies reproduce the assigned parent's yaw-moment-gated,
  distributed half-cycle controller exactly: each sustains a traveling body
  wake, follows a continuous diagonal down-left route, and reaches the target
  at `51.47`, with `0.748L` final/minimum and `1.82L` mean distance. Their exact
  repetition is a materialization baseline, not additional robustness evidence.
- The one sampled architecture change adds alignment-gated posterior emphasis
  to that same scaffold. Its sheet retains active self-propulsion and the useful
  diagonal wake crossing, but reaches the target at `46.80`; mean distance
  improves to `1.745L` and score to `0.1368`. Posterior bend grows from about
  `0.659` to `0.675` rad while anterior bend falls from about `0.721` to `0.704`
  rad, consistent with a stronger posterior traveling wave rather than a new
  mean-curvature route. The benefit costs modestly higher command-energy mean
  (`1024` versus `995`) and force/moment RMS (`441/4259` versus `426/4084`).
- The inherited propulsive-priority allocator is the informative failure. Its
  keyframes initially follow the same diagonal corridor, then pass below the
  target and continue into the lower second-row cylinder at `58.93`. Metrics
  agree: collision, `1.87L` closest approach, `3.73L` final distance, and higher
  force/moment RMS `537/4995`. Lower command-energy mean (`971`) did not justify
  changing the successful command composition. This rules out carrying that
  allocator into the evidence-backed posterior-emphasis candidate.

## Candidate hypothesis

Materialize the successful sampled alignment-gated posterior-wave policy as the
single candidate. Preserve the zero-centered anterior oscillator, response-
predicted body-frame bearing, yaw-moment-magnitude gate, and distributed half-
cycle steering. When predicted bearing is small, smoothly increase only the
anterior-state contribution to the lagged posterior target; remove the extra
posterior amplitude continuously as route error grows. This isolates one
propulsion mechanism and leaves the parent's proven steering composition intact.

The next CFD rollout should reproduce target capture and improve the parent's
`51.47` arrival and `1.82L` mean-distance baseline without the allocator's
below-target collision. Falsify the mechanism if capture or diagonal topology
is lost, arrival or mean distance regresses, or the added posterior motion raises
joint-limit residence or hydrodynamic load without useful progress. Same-snapshot
success does not establish robustness to changed wake phase, inflow, geometry,
or target.

bookshelf_consulted: true
source_domain: Lighthill-style elongated-body propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: posterior wave kinematics supply reactive thrust while body-frame feedback modulates the rhythmic envelope
transferable_invariant: preserve the traveling wave and add modest posterior emphasis only while observed route alignment is good
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, exact vortex phases, and task-specific routes
policy_translation: smoothly scale the anterior-state contribution to the posterior lag target by bounded predicted-bearing alignment while leaving distributed steering and its yaw-load gate unchanged
falsification: reject if capture or the successful lateral topology is lost, arrival and mean distance do not improve, or added posterior motion worsens rate-limit contact or hydrodynamic load without useful progress
