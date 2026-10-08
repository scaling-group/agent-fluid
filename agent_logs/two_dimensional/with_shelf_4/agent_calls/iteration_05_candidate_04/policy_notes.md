# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared held-fish prewarm sheet shows the common release state: the fish
  is held above and to the right of the target while four developed vortex
  streets interact downstream of the cylinders. It supplies no
  candidate-specific wake phase or route.
- All four sampled released sheets terminate at the target. Three are repeated
  realizations of the direct-moment-residual baseline and agree exactly on the
  reported physical metrics, so this workspace contains no sampled failure
  keyframe to compare. The inherited optimizer logs provide the relevant
  nonvisual negative boundary: a confounded slower-period, stronger,
  route-headroom-gated residual lost upstream translation and exited the top
  after `126.43` units. It does not identify a bad scalar, but it argues
  against reopening the gait or residual gate while extending the successful
  route.
- The repeated baseline visibly self-propels upstream, makes a broad
  target-directed correction, retains an alternating posterior-lagged bend,
  crosses the interacting wakes, and reaches the target in `149.572` units.
  Its route still zigzags laterally, with `4.384L` mean distance,
  `0.1362` RMS relative crossflow, and `16.22/314.99` RMS lateral
  force/yaw moment.
- The assigned solver parent adds only bounded `bearing_window_rate`
  feedback to that architecture. Its sheet retains the same successful route
  class and essentially the same arrival (`149.605`), but it finishes with
  visibly better vertical target alignment. The metrics corroborate the
  visual difference: mean distance improves to `4.358L`, head vertical
  displacement changes from `-4.145L` to `-4.465L` against the required
  `-4.5L`, RMS relative crossflow falls to `0.1321`, RMS force/moment to
  `15.49/308.48`, command-energy mean to `647.93`, and power-proxy mean to
  `46.94`. Peak joint angle, speed, and acceleration also fall slightly,
  including anterior acceleration from `30.925` to `30.826 rad/time^2`.
  Thus convergence-rate damping is an evidenced path/load refinement, not
  evidence of faster transit or a different route.

## Candidate hypothesis

Preserve the parent's oscillator, zero-mean bearing-driven anterior half-cycle
steering, posterior lag, direct normalized moment residual, and far-field
bearing-rate damping. Add one continuous terminal-approach mechanism: use
normalized body-frame `distance_L` to increase the already successful
bearing-rate damping smoothly as the target gets close. Persistent bearing
still owns the route; the schedule only releases more steering while bearing
is converging and restores it while bearing diverges. The existing final
`[-1,1]` turn bound and propulsive equilibrium are unchanged.

The later CFD evaluation should retain capture and the parent's upstream
trajectory while reducing late zigzag, mean distance, load, and command effort
without delaying arrival. Reject the mechanism if capture is lost or
materially slower, upstream translation degrades, the approach peels away,
load or actuator-cap contact rises, or the alternating posterior wave is
suppressed. The new rollout occurs after this worker exits; these are
falsification tests, not claimed results.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal target capture
source_mechanism: continuously strengthen target-relative convergence damping during approach while preserving the rhythmic propulsive scaffold
transferable_invariant: normalized body-frame distance may schedule target-bearing rate feedback so far-field route authority is preserved and near-target steering is released or restored according to observed convergence
nontransferable_details: published gains, dimensional distance thresholds, robot linkage and species kinematics, exact vortex phases, cylinder coordinates, capture-specific routes, and clock-driven approach stages
policy_translation: preserve the sampled joint-state half-cycle oscillator, direct normalized yaw-moment residual, and base bearing-rate term; add a smooth bounded function of `distance_L` that increases only the bearing-rate weight before the existing route and amplitude bounds
falsification: reject if capture or upstream thrust is lost, arrival slows materially, late target alignment or mean distance worsens, load or actuator clipping rises, or the distance schedule suppresses the alternating traveling bend
