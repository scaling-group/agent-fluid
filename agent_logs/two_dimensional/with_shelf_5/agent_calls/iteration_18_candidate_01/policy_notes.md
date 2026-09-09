# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting cylinder wakes. The merged streets already
  cross the target neighborhood before release, so this is common
  initial-condition evidence rather than evidence for any policy-specific
  route.
- All four sampled released sheets terminate at the target; there is no
  sampled failure keyframe. The inherited naive-seed lower-boundary exit is
  retained only as metric-backed context and is not assigned an unseen visual
  diagnosis. The useful comparison is therefore the strongest finite rollout
  against the slower and higher-load finite alternatives.
- `solver_f878079fe7ba` makes one decisive downward-left redirect, establishes
  a strong alternating self-generated wake, and follows a compact upstream-left
  diagonal through the developed cylinder streets into the `0.75L` capture
  circle. Mean velocity `(-0.2776,-0.1153)` versus mean local flow
  `(-0.1532,-0.1670)`, including `0.1244` mean relative upstream motion,
  confirms self-propulsion rather than passive advection.
- The sign-coherent carrier `solver_df084fc68237` and its response-release
  descendant `solver_f878079fe7ba` both capture at `39.1104`; mean distance
  changes only from `1.91494L` to `1.91533L`. With route topology and arrival
  retained, releasing extra half-cycle asymmetry after observed bearing
  convergence lowers RMS force/moment from `57.21/783.64` to
  `54.19/754.87`, while command energy changes from `50060.7` to `50044.8`.
  This is positive evidence for response completion as a semantic selector,
  not for a scalar gain change.
- Both joints nevertheless still reach the `260 deg/time` rate and
  `1800 deg/time^2` acceleration caps, and maximum excursions remain nearly
  unchanged (`0.543/0.463` versus `0.543/0.464` rad). The slower
  timescale-split sample reaches at `40.6285` with `63.65/868.82` loads, while
  the two behaviorally similar rate-guard samples reach near `40.6450` with
  `64.70/875.97`. Another cap threshold or phase selector is therefore not
  supported by the sampled evidence.

## Policy hypothesis before the edit

Descend from the evaluated response-release policy and preserve its oscillator,
posterior lag, circular-history anterior route curvature, route/current
sign-coherence selector, half-cycle response release, approach envelope, and
all large-error steering. Add one alignment-conditioned gait-envelope
mechanism: the same normalized bearing-convergence signal that has already
demonstrated safe turn completion may smoothly reduce the anterior oscillator
amplitude during aligned transit. Padded history, large error, and diverging
error give zero relief, exactly preserving the decisive release redirect.
Fade the new relief as the existing range-based approach envelope reaches its
floor, so the mechanisms do not compound below the already tested terminal
minimum. Posterior steering and lag remain algebraically unchanged for the
same observed state.

Expected evidence is the same compact, self-propelled target-reaching topology
and arrival no worse than the `40.63` timescale-split class, with lower command
effort, joint cap contact, force, or moment than `solver_f878079fe7ba`.
Falsify the mechanism if capture is lost, mean distance materially regresses,
the initial redirect changes, or load/effort/cap evidence does not improve. If
falsified, later workers should preserve the demonstrated sign-coherence and
half-cycle release, avoid tuning the new envelope floor, and require calibrated
flow/load histories before testing a signed wake-disturbance residual. The new
CFD outcome is unavailable to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: biological burst-to-cruise transitions and sensor-feedback robotic-fish CPG direction tracking
source_mechanism: release high-effort rhythmic authority into a lower-amplitude cruise envelope only after observed target-bearing response confirms alignment
transferable_invariant: preserve bounded route curvature and the traveling wave while normalized body-frame response gates a smooth gait-envelope reduction
nontransferable_details: species-specific burst shapes, robot duty ratios, published gains and amplitudes, dimensional frequencies, clock or vortex phase, cylinder coordinates, and task-specific routes
policy_translation: use current body-frame bearing and its wrapped observation-window delta to reduce only the state-feedback oscillator envelope after convergence; retain two-joint posterior lag and steering, and preserve padded-history and large-error actions
falsification: reject if the direct capture or initial redirect degrades, or if command effort, cap contact, force, and moment fail to improve over the response-release parent

## Pre-evaluation verification

The mandated guidance semantic check and solver editable-boundary check pass.
Static schema validation finds all `15` direct `params.FIELD` references among
exactly the `15` fields returned by `target_policy_params()`, with no unused
field. An algebraic sweep of `354294` states spanning range, current/oldest/
persistent wrapped bearings, joint limits, and rate limits produces finite
actions and keeps the amplitude scale in `[0.75,1.0]`. The new relief is active
in `58320` states; `39366` padded-history states and `266814` large-error or
non-converging states exactly reproduce the evaluated response-release parent.
For an identical state the candidate changes only anterior oscillator drive;
posterior steering and acceleration remain unchanged. The prescribed Julia
include check was invoked but could not start because this image has no
`julia` executable. No formal CFD was run; evaluation remains a falsifiable
hypothesis for EvE.
