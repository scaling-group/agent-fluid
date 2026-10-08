# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheet shows the common held fish at the upper-right while
  four mature, interacting vortex streets occupy the target neighborhood. This
  is common initial-condition evidence, not evidence for any candidate route.
- All four sampled released sheets are finite target captures, so there is no
  sampled failure keyframe to compare. The inherited naive-seed lower-domain
  exit remains metric-backed context only. The useful visual contrast is the
  assigned parent against the slower timescale-split and outward-rate-guard
  samples.
- The assigned parent (`solver_df084fc68237`) makes the same decisive
  downward-left redirect and compact upstream-left transit as the other
  successful carriers, but reaches in `39.1104` with mean distance
  `1.91494L`. Its mean velocity `(-0.2777,-0.1143)` versus mean local
  flow `(-0.1551,-0.1672)` gives `0.1226` mean relative upstream
  motion, confirming self-propulsion rather than passive advection.
- The parent's route/current sign-coherence selector is a semantic improvement
  over the direct current-bearing split (`solver_63ab61ca550c`): arrival
  improves from `40.6285` to `39.1104`, mean distance from
  `1.97593L` to `1.91494L`, RMS crossflow/force/moment from
  `0.2248/63.65/868.82` to `0.2193/57.21/783.64`, and maximum joint
  excursions from `0.574/0.510` to `0.543/0.463` rad. Command energy
  also falls from `52374.2` to `50060.7`. The positive mechanism is
  coherent fast posterior authority, not a gain change.
- Both parent joints still reach the `260 deg/time` rate and
  `1800 deg/time^2` acceleration caps. The two sampled outward-rate-guard
  candidates are behaviorally identical at `40.6450` and retain
  `64.70/875.97` force/moment, so another cap threshold or scalar guard
  edit is unsupported. The parent sheet shows a useful traveling wake and no
  route-scale reversal to justify indiscriminate force, moment, or crossflow
  cancellation.

## Policy hypothesis before the edit

Preserve the evaluated parent's oscillator, approach envelope, circular-history
anterior route curvature, route/current sign-coherence selector, posterior lag,
and every large-error steering action. Add one response-completion mechanism
only to the extra posterior half-cycle bias. Reconstruct the oldest body-frame
bearing from the already exposed wrapped window delta, compare its normalized
turn-request magnitude with the current request, and reduce the extra asymmetry
only in proportion to demonstrated convergence and current alignment. A padded
or stationary history gives zero release; a large error, diverging error, base
posterior traveling wave, anterior route bias, and tail mean bias remain
unchanged.

This translates response-gated burst/redirect control without an elapsed-time
mode or a dimensional response gain. Expected evidence is retention of the
parent's direct target-reaching topology and near-`39.11` arrival, with
lower command effort, force, moment, joint excursion, or cap contact during
aligned transit. Falsify it if capture is lost or materially delayed, if the
early redirect changes, or if completed effort/load evidence does not improve.
If falsified, do not tune convergence or alignment thresholds: preserve the
proven coherence selector and require calibrated load/flow histories before
adding a disturbance residual.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-feedback robotic-fish CPG direction tracking
source_mechanism: retain strong bounded redirect for large target error, then release extra steering asymmetry when observed target-bearing response demonstrates turn completion
transferable_invariant: rhythmic propulsion and slow route curvature should persist while an auxiliary high-authority steering channel is withdrawn according to normalized body-frame error and observed response
nontransferable_details: species-specific C-start shape, robot duty ratios, published gains, dimensional frequencies, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: preserve the two-joint carrier and coherence selector; multiply only the extra posterior half-cycle bias by a smooth complement of small-error alignment and scale-free bearing-window convergence
falsification: reject if the direct capture or early redirect degrades, or if command effort, force, moment, excursion, and cap evidence fail to improve over the assigned parent

## Pre-evaluation verification

The required guidance semantic check passes after removing a duplicated marker
for the same assigned parent from the rendered workspace README, and the solver
editable-boundary check passes. Static schema validation finds all `14` direct
`params.FIELD` references among exactly the `14` fields returned by
`target_policy_params()`; the policy reads only normalized range, body-frame
bearing/history, and two-joint state. An algebraic sweep of `113724` states
spanning range, wrapped bearings and histories, window response, joint limits,
and rate limits produced finite actions with `response_release` in `[0,1]`.
It also verified exact parent action in `78732` large-error or
non-converging cases and nonzero selective release in `34992` aligned,
converging cases. The prescribed Julia include check was invoked but could not
start because no `julia` executable exists on this image or in the searched
system/workspace locations. No formal CFD was run; the candidate remains a
falsifiable hypothesis for later EvE evaluation.
