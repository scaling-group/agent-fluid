# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The certified prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is a common initial condition, not
  candidate-specific evidence of wake selection or wake-phase robustness.
- All four sampled policies, released keyframe sheets, and compact metrics are
  byte-identical. They capture at `31.5645` release time with `1.60525L` mean
  distance, score `0.266663`, relative-crossflow RMS `0.24105`, and
  force/moment RMS `66.32/887.63`. The released sheet shows an immediate
  targetward redirect, a persistent traveling bend and self-generated
  posterior wake, ample cylinder clearance, and nose-first entry into the
  `0.75L` circle. Mean velocity `(-0.3446,-0.1433)` against mean local flow
  `(-0.1978,-0.1941)` confirms active upstream propulsion rather than passive
  advection. The exact repeats establish fixed-snapshot determinism only.
- The most useful available adverse visual comparison is the inherited
  curvature-release/headroom composition: it still follows the same diagonal
  and captures, but does so at `32.4555`, with `1.64548L` mean distance and
  `67.83/914.09` force/moment RMS. Its sheet shows no compensating topology or
  clearance benefit. No released failure sheet is present in this workspace;
  inherited downstream exits are therefore textual boundaries rather than new
  visual evidence.
- The assigned parent establishes target-aligned normalized yaw moment as a
  useful withdrawal cue at the optional posterior residual: it improved
  arrival from `32.318-32.340` to `31.5645` while preserving the direct route.
  It did not establish load relief, because `66.32/887.63` did not improve
  jointly over `65.52/881.45`, and both joints still touch the velocity and
  acceleration ceilings. The current edit must not add authority, cancel
  crossflow, or weaken the distributed mean curvature or base traveling wave.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: adaptive wake interaction combined with closed-loop robotic-fish CPG residual modulation
source_mechanism: preserve useful wake-assisted turning while applying the smallest bounded response when measured loading opposes the task-directed turn
transferable_invariant: arbitrate only incremental steering by the sign of normalized body-frame yaw load, yielding to target-aligned assistance and restoring bounded residual authority against target-opposing load while preserving the propulsive rhythm
nontransferable_details: species kinematics, muscle-activity values, published gains, dimensional frequencies, single-cylinder vortex phase, actuator ratings, and prescribed wake routes
policy_translation: retain coherent-closure supervision and the current target-signed moment normalization; aligned yaw load may withdraw only the optional posterior half-cycle residual, while opposing yaw load continuously vetoes actuator-state withdrawal and restores no more than the evaluated ungated residual
falsification: reject if target capture or the compact self-propelled diagonal is lost, arrival and mean distance regress without a compensating load benefit, force or moment rises without navigation benefit, the base traveling bend weakens, or held-out wakes expose beat-scale switching or phase sensitivity

## Candidate hypothesis

Produce exactly one candidate by extending the existing signed yaw-yield path
into a two-sided residual arbiter. Preserve the filtered body-frame bearing,
bounded `12 deg` distributed curvature request, bearing-conditioned
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior lag
and damping, and maximum `8%` target-helping half-cycle residual.

During coherent target closure, a positive product of persistent target turn
and normalized yaw moment continues to withdraw the optional residual. A
negative product instead softens the existing speed/acceleration withdrawal,
restoring the residual continuously toward its already evaluated ungated value
without exceeding it. Zero or absent moment recovers the parent exactly. This
tests whether alternating adverse yaw can retain steering correction while
useful hydrodynamic assistance is preserved. It does not infer vortex phase,
alter oscillator centers, or add a flow/force cancellation path. Formal CFD
evaluation remains downstream, so no same-worker improvement is claimed.
