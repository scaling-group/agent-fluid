# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common upper-right held pose and four
  developed, interacting cylinder streets. It is the same initial condition
  for every candidate, so released-route differences are controller evidence.
- Three sampled yaw-moment-gated controllers reproduce the same active
  diagonal capture at `51.47`, with `0.748L` final/minimum and `1.82L` mean
  distance, `-11.28/-4.94L` head displacement, and `426/4084` force/moment
  RMS. Their sheets show a persistent body-generated traveling wake rather
  than passive downstream advection.
- The best sampled child adds target-aligned posterior-wave emphasis. Its
  sheet retains the same down-left topology but reaches the circle earlier at
  `46.80`; the metrics confirm mean distance `1.745L` and total command energy
  `47931`, versus `1.820L` and `51225` for the repeated gated reference. This
  is a positive propulsion result, although mean command energy rises from
  `995` to `1024` and force/moment RMS rises from `426/4084` to `441/4259`.
- The most informative inherited failure gives the traveling wave explicit
  priority over steering inside acceleration headroom. Visually it crosses
  below the target, continues down-left, and collides with the lower second-row
  cylinder. Its `1.87L` closest and `4.29L` mean distance, `-14.42/-6.79L`
  displacement, and `537/4995` force/moment RMS confirm that the allocator
  weakened the successful route despite slightly lower mean command energy.
  Steering composition and its moment gate should therefore remain intact.

## Candidate hypothesis

Preserve the complete successful anterior oscillator, heading-response route
request, yaw-moment steering gate, distributed half-cycle steering, and smooth
limiter. Refine only the evidenced posterior propulsion mechanism: combine
predicted-bearing alignment with normalized windowed closing speed so the
posterior lag target receives more emphasis during weak/negative progress and
less once target closing is already strong. A bounded base emphasis prevents
the traveling wave from disappearing, while the progress-deficit term avoids
raising posterior amplitude uniformly.

The expected effect is to retain target capture and the best child's direct
route while concentrating extra posterior work in wake-induced stalls rather
than high-progress segments. The next CFD rollout falsifies this mechanism if
capture is lost, arrival exceeds `46.80`, mean distance exceeds `1.745L`, the
allocator's below-target/collision topology reappears, or joint-rate contact
and force/moment load rise without a compensating progress improvement. A
same-snapshot result does not establish robustness to changed wake phase.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish rhythmic control
source_mechanism: posterior wave kinematics provide reactive thrust while slower observed route progress modulates the rhythmic envelope
transferable_invariant: preserve the traveling wave and schedule bounded posterior emphasis from normalized target alignment and closing behavior instead of applying extra thrust uniformly
nontransferable_details: published gains, dimensional speeds, species-specific amplitude envelopes, robotic linkage geometry, exact vortex phases, and task-specific routes
policy_translation: retain the two-joint state-feedback gait and steering law; multiply the posterior lag target by a smooth alignment-weighted emphasis that increases only as windowed body-frame target closing becomes weak
falsification: reject if capture, arrival, mean distance, or route topology regresses, or if rate-limit contact and hydrodynamic loads increase without useful progress
