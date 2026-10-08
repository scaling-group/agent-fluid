# Candidate wake-policy notes

## Evidence diagnosis before editing

The assigned-parent candidate and all four sampled solver rollouts are valid,
finite, direct-uniform still-water evaluations with `U_infinity=(0,0,0)`, no
cylinders, no prewarm snapshot, and capture termination. Three sampled texts
reproduce the split-observer baseline behavior at `23.83702T`, score
`-0.53501328`, and scoring mean/final distance `2.433468/0.746096L`. The fourth
sample changes only the small progress-cadence observation: qualifying carrier
release by positive target-radial translation captures at `23.37501T` and
improves score and mean distance materially to `-0.50515772` and `2.402131L`.

I inspected the combined keyframe sheets for the progress-qualified rollout,
the assigned-parent split baseline, and the inherited one-sided joint-speed
recovery regression. In both the top-down mid-plane-vorticity rows and oblique
body/Lambda2 rows, the fish self-propels from quiescence along the same smooth
target-directed arc, forms an ordered alternating wake, and retains compact
three-dimensional structures through capture. There is no passive advection,
wake collapse, collision, boundary exit, or instability. The controller
differences are below keyframe resolution, so the trajectory, load, and
actuator histories decide the comparison.

The progress-qualified release has a real terminal trade rather than an
unqualified win. Relative to the split baseline, inside `3L` mean/peak absolute
yaw rise from `1.67938/3.19386` to `1.71255/3.29199 rad/T`, mean/peak absolute
moment rise from `0.006388/0.013581` to `0.006591/0.014507`, and peak
target-cross-track speed rises from `0.56914U` to `0.61953U`, although its mean
cross-track speed improves from `0.23868U` to `0.23513U`. Its final distance is
also looser at `0.748882L`. Crucially, it has already accumulated `0.407T` of
its total `0.462T` arrival lead when it first crosses `3L`; only about `0.055T`
is gained inside the existing terminal yaw-control band. Thus the evidence
supports the new propulsion observation outside `3L`, but not carrying its
extra cadence authority unchanged through terminal steering.

The inherited speed-envelope recovery is the informative failure. Although it
reduces exact joint-speed-cap residence, it preserves the same visible wake
while delaying capture to `24.16701T` and regressing score and mean/final
distance to `-0.555298/2.453906/0.748632L`; peak moment inside `3L` also rises
to `0.013971`. This rejects another command-boundary recovery or feasibility
gain change as the remedy for the progress rollout's terminal load. The recent
collision-cone, flow-gate, phase-lead, and envelope-share regressions likewise
exclude another terminal steering residual.

## Single candidate hypothesis

Start from the evaluated progress-qualified carrier release. Preserve its
normalized body-frame radial translation observation, the established
response-released C-bend, continuous anterior-only course response,
role-separated phase observer, posterior traveling wave, all steering gains,
and component-wise smooth command projection. Add only a continuous terminal
authority handoff: multiply the small progress-cadence reserve by the
complement of the existing terminal-yaw proximity window. The reserve is
unchanged outside `3L`, then fades as terminal steering opens; the baseline
carrier remains active everywhere. This uses no new clock, route state,
world-frame coordinate, task identity, or scalar gain increase.

The rollout should retain most of the measured `3L` arrival lead and coherent
wake while moving terminal yaw, peak cross-track speed, moment, and final
distance back toward the split baseline. Reject the handoff if capture is lost
or delayed beyond the split baseline, score/mean distance gives back the
middle-approach improvement, the ordered wake changes, terminal yaw and moment
do not improve over the progress-qualified sample, or joint/command-limit
exposure worsens.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach scheduling
source_mechanism: preserve an established traveling-wave carrier while continuously handing authority from task-qualified propulsion to near-target course control
transferable_invariant: extra propulsion authority should withdraw as the measured terminal steering regime opens, while the base posterior-lagged carrier remains intact
nontransferable_details: published gains, dimensional speeds or frequencies, clocked phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: retain the normalized body-frame target-progress release outside the terminal band and multiply only its small cadence reserve by one minus the existing distance-based terminal-yaw proximity
falsification: reject if CFD loses or delays capture beyond the split baseline, gives back the middle-approach score gain, changes wake coherence, fails to reduce terminal yaw/load versus the progress sample, or worsens actuator feasibility

## Validation plan

Do not run formal CFD in this worker. After updating the one candidate and
durable guidance, invoke the configured check runner, run its non-CFD boundary
and guidance checks, audit the direct parameter schema, and use the lightweight
Julia contract smoke only if the runtime is available.

## Validation status

The configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
unsupported on this account and failed before workspace inspection. Its
prescribed checks were then executed directly. Guidance materiality passes
after removing one duplicate assigned-parent marker from the rendered
workspace `README.md`; the solver boundary check passes. Exactly one nonempty
candidate exists, and a deterministic audit finds `69` unique direct
`params.FIELD` references among `71` returned fields with no undeclared
reference; only `version` and `control_period` are metadata. Both public
functions occur exactly once, with no explicit state clock or step input.

The prescribed Julia contract smoke was invoked but cannot start because no
Julia executable is installed. No formal CFD was run. Candidate SHA-256:
`2a81505adf289eb4f397b5112afb5dd34dc8ad1253fd2bba82c11ad7674d5f22`.
