# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the certified common initial
  condition, not candidate-specific evidence of wake selection or robustness
  to a changed release phase.
- All four sampled policies and released keyframe sheets are byte-identical.
  They reach the target nose first at `31.5645` release time on one compact
  diagonal, with a persistent traveling bend, ample cylinder clearance, and
  entry into the merged cylinder wakes only near capture. Head displacement
  `(-10.9169,-4.2166)L` and mean velocity `(-0.3446,-0.1433)` versus mean
  local flow `(-0.1978,-0.1941)` confirm active upstream propulsion rather
  than passive advection.
- The four repeats also agree on `1.60525L` mean distance, score `0.266663`,
  relative-crossflow RMS `0.24105`, force/moment RMS `66.32/887.63`, posterior
  peak excursion `0.55553 rad`, and both joints touching the velocity and
  acceleration ceilings. This establishes fixed-snapshot reproducibility and
  faster closure, not efficiency or wake-phase robustness.
- Inherited logs identify the relevant causal contrast. Progress-only
  posterior yielding captured at `32.340`, with `1.63773L` mean distance and
  `65.12/888.56` force/moment RMS; a response-supervised version captured at
  `32.318`, `1.63741L`, and `65.52/881.45`. Adding bounded target-signed yaw
  load at that same optional residual improved navigation to the sampled
  `31.5645/1.60525L` result without jointly reducing loads. The useful result
  is therefore a load-informed withdrawal cue, not added actuation.
- No released failure sheet is available in the sampled workspace. The most
  informative adverse boundaries remain inherited: target-rate feedback at
  oscillator centers erased the traveling wave and exited downstream,
  undirected physical-limit damping delayed capture to `33.9405`, and
  composing withdrawal across multiple controller layers regressed to
  `32.4555` with higher loads. These are textual falsification boundaries,
  not newly inspected visual evidence.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological Karman-gait and adaptive wake-interaction studies
source_mechanism: swimmers may yield optional active effort when an organized fluid load already assists task-directed motion instead of cancelling every lateral wake load
transferable_invariant: preserve the persistent propulsive wave and route-level steering while using only target-aligned components of the measured body-frame fluid wrench to withdraw bounded incremental steering during coherent closure
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder vortex phase, dimensional frequency, published gains, species morphology, and prescribed wake routes
policy_translation: retain normalized target-window progress supervision and add target-signed lateral `force_body_L[2]` beside the already positive target-signed `moment_z_L2` cue at the sole optional posterior half-cycle residual; keep distributed mean curvature and the unit-gain lagged wave outside the yield path
falsification: reject if target capture or the compact self-propelled diagonal is lost, arrival and mean distance fail to retain the yaw-only branch's benefit, force or moment rises without navigation gain, or a held-out wake exposes switching, propulsion loss, or phase sensitivity

## Candidate hypothesis

Produce exactly one candidate by extending the sampled yaw-only withdrawal cue
to a small target-aligned body-wrench combination at the same controller locus.
During coherent target closure, a lateral body-frame force directed toward the
target may indicate useful wake-assisted translation just as a target-signed
yaw moment indicates useful turn assistance. The maximum of the two bounded
cues may withdraw only the optional `8%` target-helping posterior residual.
Opposing or absent loads leave the evaluated progress-supervised controller
unchanged.

Preserve the filtered body-frame bearing, bounded `12 deg` distributed
curvature request, bearing-conditioned `40/60 -> 35/65` allocation, anterior
state-feedback oscillator, posterior lag and damping, and unit-gain traveling
wave. Normalize the new force observation at the sampled `RMS force_y / L`
scale, owned by `target_policy_params`; do not infer vortex phase, add force
cancellation, or alter authority elsewhere. Formal CFD evaluation remains
downstream, so no same-worker improvement is claimed.
