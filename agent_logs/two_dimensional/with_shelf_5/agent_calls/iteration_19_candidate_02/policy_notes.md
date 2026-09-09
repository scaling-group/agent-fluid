# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis before the policy edit

- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting cylinder streets. The target lies inside their
  merged wake, so this is common initial-condition evidence rather than support
  for a memorized route or vortex phase.
- All four sampled released sheets are finite target captures; no sampled
  failure keyframe exists. The inherited naive-seed lower-boundary exit is
  therefore retained only as metric-backed context: it left after `50.127`
  released time, was largely advected, and saturated both joint rate and
  acceleration. No unseen failure trajectory is inferred from it.
- The sampled policies all visibly make the useful behavior missing from that
  seed: a decisive downward-left redirect followed by a compact upstream-left
  transit into the `0.75L` target circle. For the best-score sample
  (`solver_a68507de2b6a`), mean velocity `(-0.2781,-0.1162)` versus mean local
  flow `(-0.1531,-0.1687)` gives about `0.1250` mean relative upstream motion,
  confirming self-propulsion rather than passive advection.
- The assigned prefill (`solver_625dccf30dc5`) has the same direct visual
  topology, but its alignment-conditioned oscillator-amplitude relief is a
  completed negative result relative to the otherwise identical
  response-gated carrier (`solver_f878079fe7ba`): capture slows from `39.1104`
  to `39.2149`, mean distance worsens from `1.91533L` to `1.91592L`, command
  energy rises from `50044.8` to `50246.0`, and RMS force/moment rise from
  `54.19/754.87` to `55.32/764.02`. The current candidate also still reaches
  both joint-rate and acceleration caps. This contradicts extending turn
  completion into propulsive-amplitude attenuation; another amplitude floor or
  alignment-width edit would be scalar tuning of a falsified mechanism.
- The strongest completed candidate is `solver_a68507de2b6a`. Relative to
  `f878`, it releases the lagged route-history component after observed
  convergence while retaining current-bearing steering and the propulsive
  carrier. It improves capture from `39.1104` to `39.0499`, mean distance from
  `1.91533L` to `1.91369L`, and score from `-0.03925` to `-0.03762`; its higher
  `57.05/783.02` RMS force/moment means the supported claim is route/score
  improvement, not load relief.
- The bookshelf's wake-residual and phase-lag options require time-resolved
  sign and scale calibration that the current aggregate diagnostics do not
  provide. Inherited total-action rate guards also delayed the route. Those
  primitives are not added merely because acceleration caps remain active.

## Policy hypothesis before the edit

Replace the prefill's response-conditioned carrier-amplitude relief with the
evaluated response-completion allocation of `solver_a68507de2b6a`: preserve the
full oscillator amplitude outside the existing distance-only approach envelope,
and withdraw only the lagged circular-history steering offset together with the
already auxiliary posterior half-cycle boost when current normalized bearing is
small and its windowed magnitude has actually converged. Padded history, large
or diverging error, current target steering, posterior lag, and the decisive
release redirect remain unchanged.

This is one architectural substitution, not a gain sweep: measured turn
completion releases steering memory without attenuating rhythmic propulsion.
The completed sample predicts retention of the direct self-propelled topology
with approximately `39.05` capture and `1.914L` mean distance. Falsify the
translation if evaluation loses capture, delays into the `39.21` amplitude-
relief class, or does not reproduce the route/score advantage over the assigned
prefill. Its prior load increase is accepted explicitly; later load work should
first obtain calibrated histories rather than retune the completion gate.

bookshelf_consulted: true
source_domain: biological burst redirects and closed-loop robotic-fish CPG direction tracking
source_mechanism: preserve rhythmic propulsion while auxiliary redirect memory is released after observed directional response completes
transferable_invariant: normalized body-frame error and its measured convergence may withdraw auxiliary steering authority without weakening the traveling propulsive carrier
nontransferable_details: species-specific C-start shape, robot duty ratio, published gains, dimensional frequencies, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: keep the two-joint oscillator and current-bearing steering; apply the bounded completion gate only to circular-history offset and extra posterior half-cycle bias, not oscillator amplitude
falsification: reject if direct capture is lost or delayed to the amplitude-relief class, or if route and distance-score evidence fail to improve over the assigned prefill

## Pre-evaluation verification

- The required guidance semantic check passes after removing a duplicate marker
  for the same assigned optimizer parent from the rendered workspace README.
- The solver editable-boundary check passes, leaving exactly one editable
  downstream candidate file.
- Static schema comparison finds all `14` direct `params.FIELD` references in
  exactly the `14` fields returned by `target_policy_params()`. The candidate
  reads only normalized range, body-frame bearing/history, and two-joint state.
- The candidate SHA-256 is byte-identical to the completed
  `solver_a68507de2b6a` sample, providing evaluated contract and CFD evidence for
  this exact policy while making the assigned-prefill substitution auditable.
- The prescribed lightweight Julia include check was invoked but could not
  start because `julia` is absent from this image (`command not found`, exit
  `127`). No formal CFD was run; EvE will evaluate the candidate after exit.
