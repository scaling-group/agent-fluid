# Candidate diagnosis and hypothesis

## Evidence read before architecture

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets. The three copies of the assigned
  coherent-release parent are deterministic: each reaches the target in
  `34.7105`, with `1.62283L` mean distance, `46985.9` total command energy,
  and `68.96/1036.40` force/moment RMS.
- In the released sheets, both the parent and the sampled relative-crossflow
  child are self-propelled rather than merely advected. They execute the same
  visible topology: a sharp clockwise redirect, a long leftward traverse
  through the developed multi-wake region, and capture from the target's
  downstream side. Neither sheet shows a collision, domain exit, or a
  qualitatively new route. No failed keyframe sheet is present in the current
  sampled set; the inherited guidance's domain-exit and unstable cases can
  therefore bound the architecture but cannot support a new visual claim.
- Replacing bearing-window closure with targetward relative crossflow is the
  only sampled semantic improvement. It reaches in `33.9460`, lowers mean
  distance to `1.60066L` and total command energy to `46092.2`, and raises the
  score from `0.251012` to `0.272045`. Its cost is material: force/moment RMS
  rise to `85.04/1244.16` from `68.96/1036.40`, while both policies still touch
  the `30.0` acceleration and joint-speed envelopes. The keyframes make this
  an earlier/stronger response on the same route, not evidence of a new wake
  corridor.
- Inherited logs support avoiding another kinematic or actuator-pressure
  proxy. Heading-rate response reaches only `0.0385` sooner than the parent
  while worsening mean distance and increasing force/moment RMS to
  `91.30/1389.74`; the assigned parent also records route, effort, and load
  regressions from stacked previous-command pressure. This leaves a direct
  hydrodynamic cue as the justified architecture axis.

## One candidate hypothesis

Preserve the proven oscillator, posterior lag, raw-bearing mean steering,
base half-cycle asymmetry, moment response, and coherent joint-speed release.
Adopt relative crossflow only as evidence of possible wake assistance, and
credit it only when normalized lateral fluid force co-signs with the requested
body-frame turn. The crossflow/force product releases only the optional
redirect burst; opposing or force-unsupported crossflow retains the parent's
authority. This is intended to preserve the crossflow child's shorter capture
while avoiding its indiscriminate release during high-load lateral motion.

The candidate is falsified if it loses capture, no longer improves arrival or
mean distance over the coherent-release parent, or fails to reduce
force/moment RMS materially from the crossflow-only child. Same-prewarm success
does not establish wake-phase or layout robustness.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish burst turning
source_mechanism: preserve helpful vortex-induced motion and release a transient redirect when measured environmental response already assists the requested turn
transferable_invariant: persistent body-frame target geometry owns route steering, while fast target-aligned wake response may withdraw only surplus transient authority
nontransferable_details: published gains, species kinematics, exact vortex phase, dimensional frequencies, cylinder coordinates, and task-specific routes
policy_translation: preserve the two-joint traveling carrier and mean steering; release only optional half-cycle burst by a bounded product of targetward relative crossflow and co-signed normalized lateral force
falsification: reject on lost capture, worse arrival or mean distance than the coherent-release parent, or force/moment RMS not materially below the crossflow-only child
```
