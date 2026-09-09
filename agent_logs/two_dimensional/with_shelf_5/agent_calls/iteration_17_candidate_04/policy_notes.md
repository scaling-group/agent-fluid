# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheet shows the common held fish at the upper-right while
  four mature, interacting cylinder streets fill the route to the target. It
  is identical initial-condition evidence for every candidate, not evidence
  for a controller-specific path.
- All four sampled released sheets end in finite target capture, so there is no
  sampled failure keyframe to compare. The useful contrast is the strongest
  semantic success against the assigned parent and the two least-efficient,
  byte-distinct rate-guard results; the inherited naive-seed domain exit is
  retained only as metric-backed context and is not given an unseen visual
  interpretation.
- The assigned parent (`solver_63ab61ca550c`) makes one decisive downward-left
  redirect, self-propels through the interacting wake, and enters the `0.75L`
  circle directly at `40.6285`, with mean distance `1.9759L`. Its mean velocity
  `(-0.2675,-0.1111)` versus local flow `(-0.1489,-0.1618)` confirms active
  upstream motion, but RMS crossflow/force/moment are
  `0.2248/63.65/868.82`; excursions reach `0.574/0.510` rad and both joint-rate
  and acceleration caps are reached.
- The two sampled rate-guard variants are behaviorally identical despite
  different bytes: both retain essentially the same visible diagonal route,
  arrive slightly later at `40.6450`, and raise RMS force/moment to
  `64.70/875.97`. Together with the inherited current-bearing guard result
  (`40.7715`, `62.41/843.60`), this is evidence that near-cap projection gives
  at most modest load relief on this faster carrier and is not the next
  mechanism to retune.
- The strongest sampled policy (`solver_df084fc68237`) instead withholds the
  fast posterior request when its sign contradicts the persistent body-frame
  route. Its sheet retains the same compact wake-crossing topology but reaches
  sooner at `39.1104` with mean distance `1.9149L`, greater active upstream
  relative motion `0.1226`, lower RMS crossflow/force/moment
  `0.2193/57.21/783.64`, lower excursions `0.543/0.463` rad, and lower command
  energy `50060.7`. Rate and acceleration caps remain active, so the coherent
  selector is an evidenced route-and-load improvement but not complete
  response release.

## Policy hypothesis before the edit

Use the strongest sampled agreement selector as the new base and add one
response-conditioned burst-release mechanism. Persistent circular-mean
bearing continues to own anterior mean curvature; coherent persistent/current
bearing continues to select posterior turn direction. When the wrapped
body-frame bearing has already moved toward zero over the supplied observation
window, continuously attenuate only the extra target-favored posterior
half-cycle request in proportion to that observed angular progress. Leave
mean curvature, the propulsive carrier, posterior lag, approach envelope, and
all worsening/stagnant-error behavior unchanged. Padded observations give zero
release until target-relative convergence is actually observed, preserving the
start of the strongest sample's decisive redirect.

The invariant is response semantics, not scalar gain tuning: do not reinforce
a burst-scale steering asymmetry after the measured target-relative turn is
already succeeding. Expected evidence is preservation of the direct capture
and the `39.11`-class arrival with lower posterior cap contact, excursion,
crossflow, force, moment, or effort. Reject the mechanism if the release loses
target success, delays capture beyond the assigned parent's `40.6285`, changes
the direct topology, or fails to improve any load/actuator measure over the
agreement-gated sample. In that case later workers should preserve the
agreement selector and require calibrated flow/load histories before adding a
different fast disturbance residual. The new CFD result is unavailable to
this worker and is not claimed here.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-feedback robotic-fish CPG direction tracking
source_mechanism: release high-curvature steering into the propulsive rhythm once an observed target-relative turning response appears
transferable_invariant: persistent error and observed error reduction are distinct feedback roles; preserve route curvature while withholding only extra fast steering that would reinforce an already-converging turn
nontransferable_details: species-specific C-start kinematics, published gains and history lengths, dimensional frequencies, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: circular-mean body-frame bearing retains anterior curvature, sign-coherent current and persistent bearing select the posterior half-cycle, and normalized wrapped bearing-window progress attenuates only that extra posterior asymmetry under the two-joint state-feedback contract
falsification: reject if direct target capture is lost or delayed beyond the parent, or if excursion, cap contact, crossflow, force, moment, and effort all fail to improve over the agreement-gated sample

## Pre-evaluation verification

- The mandated material-guidance check passes after removing one duplicated
  assigned-parent marker from the rendered workspace `README.md`; the parent
  identity itself is unchanged. The solver editable-boundary check also passes.
- Static schema validation finds exactly one policy implementation and all `14`
  direct `params.FIELD` references among the `14` fields returned by
  `target_policy_params()`, with no missing or unused active field.
- An algebraic sweep of `45360` states spanning distance, wrapped histories,
  current bearing, window progress, both joint limits, and both rate limits
  produces finite actions. It exactly preserves the anterior command and all
  `28512` stagnant/worsening-error cases, never amplifies or reverses the
  coherent posterior request, and selectively releases `16848` converging
  cases.
- Replaying the response selector over the strongest sampled trajectory makes
  it active on `47.48%` of states, with full-trajectory median/p90/max release
  `0/0.315/0.502`; the first `0.25` released time remains exactly unchanged.
  This calibrates the mechanism as selective rather than persistent shutdown.
- The prescribed Julia include/assert check could not execute because the base
  image has no Julia channel; an isolated `juliaup` attempt was blocked while
  downloading the version database by a connection reset. No formal CFD was
  run, and the candidate remains a falsifiable hypothesis for EvE evaluation.
