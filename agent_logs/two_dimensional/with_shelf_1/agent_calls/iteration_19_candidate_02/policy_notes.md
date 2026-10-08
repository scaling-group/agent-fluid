# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held in the upper-right while the
  four staggered-cylinder streets develop and interact. This is a common
  initial condition, not candidate-specific evidence.
- The assigned parent and its two sampled replicas have byte-equivalent policy
  behavior: after release the fish makes a sharp down-left redirect, sustains a
  coherent traveling bend while self-propelling left through the mixed wake,
  and enters the `0.75L` target radius in `34.7105`. Their metrics reproduce
  `1.62283L` mean distance, `46985.9/1353.65` total/mean command energy,
  `0.24023` RMS relative crossflow, and `68.96/1036.40` force/moment RMS.
- The relative-crossflow child retains the same visible redirect-and-traverse
  topology but reaches in `33.9460`, reduces mean distance to `1.60066L` and
  total command energy to `46092.2`, and raises the score from `0.251012` to
  `0.272045`. The compact sheets do not resolve a distinct route shape, so the
  metric differences—not visual drama—establish the improvement.
- That improvement carries a clear boundary: mean command energy rises from
  `1353.65` to `1357.81`, RMS relative crossflow from `0.24023` to `0.24249`,
  and force/moment RMS from `68.96/1036.40` to `85.04/1244.16`. Relative
  crossflow is therefore evidenced as an arrival/route-response cue, not a
  load-relief cue.
- No current sampled solver is a termination failure, so a current visual
  success/failure comparison is unavailable. Inherited textual failures bound
  the edit: the target-blind seed exited downward, wrong-sign curvature exited
  with negative progress, and wholesale carrier replacement became unstable
  with extreme load. More recent negative comparisons also show that replacing
  bearing closure with heading rate raised force/moment RMS to
  `91.30/1389.74`, while adding targetward force credit regressed arrival,
  distance, energy, and load versus the assigned parent. The carrier, steering
  sign, mean route residual, reserve, base asymmetry, and coherent speed release
  remain unchanged.

## Candidate hypothesis

Adopt the one prior mechanism that has a direct positive rollout: replace only
the optional redirect burst's line-of-sight closure response with bounded
targetward relative crossflow. Persistent body-frame bearing continues to own
mean steering and reserve; opposing crossflow cannot remove redirect authority;
and relative crossflow can release only the extra half-cycle burst, never the
traveling-bend carrier or base asymmetry. The normalization is the observed
dimensionless RMS scale from the successful parent/child comparison, not a
published gain. This is a mechanism import from a sampled solver, not a claim
about the unevaluated current candidate.

The expected same-prewarm test is reproduction of capture, earlier arrival,
lower mean distance, and lower total effort with the documented load tradeoff.
Reject this translation if the new evaluation does not reproduce those
advantages. Do not call it robust until a changed wake phase or layout retains
capture; also reject it for future load-sensitive objectives if the force and
moment penalty remains uncompensated.

bookshelf_consulted: true
source_domain: organized-wake adaptive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target-route feedback from fast measured wake assistance and modulate a residual maneuver channel
transferable_invariant: persistent target geometry owns mean turning while targetward body-frame relative crossflow may release only surplus redirect actuation
nontransferable_details: trout Karman-gait phase, species kinematics, published gains and frequencies, exact vortex timing, cylinder coordinates, and task-specific routes
policy_translation: keep the state-feedback traveling bend, raw-bearing mean steering, base asymmetry, and two-joint coherent speed release; use bounded same-sign `relative_flow_velocity_body_U[2]` only in the optional burst-response factor
falsification: reject on lost capture, failure to reproduce the prior arrival/distance/total-effort benefit, materially worse load without compensating route value, or loss of capture under a changed wake phase
