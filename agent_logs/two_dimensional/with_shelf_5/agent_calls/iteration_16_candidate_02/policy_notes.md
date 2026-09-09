# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The byte-identical shared prewarm sheets show the held fish at the upper-right
of four developed, interacting cylinder wakes, with vortex streets already
crossing the target neighborhood. This is a common initial condition, not a
candidate-specific route.

All four sampled released sheets show an immediate correct-sign redirect, a
coherent posterior traveling bend, and active upstream-left swimming through
the wake corridor into the `0.75L` target circle. The fastest sample reaches
after `40.6285` with `1.9759L` mean distance; its mean velocity
`(-0.2675,-0.1111)` differs materially from local flow
`(-0.1489,-0.1618)`, especially upstream, so the approach is not passive
advection. No sampled solver supplies a released failure keyframe. The
inherited naive-seed lower-domain exit is therefore retained only as
metric-backed context and is not assigned an unseen visual diagnosis.

The useful sampled contrast separates route quality from loading. The
current-bearing, alignment-conditioned rate-projection policy preserves the
compact route and reaches in `43.9505`, with low RMS force/moment
`44.47/657.47`. Circular history filtering applied to both mean curvature and
posterior half-cycle steering shortens capture to `41.5030` and mean distance
to `2.0216L`, but raises excursions and RMS force/moment to
`61.80/862.48`. The isolated two-timescale sample keeps history only for mean
curvature and returns posterior half-cycle steering to current bearing; it
further improves capture to `40.6285` and mean distance to `1.9759L`, lowers
mean command from `1296.36` to `1289.10`, and slightly reduces excursions,
while its `63.65/868.82` loads remain close to the fully filtered sample. The
prefilled policy combines full history with two direction-aware rate guards
and captures in `41.4205` at `63.05/872.36`; it is semantically identical to
the independently sampled `solver_a1071d8e0dd6` aside from comments.

Inherited optimizer logs bound the other options. Instantaneous yaw-moment
feedback raised loads and delayed capture; phase-leading the half-cycle also
raised loads; terminal-only guard localization was inert; and aligned global
amplitude reduction delayed capture while increasing loads. In contrast,
direction-aware outward-rate projection repeatedly preserved success and
reduced distributed loads, even though cap contact remained. Those results
support keeping the prefill's guards while changing only the observation used
by posterior corrective steering.

## Policy hypothesis before the edit

Test one two-timescale steering mechanism on the prefilled guarded carrier.
Keep the circularly filtered body-frame bearing for anterior mean curvature
and for the alignment gate that protects the large-error redirect. Use current
body-frame bearing only for the target-favored posterior half-cycle. Preserve
the oscillator, posterior lag, approach envelope, numerical parameters, and
both direction-aware outward-rate projections exactly.

The history signal represents persistent route geometry; the current signal
lets posterior asymmetric steering release or reverse without inheriting the
route filter's lag. The isolated sampled comparison predicts a direct target
capture faster than the prefill's `41.4205` and mean distance below
`2.0142L`, while the retained guards may keep RMS force/moment near or below
the prefill's `63.05/872.36`. Falsify the combination if it loses target
success or the compact route, fails to improve either arrival or mean distance
over the prefill, or increases loads without a useful route improvement. The
new CFD result is unavailable to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: wake-interaction studies and closed-loop robotic-fish direction tracking
source_mechanism: separate persistent target geometry from fast corrective steering while preserving the propulsive traveling bend
transferable_invariant: distinct observed timescales should have distinct bounded control roles, with slow body-frame target geometry governing route curvature and current body-frame error governing corrective posterior asymmetry
nontransferable_details: recurrent-network architecture, published gains, species kinematics, dimensional frequency, exact vortex phase, cylinder coordinates, target coordinates, and task-specific routes
policy_translation: circularly average normalized body-frame bearing for anterior mean curvature and retain current normalized body-frame bearing for the target-favored posterior half-cycle under the existing two-joint state-feedback and rate-guard contract
falsification: reject if direct target capture or route compactness is lost, arrival and mean distance do not improve over the fully history-driven guarded prefill, or loads rise without a useful trajectory improvement

## Pre-evaluation verification

The guidance semantic check passes after removing a duplicated, byte-identical
assigned-parent marker from the rendered workspace `README.md`. The solver
editable-boundary check passes. Static schema inspection found all `16` direct
`params.FIELD` references among the `16` fields returned by
`target_policy_params()`, the candidate remains non-empty, and exactly one
`candidate_target_policy.jl` exists in the multi-wake policy directory. The
prescribed Julia include/assertion could not start because this runtime has no
`julia` executable; this is an environment limitation, not a passed runtime
check. No formal CFD was run.
