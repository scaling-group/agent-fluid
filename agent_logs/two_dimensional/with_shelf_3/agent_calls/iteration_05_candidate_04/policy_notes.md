# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The common prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. This is the same initial wake
  for every candidate. The best sampled released sheet (`solver_e6f7391fb8c3`)
  shows an immediate targetward rotation, a sustained posterior traveling bend,
  and a compact diagonal crossing of the developed wake into the capture circle;
  it does not show passive downstream advection, a late near miss, or a collision
  approach.
- The four current sampled solvers form a useful two-factor comparison. Relative
  to the instantaneous-bearing `45/55` baseline (`39.737` release time,
  `1.934L` mean distance), bearing-history filtering alone reaches in `36.564`
  with `1.808L` mean distance, and a constant `40/60` anterior/posterior split
  alone reaches in `37.955` with `1.858L` mean distance. Their combined policy,
  which is the assigned prefill, is best at `35.689` and `1.762L`. The posterior
  shift therefore improves the filtered and unfiltered contexts, while the
  combination retains the same direct trajectory topology.
- The best combination is not a low-load result: both joint velocities and
  accelerations touch their `260/1800 deg` envelopes, peak joint excursions are
  `0.539/0.575 rad`, relative-crossflow RMS is `0.248`, lateral-force RMS is
  `59.3`, and moment RMS is `821`. Because score has zero command-energy and
  power weight in this frozen task, this candidate does not weaken the proven
  gait merely to reduce effort.
- The most informative inherited failure is the route-trend candidate
  (`solver_f106b96f25b0`). Its released sheet shows only a small downstream-right
  departure from the same wake state before `left_domain` at `16.956`; metrics
  show negative progress, a `12.424L` closest approach, just `0.140/0.163 rad`
  peak joint excursions, and `8.64` mean command energy. Although its parameter
  list retained the nominal `0.55/28 deg` gait, the added bearing-rate path was
  upstream of the oscillator-center request. The evidence does not isolate the
  exact dynamic interaction, but it does show that an additive route-trend term
  can erase the effective traveling bend. This candidate therefore adds no
  bearing-rate, force, moment, or crossflow residual.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-feedback robotic-fish turning
source_mechanism: retain a posteriorly lagged propulsive wave while target-relative turn demand modulates the distribution of a bounded mean-curvature request
transferable_invariant: large observed body-frame direction error may place slightly more of an unchanged steering-curvature budget in the posterior joint, while alignment should return continuously to the already successful allocation so steering does not replace the traveling wave
nontransferable_details: published gains, species-specific kinematic envelopes, dimensional frequencies, exact vortex phases, actuator shares, and source-task routes
policy_translation: preserve the filtered body-frame bearing, total curvature, oscillator, and posterior lag; use only the magnitude of that bearing to smoothly shift the anterior/posterior allocation from the evidenced 40/60 anchor toward a small additional posterior share at large error
falsification: reject the scheduling mechanism if target capture is lost or later than 35.689, mean distance is not below 1.762L, the direct diagonal trajectory curls or drifts downstream, or posterior joint saturation and load rise without a navigation gain

## Candidate hypothesis

Make exactly one feedback-architecture change to the best sampled policy. The
`40/60` allocation becomes the aligned anchor, and a bounded `5` percentage
point posterior shift is admitted smoothly as the magnitude of persistent
body-frame bearing grows relative to an owned angular scale. The total `12 deg`
curvature budget does not increase. At zero bearing the equations recover the
evaluated `40/60` policy exactly; at large error they approach `35/65`, extending
the empirically beneficial `45/55 -> 40/60` direction only during the turn.

The `0.55`-period, `28 deg` state-feedback oscillator, circular bearing-history
filter, curvature saturation, posterior phase lag, and damping remain unchanged.
The expected downstream result is a quicker early turn and lower distance
integral without sacrificing the known aligned approach. The scheduled split is
an unevaluated hypothesis, so no new CFD benefit is claimed in this worker.
