# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the common held fish above and downstream of
four mature, interacting cylinder streets; it anchors the initial disturbance
field but does not distinguish candidates. The three byte-identical strongest
sampled policies make one immediate targetward redirect, sustain a posterior
traveling bend, and swim a compact upstream-left diagonal to first crossing of
the `0.75L` target boundary. They reproduce capture after `43.9505`, mean
distance `2.1391L`, and RMS relative crossflow/force/moment
`0.2111/49.44/701.26`. Mean velocity `(-0.2471,-0.1020)` differs materially
from mean local flow `(-0.1342,-0.1556)`, especially upstream, so the approach
is self-propelled rather than passive advection. Both rate and acceleration
envelopes are nevertheless reached.

No current sampled solver is a semantic failure. The most informative
mechanism-level negative comparison is the assigned parent's alignment-gated
amplitude reduction. Its sheet preserves the same broad direct topology and
still captures, but arrival moves to `44.8525`, mean distance to `2.1708L`,
command energy to `54872.1`, and RMS crossflow/force/moment to
`0.2188/69.92/948.62`. Maximum joint angles increase to `0.570/0.512` rad from
the carrier's `0.525/0.452` rad while the same rate and acceleration caps remain
active, and mean relative streamwise flow falls from `0.1129` to `0.1074`.
The visibly larger terminal body/wake excursion therefore agrees with the
diagnostics: lowering the nominal oscillator amplitude after alignment did not
produce a lower-load cruise regime on this saturated nonlinear carrier.

The distinct sampled phase-lead policy also keeps the route but raises force
and moment to `53.18/736.58`; inherited phase-selective and terminal-localized
rate projections are dominated or inert. A raw yaw-moment residual previously
raised loads sharply. These results exclude another amplitude, phase, range,
rate-threshold, or uncalibrated force/moment edit. The useful route has no
visible repeated yaw reversal, so the present edit must preserve rather than
cancel wake-induced lateral motion.

## Policy hypothesis before the edit

Restore the repeatable carrier's oscillator, approach taper, body-frame
mean-curvature bias, target-favored joint-state half-cycle, posterior lag, and
reversal equations. Add one observation-side mechanism: compute the circular
mean of the testbed-provided short body-frame bearing history and blend it with
the current bearing before forming the existing bounded turn request. Early
history is padded with the current observation, so initial redirect authority
is preserved without a clock or mode switch. During transit, the blend should
separate persistent target geometry from fast tailbeat/wake-yaw bearing
oscillation without changing gait amplitude, oscillator phase, posterior rate
limits, or useful passive crossflow.

Expected evidence is the same compact direct trajectory and `43.95`-class
capture, with smaller terminal body/wake excursions and lower force, moment,
command, or cap-contact evidence. Falsify the mechanism if target capture is
lost or materially delayed, the initial redirect or direct topology changes,
or the load/saturation evidence remains unchanged or worsens. In that case,
do not tune the history blend or window length; the available compact evidence
does not support further target-bearing filtering.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and wake-swimming history feedback
source_mechanism: separate persistent route error from fast oscillatory sensory disturbance before modulating a rhythmic carrier
transferable_invariant: preserve the bounded traveling gait while a short observed body-frame history supplies the slow target-turn component instead of reacting fully to every instantaneous yaw-induced bearing fluctuation
nontransferable_details: published gains, history lengths, clock phase, species or robot kinematics, learned routes, exact vortex phase, cylinder coordinates, and task-specific target coordinates
policy_translation: circularly average the provided body-frame bearing history, blend it with current bearing through a parameter-owned bounded fraction, and feed only that persistent bearing into the existing curvature and half-cycle commands
falsification: reject if the direct redirect or capture degrades, arrival is materially delayed, or force, moment, effort, and saturation fail to improve relative to the repeatable carrier

## Pre-evaluation verification

The required guidance semantic check and solver boundary check pass. Static
schema comparison found all `13` direct `params.FIELD` references among the
`13` fields returned by `target_policy_params()`, with no unused field and no
policy-owned `L`, time, step, case, cylinder, or world-route observation. An
algebraic sweep of `11340` states spanning approach range, both bearing signs,
both joint limits, both rate limits, smooth/ramping/wrapped/empty history
patterns, and padded release history returned finite actions and bounded turn
requests. Padded release history reproduced current bearing to within
`2.3e-16`. The prescribed Julia include/assertion was attempted but could not
start because this workspace has no `julia` executable. No formal CFD was run;
the candidate's outcome remains evidence for a later worker.
