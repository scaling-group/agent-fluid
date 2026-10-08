# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver evaluations are finite direct-uniform still-water
rollouts with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
capture termination. They reproduce one controller behavior: each captures at
`23.83702T` with score `-0.53501328`, scoring mean/final distance
`2.433468/0.746096L`, and `236` moving-window shifts. Three policies are the
same v37 split-observer artifact and the fourth is behaviorally equivalent
algebra under older names.

I inspected the combined top-down mid-plane-vorticity and oblique body/Lambda2
rows from release through capture for the replicated baseline and for the
inherited collision-cone regression. Both fish self-propel from quiescent
fluid along the same smooth target-directed arc, leaving an ordered alternating
wake and compact three-dimensional vortices through the terminal bend. Neither
shows passive advection, wake breakup, collision, boundary exit, or numerical
instability. The collision-cone difference is below keyframe resolution, so
its worse `23.84802T` arrival, `-0.535108` score, `2.433569/0.746175L`
mean/final distance, `0.57337U` peak target-cross-track speed, and `0.014020`
peak moment outweigh its lower mean/peak yaw. Together with the stronger
middle-course closing-normalized regression, this closes another target-
relative velocity or terminal-course gate on the repeated path.

The replicated baseline still presents a distinct actuator-feasibility
signal. Direct trajectory measurement finds the hard `260 deg/T` speed clamp
active on `11.58%` of anterior and `4.59%` of posterior samples over the full
rollout, and on `10.32%`/`8.15%` inside `3L`; raw applied acceleration also
approaches the `1800 deg/T^2` envelope. This is clipping of the proven carrier,
not evidence for another steering correction. The hard integrator discards
outward acceleration while a joint remains clamped, so that command effort is
not contributing additional kinematic authority.

## Single candidate hypothesis

Retain the evaluated v37 response-released C-bend, role-separated terminal
observer, posterior traveling wave, cadence, steering, and component-wise
smooth acceleration projection. Add one state-feedback feasibility layer at
the final command boundary: when a joint is close to its speed envelope and
the raw command would accelerate farther outward, smoothly replace only that
outward part with a small inward recovery. Leave inward commands and all
commands below the soft boundary unchanged. The layer reads only joint rate
and parameters; it adds no clock, route state, or environment identity.

This should reduce exact speed-clamp residence and discarded outward command
while preserving the sampled capture trajectory and coherent wake. It is not
validated by this worker's evidence. Falsify it if CFD loses or delays capture,
regresses mean/final distance or wake coherence, raises yaw/moment or command
switching, or fails to reduce hard speed-cap exposure. If so, restore the split
baseline and do not increase the recovery gain or widen its soft band.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation under bounded joint kinematics
source_mechanism: preserve a thrust-producing rhythmic carrier while using observed joint state to keep its actuator trajectory inside a feasible envelope
transferable_invariant: constraint feedback should alter only the outward component that deepens an active kinematic limit, leaving the established traveling-wave and body-frame route feedback intact
nontransferable_details: published gains, clocked CPG phase, dimensional frequencies, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: apply a smooth one-sided rate-envelope recovery independently to the two final joint-acceleration commands, using only normalized joint state and policy-owned limits, after the proven steering and carrier modules
falsification: reject if speed-clamp residence is not reduced or if capture, progress, coherent wake topology, yaw/load balance, smooth command behavior, or actuator feasibility worsens

## Validation status

Formal CFD was intentionally not run in this workspace. The mandated
check-runner was invoked, but its pinned `gpt-5.4-mini` model is unavailable
for this account and failed before inspection. Its prescribed checks were then
run directly: guidance materiality and the solver edit boundary pass. The
Julia smoke command cannot launch because Julia is not installed. A
deterministic static audit finds exactly one nonempty candidate, both public
functions, and `72` unique direct `params.FIELD` references among `74` returned
fields with no undeclared reference; only `version` and `control_period` are
metadata. The policy has no explicit clock/step input, randomness, file I/O,
cylinder state, mutable global state, or memorized route. Candidate SHA-256 is
`55603328411881369c314705879dc24b5d0779bb96b3f9e98ed0bdfbb5746a2b`.
