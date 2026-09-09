# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheet shows the common held fish above and downstream of
  four mature, interacting cylinder wakes whose merged street crosses the
  target neighborhood. It is identical initial-condition evidence, not
  evidence for a candidate-specific route.
- All four current released sheets are finite target captures, so there is no
  sampled failure keyframe to invent a visual diagnosis for. The inherited
  naive-seed lower-domain exit is retained only as metric-backed context. The
  useful contrast is the assigned parent (`solver_f878079fe7ba`) against its
  evaluated no-release predecessor (`solver_df084fc68237`) and the slower
  `40.63`-time alternatives.
- The parent visibly preserves the predecessor's decisive downward-left
  redirect, strong alternating self-generated wake, compact upstream-left
  transit through the cylinder wakes, and first entry into the `0.75L` target
  circle. Its mean velocity `(-0.2776,-0.1153)` versus mean local flow
  `(-0.1532,-0.1670)` includes `0.1244` mean relative upstream motion, so the
  route is self-propelled rather than passive advection.
- Releasing only the extra posterior half-cycle asymmetry after observed
  bearing convergence is a completed positive result: the parent retains the
  predecessor's `39.1104` capture, with essentially unchanged mean distance
  (`1.9153L` versus `1.9149L`), while RMS force/moment fall from
  `57.21/783.64` to `54.19/754.87` and command energy/power fall slightly from
  `50060.7/3768.8` to `50044.8/3768.3`. The scalar score is slightly lower and
  relative crossflow rises from `0.21935` to `0.21986`, so the supported claim
  is selective load relief without route delay, not uniform metric dominance.
- Both parent joints still reach the `260 deg/time` rate and
  `1800 deg/time^2` acceleration caps. The two slower guard samples retain the
  `64.7/876.0` load class, and inherited notes report that a total-action
  outward-rate projection delayed the route. Another cap threshold or blanket
  acceleration guard is therefore unsupported.

## Policy hypothesis before the edit

Preserve the parent's oscillator, approach envelope, posterior lag,
route/current coherence selector, half-cycle structure, current-bearing
authority, and response-completion release. Extend that one validated release
mechanism only to the lagged-history component of anterior route curvature:
when normalized current bearing is small and its windowed magnitude has
actually converged, continuously withdraw the stale history offset toward the
current body-frame bearing. Padded release history, large error, stationary or
diverging error, current target steering, and the traveling-wave carrier remain
exactly unchanged.

This tests whether slow route memory should initiate and sustain the redirect
but cease adding mean curvature after the observed target response completes.
Expected evidence is the same direct self-propelled topology and near-`39.11`
capture, with lower force, moment, effort, excursion, or cap-contact evidence
from reducing residual anterior and tail mean bias. Reject the mechanism if
target success is lost, capture or mean distance regresses to the `40.6` /
`1.98L` class, the initial redirect changes, or load/actuator evidence fails to
improve over the parent. In that case later workers should retain history on
anterior curvature and require calibrated load/flow histories before adding a
disturbance residual. The new CFD outcome is unavailable to this worker and is
not claimed here.

bookshelf_consulted: true
source_domain: biological burst redirects and closed-loop robotic-fish CPG direction tracking
source_mechanism: strong target-directed curvature initiates a redirect, then auxiliary route memory is released when observed alignment response completes while rhythmic propulsion persists
transferable_invariant: slow target history may supply persistent curvature during large error, but only current normalized body-frame geometry should retain authority after a measured converging response reaches alignment
nontransferable_details: species-specific C-start shapes, published gains, dimensional rates and duty ratios, robot morphology, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: preserve the two-joint carrier and current-bearing steering; multiply only the circular-history offset and existing posterior half-cycle boost by the same scale-free bearing-convergence completion complement
falsification: reject if the early redirect or direct capture degrades, or if force, moment, effort, joint excursion, and cap evidence fail to improve over the assigned parent

## Pre-evaluation verification

The mandated guidance semantic check passes after removing a duplicated marker
for the same assigned guidance parent from the rendered workspace `README.md`,
and the solver editable-boundary check passes. Static schema validation finds
all `14` direct `params.FIELD` references among exactly the `14` fields returned
by `target_policy_params()`, with no prohibited mainline observations. A
deterministic algebraic sweep of `218700` states spanning range, current,
persistent, and oldest wrapped bearings, joint angles, and joint rates produced
finite actions. It verified exact evaluated-parent behavior in all `169020`
zero-release or zero-history-offset cases (including `540` padded-history
states), and active contraction of only the lagged route offset toward current
bearing in all `49680` release cases; the existing completion gate stayed in
`[0,1]` and reached both endpoints. The prescribed Julia contract command was
invoked but could not run because this image has no `julia` executable. No
formal CFD was run; this candidate remains a falsifiable hypothesis for EvE.
