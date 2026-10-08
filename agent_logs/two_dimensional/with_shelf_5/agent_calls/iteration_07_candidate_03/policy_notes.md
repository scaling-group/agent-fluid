# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the fixed held-fish initial condition: four
developed staggered-cylinder vortex streets already overlap the target corridor
and extend to the upper-right release pose. It does not distinguish policies.

The assigned parent and three current sampled copies show the same strong
finite behavior. Their released sheets show an immediate correct-sign redirect,
a coherent posterior traveling bend, and a compact upstream-left diagonal into
the merged wake and target. All reach the `0.75L` boundary after `43.9505`, with
`2.139L` mean distance, about `5.31e4` total command energy, and RMS lateral
force/moment of `49.4/701`. Mean fish velocity `(-0.247,-0.102)` versus local
flow `(-0.134,-0.156)` confirms controlled upstream motion rather than passive
advection. The clean no-taper ablation has the same visible topology and arrival,
changing mean distance only to `2.141L`; more terminal scalar scheduling is not
supported.

No current sampled solver is a failure, so the required contrast uses the best
finite sample against the informative inherited right-exit rollout. That failure
never establishes a traveling targetward bend, exits after `16.791`, moves
`(+2.175,-0.869)L`, and has `-0.147` progress. Inherited notes additionally
record the naive seed's adverse lower-boundary curl and failures from larger
static curvature and global carrier relief. These rule out more always-on bend
or a scalar carrier retune.

The inherited response-release branch supplies a sharper local experiment. It
attenuates up to `35%` of only the posterior half-cycle boost when body-frame
bearing is already converging. It still follows a useful diagonal and reaches
the target, while RMS force/moment fall to `36.3/587` and relative crossflow RMS
falls from `0.211` to `0.206`. But arrival is delayed to `46.673`, mean distance
worsens to `2.250L`, and total command energy rises to `5.66e4`. Thus response
conditioning genuinely changes the physical trajectory and loads, but releasing
the evaluated baseline boost sacrifices route efficiency.

## Policy hypothesis before the edit

Preserve the evaluated carrier, bearing bias, posterior lag, state-phased
half-cycle boost, and approach envelope exactly as the assigned parent uses
them. Add one response-gated recovery mechanism: when the sign product of
bounded body-frame bearing demand and `bearing_window_rate` is positive, the
angular error is worsening, so smoothly add a small bounded fraction of the
posterior boost on the already target-favored joint-state half-cycle. When
history is absent or bearing is steady/converging, reproduce the parent boost
exactly. This tests the complementary half of the inherited release result
without weakening the fast redirect or increasing static anterior curvature.

Expected evidence is preservation of the direct `43.9505`-class route with
quicker correction of any visible bearing reversal in the merged wake, yielding
no worse capture and preferably a smaller distance integral. Falsify the
mechanism if the route becomes more curved, capture is delayed or lost, the
traveling bend collapses, or load/effort rises without better arrival or mean
distance. Formal CFD remains post-worker evidence.

bookshelf_consulted: true
source_domain: biological C-start or burst redirect and closed-loop robotic-fish CPG turning
source_mechanism: retain the propulsive rhythm and add transient asymmetric tail authority only while observed directional error is worsening
transferable_invariant: a large or growing body-frame direction error can gate a bounded posterior steering burst, whose phase comes from joint state and whose release comes from observed response
nontransferable_details: published gains and duty ratios, species-specific burst kinematics, dimensional timing, clock phase, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: preserve normalized bearing-to-curvature feedback and the evaluated joint-state half-cycle boost; multiply only that posterior boost by a bounded factor above one when `turn_request * bearing_window_rate` is positive
falsification: reject if the fast diagonal capture is delayed or lost, bearing reversals persist, the traveling bend degrades, or effort and force/moment increase without a distance-integral benefit

## Pre-evaluation verification

At zero bearing the recovery residual and both actions are zero at zero joint
state. With missing history or non-worsening bearing, `bearing_window_rate`
contributes no recovery and the posterior boost is exactly the assigned parent.
For worsening bearing the multiplier stays in `[1,1.2]`; at saturated request
the peak favored-half boost is therefore at most `4.8 deg`, while the anterior
`8 deg` limit and the carrier are unchanged. A deterministic sweep of `10,125`
combinations spanning approach range, bearing signs, window-rate signs, joint
limits, and rate limits returned finite actions and multiplier bounds
`1.000--1.1999`. Static schema inspection confirms every direct
`params.FIELD` reference is returned by `target_policy_params()`.

The guidance semantic check and solver editable-boundary check pass. The
prescribed Julia include/assertion could not start because this runtime has no
`julia` executable; this is an environment limitation rather than a detected
contract failure. No formal CFD was run.
