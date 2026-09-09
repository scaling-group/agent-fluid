# Target-line-rate posterior phase-lag candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I compared the combined sheets for the highest-score capture
`solver_f792c48d0852` and the lowest-score capture `solver_11c13c1fcaff` from
release through termination, including the top-down mid-plane vorticity row
and oblique body/Lambda2 row. Both fish self-propel on the same nearly direct
down-left route behind a compact, alternating, body-connected wake with
localized posterior three-dimensional structures. Neither sheet shows passive
advection, wake breakup, a boundary event, or numerical instability. The
useful contrast is therefore terminal control quality, not propulsion.

The prefilled target-line-rate handoff is a mixed positive result. It preserves
capture, the direct route, zero joint dwell above `40 deg`, and the established
normalized peak planar force/moment class (`0.03631/0.01797`). It also has the
best sampled score and distance integral (`-0.01965/1.90130L`), improving on
the unified response-plus-miss parent (`-0.02109/1.90236L`). However, it
arrives later (`15.6893T` versus `15.5008T`) and crosses with velocity
`(-1.112,-0.671)L/T`, raw target-relative course miss `0.674L`, and absolute
target-line rate `1.562/T`. These terminal quantities fail its stated
`<0.590L` margin criterion and remain much worse than the centered parent's
`0.179L` miss and `0.411/T` line rate. The line-rate handoff nearly arrests
body yaw at the crossing (`0.073 rad/T`) but does not arrest lateral
translational course. Its score gain is real, but it is not evidence that the
shared half-cycle actuator solved redirect-to-cruise robustness.

The sampled active yaw-arrest and duty-skew alternatives confirm the boundary:
they retain the same compact wake but cross with `0.747L` and `0.717L` raw
course miss, respectively. Assigned-parent logs also reject scalar retuning of
static bend, broad carrier braking, posterior pulse phase selection, course
release qualification, and moment-residual steering. The next candidate
therefore preserves the target-line-rate observation and the propulsive
carrier but changes the actuator through which released terminal authority
acts.

## Single candidate hypothesis

Start from the prefilled target-line-rate controller, retaining all far-field
navigation, the state-feedback anterior oscillator, the posterior traveling
wave and pulse, constant-course prediction, bounded mean bend, and the shared
response-plus-miss release. Replace only the released line-rate contribution
to shared half-cycle amplitude asymmetry. Use that same bounded, closing-only
authority to modulate posterior phase lag according to target-line-rate sign
and centered anterior joint phase. The lag grows on one supporting wave
quadrant and shrinks on its reflected counterpart, so the modulation has no
persistent bend, remains reflection equivariant, and leaves the anterior
carrier and minimum target-steering share continuously active.

The hypothesis is that posterior wave-shape steering can turn the reactive
tail contribution against lateral terminal momentum after body yaw has already
settled, while preserving the direct compact-wake route and the score/progress
gain of target-line-rate feedback. Support requires capture with raw terminal
course miss below `0.590L`, preferably approaching `0.179L`, score and distance
integral comparable to the prefill, negligible `>40 deg` dwell, near-rate
occupancy in the existing class, and normalized peak planar force/moment near
or below `0.037/0.019`. Falsify on a miss or worse termination, terminal miss
at or above `0.590L`, loss of the prefill's score/progress gain without a clear
margin improvement, altered far-field route, wake decoherence, joint/load
growth, nonfinite commands, or loss of reflection equivariance. Formal CFD is
deferred to EvE and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: elongated-body reactive thrust and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve an autonomous anterior rhythm while bounded directional feedback changes the posterior phase relationship that shapes reactive tail thrust
transferable_invariant: when body yaw is settled but target-normal translation remains large, terminal course feedback should reshape the posterior traveling wave rather than merely retune or replace shared amplitude asymmetry
nontransferable_details: published phase lags and gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, exact vortex phase, task coordinates, and fixed routes
policy_translation: use normalized body-frame target-line rate, the existing closing response-plus-miss authority, and centered anterior joint phase to modulate the owned posterior lag gain while retaining the two-joint carrier and minimum rhythmic target steering
falsification: reject if capture margin, score/progress, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The mandated guidance-materiality, lightweight Julia contract/schema, and
solver editable-boundary checks pass. A deterministic `62,208`-state grid over
normalized body-frame target geometry and velocity, target distance, body yaw
response, and both joint angles and rates produced finite commands strictly
inside the smooth `30 rad/T^2` envelope with exact left/right reflection
(maximum error `0.0`). The posterior phase-lag candidate differs from the
evaluated target-line-rate prefill by as much as `2.80007 rad/T^2`, confirming
an active feedback mechanism rather than a comment or scalar-only edit. These
checks are algebraic only; formal CFD remains deferred to EvE.
