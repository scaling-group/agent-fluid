# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is a common initial condition,
  not evidence for any controller difference.
- All four released sheets show the same useful topology: a sharp targetward
  redirect, a sustained traveling bend and self-propelled leftward traverse
  through the mixed wakes, then first-entry capture from downstream. The fish
  is not merely advected: even the coherent-release baseline has mean leftward
  velocity magnitude `0.3132`, exceeding mean local-flow magnitude `0.2018`.
  No sampled failure sheet is available, so the inherited target-blind
  downward exit, wrong-sign negative-progress exit, and unstable carrier
  replacement are textual boundaries rather than new visual claims.
- The current relative-crossflow parent reaches in `33.9460`, with `1.60066L`
  mean distance, `46092.2` total command energy, score `0.272045`, and
  `85.04/1244.16` force/moment RMS. Requiring targetward relative crossflow to
  be supported by co-signed normalized lateral force improves arrival to
  `33.7260`, mean distance to `1.59412L`, total energy to `45776.3`, and score
  to `0.278591`, without changing the visible route or losing capture.
- That improvement is not unloading: force/moment RMS rise to
  `93.64/1383.73`, and both joint-speed and `30.0` acceleration limits remain
  touched. Targetward local-flow credit is slightly weaker on route and score
  (`33.9900`, `1.59701L`, `0.276097`) and raises loads further to
  `94.55/1395.74`. Direct lateral-force credit in the inherited log regressed
  the coherent baseline to `34.9415`, `1.63256L`, and score `0.240755`.
  Therefore force is supported as an agreement/selectivity signal for
  crossflow, not as a standalone response or load-release signal.

## One candidate hypothesis

Preserve the validated oscillator, posterior lag, raw-bearing mean steering
and reserve, course-slip damping, base half-cycle asymmetry, signed-moment
credit, and coherent speed release. Change only the optional redirect burst's
wake-assistance test: credit targetward relative crossflow only when measured
normalized lateral force co-signs with the requested body-frame turn. This
bounded product rejects crossflow that may simply reflect self-induced slip
while leaving propulsion, mean steering, and base asymmetry intact.

This is an evidence-backed adoption of the strongest sampled structural child,
not a claim of novelty or changed-phase robustness. Reject the mechanism if a
later wake phase loses capture, if its arrival/distance/total-effort advantage
over crossflow-only release does not repeat, or if its higher force/moment load
is unacceptable for the selection objective. Do not reinterpret force
agreement as unloading unless a separate rollout actually lowers load.

```text
bookshelf_consulted: true
source_domain: organized-wake adaptive swimming and sensor-modulated robotic-fish control
source_mechanism: preserve useful wake-induced motion while modulating only a residual maneuver channel with measured hydrodynamic response
transferable_invariant: persistent body-frame target geometry owns route steering, while a fast wake cue should release surplus authority only when an independent normalized body-frame response agrees that the fluid is assisting
nontransferable_details: species kinematics, published gains, exact vortex phase, single-cylinder synchronization, full-body waveforms, dimensional frequencies, and task-specific routes
policy_translation: retain the two-joint traveling carrier and mean steering; gate only optional half-cycle-burst release by the bounded product of targetward relative crossflow and co-signed normalized lateral force
falsification: reject on lost capture, failure to repeat the arrival/distance/total-effort gain over crossflow-only release, or unacceptable force/moment growth; changed wake phase is required for robustness
```
