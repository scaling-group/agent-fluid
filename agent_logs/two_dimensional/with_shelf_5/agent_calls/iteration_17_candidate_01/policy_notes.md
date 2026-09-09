# Multi-wake target-policy candidate notes

## Evidence read before the edit

- The shared prewarm sheet shows the common held fish above and downstream of
  four mature, interacting cylinder streets. It is identical initial-condition
  evidence for every candidate and does not distinguish controller quality.
- Every current sampled rollout reaches the target; there is no sampled failure
  keyframe to diagnose. The useful visual contrast is therefore the fastest
  finite candidate against the slower, most heavily loaded pair. All preserve
  one decisive downward-left redirect, a strong alternating body wake, and a
  compact upstream-left transit without collision, domain exit, or route-scale
  yaw reversal.
- The assigned prefill is also the strongest sampled candidate on every
  aggregate reported here: capture at `39.1104`, mean distance `1.9149L`, RMS
  relative crossflow/force/moment `0.21935/57.21/783.64`, command energy
  `50060.7`, and power proxy `3768.8`. Mean velocity
  `(-0.2777,-0.1143)` versus local flow `(-0.1551,-0.1672)` gives `0.1226`
  mean relative upstream motion, so the direct approach is self-propelled.
- The prefill's sign-coherent posterior selector materially improves its own
  parent, which reaches at `40.6285` with mean distance `1.9759L`, loads
  `63.65/868.82`, and command/power `52374.2/3960.5`. The two directional-rate
  guard samples are slower at `40.6450`, have larger loads `64.70/875.97`,
  larger joint excursions `0.574/0.510` rad, and still reach both rate and
  acceleration caps. The successful selector, by contrast, reduces excursions
  to `0.543/0.463` rad while also improving arrival and effort, although both
  actuator caps remain active.
- Inherited logs show that ungated response-conditioned release reduced loads
  to `36.25/587.15` but delayed capture to `46.6730`, while amplitude reduction,
  phase refinements, terminal localization, and outward-rate guards were inert
  or dominated on this carrier. The reusable boundary is to preserve full
  large-error redirect authority and avoid another scalar threshold refinement
  of those rejected mechanisms.

## Visual diagnosis and policy hypothesis before the edit

The six-frame sheets show no route defect to repair: the winner turns promptly,
straightens through the interacting wake corridor, and enters the target on a
direct topology. Its remaining observable liability is actuator saturation,
not passive advection or repeated wrong-sign turning. The current sign-coherence
gate already demonstrates that separating the persistent route request from a
faster target-bearing request can improve both navigation and loads.

Keep that evaluated carrier, route estimator, sign-coherent posterior selector,
approach envelope, oscillator, and lag equations unchanged. Add one small
response-conditioned mechanism: ease only the extra posterior half-cycle boost
when the current body-frame turn request is small, has the same direction as
the persistent request, and has shrunk relative to that persistent request.
Current/persistent equality at release and all large-error states leave the
winning action exactly unchanged; contradictory fast motion retains the
existing persistent fallback rather than being mistaken for convergence.

Expected evidence is the same direct target-reaching topology and `39.1`-class
redirect with less post-alignment saturation, force, moment, excursion, effort,
or power. Falsify the mechanism if capture is lost or materially delayed, the
large-error action changes, or load/actuator evidence fails to improve. If it
is falsified, do not tune the alignment threshold: preserve the sign-coherent
selector and wait for calibrated flow, load, or target-history traces before
adding another fast disturbance channel.

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish CPG direction tracking
source_mechanism: preserve a high-authority target-directed burst until observed alignment progress supports continuous release into cruise
transferable_invariant: retain the bounded traveling carrier and full large-error curvature, then reduce only extra steering authority after normalized body-frame target observations show coherent convergence
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: compare the bounded current and circular-history body-frame turn requests; smoothly ease posterior half-cycle boost only under small current error, same-direction coherence, and smaller current than persistent error
falsification: reject if the direct capture or large-error redirect degrades, or if force, moment, effort, excursion, and cap evidence do not improve over the sampled prefill

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass.
Static schema comparison finds all `15` direct `params.FIELD` references among
the `15` fields returned by `target_policy_params()`, with no unused field. An
algebraic sweep of `40401` route/current request pairs in `[-1,1]` keeps every
release gate finite and in `[0,1]`; the release is exactly zero for padded
equal requests, opposite-sign requests, and every current request of magnitude
at least `0.5`. The gate is nonzero on `7350` small, same-sign, converging
pairs, so the mechanism is not inert by construction. The prescribed Julia
include check could not run because this workspace image has no `julia`
executable. No formal CFD was run; the candidate remains a hypothesis for the
post-worker evaluation.
