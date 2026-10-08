# Evaluated lateral carrier-residual candidate

## Visual and metric diagnosis before the edit

- The assigned parent guidance is `optimizer_bf8405575646`. Its prefilled
  policy is the one-sided speed-guard carrier. Three sampled solvers
  (`solver_a2617fc44329`, `solver_a25f2f42902a`, and
  `solver_3a9293e0d0b2`) are byte-identical fixed-case repeats of that policy:
  all capture at `16.609995T`, score `-0.115560`, and have a scored mean-
  distance term of `1.999656L`. The distinct sampled child
  `solver_0f91f918d286` adds an approach-gated lateral carrier observer and
  captures one `0.0055T` step earlier, with better score `-0.113729` and
  mean-distance term `1.998146L`. These are nominal-pose, direct-uniform
  results, not independent robustness tests.
- Every sampled `wake_observation.md`, `wake_metrics.csv`, and diagnostic
  confirms `U_infinity=(0,0,0)`, uniform direct initialization, no cylinders,
  no prewarm, finite capture, and an active moving window. I inspected both
  rows of the combined keyframe sheets for the distinct best child and a
  replicated parent. Both top-down rows show self-propelled targetward motion,
  a coherent alternating vorticity street, and a shallow closed-loop arc into
  the target. Both oblique rows show finite tail-connected Lambda2 structures
  through capture. Neither trajectory is advection, wake breakup, collision,
  or numerical failure; their visible route and wake class are nearly the
  same. No sampled failure sheet exists in this workspace, so the replicated
  weaker capture is the controlled comparator.
- The inherited child note identifies the relevant mechanism rather than a
  scalar gain: inside `6L`, anterior phase explains `99.80%` of body-lateral
  velocity variance, with the stable fit
  `velocity_body_y = -0.7153*q1_carrier - 0.1314*q1_dot + residual`; inside
  `3L`, it explains `99.71%`. The completed child subtracts that reconstructed
  self-sway from velocity-course feedback and consistently adds it to
  relative-crossflow feedback, leaving the evidenced raw-course anterior
  center and far route unchanged.
- The result is favorable only for target progress. Relative to the three
  exact parent repeats, the child slightly lowers mean absolute action
  (`21.733/22.674` versus `21.738/22.691 rad/T^2`) but raises acceleration-
  near-limit residence (`74.10%` versus `73.91%`) and speed-near-
  limit residence (`27.59%` versus `27.42%`), peak planar force
  (`0.03716` versus `0.03583`), and peak moment (`0.01836` versus `0.01776`).
  Thus the earlier no-load-increase falsification condition did not survive;
  the small distance/arrival gain must not be generalized into an efficiency,
  effort, or load benefit.

## Sole candidate hypothesis

Promote the completed `solver_0f91f918d286` policy as the one candidate.
Preserve the full traveling-wave carrier, raw-course anterior response,
centered-coordinate yaw demodulator, posterior half-cycle steering, and
one-sided speed guard. Add only the evaluated approach-gated lateral observer:
reconstruct internally generated sway from normalized anterior joint state,
remove it from body-lateral velocity, and add it back to relative crossflow so
posterior route and slip feedback act on the residual rather than the carrier.

The evidence supports the narrow expectation of repeated capture with a small
fixed-case distance/arrival improvement and the same connected wake class.
Falsify reuse if capture, target-crossing topology, or wake connectivity is
lost; if the residual remains joint-phase-correlated; or if the modest load
and saturation regression grows. Do not tune the regression coefficients as
free gains: they are an evidence-calibrated observer, and changed pose, flow,
carrier family, or approach schedule requires recalibration or a held-out
test. No new CFD outcome is claimed for this workspace.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-disturbance residual control
source_mechanism: separate internally generated rhythmic locomotor response from slow target-direction and environmental-slip feedback
transferable_invariant: a beat-synchronous body-frame motion should be removed from the measured directional response before that residual drives bounded route correction
nontransferable_details: published CPG gains, species kinematics, dimensional beat frequency, exact vortex phase, prescribed routes, and task-specific maneuver timing
policy_translation: on approach, reconstruct carrier sway from centered anterior joint angle and joint velocity; use the residual lateral velocity and consistent relative crossflow only in posterior course and slip feedback while preserving the full two-joint carrier
falsification: reject if capture, distance integral, target arc, or connected wake worsens, if carrier correlation remains, or if the observed saturation and force/moment regression grows beyond the sampled narrow tradeoff
