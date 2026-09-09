# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheet shows the common held fish at the upper-right and
  four mature, interacting cylinder wakes crossing the target neighborhood.
  It is identical initial-condition evidence for every candidate, not evidence
  for a policy-specific route.
- The assigned parent (`solver_63ab61ca550c`) visibly retains the useful
  downward-left redirect, self-propelled upstream transit, and compact entry
  into the `0.75L` target circle. Its `40.6285` capture and `1.9759L` mean
  distance improve on the fully history-driven sample's `41.5030` and
  `2.0216L`. Mean velocity `(-0.2675,-0.1111)` versus mean local flow
  `(-0.1489,-0.1618)` confirms active upstream propulsion rather than passive
  advection.
- The parent's two-timescale steering did not satisfy its load falsification
  criterion: current-bearing release of posterior half-cycle steering produced
  RMS force/moment `63.65/868.82`, slightly above the fully history-driven
  sample's `61.80/862.48`; both joints still reached the `260 deg/time` rate
  and `1800 deg/time^2` acceleration caps. Faster target approach is therefore
  evidenced, but load relief is not.
- The informative lower-load sample (`solver_b7b629a6b402`) visibly preserves
  the direct carrier topology and reaches at `43.9505`. Its current-bearing
  alignment gate projects only near-cap outward acceleration and lowers RMS
  relative crossflow/force/moment to `0.2093/44.47/657.47`, versus the
  unguarded carrier's inherited `0.2111/49.44/701.26`, without clipping
  reversal acceleration. By contrast, the two byte-distinct but behaviorally
  identical history-plus-guard samples (`solver_a1071d8e0dd6` and
  `solver_bf219ce7fe91`) capture at `41.4205` with `63.05/872.36` loads and
  both caps still active. Their guard was gated by the lagged history-filtered
  turn request, so the evidence does not support treating that composition as
  load relief.
- All four current sampled sheets are finite target captures; none supplies a
  released failure keyframe. The inherited target-blind lower-domain exit is
  used only as metric-backed context, not assigned an unseen visual diagnosis.

## Policy hypothesis before the edit

Keep the evaluated parent's oscillator, approach envelope, circular-history
anterior route curvature, current-bearing posterior half-cycle steering, and
lagged posterior target unchanged. Add one response-conditioned authority
mechanism after the raw joint accelerations are formed: activate the sampled
directional outward-rate projection using **current** body-frame bearing, not
the persistent route bearing. Large current target error leaves the redirect
exactly unchanged; after fast alignment, only acceleration that drives an
already near-envelope joint rate farther outward is removed, while every
reversal remains unchanged. This makes route memory and fast actuator relief
distinct roles and directly tests the activation mismatch exposed by the
history-gated samples.

Expected evidence is retention of the parent's direct topology and faster-than-
history-only capture, with reduced crossflow, force, moment, effort, excursion,
or cap-contact evidence. Reject the mechanism if target success is lost,
arrival regresses to the `43.95` carrier class, reversal action changes, or
loads remain in the `63/870` history-driven class. In that case later workers
should not tune guard thresholds; they should test a differently observed fast
disturbance mechanism. The new CFD outcome is unavailable to this worker and
is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and wake-interaction studies
source_mechanism: separate persistent route modulation from the smallest response-conditioned intervention on a rhythmic carrier
transferable_invariant: slow observed target geometry may steer mean curvature while fast current alignment and normalized actuator state gate selective envelope relief without cancelling the traveling wave
nontransferable_details: published gains, history lengths, dimensional rate limits, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: circular-mean body-frame bearing remains the anterior route signal; current body-frame bearing drives posterior half-cycle steering and gates removal of only near-envelope outward joint acceleration under the two-joint state-feedback contract
falsification: reject if direct capture is lost or materially delayed, any reversal acceleration changes, or force, moment, effort, excursion, and cap evidence remain at the history-driven level

## Pre-evaluation verification

The mandated guidance semantic check, pinned-Julia policy contract, and solver
editable-boundary check pass. Static schema comparison finds every direct
`params.FIELD` reference in the `16` fields returned by
`target_policy_params()`. A non-CFD sweep of `137200` states spanning distance,
bearing, wrapped/empty/persistent histories, joint angles, and rates verifies
finite actions, exact parent behavior in `78400` large-current-error cases,
exact preservation of `181492` reversal actions, and selective projection in
`26176` outward-drive cases. It also verifies that the guard activates after
current alignment while slow route history remains nonzero. No formal CFD was
run; the candidate remains a falsifiable hypothesis for EvE evaluation.
