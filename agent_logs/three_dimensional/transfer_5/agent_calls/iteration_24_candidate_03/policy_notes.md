# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The four sampled solver artifacts are replicas rather than four independent
  mechanisms: their policy, combined-sheet, top-down-sheet, and oblique-sheet
  SHA-256 hashes are identical. Each reports direct uniform still-water
  initialization at `[0,0,0]`, capture at `23.8425217T`, final/minimum distance
  `0.74616498L`, 4,335 steps, and 236 lossless moving-window shifts. Thus v33 is
  both the best finite sample and the only sampled topology; no distinct
  failure keyframe exists in this workspace. The inherited score logs supply
  only exact v33 repeats or slightly worse captures, so they cannot stand in
  for a missing failure image.
- In both visual rows the fish leaves the quiescent release under its own joint
  motion, advances toward the target, and maintains a coherent alternating
  wake through capture. The top-down row shows an orderly staggered vortex
  chain at `5--18T`, then a pronounced path/body bend near `23T`; the oblique
  Lambda2 row confirms a compact three-dimensional alternating chain rather
  than passive advection, wake collapse, domain exit, or instability.
- The trajectory cross-check supports that diagnosis. Inside `3L`, absolute
  yaw averages `1.680 rad/T` and peaks at `3.185 rad/T`, while absolute moment
  peaks at `0.01373`. The joint-acceleration commands remain smoothly bounded
  below `31.39 rad/T^2`, so command feasibility is not the missing capability.
- The inherited guidance already rejects another sign gate, moment lead,
  command-pressure allocator, phase-lag damper, posterior counter-tangent, and
  fixed curvature-share retune. It identifies observation separation as the
  unresolved mechanism. Replaying v33 inside `3L` confirms that its anterior-
  only carrier-rejected yaw has `0.635 rad/T` RMS and correlation `-0.954` with
  full-tail tangent rate `phi_dot[1] + phi_dot[2]`, versus signed mean
  `0.111 rad/T`. Adding `0.17` times that distributed rate on the unchanged
  trace reduces the correlation to about `-0.053` and RMS to about
  `0.216 rad/T`. This is evidence for an observer experiment, not evidence of
  closed-loop improvement.

## Single candidate hypothesis

Keep v33's target-course feedback, coherent traveling-wave carrier, posterior
lag/amplitude, smooth command projection, and anterior half-cycle actuator.
Change only the signal feeding the added anterior half-cycle counter: estimate
slow excess yaw from heading rate plus both the existing anterior rate term and
a bounded-by-downstream-tanh full-tail tangent-rate term. Preserve the legacy
anterior-only response on the continuous course-brake path so the experiment
does not simultaneously remove the successful v24 control layer. The expected
effect is less carrier-synchronous switching of the anterior residual while
retaining route correction and propulsion.

Falsify the candidate if formal CFD loses capture, worsens v33-scale arrival or
distance performance, breaks the coherent alternating wake, or fails to hold
or improve inside-`3L` yaw, cross-track motion, moment, and joint-limit
exposure. Offline decorrelation alone is not a success criterion.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and wake-disturbance rejection
source_mechanism: preserve the propulsive oscillator while separating slow route feedback from fast periodic carrier motion before applying a small residual
transferable_invariant: estimate persistent route error on a body-intrinsic coordinate that rejects the observed fast gait carrier, and layer the corrective residual without disrupting the thrust-producing traveling bend
nontransferable_details: published gains, species kinematics, full-body CPG states, exact vortex phase, cylinder-wake synchronization, and source-task routes
policy_translation: use normalized-time joint rates from both joints to clean the terminal yaw estimate, then drive only the existing bounded anterior half-cycle counter while leaving the posterior traveling wave and continuous target-course brake unchanged
falsification: reject unless CFD preserves v33-scale capture and coherent wake while holding or improving progress, terminal yaw, cross-track motion, moment, and actuator-limit exposure
