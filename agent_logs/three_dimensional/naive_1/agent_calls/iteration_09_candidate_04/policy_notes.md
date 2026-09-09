# Phase-qualified terminal lateral-velocity candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts report direct uniform initialization at
  `U_infinity=[0,0,0]`, no prewarm, and `capture`. The best-scoring sampled
  policy is the terminal body-lateral-velocity lead at `-0.2267148`,
  `19.0190T`, and mean distance `2.11536L`; the most adverse finite comparison
  is the progress-qualified capture at `-0.2373790`, `19.1675T`, and mean
  distance `2.12587L`. The projected base captures at `19.1345T` and mean
  distance `2.12198L`, so the lead's small advantage is a mechanism hypothesis,
  not evidence beyond the observed repeat band.
- In both the best and adverse combined sheets, the top-down row develops a
  coherent alternating street and keeps translating toward the target, while
  the oblique row shows compact caudal Lambda2 packets through capture. There
  is no visible propulsion collapse, collision precursor, or imposed-flow
  advection. The lead variant reaches the target on a visibly similar useful
  trajectory, so the candidate should preserve the carrier and mean-curvature
  allocation.
- The metric/diagnostic cross-check agrees with the visual reading. Projected
  captures bound both public accelerations at `31.416 rad/T^2`, but still spend
  about `61.5--61.6%`/`72.0--72.3%` of samples at that envelope and contact the
  joint-rate limit on roughly `11.2--11.3%`/`14.3--15.0%`. Inherited optimizer
  evidence says outward rate tapers removed rate contact but lost capture and
  exited after closest approaches of `5.3386L` and `5.0277L`; command relief
  must not distort the propulsive phase or mean turn.
- The terminal body-frame target side changes during the final approach, while
  lateral body velocity contains beat-scale motion. The sampled raw lead stays
  sign-preserving and captures, whereas inherited guidance reports that an
  instantaneous line-of-sight transverse-velocity residual missed at
  `0.9490L` and departed. This supports phase-qualifying the evidenced raw lead
  rather than introducing another course projection or pointwise rate barrier.

## Policy hypothesis

Use the best sampled projected terminal-lateral-velocity policy as the carrier.
Infer the useful steering half-cycle from normalized anterior joint angle and
the current target side. Apply the sign-preserving lateral-velocity curvature
release mainly on the counter-turn half-cycle, while leaving the target-helpful
bend and posterior traveling-wave target intact. This should retain the
captured route class and coherent wake while making terminal slip release less
sensitive to beat phase. Falsify it on loss of capture, arrival/mean-distance
degradation outside the sampled capture band, less coherent top-down or
Lambda2 wakes, increased rate/load extremes, or unchanged/worse terminal
side-to-side correction.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and classical fish turning
source_mechanism: joint-state-inferred half-cycle asymmetry around a propulsive rhythm
transferable_invariant: target geometry owns turn sign while oscillator state can place a bounded steering modulation on the less useful half-cycle without replacing the traveling wave
nontransferable_details: published gains, duty ratios, species kinematics, exact vortex or clock phase, and task-specific routes
policy_translation: preserve projected differential mean curvature and posterior lag; gate only the terminal body-lateral-velocity release with normalized anterior bend alignment to the current target side
falsification: reject if capture or wake coherence is lost, the useful route changes class, rate or load statistics worsen, or terminal correction does not improve beyond repeat variability
