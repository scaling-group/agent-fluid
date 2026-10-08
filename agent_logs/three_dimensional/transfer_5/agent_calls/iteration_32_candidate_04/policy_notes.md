# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver artifacts are finite direct-uniform still-water
evaluations with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
capture termination. They are one replicated behavior: every rollout captures
at `23.83702T` with score `-0.53501328`, scoring mean distance `2.433468L`,
and final distance `0.746096L`; their combined keyframe sheets are byte-
identical. Three policy files are byte-identical v37 split observers, while
the fourth has behaviorally equivalent split-observer algebra.

I inspected the combined sheet's top-down mid-plane-vorticity and oblique
body/Lambda2 rows from quiescent release through capture. The fish is self-
propelled along a smooth target-directed arc, with an ordered alternating
mid-plane wake and compact three-dimensional structures persisting through the
terminal bend. There is no passive advection, wake breakup, collision,
boundary exit, or instability. Inside `3L`, the trajectory cross-check gives
mean/peak absolute yaw `1.67938/3.19386 rad/T`, mean/peak target-cross-track
speed `0.23868/0.56914U`, and peak absolute moment `0.013581`; peak joint
angles, joint rates, and projected commands remain inside the configured
envelope.

The inherited middle-interception and terminal collision-cone rollouts are the
informative failures missing from the sampled set. I inspected both visual
rows for each: they retain the same coherent, self-propelled wake topology, so
their policy effect is below keyframe resolution and the trajectory metrics
decide the comparison. The middle interception bias delayed capture to
`23.85352T`, regressed score/mean/final distance to
`-0.536326/2.434376/0.748282L`, worsened inside-`3L` cross-track motion to
`0.24474/0.58775U`, and raised peak moment to `0.013867` despite lower yaw.
The collision-cone gate delayed capture to `23.84802T` and regressed
score/mean/final distance to `-0.535108/2.433569/0.746175L`; its lower mean
yaw and cross-track speed came with worse peak cross-track speed `0.57337U`
and peak moment `0.014020`. This rejects another target-relative velocity
construction or terminal residual edit as the immediate search axis.

The remaining far-route cue has a directly measurable carrier contamination.
Reconstructing the seven-sample bearing-window rate from the repeated baseline
shows correlation `-0.953` with anterior joint rate over `13-9L` and `-0.986`
over `9-6L`. Adding the already established anterior carrier estimate
`0.5*phi_dot[1]` reduces bearing-trend RMS from `1.537` to `0.471 rad/T` in
the first band and from `1.480` to `0.268 rad/T` in the second. On the recorded
states, a sign-consensus projection of this corrected cue reduces far-route
turn-request RMS from `2.206` to `1.972` over `13-9L` while changing its mean
from `0.214` to `0.222`; scheduling release from `9L` to `6L` leaves the
policy algebra exactly unchanged thereafter. This replay is a scale and scope
diagnostic, not evidence of a closed-loop improvement.

## Single candidate hypothesis

Retain v37's response-released C-bend, posterior traveling wave, geometric
route feedback, cadence, middle and terminal schedules, split terminal
observer, phase-selected anterior residual, and component-wise smooth command
projection. Change only the far-route bearing-trend observation: compare the
raw trend with the anterior-carrier-rejected trend, retain the smaller raw-sign
component when they agree, and suppress it when their signs disagree. Apply
that consensus fully beyond `9L`, release it continuously by `6L`, and use the
result consistently in the existing trend and sweep-damping roles. The cue is
normalized, body-frame, memoryless at the policy surface, and does not alter
the posterior carrier or add steering authority.

The candidate predicts less beat-synchronous route-command effort during wake
formation without changing the mean turn direction, followed by the evaluated
baseline controller from `6L` inward. Falsify it if closed-loop CFD loses or
delays capture, worsens score or mean/final distance, changes the ordered wake,
raises yaw/cross-track/moment loads, or increases joint/command-limit exposure.
Because the rollout can diverge before `6L`, algebraic release is not a claim
that the later physical trajectory will match the baseline.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and classical separation of propulsive traveling waves from route steering
source_mechanism: preserve a thrust-producing rhythmic carrier while preventing its fast joint phase from masquerading as persistent target-course change
transferable_invariant: scope fast joint-state information to rejecting beat-synchronous contamination of a slow body-frame route cue, without changing posterior propulsion or adding route authority
nontransferable_details: published gains, clocked CPG phase, dimensional frequencies, species-specific envelopes, exact vortex phase, and task-specific paths or schedules
policy_translation: use the evaluated anterior joint-rate carrier estimate to form a sign-consensus bearing trend only in the far route, then release continuously to the unchanged baseline by `6L`
falsification: reject if direct-uniform CFD loses split-baseline capture/progress, coherent wake topology, mixed yaw/cross-track/load balance, or actuator feasibility

## Validation status

No formal CFD was run in this workspace. The mandated configured check runner
was invoked, but its pinned `gpt-5.4-mini` model is unsupported on this account
and failed before workspace inspection. Its prescribed guidance-materiality
and solver-boundary checks were then run directly and both pass. Julia is not
installed, so the lightweight runtime smoke cannot launch. A deterministic
static audit finds `71` unique direct `params.FIELD` references among `73`
returned fields, no undeclared reference, and only the `version` and
`control_period` metadata fields unreferenced. Both public functions are
present, delimiters are balanced, and there is no explicit clock/step input,
randomness, file I/O, cylinder cue, mutable global state, or memorized route.
Exactly one nonempty candidate exists; its SHA-256 is
`ed52f150506453829818c34479cb3e8bc5169c45675b72988be395bb592b59cf`.
