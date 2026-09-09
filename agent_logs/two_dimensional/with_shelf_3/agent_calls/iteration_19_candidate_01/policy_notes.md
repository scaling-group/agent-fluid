# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is identical common-initial-state
  evidence and does not establish candidate-specific wake selection or
  robustness to another release phase.
- The assigned yaw-only policy and the stronger sampled planar-wrench policy
  both visibly turn down and upstream, sustain a posterior-traveling body wake,
  stay clear of every cylinder, and cross the merged developed wakes only on
  the late part of a compact diagonal capture. Their mean velocities
  (`(-0.3446,-0.1433)` and `(-0.3566,-0.1474)`) exceed the respective local
  flow upstream, confirming active propulsion rather than passive advection.
- Adding target-signed lateral force beside target-signed yaw moment at the
  existing optional-residual gate was reproduced by two functionally
  equivalent sampled policies. Relative to the assigned yaw-only result, it
  advanced capture from
  `31.5645` to `30.4865`, lowered mean distance from `1.60525L` to `1.56766L`,
  mean command energy from `1420.86` to `1416.41`, force/moment RMS from
  `66.32/887.63` to `65.80/872.96`, and peak joint excursion from
  `0.5191/0.5555` to `0.5094/0.5190 rad`. Relative-crossflow RMS also fell from
  `0.24105` to `0.23534`, although both joints still touched the velocity and
  acceleration ceilings. This supports target-aligned load withdrawal at one
  bounded residual; it does not establish desaturation, energetic efficiency,
  wake avoidance, or held-out-phase robustness.
- Every sampled rollout is a target capture, so there is no sampled failure
  sheet to compare visually. The adverse boundary comes from inherited logs:
  moving target-rate feedback into oscillator centers erased the traveling bend
  and exited downstream, an undirected physical-limit gate delayed capture to
  `33.9405`, and composing withdrawal across controller layers regressed to
  `32.4555` with higher loads. Those are inherited textual boundaries, not new
  visual claims.

## Candidate hypothesis

Materialize the reproduced planar-wrench branch and extend that same single
hydrodynamic-assistance gate with a body-frame force projection onto the
instantaneous normalized target vector. A positive projection means the fluid
force is already translating the fish toward the task target; during coherent
closure it may therefore withdraw only the optional `8%` target-helping
posterior half-cycle residual. Keep the target-signed lateral-force cue so the
sampled winner is recovered whenever streamwise force is neutral, and keep the
yaw cue for rotational assistance. Opposing or absent loads leave the evaluated
progress supervisor unchanged.

Preserve the filtered bearing, bounded distributed mean curvature, anterior
state-feedback oscillator, posterior lag and damping, and unit-gain traveling
wave. Normalize the new force projection in body-length units at the sampled
force order of magnitude; do not infer vortex phase, cancel crossflow, add
actuation, alter a route, or place another gate in the controller.

bookshelf_consulted: true
source_domain: biological Karman-gait and adaptive wake-interaction studies
source_mechanism: swimmers may preserve useful vortex-induced translation or rotation by yielding optional active effort instead of cancelling every fluid load
transferable_invariant: withdraw only bounded incremental control when a measured normalized body-frame fluid load agrees with the current task-directed motion, while preserving the base propulsive wave and route steering
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase locking, dimensional frequencies, published gains, species morphology, exact vortex phases, and prescribed routes
policy_translation: project `force_body_L` onto the normalized current `target_body_L`, softly bound its positive targetward component, and combine it with the reproduced target-signed lateral-force and yaw-moment cues only at the optional posterior half-cycle residual during coherent closure
falsification: reject if target capture or the compact self-propelled diagonal is lost, arrival and mean distance regress from the sampled planar-wrench branch, force or moment rises without navigation benefit, or held-out wakes expose switching, propulsion loss, or phase sensitivity

## Scope

The new CFD result is evaluated only after this worker exits, so no same-worker
improvement is claimed. The current candidate tests one compact extension at
the already evidenced residual locus.
