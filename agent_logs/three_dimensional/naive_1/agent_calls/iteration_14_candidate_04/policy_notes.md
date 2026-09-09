# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled solver evaluations satisfy the frozen evidence contract:
direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders or prewarm, finite moving-window dynamics, and `capture`. I inspected
their combined top-down vorticity and oblique body/Lambda2 sheets, anchored by
the strongest sampled rollout (`solver_02eaf03fe1d2`, score `-0.206060`) and
the clean prefill (`solver_2e35da543303`, score `-0.213890`), and cross-checked
the images against the observations, metrics, diagnostics, trajectories,
policies, assigned-parent notes, and inherited optimizer logs.

The sampled fish are self-propelled rather than advected: each develops a
coherent alternating top-down street and compact paired caudal Lambda2
structures while following a broad target-directed curve. Geometry-scheduled
gait relief reaches capture at `18.65050T` with mean scored distance
`2.09340L`, compared with `18.88149T` and `2.10234L` for the clean
displacement-half-cycle carrier. The assigned parent's response-coupled form
repeats the scheduled result at `18.66150T`, `2.09362L`, and score
`-0.206097`; its visible wake class and route remain intact. This paired result
supports the core target-geometry gait schedule, but the `0.011T` arrival and
`0.00022L` mean-distance differences do not establish the added response-gate
factor as a separate improvement. Neither form is demand relief: inherited
diagnostics place their acceleration contact near `61%/73%`, rate contact near
`11%/15%`, and RMS actions near `27.15/28.62 rad/T^2`.

The inherited phase-leading failure is the informative failed contrast absent
from the four current solver samples. Its top-down street and caudal 3D
structures remain coherent, but after approaching `3.56872L` the fish turns
down and away, exits left at `28.64951T`, and finishes `9.19287L` from the
target. Thus joint velocity must not be restored as a route-phase lead. The
other inherited boundaries also reject another instantaneous velocity
curvature residual, bearing-progress release gate, pointwise joint-rate
barrier, or terminal drive schedule. The unresolved inconsistency is internal
to the successful mechanism: the scheduled effective oscillator envelope is
used by the Van der Pol drive, while displacement phase is still normalized by
the unscheduled base envelope.

## Single-candidate policy hypothesis

Preserve the assigned parent's normalized target geometry, one-sided
correcting-yaw release, differential mean curvature, response-coupled gait
relief, traveling-bend carrier, posterior lag, all gains, and final acceleration
projection. Compute the already existing effective amplitude before the
half-cycle calculation and normalize centered anterior displacement by that
active envelope rather than the base amplitude. This makes the observed
displacement phase coordinate consistent with the gait actually requested;
it does not introduce velocity-led phase, another route signal, a clock, or a
new scalar gain.

Expect both coherent wake views and capture to survive, with half-cycle
steering authority no longer diluted during the scheduled redirect and a
possible improvement in arrival or distance integral beyond the paired
`18.6505--18.6615T` / `2.09340--2.09362L` band. Falsify the mechanism if
capture is lost; the inherited downward/left route returns; arrival or mean
distance leaves the broader sampled capture band; wake coherence, saturation,
or planar loads worsen materially; or steering sign, posterior lag, carrier
frequency, or the owned acceleration envelope changes. The new CFD result is
not available to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by half-cycle amplitude asymmetry
source_mechanism: infer beat side from observed joint state and strengthen a bounded target-owned turn during the useful half-cycle
transferable_invariant: a joint-displacement phase coordinate should be normalized by the active gait envelope so bounded half-cycle steering retains the same meaning when state feedback schedules rhythmic amplitude
nontransferable_details: published gains, duty ratios, clock phase, motor dynamics, robot or species kinematics, exact vortex phases, world-frame paths, and task routes
policy_translation: retain the captured two-joint response-coupled carrier and use its already scheduled effective anterior amplitude as the denominator of the displacement-only half-cycle coordinate
falsification: reject if capture or either coherent wake view is lost, route and distance metrics worsen beyond sampled variability, actuator contact or loads increase materially, or phase normalization changes target-owned sign or introduces velocity-led phase
