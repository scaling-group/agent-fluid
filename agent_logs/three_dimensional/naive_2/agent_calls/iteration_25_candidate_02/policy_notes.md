# Unified response-and-predicted-miss handoff selection

## Visual diagnosis before policy editing

All four sampled solver rollouts satisfy the Phase 2 flow contract: direct
uniform initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
I inspected every combined keyframe sheet, including both its top-down
mid-plane vorticity row and oblique body/Lambda2 row. All four fish are
self-propelled rather than advected: each follows a direct down-left approach
behind a compact alternating wake, with localized three-dimensional posterior
structures and no wake collapse, broad loop, boundary event, or numerical
instability before capture. The current sample contains no failed termination
to compare visually; inherited logs supply the relevant left-exit near misses.

The sampled controllers all capture at `0.74729--0.74998L`, but their terminal
geometry and efficiency differ. The unified response-and-predicted-miss
handoff captures earliest at `15.5008T` and has the best score (`-0.021089`),
lowest normalized distance integral (`1.90236L`), and most centered terminal
course: its head ends at `(9.729,9.329)L` with velocity
`(-1.286,-0.014)L/T`. The current corridor-gated prefill captures at
`15.9209T`, crosses lower at `(9.529,8.972)L` with velocity
`(-0.834,-0.942)L/T`, and has the weakest sampled score (`-0.025487`). Its
posterior joint alone dwells beyond `40 deg` for `0.276%` of samples. The
unified sample has no `>40 deg` dwell; its `17.84/17.03%` near-rate occupancy
and peak normalized planar force/moment `0.03653/0.01801` are slightly higher
than some siblings but remain comparable and bounded. Thus stronger drive,
static bend, and scalar gain tuning are not supported; the observed difference
is a terminal rhythmic-authority handoff.

Inherited notes sharpen the boundary. Identical-controller repeats previously
turned sampled captures into `1.2164L` and `1.0117L` left-exit misses, while
angle-domain carrier subtraction lowered effort but still missed at `0.8293L`.
Those results rule out treating a threshold capture, lower effort, or carrier
phase estimation alone as robustness. They support retaining raw normalized
body-frame target/course geometry and requiring it to agree with measured
corrective yaw before releasing steering.

## Single candidate hypothesis

Select the best sampled controller mechanism rather than add another gain to
the current prefill. Preserve the joint-state traveling-bend carrier,
body-frame pursuit/course blend, predicted time-to-closest and signed miss,
bounded terminal mean bend, shared half-cycle steering, posterior mid-stroke
pulse, and all established gains. Replace the current fixed lateral corridor
handoff with one continuous consensus signal: corrective carrier-separated yaw
may release both rhythmic steering channels only in proportion to how small
the existing bounded predicted-miss request has become. This removes the two
corridor threshold parameters and makes the half-cycle and posterior-pulse
handoffs use the same normalized residual without adding a clock, coordinate,
route, or scalar-only tune.

The evidence-backed expectation is preservation of capture with a more
centered, earlier terminal crossing than the corridor prefill. A later repeat
supports the selection only if capture or a better-than-`0.8293L` pass and
termination survive together with the direct route, compact wake, negligible
`>40 deg` dwell, comparable joint-rate occupancy, and peak normalized planar
force/moment near or below `0.037/0.019`. Falsify it on another left exit,
larger low-side miss, wake or route change, persistent steering pinning, or
material joint/load growth. The new CFD evaluation occurs after this worker
exits and is not evidence claimed here.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: return authority from bounded rhythmic steering to the propulsive carrier only when measured turn response and remaining direction error jointly indicate redirect completion
transferable_invariant: corrective response alone is not a completion signal; release steering only when target-relative geometric miss is also small
nontransferable_details: species-specific curvature and maneuver timing, published gains, robot linkage geometry, dimensional beat frequency, exact vortex phase, target coordinates, and task-specific route
policy_translation: combine carrier-separated corrective yaw with the complement of bounded body-frame predicted miss, and use that reflection-equivariant consensus to hand off both existing two-joint rhythmic steering channels
falsification: reject if capture or closest pass and termination do not improve together, or if direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection symmetry degrades

## Dry validation only

The required guidance-materiality check, lightweight Julia contract test,
direct parameter-schema comparison, and solver editable-boundary audit pass.
The candidate has no clock, step, random, cylinder, world-position, or target
coordinate reference, and every direct `params.FIELD` access is owned by
`target_policy_params()`. No CFD was run in this worker.
