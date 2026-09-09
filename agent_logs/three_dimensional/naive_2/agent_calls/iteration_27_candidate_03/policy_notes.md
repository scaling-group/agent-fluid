# Evidence-selected unified rhythmic-handoff candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen Phase 2 flow contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected every combined keyframe sheet, including the
top-down mid-plane vorticity row and the oblique body/Lambda2 row. All four
fish are self-propelled on nearly direct down-left routes behind compact,
body-connected alternating wakes with localized three-dimensional posterior
structures. There is no visible wake collapse, passive advection, broad loop,
boundary event, or numerical instability before capture. The useful contrast
is therefore terminal course control: every sample captures, so the weakest
capture is an informative relative failure rather than a failed termination.

The unified response-and-predicted-miss handoff has the strongest sampled
result. It captures at `15.5008T`, scores `-0.021089`, has normalized distance
integral `1.90236L`, and crosses with raw constant-course miss `0.1790L` and
nearly horizontal targetward velocity `(-1.286,-0.014)L/T`. The assigned
parent's active yaw-arrest transfer still captures, but it arrives later at
`15.8061T`, scores `-0.021747`, and widens terminal course miss to `0.7468L`
with velocity `(-0.774,-1.012)L/T`. That exceeds the parent's own `0.590L`
falsification boundary. The two other captures arrive at `15.7735--16.0270T`
with miss `0.6432--0.6820L`. Across the sample, peak normalized planar
force/moment remains comparable at `0.0348--0.0365/0.0174--0.0180`, near-rate
occupancy remains about `17--18%`, and only one sibling has material posterior
`>40 deg` dwell (`0.418%`). The active yaw-arrest change therefore degraded
terminal geometry without buying wake, load, joint-reserve, arrival, or score
improvement.

Inherited optimizer logs add the robustness boundary. The unified handoff has
a semantic repeat capture at `15.6625T`, but its two known capture-course
misses span `0.179--0.590L`; older identical-controller evidence also contains
threshold-sensitive left exits. Static bend, broad carrier braking,
angle-domain carrier subtraction, and posterior phase selection have already
failed to improve termination and geometry together. The current evidence
supports removing the newly falsified raw-yaw countersteer rather than adding
another unevidenced terminal actuator.

## Single candidate hypothesis

Replace only the parent's active yaw-arrest authority transfer with the
evidence-selected unified response-and-predicted-miss handoff. Preserve all
owned gains, the joint-state traveling-bend carrier, raw normalized body-frame
pursuit/course blend, constant-course predicted miss, terminal mean bend,
posterior mid-stroke pulse, and the common response-plus-geometry release. A
corrective carrier-separated yaw response may release both rhythmic steering
channels only to the extent that predicted miss is already small; released
shared authority returns to the propulsive carrier instead of countersteering
on instantaneous yaw residual. This is a mechanism rollback, not scalar gain
tuning.

The evidence-backed expectation is restoration of the repeatedly captured
unified behavior and removal of the sampled parent's wider, more lateral
terminal crossing. A later evaluation supports the selection only if it
captures, or improves closest pass and termination together, while preserving
the direct compact-wake route, negligible `>40 deg` dwell, roughly `18%` or
less near-rate occupancy, and peak normalized planar force/moment near or below
`0.037/0.019`. Falsify on a miss or left exit, terminal-course miss above the
known `0.590L` repeat boundary, loss of the direct route or coherent wake, or
material joint/load growth. The new CFD evaluation occurs after this worker
exits and is not evidence claimed here.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: return bounded rhythmic steering authority to the propulsive carrier only when measured turn response and remaining target-relative error jointly indicate redirect completion
transferable_invariant: release a rhythmic redirect only when corrective response and small residual geometric miss agree; do not infer that released authority should countersteer on a phase-sensitive yaw signal
nontransferable_details: published gains, robot linkage geometry, species-specific maneuver timing and curvature, dimensional frequency, exact vortex phase, target coordinates, capture pose, and task-specific route
policy_translation: use carrier-separated yaw response and normalized body-frame predicted miss as one reflection-equivariant release gate for both two-joint rhythmic steering channels, with released shared authority returning to the state-feedback carrier
falsification: reject if capture margin or termination worsens, or if terminal-course spread, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance degrades
