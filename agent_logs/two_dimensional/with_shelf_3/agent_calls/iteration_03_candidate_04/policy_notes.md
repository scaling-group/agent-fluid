# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent optimizer evaluated the same `0.55`-period, `28 deg`
  oscillator and `45/55` split total-curvature controller that is prefilled in
  this workspace. All four sampled solver results reproduce the same finite
  target-reaching trajectory: capture after `39.7374` release-time units,
  `1.9338L` mean distance, `0.7473L` final/minimum distance, and `0.9399`
  progress. Their released keyframe sheets are byte-identical, and their
  metrics differ only in wall time. This is a reproducible navigation baseline
  under the common prewarm snapshot, not four independent wake conditions.
- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. In the released success sheet,
  the fish immediately sustains a posterior-traveling bend, self-propels on a
  compact upstream-left diagonal, enters the interacting-wake corridor, and
  reaches the green capture circle without a visible targetward yaw reversal.
  The metrics confirm active upstream swimming rather than passive advection:
  mean velocity x is `-0.2732` while mean local-flow x is `-0.1536`, for about
  `-0.1196` relative streamwise velocity; head displacement is
  `(-10.9124,-4.3318)L`.
- The inherited full-anterior-bias failure provides the informative visual
  contrast. It shows little sustained deformation or targetward translation,
  moves the head `(+2.1945,-1.3023)L`, and exits downstream after `18.6834`
  units with negative progress. Its `0.249/0.191 rad` peak joint excursions
  and `187.66` mean command energy are far below the successful baseline, so
  low effort alone is not useful if the propulsive scaffold collapses.
- The successful baseline nevertheless reaches both joint velocity and
  acceleration envelopes (`4.5379 rad/time` and `31.4159 rad/time^2`) and has
  `1278.79` mean command energy with `761.95` moment RMS. An inherited global
  rhythm reduction to `0.9` period and `20 deg` amplitude reduced mean command
  energy to `17.02` but exited downstream after `16.984` units. The available
  evidence therefore contradicts global gait relief and does not calibrate a
  signed wake-force residual. It supports preserving the demonstrated route
  mechanism while testing a small, observation-gated propulsion response.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: elongated-body tail-thrust theory and robotic-fish residual modulation over a propulsive CPG
source_mechanism: preserve a lagged traveling bend while using task feedback to adjust posterior wave emphasis instead of replacing the rhythm
transferable_invariant: posterior motion is a bounded thrust-control channel, so an observed persistent loss of target closure may request a small increase in the zero-mean tail wave while mean curvature continues to own steering
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot geometry, exact vortex phase, source-task routes, and source actuator allocation
policy_translation: retain the evaluated bearing-to-total-curvature controller and state-derived anterior phase; map normalized windowed closing speed through a bounded deficit gate to at most a small posterior-only multiplier on the zero-mean lagged wave
falsification: reject if capture is lost or later than the `39.7374` baseline, the diagonal wake-corridor trajectory changes adversely, joint/load saturation grows without earlier approach, or the gate remains active despite useful target closure

## Candidate hypothesis

Add one mechanism to the evaluated success: progress-conditioned posterior
wave emphasis. The baseline's gross release-average closure is approximately
`0.294L/time`, so an owned `0.30L/time` scale normalizes the windowed closing
speed. A smooth deficit gate applies no boost at or above that scale and at
most a `12%` multiplier when closure is absent or negative. The multiplier is
applied only to the zero-mean posterior traveling component; the proven total
curvature budget, its joint allocation, the anterior oscillator, and all base
gait parameters remain unchanged.

Expected evidence is the same target-reaching diagonal topology with quicker
early target-distance reduction or better recovery from a wake-induced loss
of closure. The candidate is not claimed to improve before its post-worker CFD
evaluation. Later workers should compare capture time and distance integral
first, then inspect gate-sensitive switching, velocity/acceleration residence,
command effort, and force/moment loads; a nominal success that merely increases
bang-bang residence is a negative result.
