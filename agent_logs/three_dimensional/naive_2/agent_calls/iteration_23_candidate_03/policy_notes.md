# Target-signed posterior-stroke redirect candidate

## Evidence and visual diagnosis before editing

All four sampled evaluations satisfy the frozen evidence contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. Three byte-identical executions of the prefilled always-pulse
policy capture at `15.983--16.044T` and `0.7472--0.7500L`; a
response-released-pulse sibling captures at `16.016T` and `0.7486L`. I
inspected both rows of the combined sheet for the highest-score capture and the
assigned parent's latest informative failure. The capture follows a nearly
direct down-left path behind compact, body-connected alternating top-down
vorticity and localized paired oblique Lambda2 structures. The fish is
self-propelled rather than advected, and the wake remains coherent through
capture.

The sampled captures agree with the metrics: joint angles remain below
`37.9 deg`, each joint spends about `17%` of logged steps within `10 deg/T` of
the rate limit, and peak normalized planar force/moment is only
`0.033--0.037/0.017--0.019`. This supports preserving the full traveling-bend
carrier, body-frame constant-course prediction, bounded terminal mean bend,
and far-field half-cycle steering. First crossing stops the episode at
`0.75L`, so the final distance itself cannot distinguish capture margin; the
semantic evidence is repeat capture with arrival, route, wake, and load class.

The assigned parent logs delimit terminal phase changes more sharply. The
response-released posterior pulse has mixed evidence: its sampled execution
captures, but a byte-identical inherited execution misses at `1.01175L` and
exits left. Subtracting a fitted joint-rate sway carrier from the predictor
misses at `1.02506L`. Extending the posterior pulse through an anterior
reversal whenever the posterior joint moves opposite the requested bend misses
at `0.92803L` and exits left at `27.47T`. Its visual sheet shows an organized
self-generated wake and a direct initial approach, followed by a pass outside
the sphere and a long curling boundary exit; peak planar force/moment remains
low (`0.0346/0.0169`) and joint angles stay below `38.7 deg`. That is a
terminal phase-allocation failure, not passive advection, wake breakup,
actuator locking, or numerical instability. A sampled sibling's removal of an
angle-domain carrier component from terminal bearing also misses at `1.10362L`,
so another observation correction is not supported.

At `about 1L` range in all three always-pulse captures, the terminal request is
positive (`0.94--0.95`) and the posterior joint moves in that requested
direction (`+2.88` to `+4.11 rad/T`). At capture the request remains positive
(`0.79--0.83`) but the posterior joint is returning in the opposite direction
(`-3.54` to `-4.54 rad/T`). The inherited lagged-follow-through edit explicitly
added authority during that latter target-opposed stroke and lost capture.
This does not prove the converse phase is causal, but it supplies a normalized,
reflection-equivariant actuator hypothesis distinct from pulse-gain or
static-bend tuning.

## Single candidate hypothesis

Preserve every prefilled route, carrier, curvature, response, and limit
mechanism. Replace only the anterior absolute-speed gate on the bounded
posterior redirect with a target-signed posterior-stroke gate. The existing
body-frame terminal request supplies direction; its product with posterior
joint rate identifies whether the lagged joint is advancing the requested bend.
The redirect is active only on that half-cycle and releases continuously on the
target-opposed return, while both halves of the propulsive carrier remain
active. This transfers phase-lag/half-cycle steering as an actuator allocation,
not a new scalar gain.

Support is capture with arrival and score outside repeat variability while
retaining the direct compact-wake trajectory, no `>40 deg` joint dwell, about
the established rate occupancy, and peak planar force/moment near or below
`0.037/0.019`. Falsify on loss of capture, another `0.9--1.1L` left-exit miss,
route or wake-class change, persistent terminal sign switching, increased
joint/load occupancy, or failure under reflected geometry. A nominal capture
alone establishes survival of the edit, not general robustness.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive emphasis and robotic-fish phase-lag or half-cycle steering
source_mechanism: concentrate bounded steering authority in the posterior stroke that advances the requested bend while preserving the traveling propulsive rhythm
transferable_invariant: phase-selective steering should reinforce the target-signed lagged stroke and release on the target-opposed return rather than bias both halves of the beat
nontransferable_details: published gains, species-specific envelopes, robot linkage geometry, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: multiply the normalized posterior joint rate by the bounded body-frame terminal request, rectify the target-signed product, and use it to gate the existing posterior target pulse under the two-joint state-feedback contract
falsification: reject if capture or closest approach and termination worsen, or if direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance degrades

The candidate's CFD evaluation occurs only after this worker exits. All
outcomes above are prior sampled or inherited evidence, not claims about the
new policy.

## Offline contract check after editing

Replaying saved states through both policies changes the acceleration-vector
norm by only `0.007` on average above `5L`, `0.225` from `3--5L`, and `0.281`
below `3L` on the strongest sampled capture. The corresponding means on the
lagged-follow-through failure are `0.005/0.108/0.121`. This confirms that the
edit reallocates the terminal redirect rather than replacing the carrier; it
does not predict a CFD outcome. Every replayed action is finite and within the
owned `30 rad/T^2` soft bound, and an explicit reflected-state replay has zero
numerical equivariance error.
