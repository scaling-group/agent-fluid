# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held in the upper-right while the
  four staggered-cylinder streets develop and merge around the second-row
  target. This is a common initial condition, not a transferable vortex phase,
  timed stage, or fixed route.
- All four sampled solver results are semantic duplicates of the current
  policy under that snapshot. They actively self-propel upstream through the
  mixed wake with an alternating posterior-lagged bend and capture after
  `137.357` released units. Their replicated metrics are `4.18356L` mean
  distance, `-10.9139L/-4.3711L` head displacement, `90228.38` total command
  energy, and `0.12955/14.75/303.02` RMS relative crossflow/force/moment.
  The keyframe path contains several targetward zigzags, but neither passive
  downstream advection nor a loss of the propulsive wave.
- The assigned-parent guidance and inherited logs reject scalar oscillator
  escalation, extra posterior steering, bearing smoothing, and unconditioned
  lateral-target or crossflow residuals. The anterior acceleration already
  reaches `30.846` against the `31.416 rad/time^2` cap, so this candidate must
  change when existing authority is used rather than increase the gait.
- The newest terminal-route-relief rollout is the informative failure. A
  `30%` relief scheduled by proximity and positive closing speed changes the
  `137.357` capture into `left_domain` after `243.447` units. It approaches
  only to `1.796L`, then its sheet shows repeated right-side switchbacks and an
  upward escape; mean/final distance become `7.938L/7.185L`, upstream
  displacement falls to `-7.710L`, and energy rises to `161191`. Thus useful
  closure is not evidence that route authority can safely be relaxed before
  first crossing of the tight capture radius.
- The inherited yaw-moment gate is a second negative boundary. Suppressing the
  direct residual whenever absolute bearing is not growing still captures,
  but lengthens the lower excursion and arrival to `149.490`, raises mean
  distance and energy to `4.428L/97418`, and raises RMS force/moment to
  `16.38/318.46`. Keep the small direct moment loop intact rather than making
  it earn authority from a coarse route-response gate.

## Policy hypothesis

Make exactly one mechanism change from the replicated policy: add a bounded
retreat-triggered multiplier to the existing anterior bearing error. Negative
`window_closing_speed_L` is direct evidence that target distance is increasing;
only then does the multiplier smoothly strengthen the route request. During
zero or positive closure it is exactly the sampled controller, so useful
approach cannot cause premature relief. Preserve progress-qualified
bearing-rate damping, the direct yaw-moment residual, state-inferred zero-mean
half-cycle steering, oscillator gait, and unmodulated posterior lag.

The formal test is preserved capture and alternating upstream propulsion, with
shorter target-regressing zigzags and lower arrival time or mean distance. The
mechanism is falsified if it changes the route into a loop or boundary exit,
adds anterior cap contact, delays capture, weakens upstream translation, or
raises energy, crossflow, force, or moment relative to the replicated
`137.357` baseline. CFD evaluation occurs only after this worker exits, so
these are expectations rather than claims about this candidate.

bookshelf_consulted: true
source_domain: nonsteady fish redirect control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: recruit bounded redirect authority from observed adverse translational response while retaining the propulsive rhythm
transferable_invariant: persistent normalized body-frame route error may receive extra anterior steering only when measured target-distance response is adverse, and should return continuously to cruise authority when closure resumes
nontransferable_details: published gains, dimensional beat settings, species-specific burst envelopes, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the evidenced two-joint half-cycle traveling bend, direct normalized moment residual, and posterior lag; multiply only the anterior bearing-error term by a bounded function of negative normalized `window_closing_speed_L`
falsification: reject if retreat-triggered recruitment loses or delays capture, increases target-regressing excursions, weakens upstream translation or the alternating bend, or raises effort, loads, or actuator-cap contact
