# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheet is byte-identical across all four sampled solvers.
  It shows the held fish above and downstream of four mature, interacting
  cylinder streets, with the target embedded in the merged wake. It is common
  initial-condition evidence, not evidence for a candidate-specific route.
- Every sampled released sheet is a finite target capture; no current sampled
  failure keyframe exists. The inherited naive-seed lower-boundary exit is
  therefore retained only as metric-backed context and is not assigned an
  unseen visual diagnosis. The useful contrast is the strongest finite
  prefill against the slower finite alternatives and inherited guarded run.
- The prefill (`solver_df084fc68237`) makes one decisive downward-left redirect,
  establishes a strong alternating self-generated wake, and follows a compact
  upstream-left diagonal through the developed cylinder wakes into the
  `0.75L` capture circle. Mean velocity `(-0.2777,-0.1143)` versus mean local
  flow `(-0.1551,-0.1672)`, including `0.1226` mean relative upstream motion,
  confirms active propulsion rather than passive advection.
- Its semantic-coherence selector is a material improvement over the assigned
  parent's current-bearing posterior channel (`solver_63ab61ca550c`): capture
  improves from `40.6285` to `39.1104`, mean distance from `1.9759L` to
  `1.9149L`, RMS crossflow/force/moment from `0.2248/63.65/868.82` to
  `0.2193/57.21/783.64`, and joint excursions from `0.574/0.510` to
  `0.543/0.463` rad. Command energy and power also fall from
  `52374/3960` to `50061/3769`. Thus withholding fast posterior requests that
  contradict persistent body-frame route geometry improves both route and
  load evidence; it is not merely a scalar-score effect.
- Both joint-rate and acceleration caps are still reached in the prefill, so
  bounded posterior authority remains the dominant unresolved control issue.
  The two byte-identical sampled alternatives capture at `40.645` with the
  higher `64.70/875.97` load class. The inherited current-alignment outward-rate
  projection captures at `40.7715` and `62.41/843.60`; it offers modest load
  relief over the unguarded parent but regresses the route and is dominated by
  the coherence selector. Further rate-guard threshold tuning is not supported.

## Policy hypothesis before the edit

Keep the prefill's carrier, circular-history anterior curvature, approach
envelope, posterior lag, joint-state half-cycle gate, and proven sign-coherence
fallback. Refine only the semantic role of instantaneous posterior steering:
project the existing sign-coherent blend onto the signed interval from zero to
the persistent half-cycle request. Current body-frame bearing may thereby
release persistent authority, but it cannot amplify that authority or reverse
its sign. Padded release history makes current and persistent requests equal,
so the decisive initial redirect is exactly preserved. Later, the fast channel
becomes a response-conditioned release from the burst rather than a second
route command.

Expected evidence is retention of the prefill's direct self-propelled topology
and early redirect, with lower posterior switching, excursion, cap contact,
crossflow, force, moment, or effort from refusing fast amplification and any
residual reversal.
Reject the mechanism if target success is lost, capture/mean distance regress
to the `40.6`/`1.98L` parent class, or completed actuator/load evidence does not
improve over the prefill. If rejected, later workers should not tune the new
release transition; they should require calibrated flow/load histories before
adding a signed wake residual. The new CFD outcome is unavailable to this
worker and is not claimed here.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-feedback robotic-fish CPG direction tracking
source_mechanism: release a high-curvature redirect into rhythmic propulsion when observed alignment responds, while preserving bounded route authority
transferable_invariant: a fast observed response may release but should not amplify or reverse the slower persistent target-directed request
nontransferable_details: species-specific C-start kinematics, clock phase, published gains, dimensional rates, robot morphology, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: circular-mean normalized body-frame bearing retains anterior route curvature and persistent posterior authority; the current-bearing coherent blend is projected between zero and that persistent request before the existing joint-state half-cycle gate
falsification: reject if direct target capture is lost or delayed to the parent class, or if excursion, cap, crossflow, force, moment, and effort evidence fail to improve over the semantic-coherence prefill

## Pre-evaluation verification

The mandated guidance/notes semantic check and solver edit-boundary check pass.
The guidance check initially exposed two identical assigned-parent markers in
the rendered workspace `README.md`; removing the duplicate metadata entry made
the parent unambiguous without changing its identity or evidence. Static schema
validation finds all `14` direct `params.FIELD` references among the `14`
fields returned by `target_policy_params()`, with no unused field. An algebraic
sweep covers `6561` current/persistent-bearing combinations and `164025` joint,
range, and rate states: all actions are finite, the projection is active in
`2447` bearing states, its authority never exceeds or reverses the persistent
request, and all `81` padded-history release cases exactly reproduce the
prefill request. The prescribed Julia include check could not start because
this image has no `julia` executable. No formal CFD was run; evaluation remains
a falsifiable hypothesis for EvE.
