# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The common prewarm sheet shows the held fish downstream and above four fully
developed, interacting vortex streets. It defines the shared release
disturbance and does not distinguish controllers.

The three byte-identical strongest sampled policies all show the same useful
released topology: an immediate correct-sign redirect, a coherent posterior
traveling bend, and a compact upstream-left diagonal to the `0.75L` capture
boundary in `43.9505`. Their mean fish velocity, approximately
`(-0.2471,-0.1020)`, differs materially from mean local flow
`(-0.1342,-0.1556)`, so upstream target closure is actively propelled rather
than wake advection. Their repeated `2.1391L` mean distance and
`0.2111/49.44/701.26` RMS crossflow/force/moment establish the route and
carrier that should be preserved.

No sampled solver has a semantic-failure keyframe. The informative mechanism
failure is the phase-led half-cycle sample: its released sheet preserves the
same route and capture at `43.9780`, but RMS crossflow/force/moment increase to
`0.2136/53.18/736.58`. The inherited instantaneous yaw-moment residual likewise
delayed capture to `45.1935` and raised force/moment to `71.51/957.29`.
Uncalibrated phase advance and instantaneous load cancellation are therefore
excluded. The assigned parent's target-blind seed domain exit remains the
failure-class boundary; it lacks the visible recovery redirect that the current
carrier already supplies.

The inherited direction-aware posterior rate projection is a bounded load
improvement, retaining capture at `44.0220` while lowering force/moment to
`44.86/663.89`. However, three consecutive completed assigned-parent
iterations materialized the same policy and exactly the same metrics, while
terminal-only localization of the projection was dynamically inert. A deeper
inherited-log audit also closes the response-gate hypothesis proposed by an
earlier lesson: small-bearing, windowed-convergence relief captured slightly
faster at `43.8955`, but raised crossflow/force/moment to
`0.2166/55.12/764.85` and mean command to `1216.18`. Its late keyframe shows a
larger wake excursion. Convergence is therefore not a reliable low-load stroke
label, even after a small-bearing gate.

A phase-selective rate projection supplies the remaining positive boundary.
Preserving the target-favored stroke captured at `44.0605` and reduced
force/moment to `46.71/677.72`, but it gave back part of the global projection's
load improvement and still touched the rate/acceleration envelopes. Together,
the evaluated variants support changing how the posterior rhythm approaches
the envelope rather than another response threshold, phase selector, distance
localization, or copy of output acceleration projection.

## Policy hypothesis before the edit

Preserve the sampled anterior oscillator, bounded body-frame bearing curvature,
joint-angle half-cycle steering, posterior velocity-derived lag, and
distance-based anterior amplitude envelope. Add one rate-conditioned posterior
wave-envelope mechanism upstream of acceleration tracking. Large bearing keeps
the evaluated posterior target exactly unchanged. Once target-bearing demand is
small, smoothly compress only the oscillatory part of the posterior target as
normalized posterior rate approaches its owned envelope; the mean steering
bias and the damping/reversal pathway remain active.

This is closed-loop rhythmic-target modulation, not another scalar change to
the evaluated output projection. It acts before the hard rate envelope, where
the repeated projection candidates did not remove peak contact, and should
begin deceleration without cancelling the target-favored half-cycle or using
an uncalibrated wake/load residual. Expected evidence is the same compact
redirect and direct capture, with reduced rate-cap contact, command effort, and
force/moment. Falsify the candidate if capture is lost or materially delayed,
the initial redirect changes, posterior propulsion collapses, or peak-rate and
load evidence remain unchanged. No CFD result for this candidate is claimed in
these notes.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: retain a posterior traveling wave for thrust while feedback continuously adapts its internal amplitude envelope before actuator saturation
transferable_invariant: preserve the proven traveling-bend carrier and full target-directed redirect at large normalized body-frame error, then reduce only posterior oscillatory target amplitude as normalized joint-rate utilization approaches its envelope
nontransferable_details: published gains, dimensional timing, species-specific kinematics, clock phase, exact vortex phase, cylinder or target coordinates, and source-task routes
policy_translation: use bounded body-frame bearing to preserve large-error authority and posterior joint rate normalized by the owned actuator envelope to compress only the lagged posterior wave target, retaining mean steering and damping
falsification: reject if compact direct capture is lost or delayed materially, the initial redirect weakens, posterior thrust collapses, or cap contact, command effort, and loads do not improve

## Pre-evaluation verification

The prescribed guidance/provenance check and solver editable-boundary check
pass. The guidance checker initially found the assigned parent duplicated in
the rendered workspace `README.md`; removing only the duplicate marker restored
the required single parent and the substantive guidance comparison then passed.

Static schema inspection found all `16` direct `params.FIELD` references among
the `16` fields returned by `target_policy_params()`, with no policy-owned `L`
and no prohibited wake probe, station, coordinate, time, or step observation.
An algebraic sweep over `12,348` combinations of range, both bearing signs,
joint-angle limits, and rates through and beyond the owned envelope found
finite actions, posterior-wave scale bounded in `[0.75,1]`, and exact
compression inactivity during large bearing demand or below the rate onset.
The candidate SHA-256 is distinct from every sampled and inherited policy.

The configured Julia include/assertion could not start because this runtime has
no `julia` executable; this is a verification limitation, not a passed runtime
assertion. No formal CFD was run.
