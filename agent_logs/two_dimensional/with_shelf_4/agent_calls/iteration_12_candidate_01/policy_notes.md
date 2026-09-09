# Multi-wake candidate diagnosis

## Evidence read before editing

- The four sampled solver results are deterministic replications of one
  successful trajectory. Their released sheets are byte-identical and all
  reach the target after `137.357` released units with `4.184L` mean distance,
  `-10.914L/-4.371L` head displacement, `90228` total command energy, and
  `0.12955/14.75/303.02` RMS relative crossflow/force/moment. The two policy
  hashes differ only in comments. This is a strong regression baseline under
  one certified wake snapshot, not four independent robustness trials.
- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. In the released sheet the fish
  is visibly self-propelled: it redirects from the upper right, retains an
  alternating posterior-lagged bend, crosses the mixed wake on a broad
  targetward arc, and reaches the target from the right. The `-10.914L`
  upstream displacement and mean body velocity `-0.0791` versus mean local
  streamwise flow `-0.0542` support active propulsion rather than passive
  advection. The anterior acceleration already reaches `30.846 rad/time^2`
  against the `31.416` cap, so more scalar gait or steering gain is not
  supported.
- The assigned parent's one-change response-gated yaw-moment residual still
  captures, but its sheet shows a deeper lower midcourse excursion before the
  same right-side approach. Arrival regresses to `149.490`, mean distance to
  `4.428L`, energy to `97418`, and RMS crossflow/force/moment to
  `0.13148/16.38/318.46`. Gating moment rejection only when absolute bearing
  is growing therefore does not preserve the baseline's trajectory or load
  advantage.
- No sampled solver result is a failure. The most informative available
  inherited failure is the closing-qualified near-target route-relief policy:
  its released sheet approaches to only `1.796L`, then makes repeated broad
  loops, turns upward, and exits the domain after `243.447` units. Metrics
  agree with the visible loss of route control: final distance is `7.185L`,
  mean distance `7.938L`, energy `161191`, RMS crossflow `0.13567`, and joint-1
  acceleration reaches the hard cap. Smooth proximity and positive closure
  did not make removing route authority safe.
- Together with inherited regressions from unconditioned crossflow and lateral
  target residuals, the evidence supports retaining the observations, gains,
  gait, direct moment sign, and target route. The unresolved structural issue
  is command arbitration: the baseline separately saturates the route, adds a
  fast moment residual, and hard-clamps their sum. Near a large route request,
  that residual can either flatten at the clamp or subtract its full amount
  from the persistent target command.

## Candidate hypothesis

Make exactly one feedback-topology change: compose the bounded normalized
yaw-moment residual with the unsaturated target-route drive, then apply one
smooth `tanh` authority envelope. With zero moment this exactly preserves the
sampled route request. Near alignment it retains almost the full measured-load
response, while at large bearing the saturation slope automatically limits a
fast residual without a proximity mode, bearing-divergence gate, hidden time,
or extra actuator gain. Preserve the progress-qualified bearing-rate term,
state-inferred half-cycle steering, oscillator, posterior lag, and every
existing scalar parameter.

The test is retained capture and alternating upstream propulsion with a
shorter or smoother wake crossing and improvement in arrival/mean distance
and effort/load together. Reject the mechanism if capture is lost or delayed,
the lower excursion widens, moment rejection becomes too weak in the wake,
joint-1 cap contact increases, or the route, energy, crossflow, force, or
moment metrics regress from the replicated `137.357` baseline. The candidate's
CFD result is unavailable until after this worker exits and is not claimed as
evidence here.

bookshelf_consulted: true
source_domain: robotic-fish CPG residual control and adaptive wake swimming
source_mechanism: preserve rhythmic propulsion and persistent direction tracking while admitting a bounded sensor residual that cannot replace the route command
transferable_invariant: slow normalized body-frame target geometry should own steering, while a fast normalized load residual shares one smooth bounded authority envelope whose slope limits it near route saturation
nontransferable_details: published controller gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, single-wake phase relations, cylinder coordinates, and task-specific routes
policy_translation: add the bounded `moment_z_L2` residual to the progress-qualified bearing drive before one `tanh`, then use that request in the existing joint-state half-cycle asymmetry and unmodified posterior traveling bend
falsification: reject if capture, upstream translation, or the alternating wave is lost, or if arrival, mean distance, command effort, crossflow, force, moment, or actuator-cap contact fails to improve jointly against the replicated baseline
