# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- All four sampled evaluations use direct uniform still-water initialization
  (`U_infinity=(0,0,0)`) and terminate in capture. The three byte-identical
  redistribution policies capture at `18.6505--18.8815T` with score-metric
  mean distance `2.08855--2.09222L`; their top-down rows show a coherent,
  target-bending alternating street and their oblique rows show compact
  caudal Lambda2 structures from release through capture. This is genuine
  self-propulsion and stable target approach, not advection.
- Those replications still contact the acceleration limits on about
  `60.85--61.00%`/`72.97--73.27%` of anterior/posterior samples and the rate
  limits on `11.01--11.07%`/`14.88--15.07%`. Peak planar force and moment are
  about `0.0307--0.0322` and `0.0160--0.0166`; the coherent wake therefore
  does not establish demand relief.
- The rearward-route multiplier also captures (`18.9640T`, `2.09072L`) and
  has visually indistinguishable wake topology, but its target stays forward.
  It demonstrates non-interference, not exercised recovery. The sampled set
  has no failure keyframe sheet; the informative failure contrast is the
  assigned parent's inherited evidence that the same redistribution bytes
  also produced coherent-wake misses at `0.81206L` and `1.25093L` before
  downward/left exits. The parent's inherited step-33 log supplies only a
  capture score (`-0.20750`) and no activation or route history, so it cannot
  resolve that semantic contradiction.

## Candidate hypothesis

Remove only phase-dependent amplitude-relief redistribution. Preserve the
normalized body-lateral target sign, target-signed displacement-half-cycle
curvature, common geometry-owned mean amplitude relief, correcting-yaw
response release, posterior lag, and final acceleration projection. This is a
matched semantic ablation: it tests whether two simultaneous phase channels
make the otherwise successful route fragile without replacing the proven
propulsive carrier or tuning scalar gains.

Expected result: retain capture, both coherent wake rows, and return near the
simpler geometry-scheduled carrier's `2.09340--2.09542L` mean-distance band.
Falsify the hypothesis if capture is lost, either wake row loses coherence,
the downward/left-exit topology recurs, or route/load behavior worsens outside
the established bands. Lower actuator contact alone is not success.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and fish mean-curvature turning
source_mechanism: target-feedback mean bias plus bounded half-cycle asymmetry of a traveling joint rhythm
transferable_invariant: preserve the posterior-lagged traveling bend while body-frame target geometry owns turn sign and observed joint displacement identifies the useful beat half
nontransferable_details: published gains, duty ratios, clock phase, species-specific envelopes, exact kinematics, and task routes
policy_translation: retain normalized lateral-target curvature and displacement-phase steering, but remove the second phase-dependent amplitude-envelope channel so only common geometry-owned relief remains
falsification: reject on loss of capture or either coherent wake row, recurrence of the downward exit, or failure to recover the geometry-scheduled route band; do not accept lower saturation by itself
