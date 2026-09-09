# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. It is the common certified
  initial condition, not evidence that any candidate selects a wake phase.
- The two yaw-only samples reproduce the prefilled policy exactly: both turn
  down and upstream, retain a posterior-traveling bend, enter the merged wakes
  only near the target, and capture at `31.5645` release time. Their matching
  diagnostics are mean distance `1.60525L`, score `0.266663`, mean velocity
  `(-0.34460,-0.14334)L/time`, relative-crossflow RMS `0.24105`, and
  force/moment RMS `66.32/887.63`. Mean local flow
  `(-0.19776,-0.19407)` confirms that the upstream transit is actively
  propelled rather than passive advection.
- The two sampled planar-wrench policies differ only in comments and reproduce
  the same stronger result. Their released sheets preserve the same compact,
  nose-first diagonal and coherent traveling wake while capture advances to
  `30.4865`; mean distance falls to `1.56766L`, score rises to `0.302848`,
  and mean velocity becomes `(-0.35660,-0.14740)L/time`. Relative-crossflow
  RMS falls to `0.23534`, force/moment RMS to `65.80/872.96`, mean command
  energy to `1416.41`, and mean power proxy to `107.80`.
- Both policy classes still touch the joint velocity and acceleration limits,
  so the evidence supports faster closure with lower aggregate loads, not
  desaturation or a general efficiency claim. The planar-wrench policy also
  reduces peak excursions from `0.5191/0.5555` to `0.5094/0.5190 rad`.
- No sampled released failure sheet is available. The adverse boundary remains
  inherited textual evidence: unrestricted bearing-trend feedback erased the
  traveling bend and exited downstream, undirected physical-limit damping
  delayed capture, and distributing withdrawal across another controller
  layer regressed. This candidate therefore changes only the already guarded
  optional posterior residual.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological Karman-gait and adaptive wake-interaction studies
source_mechanism: swimmers can retain useful vortex-induced translation or rotation by yielding optional active effort instead of cancelling every lateral fluid load
transferable_invariant: preserve the propulsive traveling wave and route-level steering while withdrawing only bounded incremental effort when measured body-frame loading agrees with coherent target-directed motion
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase locking, dimensional frequencies, published gains, species morphology, exact vortex phases, and prescribed routes
policy_translation: combine softly normalized target-signed `force_body_L[2]` and `moment_z_L2` as planar-wrench assistance under the existing trajectory-efficiency supervisor, and apply their maximum only to the optional posterior half-cycle residual
falsification: reject if target capture or the compact self-propelled diagonal is lost, arrival or mean distance regresses from the yaw-only branch, loads rise without navigation gain, or a held-out wake exposes switching, propulsion loss, or phase sensitivity

## Candidate hypothesis

Produce exactly one candidate by materializing the twice-reproduced
planar-wrench withdrawal mechanism on the prefilled yaw-only policy. A lateral
body-frame force whose sign agrees with the persistent target-turn request is
useful translation toward the route, just as a same-signed yaw moment is useful
rotation. During coherent target closure, either measured assistance may
withdraw only the bounded `8%` target-helping posterior half-cycle residual.
Opposing or absent loads recover the existing progress-supervised behavior.

Preserve the filtered body-frame bearing, bounded `12 deg` distributed
curvature request, bearing-conditioned `40/60 -> 35/65` allocation, anterior
state-feedback oscillator, posterior lag and damping, and unit-gain traveling
wave. Normalize lateral force at the sampled order-one `force/L` scale through
`target_policy_params`; do not infer vortex phase, cancel crossflow, alter the
mean-curvature path, or add another controller layer. The current candidate's
formal CFD result remains downstream, so no same-worker improvement is
claimed.
