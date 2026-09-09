# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the common held fish at the upper downstream
edge of four mature, interacting cylinder streets. It fixes the initial wake
phase but is not candidate-specific. The released sheets for all four sampled
solvers show self-propelled upstream-left travel: each fish makes one decisive
targetward redirect, keeps a posterior traveling bend, enters the interacting
wake corridor, and reaches the `0.75L` capture boundary without collision or a
repeated yaw reversal. In particular, the history-filtered parent has mean
velocity `(-0.2618,-0.1084)` versus mean local flow
`(-0.1496,-0.1600)`, so its upstream motion is not passive advection.

No current sampled solver is a semantic failure. The inherited naive-seed
failure remains the applicable failure boundary: a target-blind fish was
advected through the lower domain boundary after `50.127` while reaching both
rate and acceleration caps. The present family visibly fixes that missing
redirect, so this candidate must preserve body-frame target steering rather
than suppressing lateral motion indiscriminately.

The assigned history-filtered parent is a real semantic improvement over the
byte-identical unfiltered carrier. It shortens capture from `43.9505` to
`41.5030` and mean distance from `2.1391L` to `2.0216L`. The improvement is
not load relief: command energy rises from `53082.6` to `53802.7`, RMS
crossflow/force/moment rises from `0.2111/49.44/701.26` to
`0.2246/61.80/862.48`, maximum joint excursions rise from
`0.525/0.452` to `0.579/0.527` rad, and both joints still reach the
`4.5379` rate and `31.4159` acceleration envelopes. Thus short bearing
history is useful as a faster route selector but is falsified as a standalone
wake/load filter.

The distinct sampled two-joint outward-rate projection supplies compatible
actuator evidence. On the unfiltered carrier it preserves the exact
`43.9505` capture time while reducing mean distance to `2.1372L`, command
energy to `52868.1`, and RMS crossflow/force/moment to
`0.2093/44.47/657.47`. Its sheet retains the same redirect and traveling-bend
topology. Although peak rate and acceleration remain capped, the projection
removes only acceleration that drives an already near-envelope joint farther
outward after target alignment; reversal acceleration is unchanged. This is
more specific than the already rejected amplitude, phase, range-localization,
or scalar-threshold directions.

## Policy hypothesis before the edit

Keep the parent's circular bearing-history route estimate, bounded mean
curvature, target-favored joint-state half-cycle, approach taper, and posterior
lag unchanged. Add the independently evaluated alignment-gated outward-rate
projection to both raw joint accelerations. Use the same filtered turn request
for the alignment gate so route estimation and actuator relief share one
body-frame semantic: full authority during redirect, then projection only of
cap-driving outward acceleration during aligned transit. Preserve every
reversal exactly, avoiding indiscriminate damping of useful wake motion or the
traveling bend.

Expected evidence is retention of the parent's compact direct route and
`41.5`-class capture, with lower command energy, crossflow, force, moment,
joint excursion, or cap-contact duration. Falsify the combination if target
capture is lost or materially delayed, the initial redirect changes, or load
and saturation evidence does not improve over the history-filtered parent. If
falsified, do not tune the history blend or rate thresholds; keep the measured
arrival/load tradeoff explicit and test a distinct observation-side feedback
primitive.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and adaptive wake swimming
source_mechanism: separate persistent route estimation from a small response-conditioned residual at the rhythmic actuator boundary
transferable_invariant: let slow body-frame target geometry select mean route while attenuating only cap-driving outward actuation after observed alignment, preserving the propulsive carrier and all reversals
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phases, learned routes, fixed cylinder or target coordinates, and source-specific history lengths
policy_translation: retain the circular body-frame bearing-history turn request and add a parameter-owned near-rate-envelope projection to each raw joint acceleration, gated off during large target error and inactive for reversal acceleration
falsification: reject if direct capture or redirect authority degrades, arrival is materially delayed, or effort, crossflow, force, moment, joint excursion, and cap evidence fail to improve relative to the history-filtered parent

## Pre-evaluation verification

The required guidance semantic check and solver boundary check pass. Static
schema comparison found all `16` direct `params.FIELD` references among the
`16` fields returned by `target_policy_params()`, with no unused field or
policy-owned time, step, case, cylinder, inflow, station, random, or
world-route input. An algebraic sweep of `39375` states spanning approach
range, wrapped and empty bearing histories, both target-error signs, both joint
limits, and rates through the guard and hard envelopes returned finite actions
and bounded turn requests; every reversal acceleration was exactly preserved,
and projected outward acceleration never increased in magnitude. The
prescribed Julia include/assertion check was attempted but could not start
because this workspace has no `julia` executable. No formal CFD was run; the
candidate outcome remains evidence for a later worker.
