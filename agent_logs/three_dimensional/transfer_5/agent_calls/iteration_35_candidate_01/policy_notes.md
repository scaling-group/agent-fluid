# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled rollouts are finite captures from direct-uniform still water
with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. The assigned
parent is the progress-qualified split-observer carrier: it captures at
`23.375013T`, scores `-0.505158`, and has scoring mean/final distance
`2.402131/0.748882L`. The demand-coupled reserve handoff is the strongest
sample at the same capture time, with improved score and mean/final distance
`-0.503415/2.400748/0.747085L`. The middle-window handoff captures later at
`23.435516T` and scores `-0.504742`; the monotone terminal handoff captures at
`23.391514T` and regresses to `-0.505421`.

I inspected the combined keyframe sheets for the strongest demand handoff and
the informative monotone-handoff regression from release through capture. In
both the top-down mid-plane-vorticity rows and oblique body/Lambda2 rows, the
fish self-propels from quiescence along the same smooth target-directed arc and
sheds a coherent alternating three-dimensional wake. Neither rollout shows
passive advection, wake collapse, collision, boundary exit, or instability;
the policy difference is below keyframe resolution, so trajectory and load
histories decide the comparison.

The demand handoff is a real distance-progress improvement over the assigned
parent, but not the terminal cleanup its inherited falsification required.
Inside `3L`, sampled trajectory replay changes mean/peak absolute yaw from
`1.71255/3.29199` to `1.71472/3.27552 rad/T`, peak target-line cross-track
speed from `0.61953` to `0.62108U`, and peak absolute moment from `0.014507`
to `0.014923`. Conversely, the middle and monotone distance schedules reduce
yaw/load but delay capture and fail to beat the demand handoff's progress.
Thus the evidence supports the demand-coupled controller as the strongest
available selection, while rejecting another scalar handoff retune or an
additional fast-signal gate as an evidence-backed improvement.

## Single candidate hypothesis

Replace the assigned parent with the sampled demand-coupled split-observer
policy exactly: preserve target-progress-qualified cadence, the response-
released C-bend, anterior-only continuous course response, distributed rate
cue only for phase classification, phase-selected anterior correction,
posterior traveling wave, and component-wise smooth command projection. Yield
only the small progress-cadence reserve in proportion to the already bounded
terminal course-brake magnitude; leave base cadence and all evaluated gains
unchanged.

This restoration should reproduce the sampled coherent capture near
`23.375T` and improve scoring mean/final distance over the assigned parent
without introducing an untested mechanism. Its applicability is the sampled
direct-uniform still-water topology. Falsify the selection if deterministic
repeat or held-out CFD loses capture, materially regresses the sampled
distance progress, breaks wake coherence, or worsens actuator feasibility.
Do not interpret repeat success as evidence that the handoff solves terminal
load; that claim is already contradicted by the sampled moment and cross-track
histories.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach control
source_mechanism: sensory arbitration between an intact traveling-wave propulsion carrier and measured near-target course demand
transferable_invariant: preserve the base posterior-lagged carrier while yielding only surplus rhythmic authority when bounded stabilization feedback is active
nontransferable_details: published gains, dimensional frequencies and speeds, clocked phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: select the evaluated body-frame demand handoff that gates only target-progress cadence reserve by absolute terminal course-brake demand; keep the carrier, steering roles, and projection unchanged
falsification: reject if repeat or held-out CFD loses sampled capture/progress, coherent wake topology, or actuator feasibility; do not claim yaw/load improvement unless both cross-track and moment histories improve

## Validation plan

Do not run formal CFD. After materializing the one candidate and updating
durable guidance, invoke the configured check runner and execute its prescribed
non-CFD boundary, schema, and lightweight contract checks where available.

## Validation status

The configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
unsupported by this account and failed before inspecting the workspace. Its
three prescribed checks were then run directly and separately. The guidance
check initially found the assigned parent marked twice in the rendered root
`README.md`; removing only one duplicate marker repaired the ambiguity, and
the rerun passes with a material reusable guidance update. The solver boundary
check passes.

The prescribed Julia contract smoke cannot launch because no Julia executable
is installed. A deterministic static audit finds exactly one nonempty canonical
candidate, each public function exactly once, and `70` unique direct
`params.FIELD` references among `72` returned fields with no undeclared
reference. The candidate contains no explicit time/step state, randomness,
file I/O, cylinder/wake-position cue, mutable global state, or memorized route.
Its executable text differs from the evaluated demand-handoff sample only in
the assigned-parent provenance comment. Candidate SHA-256:
`6fda23da0cb16dd07214765c14a59bfb454115f4be703c93db35c7371c0bee72`.
No formal CFD was run.
