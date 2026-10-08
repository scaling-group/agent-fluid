# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent is the byte-identical course-preview policy sampled as
  `solver_6e00d384ddf6`, `solver_1ebdfe824319`, and
  `solver_f6caa4a4502f`. All three capture at `24.5795T` with final/minimum
  distance `0.74697L` and score-metric mean distance `2.36044L`. The
  replication makes capture the behavior to preserve, not a one-off scalar.
- Both rows of the combined keyframe sheets were inspected for the assigned
  parent and the stroke-aware comparison `solver_162cce0ac49b`. The direct
  uniform initialization is visible and confirmed by diagnostics
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm): there is no inherited wake
  at release. By `8T` both policies are self-propelled and shed a coherent
  alternating top-down wake with compact oblique Lambda2 structures. The wake
  and trajectory remain organized through the middle redirect and target
  crossing; there is no sign of passive advection or instability.
- The informative failure is actuator quality rather than termination. The
  course-preview capture keeps the posterior joint at the `45 deg` hard limit
  for about `23.38%` of the trace and reaches peak absolute body-frame
  force/moment coefficients `0.269/0.178/0.143`. The position-and-command-aware
  stroke guard preserves the same visible route topology and capture
  (`24.6180T`, `0.74872L`) while reducing hard-limit occupancy to `12.60%` and
  peaks to `0.165/0.118/0.089`. It does not cure the upstream command problem:
  raw acceleration-envelope and joint-rate exposure remain approximately
  `72.65%/15.10%`, versus `72.84%/15.15%` for course preview.
- The detailed inherited logs close three tempting branches. Returning stroke
  relief only during measured inward joint motion retains capture but slips to
  `0.749001L` and score `-0.462859`; a course-alignment handoff is weaker again
  at `0.749838L` and `-0.464278`. A final acceleration-envelope projection then
  scores exactly like the evaluated stroke guard (`0.748724L`, `-0.462756`),
  consistent with duplicating downstream actuator clipping rather than
  changing dynamics. The inherited terminal allocation negative control still
  exits with a `1.092L` closest pass. This rules out another conditional
  handoff, output-only clipping, late recapture, or curvature-gain edit.

## Policy hypothesis

Preserve the evaluated stroke-aware policy's thresholds, maximum `15%`
priority release, far-path dormancy, course preview, and all route requests.
Refine only when its posterior guard begins acting. The evaluated guard reads
position but not outward joint speed, so a fast tail can enter the `36--44 deg`
guard band with more kinetic stroke than the remaining margin. Compute the
tail's idealized braking distance `v_out^2/(2*a_limit)` from observed outward
joint rate and the already owned acceleration limit, add it to absolute tail
angle, and feed that projected stroke into the existing guard. Inward or
stationary motion contributes zero preview, and all existing guard magnitudes
remain unchanged. This is a mirror-equivariant proprioceptive constraint
prediction, not a new route stage or scalar relief increase.

Expected evidence: retain capture and the reduced-load visual class, reduce
tail hard-limit and joint-rate exposure below `12.60%/15.10%`, and avoid
materially changing the far trajectory. Falsify the refinement if capture is
lost, the arrival margin shrinks below the completed conditional variants,
hard-limit/load returns toward the course-preview class, or earlier relief
weakens the course redirect. Raw command exposure is not an acceptance
criterion because the sampled guard and completed output projection show it
is not a reliable proxy for improved dynamics at this layer.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and posterior reactive-swimming theory
source_mechanism: proprioceptive feedback modulates a bounded propulsive rhythm before finite actuator stroke disrupts posterior kinematics
transferable_invariant: preserve the posterior traveling wave while anticipating a finite-stroke conflict from observed position and outward rate
nontransferable_details: published gains, species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: add normalized constant-deceleration stopping stroke to posterior angle only for outward motion, then use the projected stroke in the existing bounded steering-priority guard
falsification: reject if capture, far-path dormancy, the 12.60 percent hard-limit boundary, or the sampled reduced-load class is not preserved

## Pre-evaluation validation

- All `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`, and the prescribed public-contract
  state returns two finite accelerations.
- An `864`-state grid spanning range, target side, bearing, lateral course,
  posterior angle, and posterior rate returns finite actions. Direct guard
  probes are exactly equal to evaluated v28 for stalled or inward tail motion;
  mirrored outward probes activate earlier on both stroke sides.
- The guidance semantic-change check, Julia public contract, and solver
  editable-boundary audit pass. The rendered README's duplicated identical
  parent marker was removed so the mandated checker could select its one
  assigned parent. The configured check-runner was invoked, but its pinned
  model is unsupported on this account; its three declared no-CFD commands
  were run directly and separately. No formal CFD was run.
